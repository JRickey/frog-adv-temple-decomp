#!/usr/bin/env tsx
/**
 * detect-fn-boundary
 *
 * Walks Thumb instructions forward from a given start address in the baserom
 * and reports candidate function end addresses. Flags peel-boundary risks
 * before you commit to a range in `tools/disasm/peel.py`.
 *
 * Key checks:
 *  - **Epilogue detection**: `pop {…, pc}`, `bx lr` mark places where control
 *    leaves the function. The last fall-through-killing instruction before
 *    obvious data/padding/next-prologue is the candidate end.
 *  - **Literal-pool detection**: after an epilogue, 4-byte-aligned values that
 *    look like load-immediate addresses (0x0800xxxx, 0x0200xxxx, 0x0300xxxx,
 *    0x0400xxxx) are pool entries belonging to the function above them.
 *  - **Alignment padding detection**: 0x0000 (`movs r0, r0`) and 0x46c0
 *    (`mov r8, r8` nop) used as 2-byte padding to the next aligned address.
 *  - **Next-function prologue detection**: `push {…, lr}` after the pool +
 *    padding is the next function's entry.
 *  - **Interior-bl warning**: every `bl <target>` recorded; if any target lies
 *    inside [start, candidate_end), that almost certainly means the peel is
 *    swallowing an adjacent helper. This is the AgbMain case (commit 0c989b1).
 *
 * Usage:
 *   npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts 0x080002a4
 *   npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts 0x080002a4 --proposed-end 0x080004c4
 *   npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts 0x080002a4 --json
 */
import { execFileSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const PROJECT_ROOT = path.resolve(__dirname, '..', '..', '..', '..');

const ROM_BASE = 0x08000000;
const MAX_WALK_BYTES = 8 * 1024;

interface DisasmLine {
  addr: number;
  /** Raw bytes as printed by objdump (e.g., "b500", "f000 f8bf"). */
  rawBytes: string;
  /** Numeric value of `rawBytes` (1, 2, or 4 bytes). */
  bytesNum: number;
  mnemonic: string;
  operands: string;
  /** Raw line for reproduction in reports. */
  raw: string;
}

interface BoundaryReport {
  start: number;
  /** Best single candidate end (recommended). */
  recommendedEnd: number;
  /** All plausible end candidates with their reasoning. */
  candidates: Array<{ end: number; reason: string; epilogueAddr: number }>;
  /** Every `bl <target>` recorded. */
  callTargets: Array<{ from: number; to: number }>;
  /** Warnings to surface to the user. */
  warnings: string[];
  /** Proposed end (if --proposed-end was passed) compared against findings. */
  proposedEnd: number | null;
}

function findBaserom(): string {
  for (const p of [path.join(PROJECT_ROOT, 'frog_us_baserom.gba'), path.join(PROJECT_ROOT, 'baserom.gba')]) {
    if (fs.existsSync(p)) return p;
  }
  throw new Error(`Baserom not found near ${PROJECT_ROOT}`);
}

function objdumpThumb(start: number, end: number): string {
  return execFileSync(
    'arm-none-eabi-objdump',
    [
      '-D',
      '-b',
      'binary',
      '-m',
      'arm7tdmi',
      '-Mforce-thumb',
      `--adjust-vma=0x${ROM_BASE.toString(16)}`,
      `--start-address=0x${start.toString(16)}`,
      `--stop-address=0x${end.toString(16)}`,
      findBaserom(),
    ],
    { encoding: 'utf-8', maxBuffer: 16 * 1024 * 1024 },
  );
}

// objdump format examples:
//   80002a4:	b500      	push	{lr}
//   80002ae:	f000 f8bf 	bl	0x8000430
//   80002b8:	f020 fc82 	bl	0x20bc0
// Capture: address, byte-group, mnemonic, operands.
const LINE_RE = /^\s*([0-9a-f]+):\s+([0-9a-f]+(?:\s+[0-9a-f]+)?)\s+(\S+)(?:\s+(.*?))?\s*$/i;

function parseDisasm(text: string): DisasmLine[] {
  const out: DisasmLine[] = [];
  for (const line of text.split('\n')) {
    const m = line.match(LINE_RE);
    if (!m) continue;
    const addr = parseInt(m[1], 16);
    const rawBytes = m[2];
    const cleaned = rawBytes.replace(/\s+/g, '');
    // Reorder bytes for the numeric value: objdump prints little-endian
    // as two bytes per halfword in source order, so "b500" → halfword 0xb500
    // and "f000 f8bf" → 0xf000_f8bf (two halfwords, big-endian-as-shown).
    const bytesNum = parseInt(cleaned, 16);
    out.push({
      addr,
      rawBytes,
      bytesNum,
      mnemonic: m[3].toLowerCase(),
      operands: (m[4] ?? '').trim(),
      raw: line,
    });
  }
  return out;
}

/** Is this instruction an epilogue (control-leaves-function, no fall-through)? */
function isEpilogue(insn: DisasmLine): boolean {
  if (insn.mnemonic === 'pop' && /\bpc\b/.test(insn.operands)) return true;
  if (insn.mnemonic === 'bx' && /\b(lr|r\d+)\b/.test(insn.operands)) return true;
  // Unconditional branches kill fall-through too. (Conditional branches like
  // beq/bne/etc. do not.)
  if (insn.mnemonic === 'b' || insn.mnemonic === 'b.n' || insn.mnemonic === 'b.w') return true;
  return false;
}

/** Is this an unconditional branch? (Function can end after one, but only if backward or to outside.) */
function isUnconditionalBranch(insn: DisasmLine): { addr: number } | null {
  if (insn.mnemonic === 'b' || insn.mnemonic === 'b.n' || insn.mnemonic === 'b.w') {
    const m = insn.operands.match(/0x([0-9a-f]+)/i);
    if (m) return { addr: parseInt(m[1], 16) };
  }
  return null;
}

/** Is this a function call? Returns target address. */
function getCallTarget(insn: DisasmLine): number | null {
  if (insn.mnemonic === 'bl' || insn.mnemonic === 'blx') {
    const m = insn.operands.match(/0x([0-9a-f]+)/i);
    if (m) return parseInt(m[1], 16);
  }
  return null;
}

/** Is this a Thumb push prologue with lr saved? */
function isPushLr(insn: DisasmLine): boolean {
  return insn.mnemonic === 'push' && /\blr\b/.test(insn.operands);
}

/** 2-byte alignment padding nop. */
function isAlignmentPad(insn: DisasmLine): boolean {
  // 0x0000 = movs r0, r0 / lsls r0, r0, #0
  // 0x46c0 = mov r8, r8 (canonical Thumb nop)
  return insn.bytesNum === 0x0000 || insn.bytesNum === 0x46c0;
}

/**
 * Heuristic: does this 4-byte sequence look like a literal-pool entry?
 * Pool entries are typically RAM/ROM addresses or constants. We accept any
 * 4-byte value whose top byte points to a known GBA memory region.
 */
function isLikelyPoolWord(addr: number, lines: DisasmLine[]): boolean {
  // Find two consecutive 2-byte lines at addr and addr+2 (or one 4-byte line).
  const idx = lines.findIndex((l) => l.addr === addr);
  if (idx === -1) return false;
  const first = lines[idx];
  if (first.rawBytes.length === 8) {
    // Single 4-byte line — already a word.
    const top = (first.bytesNum >>> 24) & 0xff;
    return top === 0x08 || top === 0x02 || top === 0x03 || top === 0x04 || top === 0x05 || top === 0x06 || top === 0x07;
  }
  if (idx + 1 >= lines.length || lines[idx + 1].addr !== addr + 2) return false;
  const second = lines[idx + 1];
  // Compose little-endian: byte order is first-halfword-low, first-halfword-high, second-halfword-low, second-halfword-high
  const lo = first.bytesNum;
  const hi = second.bytesNum;
  const word = (hi << 16) | lo;
  const top = (word >>> 24) & 0xff;
  return top === 0x08 || top === 0x02 || top === 0x03 || top === 0x04 || top === 0x05 || top === 0x06 || top === 0x07;
}

export function detectBoundary(start: number, proposedEnd: number | null = null): BoundaryReport {
  const walkEnd = start + MAX_WALK_BYTES;
  const disasm = objdumpThumb(start, walkEnd);
  const lines = parseDisasm(disasm).filter((l) => l.addr >= start && l.addr < walkEnd);

  if (lines.length === 0) {
    throw new Error(`No instructions disassembled in [0x${start.toString(16)}, 0x${walkEnd.toString(16)}).`);
  }

  // Verify we start with a plausible prologue. Warn if not.
  const warnings: string[] = [];
  if (!isPushLr(lines[0]) && lines[0].mnemonic !== 'push' && lines[0].mnemonic !== 'sub' && lines[0].mnemonic !== 'mov') {
    warnings.push(
      `Start address 0x${start.toString(16)} doesn't look like a function entry ` +
        `(first insn: "${lines[0].mnemonic} ${lines[0].operands}"). Expected push/sub/mov prologue.`,
    );
  }

  const callTargets: Array<{ from: number; to: number }> = [];
  const candidates: BoundaryReport['candidates'] = [];

  let i = 0;
  while (i < lines.length) {
    const insn = lines[i];

    const callTo = getCallTarget(insn);
    if (callTo !== null) {
      callTargets.push({ from: insn.addr, to: callTo });
    }

    if (isEpilogue(insn)) {
      // Scan forward from the instruction after the epilogue.
      // Skip: pool words (4-byte addresses), alignment padding.
      // Stop at: next push-lr (next function prologue) → that's a candidate end.
      const epilogueAddr = insn.addr;
      const insnSize = insn.rawBytes.length === 4 ? 2 : insn.rawBytes.length === 8 ? 4 : 2;
      let probeAddr = insn.addr + insnSize;
      let j = i + 1;
      while (j < lines.length) {
        const probe = lines[j];
        if (probe.addr !== probeAddr) {
          // Address skipped — typically because we walked over a pool word.
          probeAddr = probe.addr;
        }

        // Pool word (4 bytes, looks like a RAM/ROM address)?
        if (isLikelyPoolWord(probe.addr, lines)) {
          probeAddr += 4;
          // Advance j past the 4-byte block (could be 1 line of 4 bytes or 2 lines of 2 bytes each).
          if (probe.rawBytes.length === 8) {
            j += 1;
          } else {
            // 2-byte line — also consume the next 2-byte line if it's at addr+2.
            j += 1;
            if (j < lines.length && lines[j].addr === probe.addr + 2) j += 1;
          }
          continue;
        }

        // Alignment padding?
        if (isAlignmentPad(probe)) {
          probeAddr = probe.addr + 2;
          j += 1;
          continue;
        }

        // Next function prologue?
        if (isPushLr(probe)) {
          candidates.push({
            end: probe.addr,
            reason: `epilogue at 0x${epilogueAddr.toString(16)}, pool + padding, then push-lr prologue at 0x${probe.addr.toString(16)}`,
            epilogueAddr,
          });
          break;
        }

        // Something else: more code? That means the epilogue wasn't actually
        // the end — control flow continues (e.g., the function has multiple
        // returns and this is in the middle). Resume normal walking.
        break;
      }
    }

    i += 1;
  }

  // First-pass recommended end: the earliest of (first push-lr candidate, walk
  // window end). We'll override this if interior-bl targets give a tighter
  // signal.
  let firstPassEnd: number;
  if (candidates.length > 0) {
    firstPassEnd = candidates[0].end;
  } else {
    const lastEpilogue = [...lines].reverse().find((l) => isEpilogue(l));
    if (lastEpilogue) {
      const sz = lastEpilogue.rawBytes.length === 4 ? 2 : 4;
      firstPassEnd = lastEpilogue.addr + sz;
      warnings.push(
        `No clean next-prologue boundary found within ${MAX_WALK_BYTES} bytes. ` +
          `Falling back to last-epilogue + 2 at 0x${firstPassEnd.toString(16)}. Verify manually.`,
      );
    } else {
      firstPassEnd = walkEnd;
      warnings.push(
        `No epilogue or next-prologue detected within ${MAX_WALK_BYTES} bytes from 0x${start.toString(16)}. ` +
          `This function may not be Thumb, may have unusual control flow, or the start address is wrong.`,
      );
    }
  }

  // Interior-bl check: the strongest possible boundary signal. `bl <X>` means
  // X is a function entry — full stop. If any bl target is strictly inside
  // (start, firstPassEnd), the function actually ends at that target.
  const interiorBl = callTargets.filter((c) => c.to > start && c.to < firstPassEnd);
  let recommendedEnd = firstPassEnd;
  if (interiorBl.length > 0) {
    const earliest = interiorBl.reduce((a, b) => (a.to < b.to ? a : b));
    recommendedEnd = earliest.to;
    warnings.push(
      `INTERIOR CALL detected: bl from 0x${earliest.from.toString(16)} → 0x${earliest.to.toString(16)} is the ` +
        `tightest function-entry signal. Recommended end revised from 0x${firstPassEnd.toString(16)} to ` +
        `0x${recommendedEnd.toString(16)} (size ${recommendedEnd - start} bytes).`,
    );
    // Surface the other interior calls too — they're not "the" boundary but
    // the user should know about them.
    for (const c of interiorBl) {
      if (c.to !== earliest.to) {
        warnings.push(
          `Additional interior call: bl from 0x${c.from.toString(16)} → 0x${c.to.toString(16)} also lies inside ` +
            `the original [start, ${firstPassEnd.toString(16)}) range. (Outside the revised end.)`,
        );
      }
    }
  }

  // If proposed_end was provided, compare.
  if (proposedEnd !== null) {
    if (proposedEnd > recommendedEnd) {
      warnings.push(
        `PROPOSED END too high: your --proposed-end 0x${proposedEnd.toString(16)} extends past detected boundary ` +
          `0x${recommendedEnd.toString(16)} by ${proposedEnd - recommendedEnd} bytes. Likely swallowing adjacent function(s).`,
      );
    } else if (proposedEnd < recommendedEnd) {
      warnings.push(
        `PROPOSED END too low: your --proposed-end 0x${proposedEnd.toString(16)} is short of detected boundary ` +
          `0x${recommendedEnd.toString(16)} by ${recommendedEnd - proposedEnd} bytes. Function may continue past your range.`,
      );
    }
  }

  return {
    start,
    recommendedEnd,
    candidates,
    callTargets,
    warnings,
    proposedEnd,
  };
}

function parseAddr(s: string): number {
  if (s.startsWith('0x') || s.startsWith('0X')) return parseInt(s.slice(2), 16);
  return parseInt(s, 16);
}

function main() {
  const args = process.argv.slice(2);
  if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
    process.stderr.write(
      'Usage: detect-fn-boundary <start_addr> [--proposed-end <addr>] [--json]\n' +
        '\n' +
        'Walks Thumb forward from start_addr in the baserom and reports the\n' +
        'detected function-end boundary. Flags interior-bl targets that suggest\n' +
        'the peel range would swallow an adjacent function.\n' +
        '\n' +
        'Example:\n' +
        '  detect-fn-boundary 0x080002a4                          # detect AgbMain\'s end\n' +
        '  detect-fn-boundary 0x080002a4 --proposed-end 0x80004c4 # check your guess\n',
    );
    process.exit(args.length === 0 ? 1 : 0);
  }

  const start = parseAddr(args[0]);
  let proposedEnd: number | null = null;
  const peIdx = args.indexOf('--proposed-end');
  if (peIdx !== -1 && peIdx + 1 < args.length) {
    proposedEnd = parseAddr(args[peIdx + 1]);
  }
  const asJson = args.includes('--json');

  const report = detectBoundary(start, proposedEnd);

  if (asJson) {
    process.stdout.write(JSON.stringify(report, null, 2) + '\n');
    return;
  }

  const lines: string[] = [];
  lines.push(`Start:           0x${start.toString(16).padStart(8, '0')}`);
  lines.push(`Recommended end: 0x${report.recommendedEnd.toString(16).padStart(8, '0')}  (size ${report.recommendedEnd - start} bytes)`);
  if (proposedEnd !== null) {
    lines.push(`Proposed end:    0x${proposedEnd.toString(16).padStart(8, '0')}  (size ${proposedEnd - start} bytes)`);
  }
  lines.push('');
  if (report.candidates.length > 0) {
    const shown = report.candidates.slice(0, 3);
    lines.push(`Candidate ends (showing top 3 of ${report.candidates.length}):`);
    for (const c of shown) {
      lines.push(`  0x${c.end.toString(16).padStart(8, '0')}  — ${c.reason}`);
    }
    lines.push('');
  }
  const interiorCalls = report.callTargets.filter((c) => c.to > start && c.to < report.recommendedEnd);
  if (interiorCalls.length > 0) {
    lines.push(`Interior bl targets (${interiorCalls.length}):`);
    for (const c of interiorCalls) {
      lines.push(`  0x${c.from.toString(16).padStart(8, '0')}  bl  0x${c.to.toString(16).padStart(8, '0')}  ⚠`);
    }
    lines.push('');
  } else {
    lines.push(`Interior bl targets: none (of ${report.callTargets.length} total bl calls scanned).`);
    lines.push('');
  }
  if (report.warnings.length > 0) {
    lines.push('Warnings:');
    for (const w of report.warnings) {
      lines.push(`  ⚠ ${w}`);
    }
  } else {
    lines.push('No warnings.');
  }
  process.stdout.write(lines.join('\n') + '\n');
  if (report.warnings.length > 0) process.exit(2);
}

const isMain = process.argv[1]?.endsWith('detect-fn-boundary.ts');
if (isMain) {
  main();
}
