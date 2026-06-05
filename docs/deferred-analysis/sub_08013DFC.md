# Deferred analysis: sub_08013DFC

Range: 0x08013DFC-0x08013E94 (152 bytes, Thumb). Dest: src/engine/sub_08013d1c.c (tail).

Classifier: `ATTEMPT_MATCH`. Advisory only: high regs (`r8`/`r9`/`sl`) live across
`bl sub_0801185C`. NOT `STRONG_UNMATCHABLE` — do not ship NAKED.

## Semantics (confirmed via corpus)

This is the "pick a random entry and remove it from a list" idiom. The exact same
shape is in pret/pokeemerald `src/contest.c` (SetAiContestants /
SetLinkAIContestants) and pret/pokeruby `src/contest_2.c`, both pure-C agbcc:

```c
for (i = 0; i < count; i++) {
    rnd = Random() % count;
    pick(opponents[rnd]);
    for (j = rnd; opponents[j] != SENTINEL; j++)
        opponents[j] = opponents[j + 1];     // shift-compaction
    count--;
}
```

Frogger differs in two ways that matter for matching:
- The inner compaction terminates on a COUNT bound (`gIwram_549F`, which is the same
  byte as `arr[0xFF]` = `*limit`), not a sentinel. So it lowers to an `if (rnd <
  *limit) { do { ... } while (j < gIwram_549F); }` — the GUARD reads `*limit` (r7) and
  the LOOP reads the separate absolute symbol `gIwram_549F` (r6). They are DISTINCT
  expressions in the baserom (different pool literals); a single `for (j=rnd;
  j<gIwram_549F; j++)` regresses (77) because it makes the guard use gIwram_549F too.
- `j` is unsigned (`u8`): the baserom inner compare is `bcc` (unsigned). `int j`
  produces `blt` (signed) — wrong. Use `u8 j`.

Arrays (linker symbols; `gIwram_549F` ADDED by this analysis at 0x0300549F between
gIwram_53A0 and gIwram_60A0 — keep that linker.ld line, it is a prerequisite):
- `gIwram_53A0` = working array `arr`; `arr[0xFE]` = write index, `arr[0xFF]` = count.
- `gIwram_3610` = candidate list being compacted.

## Drift — the plateau is a sharp register-coloring / rematerialization local minimum

Two mutually-exclusive plateaus; no source shape or flag reaches both halves at once:

1. **Plain `j++` inner loop → byte_diff 35, CORRECT prologue (n in r8, 3 high regs).**
   Residual diff = (a) the rnd/j vs base color is SWAPPED (baserom rnd/j=r3, base=r2;
   ours rnd/j=r2, base=r3) and (b) the inner loop CSE-FOLDS `&gIwram_3610 + 1` into a
   loop-invariant hoisted constant (`adds r5, r3, #1` = base+1) instead of computing
   `next = j+1` once and adding the base freshly like the baserom.

2. **`int next = j+1; table[j]=table[next]; j=next;` (u8 j) → CORRECT inner loop**
   (single `next`, unsigned `bcc`, byte-identical inner structure) **but WRONG prologue**
   (size 144, only 2 high regs r8/r9, `n` falls to r7), and the color cascade flips.

### Instrumentation result (NEW — this is the key finding to act on)

Built a private debug old_agbcc with an `fprintf` probe in `gcc/global.c`'s `find_reg`
best_reg commit (`reg_renumber[...] = best_reg`), traced both forms:

- Plain form: **16** global pseudos allocated. The EXTRA one is the `&gIwram_3610+1`
  fold result (`pseudo=53 refs=5 -> r5`). Having 16 long-lived pseudos forces n
  (`pseudo=22 refs=4`) into **r8** and uses r8/r9/r10(sl) — the correct 3-high prologue.
- int-next form: **15** pseudos (no base+1 pseudo). One fewer reg needed → n → **r7**,
  only r8/r9 high.

So the +1 CSE-fold is simultaneously (a) the CAUSE of the wrong inner loop AND (b) the
load-bearing extra-pressure value that correctly forces n→r8. Removing the fold (the
int-next form) ALWAYS drops a register and demotes n. The two are COUPLED through
register pressure.

