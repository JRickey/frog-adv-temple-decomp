# GAX Sound System (Shin'en Multimedia)

Frogger's Adventures: Temple of the Frog drives its audio through the **GAX
Sound System**, a licensed third-party Game Boy Advance sound engine by Shin'en
Multimedia (identifiable by the `*Gax` marker in the music/SFX data). It is a
third-party dependency distinct from the Nintendo m4a/"Sappy" driver.

This directory isolates that engine. It is kept **byte-exact** and treated as a
library. This is a preservation decision, not a claim of completed
decompilation. The game-side code that calls GAX lives in `src/`.

## Status

The engine occupies `0x0802d5ec`-`0x080338a8` and is built from
labeled `.incbin` of the original ROM bytes — so the ROM stays byte-identical to
the retail cartridge with no compilation and no per-TU flags. Where a function
had previously been decompiled, its C is preserved under `reference/` (50 files)
as a reading aid only; that C is **not** the build input and may drift. The
`.incbin` bytes are authoritative. Reference C earns no matching-source credit
until it is compiled, selected by the linker, and verified. Public progress
must not mark this library 100% merely because its binary is retained.

## Attribution

GAX function and data-structure names follow the public reverse-engineering of
the engine:

- beanieaxolotl — *shinen-gax-python*: https://github.com/beanieaxolotl/shinen-gax-python
- beanieaxolotl — GAX function decompilations on decomp.me
- loveemu — *Shin'en GAX Sound Engine (GBA)* research note

All code in this directory was decompiled independently from this game's own
binary. The references above are used only for naming and structure, never as a
source of code.
