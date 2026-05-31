# sub_0802EA2C — Deferred analysis (Opus round 2)

Range: 0x0802ea2c..0x0802ea80 (84 bytes). Destination:
src/system/sound_envelope_dual.c (after the NAKED sub_0802E934).

## Summary

Envelope-A0 parameter setter. Writes step (s16), countdown (u8) and
reload (u8) for channel `ch`'s envelope-A0 sub-block — the structure
sub_0802EA80 ticks. Signature is `(s32 step, u32 reload, s32 ch)`
(r0=step→r5, r1=reload→r4, r2=ch; params are 32-bit — no widening
prologue). Three paths:
- ch <= 2: inline channel blocks at `*gpSoundSystem + ch*36`; reload at
  +57, countdown(=reload>>1) at +56, step at +54.
- ch == 3: no-op.
- ch >= 4: dynamic slot bank via `*(gpSoundSystem->+0xc8) + ch*64 - 0xec`;
  reload at +5, countdown(=reload>>1) at +4, step at +2.

## Progress this round: byte_diff 5 in PURE C (no asm barriers)

The prior round reached byte_diff 5 but ONLY with `asm("")` barriers in
the dynamic ("big slot") block. THIS round reaches the SAME byte_diff 5
with a fully PURE-C body (no NAKED, no inline asm, no NON_MATCHING) — a
strictly cleaner base. The breakthrough was the dynamic block:

```c
{
    u8 **bankp = (u8 **)((u8 *)gpSoundSystem + 0xc8);
    u8 *slot = (u8 *)(ch * 64 + (s32)*bankp - 0xec);   /* index-first */
    ...
}
```

Splitting the swSlots deref into a NAMED `u8 **bankp` local and then
forming the slot pointer as INTEGER arithmetic with the index first
(`ch*64 + (s32)*bankp`) makes agbcc emit the baserom's exact dynamic
block: `ldr r1,[r0]; adds r1,#0xc8; lsls r0,r2,#6; ldr r1,[r1];
adds r0,r0,r1; subs r0,#0xec` (index-first add, chain held in r1). This
matched the dynamic block BYTE-FOR-BYTE in pure C — the prior round's
asm barriers there are unnecessary. Same family as the
sub_0800A328 / sub_08006FEC "index-first pointer cast" idiom in
docs/codegen-notes.md §"Reclamation idioms".

## Remaining drift: byte_diff 5, diff_count 3 — ALL in the static block

Best pure-C base (the committed best-effort C below) drifts at:
1. fn+0x14: `adds r0, r1, r0` (0x1808, offset-first) vs target
   `adds r0, r0, r1` (0x1840, base-first) — store-1's address add.
2. fn+0x1e/0x20: 2-instruction SCHEDULE swap. Target store-2 is
   `adds r0,r0,r1; lsrs r2,r4,#1; adds r0,#56`; built emits
   `adds r0,r0,r1; adds r0,#56; lsrs r2,r4,#1` (value-shift AFTER the
   +56 const-add instead of between the two adds).

## Root cause (read the compiler, not just the diff)

The two issues are coupled to an irreducible 3-way tension in agbcc's
combine + scheduler under the forced gpSoundSystem-reload pattern. The
baserom reloads `*gpSoundSystem` at EACH of the three stores
(`ldr r0,[r3]` x3, r3=&gp held from pool) and holds `ch*36` in r1.

