# GAX Sound System — third-party library boundary (do not decompile)

Frogger's audio engine is the **GAX Sound System by Shin'en Multimedia**, a
licensed third-party GBA sound middleware (signature: the `*Gax` marker in the
music/SFX data). It is **not** Frogger code and **not** standard m4a. Like the
in-ROM libgcc helpers, it is treated as a library: kept byte-exact, **not**
decompiled to matching C, and excluded from the decomp queue.

## Layout

| ROM range | What | Where it lives |
|---|---|---|
| `0x0802d170`-`0x0802d514` | Frogger entity/game cluster (calls `Entity_Update`, `Sound_Play`, …) | `src/` — normal decomp targets |
| `0x0802d514`-`0x0802d5ec` | `libagbsyscall` — Nintendo SDK BIOS/SWI wrappers | `asm/libagbsyscall.s` (separate SDK lib) |
| `0x0802d5ec`-`0x080338a8` | **GAX Sound System engine (139 functions)** | `lib/gax/*.s` — labeled `.incbin` of the ROM bytes |

`tools/agent/pick_target.py` excludes `GAX_REGION` (`0x0802d5ec`-`0x080338a8`)
so the decomp loops never select GAX functions.

## Why we don't decompile it

- Middleware shared verbatim across dozens of unrelated GBA titles; carries no
  Frogger-specific information.
- Already byte-correct in the build (`make check` passes); decompiling it to
  readable C buys nothing for the matching goal.
- The hard tail (mixer, ARM-mode IRQ handler, tracker/opcode interpreter) is
  register/ARM/dispatch code with no liftable reference for this exact build.

## How the boundary was drawn (internal method)

The engine address range is interleaved at its edges with Frogger code, so
membership was decided two ways:

1. **Byte-identity against a large GBA ROM set** — functions whose bytes are
   shared with many other GAX titles are unambiguously the library. (Some GAX
   functions carry game-specific pointer literals and so don't byte-match other
   games; those score low but are still GAX.)
2. **Call graph** (`build_callgraph.py`) — every function in
   `0x0802d5ec`-`0x080338a8` is `Sound*`-named and calls only other engine
   functions / BIOS / libgcc / hardware (0 calls into Frogger game code), so the
   whole range is GAX. The block just below it *does* call `Entity_*`/`Sound_Play`,
   so it is Frogger and stays in `src/`.

## Build treatment

Each engine function is a labeled `.incbin "frog_us_baserom.gba", <off>, <len>`
under `lib/gax/` — no compilation, no per-TU flags, byte-exact by construction.
Where a function had been decompiled, its C is preserved (uncompiled) under
`lib/gax/reference/` as a reading aid only. The 50 reference `.c` files are NOT
the build input and may drift; the `.incbin` bytes are authoritative.

Frogger's own audio code — the game-side API that *calls* GAX (e.g.
`Entity_PlaySound`, `Sound_Play*` around `0x08020xxx`) — is **not** here; it
stays in `src/` and is decompiled normally.

## Attribution

GAX function and data-structure names follow the public reverse-engineering of
the engine: beanieaxolotl's *shinen-gax-python* and decomp.me work, and
loveemu's GAX research notes. All code was decompiled independently from this
game's own binary; those references are used only for naming and structure.
