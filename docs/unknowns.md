# Unknowns

Open questions and hypotheses. Each entry should be specific enough that
a future agent can resolve it or close it as untestable.

## `sub_08000240` — exact purpose

ARM, 100 bytes. Pattern looks like a manually-wrapped `IntrWait` or
`VBlankIntrWait`:
- Reads a state flag at `0x082F9010`
- If non-zero: temporarily clears the VBlank bit in `REG_IE`, enables
  IRQs globally (clears CPSR I-bit), calls the thumb handler at
  `0x0802FFD8`, restores `REG_IE`
- If zero: skips the IRQ wrangling and just calls the same handler

**Hypothesis:** the thumb handler is a synchronous VBlank-tied tick.
The state flag toggles whether the tick is "wait for VBlank" vs
"just run". To confirm, decomp the thumb handler at `0x0802FFD8`.

## Thumb function at `0x0802FFD8`

Called by `sub_08000240`. Likely the actual VBlank work routine. Far
into ROM — needs a peel + decomp pass. The thumb-bit form `0x0802FFD9`
is what's stored in IntrMain's literal pool at `0x0800023C`.

## `gIntrTable` (`0x08035D9C`)

Function-pointer table indexed by `(IRQ_source * 4)`. 13 entries cover
VBlank/HBlank/VCount/Timer0-3/Serial/DMA0-3/KEYPAD. Needs to be
extracted as a typed C array (`InterruptCallback gIntrTable[13];`)
once the handler functions get decompiled.

## `GameStuff` struct layout (`0x03005330`)

Known fields:
- offset 9: `mode` — dispatched by AgbMain's switch. AgbMain init writes 4.
- offset 10: `pendingMode` — written by the 7 `SetGameMode_NN` helpers
  with values 3, 6, 7, 8, 9, 12, 15. **Nothing currently decompiled reads
  this field.** Whatever reads it lives somewhere we haven't peeled yet.

  Hypotheses:
  - "Pending"/"requested" mode that a separate routine eventually copies
    into `mode` (offset 9) — would explain why the setters exist but
    don't directly drive dispatch.
  - "Last mode" / "previous mode" record — but then we'd expect more than
    7 distinct values across the call sites.
  - Secondary state for a parallel subsystem (audio, save, networking).

  To resolve: find the `ldrb [r?, #10]` callers in the ROM and look at
  what they do with the value. Likely candidates are AgbMain's case
  bodies and any "tick" routine called from VBlank IRQ.

Other fields referenced from `AgbMain`'s callees but unmapped. Watch
for `ldr r1, =0x03005330` followed by `ldrh/ldrb/ldr [r1, #N]` to
enumerate fields.

## Other EWRAM/IWRAM pointers in `AgbMain`'s literal pool

`AgbMain` literal pool 2 (0x4A4-0x4C3) names these IWRAM addresses:
`0x03003480`, `0x030034A0`, `0x030034B0`, `0x030034B4`, `0x03003550`,
`0x030035E0`. Each is presumably a different game-subsystem state
structure. Names should fall out as each subsystem is decompiled.

Init1 (`sub_08000430`) writes byte patterns into each that look like
default-config values (see `subsystems.md`):
- `[0x030034B4+0..1] = 1`, `[+2..3] = 5` — four-byte tuple; possibly a
  default `{flag, flag, count, count}` or `{x, y, w, h}`.
- `[0x030035E0] = 5` — single-byte initial state.
- `[0x03003550] = 16-byte halfword block of zeros` — looks like a small
  RAM ring buffer or coord array.

These hints aren't enough to name the subsystems yet; revisit once one
of the `sub_08017364` / `sub_0800072C` / `sub_08000820` callees is
decompiled (they consume these IWRAM structs immediately after Init1
writes them).

## `sub_08000430`'s call targets

Init1 calls four functions whose bodies are still inside the raw
`text_0x*.o` blobs:

- `sub_08020B30` — called first thing, before any state init. Probably
  hardware init (sound, DMA, BIOS-tier setup) given its precedence.
- `sub_08017364` — called after IWRAM-struct init but before the
  halfword zero-fill of 0x03003550. Likely a "subsystem A init" that
  needs the IWRAM bases ready.
- `sub_0800072C` — called immediately after `sub_08017364`. Possibly a
  paired routine ("subsystem B" or a continuation).