- **store-1 base-first** requires `ch*36` to be a MATERIALIZED plain
  register at the add. combine.c (gcc/thumb.md `addsi3`, and
  combine.c:3354 "put a complex expression first") swaps the operands
  so the non-'o'-class (MULT) operand becomes %1 → offset-first —
  WHENEVER the mult is adjacent/fresh at the add (store-1's case).
  Stores 2&3 get base-first for free because `off` is then an
  "established" plain REG (class 'o') and combine leaves source order.
- **Materializing `off` before store-1** (off-first initializer, or
  `asm("")` barrier on off, or `register s32 off asm("r1")` init) DOES
  give store-1 base-first — but it pulls the `ch*36` mult chain BEFORE
  the pool load (`ldr r3; ldr r0`), because the mult has no dependency
  and the scheduler/emitter front-loads it. Target has pool-load FIRST,
  mult SECOND. So you trade the store-1 byte for a pool-order 2-insn
  reorder (byte_diff 13–17) — no net win.
- **Forcing the pool load first** (load `base=(u8*)gpSoundSystem` into a
  pinned/barriered local before computing off) does restore pool-first
  order — but agbcc then CSE-folds `base` back into a fresh
  `ldr r0,[r3]` reload at store-1 (reload is cheaper than keeping base
  live), re-adjacenting the mult → offset-first AGAIN (back to
  byte_diff 5). The forced reload defeats every attempt to keep the
  base an "established" plain reg at store-1.
- **off-first also moves `ch` out of r2** (to r3, a call-clobbered reg —
  NOT a prologue cost) because `ch` is reused by the dynamic block's
  `ch*64`; pinning `off` to r1 keeps ch in r2 but leaves the pool-order
  drift (byte_diff 13). The baserom keeps ch in r2 AND off materialized
  before store-1 because its `ch*36` is computed INSIDE the ch<=2 branch
  (ch dead on the returning path) — agbcc's local-alloc nonetheless
  keeps ch live across the bgt join.

The net: store-1-base-first, pool-load-first, and ch-in-r2 are pairwise
satisfiable but NOT simultaneously satisfiable from any C structure I
found. This smells like the baserom agbcc build had a marginally
different combine↔scheduler interaction (or a flag) than our agbcc /
old_agbcc — both of ours produce identical byte_diff-5 output here.

## Levers tried this round (all FAIL to reach 0)

- Pure-C structures (≥15 distinct): inline ch*36; `off` after store-1
  (byte_diff 9 → 5 once dynamic fixed); `off` as initializer (76, ch→r3
  churn); `off` pinned r1 init (13, pool-order); `off` pinned r1 after
  store-1 (9); `u8 *p`/`u8 *base` pointer anchors; shared `p` across
  blocks (85/92); store reorder 54/56/57 (no change — agbcc emits in
  offset order regardless); `(u8*)gp` subscript form `((u8*)gp)[idx]`;
  `(s32)(u8*)gp + ...` int-cast base-first; explicit `(ch*9)<<2`
  (77, worse); `SoundSystem **pp` anchor; `u8 *half`/`u32 half` local
  (80 — adds push {r6}, register churn; baserom recomputes reload>>1
  from r4 each block, so a shared local is wrong).
- asm("") barriers: on off only (17, base-first but pool reorder); on
  base only (9); on base+off together (5, CSE-folds base back to reload).
- `register asm("rN")` pins: off→r1, base→r0, idx→r0, bank→r1, c(ch)→r2
  (the last gave 52 — explicit r2 var disrupts the prologue/params).
- Flags: OLD_AGBCC for the TU (identical byte_diff 5/13 — same combine &
  schedule as agbcc); `-fno-gcse` (no effect on the hoist);
  `-fno-schedule-insns(2)` (agbcc rejects the flag).
- Index-first on the STATIC block (made it worse / hoisted the mult).
- bankp pinned r1 in dynamic (collapsed the split chain — the pure
  unpinned `u8 **bankp` + index-first int-add is what matches).

## Permuter

- Base byte_diff-9 base: score 95, 417 iters in smoke + ~800 in full
  (50s) → ZERO improvement, no score 0.
- Base byte_diff-5 base (pure C, this round): base score 70, ~50s,
  ~700+ iters at score 70 → ZERO improvement, no score 0.
- Confirms statement-mutation cannot reach the residual; the fix is a
  compiler-interaction / structural idiom the permuter can't invent.

## Next agent should try

- A C structure that keeps `ch` in r2, materialises `ch*36` into r1 as a
  plain reg AFTER the pool load but BEFORE store-1's add, and survives
  the gpSoundSystem reload-at-each-store. The reload-fold is the wall —
  look for a way to make store-1 NOT reload gp (use a base held across
  store-1 only) while stores 2&3 reload, WITHOUT agbcc CSE-folding the
  held base back into a reload. Maybe a `volatile`-qualified single read
  bound to store-1, or splitting store-1 into its own scope.
- Read gcc/thumb.md `addsi3` + combine.c:3354 ("complex first") and
  local-alloc/reload for WHY the reload-fold re-adjacents the mult; the
  lever may be preventing the fold (a use of `base` between the load and
  store-1 that pins it as class-'o' established).
- The 2-insn schedule swap (issue 2) is likely the SAME combine/sched
  interaction; if issue 1 is solved by a base-held-across-store-1 form,
  issue 2 may fall out too (the target interleaves the lsrs into the
  store-1→store-2 r0 dependency chain).

## Best-effort C (PURE C, byte_diff 5, diff_count 3 — dynamic block matches exactly)

```c
void sub_0802EA2C(s32 step, u32 reload, s32 ch)
{
    if (ch <= 2) {
        s32 off;

        *(u8 *)((u8 *)gpSoundSystem + ch * 36 + 57) = reload;
        off = ch * 36;
        *(u8 *)((u8 *)gpSoundSystem + off + 56) = reload >> 1;
        *(s16 *)((u8 *)gpSoundSystem + off + 54) = step;
        return;
    }

    if (ch <= 3)
        return;

    {
        u8 **bankp = (u8 **)((u8 *)gpSoundSystem + 0xc8);
        u8 *slot = (u8 *)(ch * 64 + (s32)*bankp - 0xec);
        slot[5] = reload;
        slot[4] = reload >> 1;
        *(s16 *)(slot + 2) = step;
    }
}
```

Remaining 5 bytes (all static block): store-1 `adds r0,r1,r0` (0x1808)
vs target `adds r0,r0,r1` (0x1840); + the 2-instruction
`lsrs r2,r4,#1` / `adds r0,#56` schedule swap in store-2.
