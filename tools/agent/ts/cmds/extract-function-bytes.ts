#!/usr/bin/env tsx
/**
 * extract-function-bytes
 *
 * Given a function name, returns the authoritative byte range
 * `[start, next_symbol_start)` for that symbol, derived from `frog_us.map`.
 *
 * This is the "ground truth" for where a function lives in the baserom.
 * Use it to validate proposed peel ranges in `tools/disasm/peel.py` and to
 * sanity-check function boundaries before refining asm to mnemonics.
 *
 * Adapted from mizuchi's `#writeObjdumpWrapper` pattern in
 * `src/shared/decomp-permuter.ts` (lines ~472-563): mizuchi uses this to
 * constrain `objdump` to a single function so a permuter run only sees
 * the symbol it's mutating. We use the same idea but applied to the
 * baserom (not just a built `.o`), so we can fact-check peel boundaries.
 *
 * Usage:
 *   npx tsx tools/agent/ts/cmds/extract-function-bytes.ts <FunctionName>
 *   npx tsx tools/agent/ts/cmds/extract-function-bytes.ts <FunctionName> --asm
 *   npx tsx tools/agent/ts/cmds/extract-function-bytes.ts <FunctionName> --bytes
 *   npx tsx tools/agent/ts/cmds/extract-function-bytes.ts <FunctionName> --json
 */
import { execFileSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { parseMapFileAddresses } from '../shared/map-file/map-file.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const PROJECT_ROOT = path.resolve(__dirname, '..', '..', '..', '..');

const ROM_BASE = 0x08000000;

interface ExtractResult {
  name: string;
  /** ROM-loaded start address (e.g., 0x080002a4). */
  start: number;
  /** ROM-loaded end address (exclusive). */
  end: number;
  /** Number of bytes. */
  size: number;
  /** The symbol that follows this one in baserom address order. `null` if last. */
  nextSymbol: string | null;
  /** The symbol that immediately precedes this one. `null` if first. */
  prevSymbol: string | null;
  /** Byte offset into the baserom file. */
  fileOffset: number;
}

function findBaserom(): string {
  const candidates = [
    path.join(PROJECT_ROOT, 'frog_us_baserom.gba'),
    path.join(PROJECT_ROOT, 'baserom.gba'),
  ];
  for (const p of candidates) {
    if (fs.existsSync(p)) return p;
  }
  throw new Error(`Baserom not found. Looked at: ${candidates.join(', ')}`);
}

function findMapFile(): string {
  const p = path.join(PROJECT_ROOT, 'frog_us.map');
  if (!fs.existsSync(p)) {
    throw new Error(`Map file not found at ${p}. Run \`make -j8\` first.`);
  }
  return p;
}

export function extract(functionName: string): ExtractResult {
  const mapContent = fs.readFileSync(findMapFile(), 'utf-8');
  const addressMap = parseMapFileAddresses(mapContent);

  const startAddr = addressMap.get(functionName);
  if (startAddr === undefined) {
    throw new Error(
      `Symbol "${functionName}" not found in frog_us.map. ` +
        `Either it doesn't exist or the build is stale (rerun \`make -j8\`).`,
    );
  }

  // Sort all symbols by address to find prev/next.
  const sorted = [...addressMap.entries()]
    .filter(([, addr]) => addr >= ROM_BASE) // exclude EWRAM/IWRAM/MMIO symbols
    .sort((a, b) => a[1] - b[1]);

  const idx = sorted.findIndex(([name]) => name === functionName);
  if (idx === -1) {
    // Shouldn't happen — addressMap has it but sorted doesn't (means it's < ROM_BASE)
    throw new Error(`Symbol "${functionName}" at 0x${startAddr.toString(16)} is below ROM_BASE 0x${ROM_BASE.toString(16)}.`);
  }

  // Skip duplicate entries at the same address (e.g., labels at function start).
  let nextIdx = idx + 1;
  while (nextIdx < sorted.length && sorted[nextIdx][1] === startAddr) {
    nextIdx++;
  }

  const nextSymbol = nextIdx < sorted.length ? sorted[nextIdx][0] : null;
  const endAddr = nextIdx < sorted.length ? sorted[nextIdx][1] : -1;

  if (endAddr === -1) {
    throw new Error(
      `"${functionName}" appears to be the last symbol in the map; cannot derive end address.`,
    );
  }

  // Find prev symbol (different address, immediately before).
  let prevIdx = idx - 1;
  while (prevIdx >= 0 && sorted[prevIdx][1] === startAddr) {
    prevIdx--;
  }
  const prevSymbol = prevIdx >= 0 ? sorted[prevIdx][0] : null;

  return {
    name: functionName,
    start: startAddr,
    end: endAddr,
    size: endAddr - startAddr,
    nextSymbol,
    prevSymbol,
    fileOffset: startAddr - ROM_BASE,
  };
}

export function readBytes(result: ExtractResult): Buffer {
  const baserom = findBaserom();
  const fd = fs.openSync(baserom, 'r');
  try {
    const buf = Buffer.alloc(result.size);
    fs.readSync(fd, buf, 0, result.size, result.fileOffset);
    return buf;
  } finally {
    fs.closeSync(fd);
  }
}

export function disassembleThumb(result: ExtractResult): string {
  const baserom = findBaserom();
  // With --adjust-vma, --start-address / --stop-address must be the adjusted
  // (post-shift) values, not the file offsets.
  const out = execFileSync(
    'arm-none-eabi-objdump',
    [
      '-D',
      '-b',
      'binary',
      '-m',
      'arm7tdmi',
      '-Mforce-thumb',
      `--adjust-vma=0x${ROM_BASE.toString(16)}`,
      `--start-address=0x${result.start.toString(16)}`,
      `--stop-address=0x${result.end.toString(16)}`,
      baserom,
    ],
    { encoding: 'utf-8', maxBuffer: 16 * 1024 * 1024 },
  );
  return out;
}

function formatHexDump(bytes: Buffer, startAddr: number): string {
  const lines: string[] = [];
  for (let i = 0; i < bytes.length; i += 16) {
    const chunk = bytes.subarray(i, Math.min(i + 16, bytes.length));
    const addr = (startAddr + i).toString(16).padStart(8, '0');
    const hex = [...chunk].map((b) => b.toString(16).padStart(2, '0')).join(' ');
    lines.push(`0x${addr}  ${hex}`);
  }
  return lines.join('\n');
}

function main() {
  const args = process.argv.slice(2);
  if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
    process.stderr.write(
      'Usage: extract-function-bytes <FunctionName> [--asm | --bytes | --json]\n' +
        '\n' +
        'Reports the authoritative ROM byte range for a symbol, derived from\n' +
        'frog_us.map. Use to validate peel boundaries.\n',
    );
    process.exit(args.length === 0 ? 1 : 0);
  }

  const fnName = args[0];
  const showAsm = args.includes('--asm');
  const showBytes = args.includes('--bytes');
  const asJson = args.includes('--json');

  let result: ExtractResult;
  try {
    result = extract(fnName);
  } catch (e) {
    process.stderr.write(`error: ${(e as Error).message}\n`);
    process.exit(1);
  }

  if (asJson) {
    const payload: Record<string, unknown> = {
      ...result,
      startHex: `0x${result.start.toString(16)}`,
      endHex: `0x${result.end.toString(16)}`,
    };
    if (showBytes) {
      payload.bytesHex = readBytes(result).toString('hex');
    }
    if (showAsm) {
      payload.disasm = disassembleThumb(result);
    }
    process.stdout.write(JSON.stringify(payload, null, 2) + '\n');
    return;
  }

  const lines: string[] = [];
  lines.push(`Function: ${result.name}`);
  lines.push(`Start:    0x${result.start.toString(16).padStart(8, '0')}`);
  lines.push(`End:      0x${result.end.toString(16).padStart(8, '0')}  (exclusive)`);
  lines.push(`Size:     ${result.size} bytes`);
  lines.push(`Prev:     ${result.prevSymbol ?? '(none)'}`);
  lines.push(`Next:     ${result.nextSymbol ?? '(none)'}`);
  lines.push('');

  if (showBytes) {
    lines.push('Bytes:');
    lines.push(formatHexDump(readBytes(result), result.start));
    lines.push('');
  }

  if (showAsm) {
    lines.push('Disassembly (Thumb):');
    lines.push(disassembleThumb(result));
  }

  process.stdout.write(lines.join('\n') + (lines[lines.length - 1] ? '\n' : ''));
}

const isMain = import.meta.url === `file://${process.argv[1]}` || process.argv[1]?.endsWith('extract-function-bytes.ts');
if (isMain) {
  main();
}