- `sub_08000820` — called after the halfword zero-fill, just before
  `REG_DISPCNT = 0x1F40`. Likely the renderer/sprite init that needs
  the zeroed buffer at 0x03003550.

Peeling these in baserom-address order would unblock the C decomp of
Init1 (see `codegen-notes.md`, "Cross-region Thumb BL targets" for
why).

### Init1 decomp attempt — open blocker: agbcc CSE-folds adjacent IWRAM bases

All four BL targets are now peeled (commit `b8415d7` + earlier), so the
Thumb BL relocations resolve cleanly. The remaining matching blocker is
register-coloring / literal-pool ordering:

The baserom emits a SEPARATE `ldr` for each IWRAM base address. e.g.
0x03003480 then 0x030034a0 are loaded with two distinct `ldr rN, [pc, ...]`
instructions. But agbcc CSE-folds the second base via `adds rN, #32`
because 0x030034a0 - 0x03003480 = 32 (small Thumb immediate). Same
trap for 0x030034b4 (= +0x14 from 0x030034a0) and 0x030034b0 (= -0x4
from 0x030034b4).

Approaches tried (none produced a match):

1. Two C scopes with separate `u8 *p_3480 = ...; u8 *p_34a0 = ...;` locals
   — agbcc CSE'd across the block boundary.
2. Scopes separated by `asm volatile ("" : : : "memory")` — same fold.
3. `vu8 *p_34a0` (volatile-qualified target) — same fold.
4. Register-pinned p_34a0 (`register u8 *p_34a0 asm("r0")`) — same fold.
5. Struct-typed pointers (`struct s_3480` vs `struct s_34a0`) — fold
   shifted to the next pair (0x030034a0 → 0x030034b4 via `adds r1, #20`).
6. Pure `*(volatile u8 *)0x030034a1 = 0` style with offsetted absolute
   addresses — agbcc emits one `ldr` per write, totally wrong shape.
7. Inline `asm ("ldr %0, =0x030034a0" : "=r"(p_34a0))` — forces a fresh
   literal but gas places it OUTSIDE agbcc's own literal pool, growing
   the function by 4 bytes (148 not 144).

Best diff so far: 13 instruction-level mismatches, 22 byte_diff. The
core issue: agbcc 2.x's `loop_optimize` / `combine` passes CSE constant
addresses that differ by ≤256 bytes. Until we find a way to defeat that
specifically, Init1 stays in asm.

Hypothesis to try next: structurally rearrange the source so all writes
to a given base happen contiguously WITHOUT a base re-load in between
(maybe a single struct typedef covering 0x03003480..0x030035e0 — but the
holes between bases are big enough that the resulting struct would be
512+ bytes, and field-offsets > 124 don't fit in Thumb immediate offset
encoding so agbcc would emit `ldr rN, =&struct+offset` per write anyway,
defeating the purpose).

A second hypothesis: this might be one of those cases where the original
TU was built with a slightly different compiler version (different
`-fno-cse-skip-blocks` or pass ordering). Worth a `decomp-permuter`
attempt once that pipeline is wired up.

**Permuter result (2026-05-25):** decomp-permuter wired up
(`scripts/permuter-compile-agbcc.sh`) and run against this function for
~15 minutes. Best score 90 (byte_diff), worse than the manual 22 the
previous agent achieved. Permuter started from a worse base.c — its
output exposed only minor variations on the same `u8 *p_3480 = (u8 *)
0x03003480; …` shape that doesn't crack the fold.

**Solution found via Phase D corpus search (2026-05-25):** see
`docs/codegen-notes.md` "Adjacent IWRAM bases — defeat CSE-fold via
linker-assigned symbols". The fix is to stop casting absolute
addresses in C and instead declare each IWRAM base as a real C global
with a linker-assigned address (`. = 0x00003480; gIwram_3480 = .;` in
`linker.ld`). agbcc has no compile-time addresses to fold; the
literal pool gets one entry per unique symbol; ld resolves each at
link time. Pattern verified in `testyourmine/cvaos` for the analogous
`gUnk_03002CB0` / `gDisplayRegisters` pair.

**Resolved (2026-05-25)** — landed as `src/system/init1.c` +
`include/iwram.h` + six dot-pinned symbols in `linker.ld`'s
`iwram (NOLOAD)` section. First-try match — no permuter needed.
The linker-symbol substitution alone cracked the CSE fold; agbcc
emits one `ldr =gIwram_NNNN` per unique base and ld resolves each at
link time. Function-level `byte_diff: 0` confirmed via
`compile_and_view_assembly.py sub_08000430 --human`.

