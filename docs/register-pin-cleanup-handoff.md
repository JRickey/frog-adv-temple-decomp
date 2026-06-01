# Register Pin Cleanup Handoff

## Current state

The Makefile now uses `old_agbcc` as the default compiler. The newer `agbcc`
is only kept for four files that diverge under the old compiler:

```make
src/game/sub_08002ae8.s: CC = $(AGBCC_BIN)
src/engine/sub_0800f24c.s: CC = $(AGBCC_BIN)
src/engine/sub_08012d40.s: CC = $(AGBCC_BIN)
src/engine/sub_08013040.s: CC = $(AGBCC_BIN)
```

This was verified on main with:

```sh
make tidy
make -j8
make check
```

Result:

```text
frog_us.gba: OK
```

## Why this matters

The prior Makefile used newer `agbcc` by default and carried a long list of
per-file `old_agbcc` overrides. A matrix probe showed the inverse is a much
better model for this game:

```text
baseline                         matches
current + -ffix-debug-line        26 ROM bytes off, 3 funcs
all_new                           2,523,663 ROM bytes off
all_new + -ffix-debug-line        2,523,680 ROM bytes off
all_new + -fprologue-bugfix       2,351,125 ROM bytes off
all_old                           47,061 ROM bytes off
old default + 4 new exceptions    matches
```

The old `CC = $(OLD_AGBCC_BIN)` per-file overrides are intentionally gone
because they are redundant under the new default. The remaining per-file
`CFLAGS += ...` lines are still intentional codegen knobs and should be
tested individually before removal.

## Confirmed cleanup

After the compiler inversion, six register pins were removed from
`src/engine/sub_08020c78.c`:

- `sub_08020C78`: removed `p asm("r1")` and `mask asm("r0")`
- `sub_08020CA4`: removed `snd asm("r1")`, `handle asm("r0")`,
  `pan asm("r1")`, and `result asm("r4")`

Verification:

```sh
python3 tools/agent/compile_and_view_assembly.py sub_08020C78 --human
python3 tools/agent/compile_and_view_assembly.py sub_08020CA4 --human
python3 tools/agent/compile_and_view_assembly.py sub_08020CDC --human
python3 tools/agent/compile_and_view_assembly.py sub_08020D2C --human
make check
```

All matched.

## Failed probe

Do not assume all pins are now fake. A wholesale 17-pin removal in
`src/engine/sub_080210a0.c` failed badly. That function appears to still
depend on high-register lifetime and stack-argument coloring in its current
source shape.

## Suggested workflow

Work one file at a time. For each file:

1. Remove only an obvious cluster of pins or zero-width asm barriers.
2. Run `compile_and_view_assembly.py` for every function in that file that
   could have shifted.
3. Run `make check`.
4. Keep the cleanup only if the ROM still matches.

Use subagents on independent files. Avoid parallel work on files that share a
linker-adjacent cluster or where removing code from an earlier function can
shift later symbols.

Useful commands:

```sh
rg -n 'register .* asm\(|asm volatile' src --glob '*.c'
python3 tools/agent/compile_and_view_assembly.py FunctionName --human
make check
```

## High-priority files by current pin/barrier count

```text
 26  src/engine/sub_0800b7b0.c
 17  src/engine/sub_080210a0.c
 16  src/game/sub_08003254.c
 16  src/engine/sub_08013040.c
 16  src/engine/sub_0800a83c.c
 15  src/system/sound_volume.c
 15  src/engine/sub_0800dd80.c
 13  src/game/sub_0803299c.c
 13  src/engine/sub_08020f3c.c
 13  src/engine/sub_08012bc4.c
 12  src/system/sound_period.c
 12  src/engine/sub_08020c78.c
 10  src/game/sub_08002450.c
 10  src/game/sub_0800679c.c
  9  src/system/sound_mixer.c
  9  src/engine/sub_0800fd50.c
  8  src/system/sound_channel.c
  8  src/game/sub_08009ba0.c
  8  src/engine/sub_0800a4d0.c
```

The four new-agbcc exception files may still be harder to clean up, especially
`src/engine/sub_08013040.c`. The best initial wins are likely in files that
were previously forced to old-agbcc but now simply compile under the default.
