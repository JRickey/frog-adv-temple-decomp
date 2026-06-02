# sub_0801F8BC — deferred analysis

Round 66. ATTEMPT function (pure game logic, no structural impossibility).
Semantics fully understood and reproduced; stuck at **byte_diff 4 / diff_count 2**
on a single robust RTL load-ordering quirk.

## What the function does

Signature: `int sub_0801F8BC(u8 arg0)` (returns the result of the tail call
`sub_0801F970(arg0)`, which itself returns 0 — the return value flows through, which
is why the baseline epilogue is `pop {r1}; bx r1` preserving r0).

Stack struct (16 bytes via `sub sp,#16`):
```c
struct { u8 name[10]; u8 pad[2]; u32 attr; } s;   /* attr at offset 12 */
```
1. `sub_0803578C(s.name, (const void*)0x081BE804, 10)` — memcpy of a 10-byte ROM
   blob (ASCII "fashfjsfa\0" at 0x081BE804) into `s.name`. `sub_0803578C` is memcpy
   (word-fast-path + byte tail, returns dst). Prototype: `void *sub_0803578C(void *dst,
   const void *src, u32 n)`.
2. `s.attr` (offset 12, *uninitialized* — memcpy only wrote 0..9) is packed byte-wise,
   every byte cleared-then-set, read once / stored as agbcc CSEs it into one register:
   - byte0 = 0x02   `(s.attr & 0xffffff00) | 0x02`
   - byte1 = 0x03   `(s.attr & 0xffff00ff) | 0x0300`
   - byte3 = 0x04   `(s.attr & 0x00ffffff) | 0x04000000`
   - byte2 = 0x1a   `(s.attr & 0xff00ffff) | 0x001a0000`
3. `switch (arg0)` overrides byte1: case0→0x03, case1→0x07, case2→0x0b, case3→0x0f
   (`(s.attr & 0xffff00ff) | val<<8`); default leaves the mainline value. The switch
   CSEs correctly (reuses the live r1 value + r2=0xffff00ff + r3 mask) — **the switch
   matches byte-for-byte**.
4. `sub_080196EC(&s.attr, (const void*)0x081D8398, 2)`  (proto: `void(u32*,const void*,u8)`)
5. `sub_080184DC(&s.attr, 5, 4, 2)`                     (proto: `void(u32*,u16,u16,u8)`)
6. `return sub_0801F970(arg0);`                          (proto: `int(u8)`)

## Drift

Only diff: the **first two loads after `bl memcpy` are swapped**.

- BASELINE: `0x12: ldr r0,[pc] (=0xffffff00)`  then  `0x14: ldr r1,[sp,#12]`  (const FIRST)
- BUILT:    `0x12: ldr r1,[sp,#12]`            then  `0x14: ldr r0,[pc] (=0xffffff00)` (mem FIRST)

Same registers (mem→r1, const→r0), only emission order differs. 4 bytes, 2 insns.

agbcc's instruction scheduler is **OFF** (`flag_schedule_insns=0`, `-O2` does NOT enable
it; `-fschedule-insns`/`-fschedule-insns2` are rejected by this agbcc build). So this is
an RTL-generation / local-alloc / reload ordering quirk, NOT a scheduling decision:
agbcc *always* evaluates the memory operand of `mem & const` before the constant operand,
and I could not find a C shape that flips it. The baseline materializes the const into
r0 (the just-freed memcpy-return reg) immediately after the `bl`, before the mem load.

## Levers tried (ALL still emit mem-load-first — pick a DIFFERENT angle next)

- operand swap `(0xffffff00 & s.attr)` — agbcc canonicalizes, no change
- intermediate `u32 t = s.attr; ...; s.attr = t;` vs operating directly on `s.attr` — same
- compound assignment `s.attr &= ...; s.attr |= ...;` (8 stmts) — same, rest still matches
- `~0xff` mask form — same
- const-as-variable `u32 m0 = 0xffffff00;` — CSE'd to pool, still mem-first
- pointer-via-memcpy-return `p = memcpy(...); p->attr = ...` — MUCH worse (keeps ptr in reg,
  `[r2,#12]` instead of `[sp,#12]`); baseline is stack-relative, so NOT a pointer.
- `register u32 t asm("r1")` pin + single store at end — worse (192B, breaks switch CSE)
- per-TU flag sweep, all STILL mem-first: `-fforce-addr`, `-fforce-mem`,
  `-fno-cse-follow-jumps`, `-fno-expensive-optimizations`, `-fno-omit-frame-pointer`
  (uses r7 frame ptr — wrong), `-fno-defer-pop`, `-fno-caller-saves`, `-fno-function-cse`,
  `-fno-peephole`, `-frerun-cse-after-loop`
- `CC=old_agbcc` — same
- PERMUTER: scaffolding is broken in-worktree — the only byte-exact target.o I could
  build is an `.incbin` of the ROM slice, which has NO relocations for the 4 external
  `bl`s, so the scorer reports a bogus base score ~11330 (vs the true ~8 for byte_diff 4).
  A valid permuter run needs a hand-resolved mnemonic target.s with symbolic `bl sub_XXXX`
  + a literal pool (.word 0x081be804/0xffffff00/0xffff00ff/0x00ffffff/0xff00ffff/0x081d8398).
  NEXT AGENT: build that proper target.s (the 4 bl targets are sub_0803578C @0x3578c,
  sub_080196EC @0x196ec, sub_080184DC @0x184dc, sub_0801F970 @0x1f970), import, and let
  the permuter mutate statement/scope to flip the two loads — this is exactly its niche
  (register-coloring/ordering drift from a near-match).

## Best-effort C (byte_diff 4, diff_count 2 — everything except the 2-insn load swap)

```c
#include "types.h"

extern void *sub_0803578C(void *dst, const void *src, u32 n);
extern void sub_080196EC(u32 *attr, const void *src, u8 arg2);
extern void sub_080184DC(u32 *attr, u16 arg1, u16 arg2, u8 arg3);
extern int sub_0801F970(u8 arg0);

int sub_0801F8BC(u8 arg0)
{
    struct {
        u8 name[10];
        u8 pad[2];
        u32 attr;
    } s;

    sub_0803578C(s.name, (const void *)0x081BE804, 10);

    s.attr = (s.attr & 0xffffff00) | 0x02;
    s.attr = (s.attr & 0xffff00ff) | 0x0300;
    s.attr = (s.attr & 0x00ffffff) | 0x04000000;
    s.attr = (s.attr & 0xff00ffff) | 0x001a0000;

    switch (arg0) {
    case 0:
        s.attr = (s.attr & 0xffff00ff) | 0x0300;
        break;
    case 1:
        s.attr = (s.attr & 0xffff00ff) | 0x0700;
        break;
    case 2:
        s.attr = (s.attr & 0xffff00ff) | 0x0b00;
        break;
    case 3:
        s.attr = (s.attr & 0xffff00ff) | 0x0f00;
        break;
    }

    sub_080196EC(&s.attr, (const void *)0x081D8398, 2);
    sub_080184DC(&s.attr, 5, 4, 2);
    return sub_0801F970(arg0);
}
```