## `sub_0802F4B0` (sound mixer tick)

VBlank-tick of the custom sound engine. 462 Thumb instructions / 960
bytes. Body still `.incbin`'d in `asm/disasm_0x0802f4b0.s`. Destination
scaffolded at `src/system/sound_mixer.c`. State struct hypothesis is in
`subsystems.md` (Audio / sound).

**Decomp blocker (the primary one):**

m2c can't seed pseudo-C from a `.incbin`'d function body — see
`tools/agent/decomp_brief.py` output, "(m2c can't seed this function —
its body is still .incbin'd. Refine the asm to mnemonics first...)".
And 462 instructions of mixer-shaped agbcc Thumb is well past the
hand-translation budget for a single session, especially without the
m2c shape to lean on.

**Plan to unblock:**

1. Refine `asm/disasm_0x0802f4b0.s` from `.incbin "...", 0x2f4b0, 0x3c0`
   to actual Thumb mnemonics (`.short` directives → assembler picks
   matching encodings if we're careful, OR plain mnemonic source where
   we trust agbcc's chosen encoding for each pattern). This is mostly
   a mechanical port from the objdump output (`arm-none-eabi-objdump
   -D -b binary -m arm7tdmi -Mforce-thumb --start-address=0x2f4b0
   --stop-address=0x2f870 frog_us_baserom.gba`), with care for:
   - Pool literals that decode as instructions — keep them as `.4byte`
     in the pool region after the function body.
   - Mid-function pool addressing (the function has a pool slab around
     0x2f6bc-0x2f70c that's reached via a `b.n 0x2f6f4` jump-into-pool
     followed by code that resumes at 0x2f6d4).
   - The mode-switch via `bx r0` (interwork epilogue, not `pop {pc}`).
2. Re-run `tools/agent/decomp_brief.py sub_0802F4B0` to confirm m2c
   now seeds. Expect rough/ugly C but with the correct branching
   structure.
3. Iteratively shape the seed into matching agbcc-style C using
   `compile_and_view_assembly.py sub_0802F4B0 --human`, applying the
   register-pin / `vu*` / interwork-thunk tricks from
   `codegen-notes.md`.
4. The sound state struct (`SoundSystem *` at `0x030065e0`) needs a
   proper header before C can reference fields by name — see
   `subsystems.md` for the field table. Likely lands in
   `include/system/sound_mixer.h`. Note: 0x030065e0 is the
   POINTER-slot, not the state itself; the state's actual address is
   computed at boot.

**Anti-plan:** trying to hand-write 460 instructions of agbcc Thumb-2.x
mixer code from objdump alone, without m2c, almost certainly produces
a non-matching result. Don't attempt without (1) above.

## Compiler patch

The `-f2003-patch` flag in `testyourmine/cvaos` (Castlevania: Aria of
Sorrow, also Konami GBA, also 2003) is a custom agbcc patch we don't
have. If a function persistently misses by a small margin and the C
looks right, try applying that patch.

## Region variants

`Makefile` has `REGION ?= us` with hooks for EU/JP. Frogger's Adventures
shipped in multiple regions but no other baserom is checked in. Worth
verifying region differences are small (the engine should be identical;
only text/audio/data should change) before deep work.

## sub_0802EDF0 — stream-cursor advancer, blocked at ~207 byte_diff

132-instruction sound-system per-frame leaf. Asm slice refined to real
Thumb mnemonics (matching) but C decomp stuck on two structural issues
agbcc 2.x doesn't seem to express cleanly:

1. **Prologue gpSS preload + count-check entry**: Baserom has
   `ldr r0, [r1]; mov sl, r1; b _0802EEE4` where `_0802EEE4` is INSIDE
   the loop-end count-check (after a paired `mov r1, sl; ldr r0, [r1]`
   on the iteration-end path). The b skips those re-loads on the first
   iteration. No C source structure tried (pinned register variable,
   opaque asm("") fence on ss, explicit ss-as-arg passthrough) kept
   the preload live across the b.n — agbcc's DCE removes it because
   `ss` is reassigned at the body's `ss = *gpsp` line.

2. **Register allocation drift in the active block**: Pinning the
   "outer" variables {gpsp→sl, i→r9, overflow→r8, stream→r7,
   remaining→r6} gets us close (function size 256 vs target 264) but
   agbcc allocates {ss, slot, env} to {r2, r3, r2} where baserom uses
   {r4, r2, r3}. Pinning ss→r4 spills locals in the active block;
   pinning both ss and slot makes the active block reload
   stream/head/field8/field10 from the stack.

**Permuter run** (4 threads, ~2000 iterations): best score 2725 vs
base 3410 — no breakthrough mutation. Best mutation found was caching
`stream->field10` into a local; applied to the in-tree C, it shifts
byte_diff slightly without breakthrough. The permuter setup is at
`nonmatchings/sub_0802EDF0/` for next-agent reuse.

**Status:** asm slice kept matching, C function not landed, comment
added in `src/system/sound_channel.c` documenting the blockers for
the next agent. Suggested next attempts:
- Try `old_agbcc` instead of `agbcc` (per the existing per-TU override
  pattern for sub_08033910).
- Permuter run from a base that explicitly uses ss→r4 pinning,
  accepting the spills, to see if permuter can rearrange them away.
- Look in the corpus for an agbcc 2.x function that mixes the "prologue
  load + shared count-check" pattern; if it exists, copy the source
  shape.

### Corpus search (Phase D) — verdict: NOVEL

Searched the curated agbcc corpus (testyourmine/cvaos, metroidret/mf,
metroidret/mzm, pret/{pokeruby,pokeemerald,pokefirered,pokepinballrs})
for prior art on the two structural blockers. Decisive negative result
across multiple angles.

**Queries that mattered:**
- `corpus.py grep 'mov\s+sl,' --asm` → 966 hits across 3 repos
  (cvaos, mf, mzm), ALL in unrefined `disasm_*.s` or m4a's `.s` libs.
  ZERO appearances in compiled-and-matching C.
- `corpus.py grep 'asm\("sl"\)' --c` and `'asm\("r10"\)'` → 0 and 1
  hits respectively. The one r10 hit is `pret/pokeruby:src/shop.c:758`
  (`Shop_MoveItemListUp`) — and it's inside `#ifdef NONMATCHING`,
  with a `NAKED` asm fallback for the real build (see lines 753–887).
- `grep -rn 'register.*asm("r9"|"r10"|"sl"|"sb"|"r8")'` filesystem-wide →
  4 total hits across the entire corpus:
  - `pret/pokeruby:src/palette.c:152` — `register T x asm("r8") = expr;`
    pin-on-init for a single arg; matches but trivial shape.
  - `metroidret/mf:src/sa_x.c:1045` — `register s32 tmp asm("r8");`
    used as a sentinel `tmp = ++ended;` "fake match" assignment; not
    carrying loop state.
  - `pret/pokepinballrs:src/high_scores.c:986` — `register T *p asm("r9") = expr;`
    inside `#ifdef NONMATCHING` (file falls back to NAKED for the
    real build at line 1093).
  - `pret/pokeruby:src/shop.c:758` — same NONMATCHING/NAKED pattern.
- `corpus.py grep 'goto\s+\w+' --c` → 363 hits across 49 files; none
  match the "prologue branch into the bottom-of-loop count check"
  shape. Most-common labels are `fail` (109), `END` (10), and
  audio-state machine labels in m4a (envelope_*, oscillator_off,
  channel_complete) — but those are intra-state-machine transitions
  inside one iteration, never `b _loop_count_check` from prologue.
- `corpus.py grep 'asm\s*\("":::"r' --c` → 8 hits (DCE/clobber fences).
  Useful pattern (and we used a variant), but none in a prologue-share-
  count-check shape; all are mid-function register-allocation nudges.

**Smoking-gun evidence:** Even the canonical Konami GBA audio mixer
in `testyourmine/cvaos:asm/m4a0.s` (4 `mov sl, ...` instances) and the
pret family's `src/libs/m4a_1.s` / `src/m4a_1.s` (m4a internals across
ruby/emerald/firered) are LEFT IN ASM, not decompiled. The pret m4a.c
files only cover the high-level player wrappers (`FadeOutBody`,
`m4aMPlayStop`, etc.), which use `register T x asm("rN")` for low
registers only — they never touch sl/r10. `metroidret/mf:src/dma.c:99`
shows the same pattern at infrastructure level: `BitFill` has a
NON_MATCHING C version + a NAKED asm fallback because the asm uses
`mov sl, r4` and `mov sb, r5`. The pret/MF teams have spent thousands
of commits on agbcc decomp and consistently NAKED-asm any function
that wants r10.