The baserom's equivalent 16th value is the **base `&gIwram_3610` kept RESIDENT across
the inner loop** (loaded once into r2 at 0x3a for the outer `gIwram_3610[rnd]` read,
then COPIED `adds r4, r2, #0` into the now-dead `i`'s r4 for the inner loop). Our agbcc
REMATERIALIZES the base constant inside the inner loop (a fresh `ldr rN,[pc]`) instead
of keeping the outer-read value live — because a constant-pool load is "cheap" to
recompute, agbcc's live-range analysis lets the outer-read base die. THIS
rematerialize-vs-keep-resident decision is the single divergence to defeat.

### Levers RULED OUT (do not re-try)

- Compiler swap `CC=$(AGBCC_BIN)` (newer agbcc): identical plateaus (35 / 144) on BOTH
  forms. Compiler choice is neutral here.
- Per-TU CFLAGS, all neutral-or-worse: `-fno-gcse` (126 on int-next; 54 on plain),
  `-fforce-addr` (140/2-high), `-fno-strength-reduce`, `-fno-cse-follow-jumps`,
  `-fno-rerun-cse-after-loop` (160), `-fno-schedule-insns(2)`, `-fno-peephole`,
  `-fcaller-saves`, `-fno-defer-pop`, `-fcse-skip-blocks`, `-funroll-loops`,
  `-fno-thread-jumps`, `-fno-expensive-optimizations`, `-ffixed-r2` (93).
- `register u8 count asm("r8") = n;` — keeps n in r8 but re-extends count to u8 every
  loop (QImode re-ext), size 160, byte_diff 89.
- `register u32 count asm("r8")` — pin dropped (pressure too low), 126/2-high.
- `register u8 rnd asm("r3")` — QImode re-ext explosion (113).
- `register u8 *table asm("r2"/"r4")` (caller/callee) with int-next — base not kept
  resident / conflicts with i; 127 / 130.
- Opaque `u8 *table = &gIwram_3610` (outer-scope, in-if, or inner-only) — always lowers
  pressure (n→r7); agbcc rematerializes the constant rather than keeping the pointer.
- `u8 *bound = &gIwram_549F` (resident bound pointer to add pressure) — 123, worse.
- Hoisting the `gIwram_3610[rnd]` outer read into a temp — 84.
- `(u8)(j+1)` cast on the index — re-extension, 132/2-high.

### Untried leads for the next attempt (pick a DIFFERENT lever)

1. **Permuter (the documented right tool here, but currently BLOCKED).** Function is
   corpus-confirmed-matchable + byte_diff 35 (≤40) + pure coloring tail = textbook
   permuter case. BLOCKER: `tools/agent/make_permuter_target.py sub_08013DFC` builds a
   BROKEN target.o — it emits the FIRST function of the multi-fn TU (sub_08013D1C's
   body) under the label `sub_08013DFC` (size 376 / "runs 6", disasm starts with
   `bl sub_0800E85C`). base score 17233 (should be ≈5×23≈115). Fix the target
   extractor to slice ONLY sub_08013DFC's 152 bytes (it is NOT the first fn in
   src/engine/sub_08013d1c.o) with $t/$d + 23 relocs, THEN run permuter from the plain
   `j++` 35-diff base — statement-reorder/temp-introduction mutations are exactly what a
   rematerialize-vs-resident coloring tail needs. (Also: this worktree's
   vendor/decomp-permuter was an empty dir, not the symlink; the bootstrap skipped it
   because the dir pre-existed. Symlink it from main before running.)
2. **Force base residency at the RTL level.** The decision is in agbcc's
   rematerialization cost: it lets the outer-read base die and reloads inside the inner
   loop. Read `gcc/cse.c` (constant rematerialization) / `gcc/local-alloc.c`
   `update_equiv_regs` (REG_EQUIV on a constant lets it be rematerialized freely) —
   the base const gets a REG_EQUIV note, so reload feels free to recompute it. A C
   shape that breaks the REG_EQUIV (e.g. derive `&gIwram_3610` from a runtime value the
   compiler can't fold back to the constant) would force residency. Instrument
   `local-alloc.c::update_equiv_regs` to confirm the base pseudo gets a const equiv.
3. The global-alloc probe recipe (drop-in) for the next agent: copy
   `tools/agbcc-src` → /tmp (deref symlink), add
   `fprintf(stderr,"DBG pseudo=%d r%d refs=%d\n", allocno_reg[allocno], best_reg,
   allocno_n_refs[allocno]);` right before `reg_renumber[allocno_reg[allocno]] =
   best_reg;` in `gcc/global.c`, `make -C gcc old`, compile the TU's .i. Count pseudos
   (16 = correct prologue).

## Best-effort C (the clean byte_diff-35 plateau; correct prologue, wrong inner)

```c
extern u8 gIwram_53A0;
extern u8 gIwram_3610;
extern u8 gIwram_549F;
extern u8 sub_0801185C(u8 range);

void sub_08013DFC(u8 n)
{
    u8 i;

    for (i = 0; i < n; i++) {
        u8 *arr = &gIwram_53A0;
        u8 *limit = arr + 0xFF;
        u8 *writeIdx = arr + 0xFE;
        u8 rnd = sub_0801185C(*limit);

        arr[rnd] = 1;
        arr[*writeIdx + 0x64] = (&gIwram_3610)[rnd];
        (*writeIdx)++;

        if (rnd < *limit) {
            u8 j = rnd;
            do {
                (&gIwram_3610)[j] = (&gIwram_3610)[j + 1];
                j++;
            } while (j < gIwram_549F);
        }

        (*limit)--;
    }
}
```

The byte-identical-INNER variant (swap the do-body for the lines below) reaches the
OTHER plateau — correct inner loop, wrong (2-high) prologue, byte_diff ~132:

```c
            do {
                int next = j + 1;
                (&gIwram_3610)[j] = (&gIwram_3610)[next];
                j = next;
            } while (j < gIwram_549F);
```