**What the corpus rules in:**
- `register T x asm("rN") = expr;` pin-on-init for **low** registers
  (r4-r7) is widely-used and reliably anchors a register. We already
  tried this for `gpsp` and got partway there. Worth one more pass
  pinning `gpsp` and `ss` simultaneously this way.
- `asm("":::"rN");` clobber-fence to force the compiler to spill/reload.
  We tried `asm("" :::)` variants in prior attempt without
  breakthrough — but the corpus uses these single-register clobbers
  (not multi-) and inside the function body rather than at the top.
  A targeted clobber at the loop entry point (force r0 to be live
  across the prologue→count-check branch) is one more thing to try.

**What the corpus rules out:**
- No "prologue ldr + branch into shared count-check" idiom exists in
  matched C anywhere in the corpus. Two possible reasons: (a) agbcc 2.x
  literally cannot produce this CFG from any plausible C source — the
  prologue preload comes from a hand-written asm template or a custom
  toolchain patch Konami used, OR (b) decomp teams consistently
  side-step it via NAKED-asm rather than fight it.
- No `register T x asm("sl")` / `asm("r10")` / `asm("sb")` ever lands
  outside `#ifdef NONMATCHING`. Spending more permuter time on a C
  source structure that pins sl is likely a dead end.

**Verdict: NOVEL.** The corpus has no idiom to ADOPT or ADAPT. The
two structural blockers (prologue-share-count-check CFG + sl pinning)
are the same ones every agbcc decomp team has hit and consistently
worked around with NAKED asm.

**Recommended path forward** (in priority order):

1. **Accept NAKED asm.** The asm slice is already refined and matching;
   wrap it in `NAKED` with a `#ifdef NON_MATCHING` C body next to it,
   exactly as `metroidret/mf:src/dma.c:BitFill` and
   `pret/pokeruby:src/shop.c:Shop_MoveItemListUp` do. This is the
   corpus-validated answer for this exact problem class. Doesn't
   decrement `asm_funcs_remaining` (we'd keep the asm), but it would
   move the function from `asm/disasm_0x0802edf0.s` into
   `src/system/sound_channel.c` near its siblings, in a form that's
   readable for porting purposes (phase 3) even if not C-matching.

2. **Targeted permuter mutation** (if a real C match is required).
   The permuter is unlikely to find the right shape with default
   `PERM_GENERAL`/`PERM_LINESWAP` because the answer lives in a
   register-allocation space that mainstream agbcc doesn't reach
   from any C input. A custom run with these macros would be needed:
   - `PERM_GENERAL` over the **prologue gpsp load** — try every
     ordering of `gpsp = &gpSoundSystem; ss = *gpsp; count = ss->count;`
     with each subset wrapped in a no-op `asm` fence.
   - `PERM_LINESWAP` to permute the order of `register T x asm("rN")`
     declarations (their textual order seems to influence agbcc 2.x's
     allocation pass).
   - `PERM_RANDOMIZE_TYPE` over the count variable (s32/u32/int) — the
     bottom count-check uses `ldrb r0, [r0, #0]` which is u8-typed in
     the baserom; mixing u8/s8/int for the loop bound at multiple sites
     might dislodge the fold.
   - Estimated budget: 5k-10k iterations to even sample the relevant
     state space, vs. the 2k we ran with default mutations. Even then,
     low probability of success based on corpus evidence.

3. **Try `old_agbcc` per-TU override.** The corpus doesn't tell us
   which agbcc variant Konami used for the audio engine in this title
   — pret family uses `agbcc`, mzm/mf use `agbcc`, but pokepinballrs's
   m4a quirks suggest different toolchains may have been involved.
   `src/Makefile` already has a per-TU `OLD_AGBCC` override (see
   `sub_08033910` precedent in docs/codegen-notes.md). Worth one build
   with sound_channel.o forced through `old_agbcc` to see if it
   alleviates either blocker.

Recommend option 1 (NAKED + NON_MATCHING C scaffold) for now. It is
the documented best-practice answer in the corpus for exactly this
class of un-matchable agbcc function, gets the function into its
semantic home in `src/system/sound_channel.c`, and unblocks any
adjacent decomps in the same file.
