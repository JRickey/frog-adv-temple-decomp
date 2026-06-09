# Frogger's Adventures: Temple of the Frog — Decompilation

A work-in-progress matching decompilation of *Frogger's Adventures: Temple of the Frog* (Game Boy Advance, USA region) by Konami.

Targets byte-identical output to the original ROM using **agbcc** (gcc 2.x for thumb/ARM) and `arm-none-eabi-binutils`.

This decomp is not shiftable yet, so it is not suitable for developing ROM hacks.

> *"Shiftable" means you can add/remove/reorder code in the source and still
> get a working ROM. This one isn't because matching is the only goal:
> `linker.ld` places every section at its exact baserom address, and the
> not-yet-decompiled assembly references data tables by hard-coded
> `0x080xxxxx` pointers. Move any function and those pointers fall on the
> wrong bytes. Becoming shiftable is a separate, post-matching effort
> (replace every raw address with a named symbol, drop the absolute
> placements in `linker.ld`) that hasn't happened here.*

This was one of my favorite games as a kid. I am sure no one is going to attempt to decomp it. So I will. If you want to lend your brain or inference compute, feel free.

This is an agentic project. Instructions for your agent on how to work and contribute can be found at *CLAUDE.MD* and *AGENTS.MD* respectively.

## Progress

Current `main` builds a byte-identical ROM: `make check` passes, the built
SHA1 equals the baserom SHA1, and `tools/agent/progress.py --per-function`
reports `0` ROM-diff bytes with no nonmatching functions.

There is still decompilation work remaining. As of my last check, I use ~400 register pins, there are a few instances of volatile asm,
which will be cleaned up. I am trying my best to minimize the number of register pins used.

More importantly, a large majority of the symbols are not named. A lot of locals are not properly named either.

The generated estimate block below is the broader progress snapshot. The
denominator is pinned at ~1114 functions — our working estimate of the total
in the code region, which sits inside the Thumb prologue scan's 335…1140
bracket. It's still an estimate, not a ground-truth disassembly. Note the
`peeled-but-still-asm` count is file/slice-based, so it can differ from the
function count reported by `progress.py`.

<!-- BEGIN PROGRESS (managed by tools/agent/progress_stats.py) -->

**All figures are estimates** — the function-count denominator (~1114) is a working estimate bracketed by a Thumb prologue
scan, not a ground-truth disassembly. Treat ±20% as honest.
Regenerate with `python3 tools/agent/progress_stats.py --update-readme`.

- **Functions decompiled to C**: 733 / ~1114 estimated total (**65.8%**)
  - true pure-C matches: 674
  - NAKED+NON_MATCHING (asm fallback, byte-matches but not pure C): 59
  - peeled-but-still-asm: 69
  - not yet in C (non-matching tail — asm slices + raw INCBIN): ~381
  - prologue-scan bracket (lower / upper): 335 / 1140
- **Data deblobbed**: 601.7 KiB of 4.00 MiB (**14.69%**)
  - raw INCBIN bytes: 3.41 MiB (85.3% of ROM)
  - `database.json` entries: 265

Code occupies roughly [0x08000000, 0x08036000) (~216.0 KiB). Past that the
ROM is graphics, audio, level/script data, and lookup tables.

<!-- END PROGRESS -->

## ROM info

- Region: USA, North America
- Game code: `AFRE`
- Maker code: `A4` (Konami)
- Game title (internal): `FROG: TEMPLE`
- SHA1: `7b4c27009198df18555e63fb5dcad223eaf09815`

The matching build target is `frog_us.gba`. Provide a baserom named
`baserom.gba` (a symlink `frog_us_baserom.gba` is created automatically
during setup) — never commit it; the build verifies its SHA1.

## Dependencies

- [agbcc](https://github.com/pret/agbcc) — clone separately (see Setup), then
  `./build.sh && ./install.sh "$(pwd)/../.."` from inside the clone to populate
  `tools/agbcc/` (`install.sh` only copies binaries; `build.sh` compiles them)
- `arm-none-eabi-binutils` (`brew install arm-none-eabi-binutils` on macOS;
  `apt-get install binutils-arm-none-eabi` on Linux)
- `python3`
- `g++` and `make` for building `tools/preproc`, `tools/gbafix`, and agbcc
- `clang-format` for the pre-commit hook (`brew install clang-format` /
  `apt-get install clang-format`)
- macOS: `brew install gcc` (for `cpp-15`; Apple's clang `cpp` keeps `//`
  comments which agbcc 2.x rejects)

## Setup

### macOS / Linux

```sh
# 1. Drop your baserom at ./baserom.gba (the frog_us_baserom.gba symlink
#    points to it). Hash is verified by `make check`.

# 2. Clone agbcc somewhere and install it into this project.
#    Convention here: clone into tools/agbcc-src/ (gitignored) so a rebuild
#    is one command away.
git clone https://github.com/pret/agbcc.git tools/agbcc-src
cd tools/agbcc-src && ./build.sh && ./install.sh "$(pwd)/../.." && cd ../..

# 3. Install the pre-commit hook so the baserom can't be accidentally committed
ln -sf ../../scripts/pre-commit .git/hooks/pre-commit
```

### Windows (via WSL)

Native Windows isn't supported — build under WSL.

```powershell
# 1. Install WSL (run in elevated PowerShell, then reboot)
wsl --install
```

```sh
# 2. From inside your WSL shell (Ubuntu is the easiest path):
sudo apt update
sudo apt install -y build-essential binutils-arm-none-eabi git make python3 clang-format

# 3. Clone the project INTO the WSL filesystem (e.g. ~/dev/), NOT under
#    /mnt/c/... — building across the Windows↔Linux boundary is slow and
#    the symlinks/permissions misbehave.
cd ~ && mkdir -p dev && cd dev
git clone <repo-url> frog-adv-decomp && cd frog-adv-decomp

# 4. Make sure git isn't mangling line endings. CRLF in any .c/.s/.sh
#    will break agbcc and the pre-commit hook.
git config core.autocrlf false
git config core.eol lf

# 5. Drop your baserom at ./baserom.gba. If you copied it from Windows,
#    chmod it readable to your WSL user.

# 6. Clone and install agbcc (same as macOS/Linux above).
git clone https://github.com/pret/agbcc.git tools/agbcc-src
cd tools/agbcc-src && ./build.sh && ./install.sh "$(pwd)/../.." && cd ../..

# 7. Install the pre-commit hook
ln -sf ../../scripts/pre-commit .git/hooks/pre-commit
```

WSL2 is recommended over WSL1 (faster filesystem, full kernel). Check with
`wsl -l -v`; if version is 1, run `wsl --set-default-version 2` and convert
the distro with `wsl --set-version <DistroName> 2`.

## Build

```sh
# Extract data blobs from the baserom according to database.json
python3 tools/extractor.py

# Build (parallel-safe)
make -j8

# Verify byte-match against the baserom — exits 0 only on full match
make check

# Clean (keeps data/; add DATA=1 to drop it too)
make tidy
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). **Clean-room** — do not consult any
leaked or otherwise-obtained Konami source.

## Acknowledgements

Tooling and prompts adapted from:
- the [pret](https://github.com/pret) family of decompilation projects
  (`tools/preproc`, `tools/gbafix`)
- [Mizuchi](https://github.com/macabeus/mizuchi) (MIT) — agent prompt
  structure, attribution in `tools/agent/prompts/ATTRIBUTION.md`

Corpus of GBA decompilations git mirrors that agents are allowed to search inside for hard asm patterns, then review the matching C idioms to defeat those patterns. Huge thanks to every author and team below — some very tricky functions were matched using idioms found in these repositories.

| Game | Repository | Author / team |
|---|---|---|
| Boktai 2: Solar Boy Django | [akatsuki105/boktai2](https://github.com/akatsuki105/boktai2) | akatsuki105 |
| Rhythm Tengoku | [arthurtilly/rhythmtengoku](https://github.com/arthurtilly/rhythmtengoku) | arthurtilly |
| Fire Emblem: The Binding Blade (FE6) | [FireEmblemUniverse/fireemblem6j](https://github.com/FireEmblemUniverse/fireemblem6j) | FireEmblemUniverse |
| Fire Emblem: The Sacred Stones (FE8) | [FireEmblemUniverse/fireemblem8u](https://github.com/FireEmblemUniverse/fireemblem8u) | FireEmblemUniverse |
| Mario Kart: Super Circuit | [jellees/mksc](https://github.com/jellees/mksc) | jellees |
| Summon Night: Swordcraft Story 3 | [jiangzhengwenjz/csm3](https://github.com/jiangzhengwenjz/csm3) | jiangzhengwenjz |
| Kirby & The Amazing Mirror | [jiangzhengwenjz/katam](https://github.com/jiangzhengwenjz/katam) | jiangzhengwenjz |
| Tactics Ogre: The Knight of Lodis | [jiangzhengwenjz/totkol](https://github.com/jiangzhengwenjz/totkol) | jiangzhengwenjz |
| Advance Wars | [ketsuban/advancewars](https://github.com/ketsuban/advancewars) | ketsuban |
| Mother 3 | [Kurausukun/mother3](https://github.com/Kurausukun/mother3) | Kurausukun |
| Metroid Fusion | [metroidret/mf](https://github.com/metroidret/mf) | metroidret |
| Metroid: Zero Mission | [metroidret/mzm](https://github.com/metroidret/mzm) | metroidret |
| Mega Man Zero 3 | [mmzret/rmz3](https://github.com/mmzret/rmz3) | mmzret |
| Fire Emblem: The Blazing Blade (Rekka no Ken, JP) | [MokhaLeee/FireEmblem7J](https://github.com/MokhaLeee/FireEmblem7J) | MokhaLeee |
| Harvest Moon: Friends of Mineral Town | [not-alons/hmfomt](https://github.com/not-alons/hmfomt) | not-alons |
| Pokémon Emerald | [pret/pokeemerald](https://github.com/pret/pokeemerald) | pret |
| Pokémon FireRed | [pret/pokefirered](https://github.com/pret/pokefirered) | pret |
| Pokémon Pinball: Ruby & Sapphire | [pret/pokepinballrs](https://github.com/pret/pokepinballrs) | pret |
| Pokémon Ruby | [pret/pokeruby](https://github.com/pret/pokeruby) | pret |
| Castlevania: Aria of Sorrow | [testyourmine/cvaos](https://github.com/testyourmine/cvaos) | testyourmine |
| Hamtaro: Ham-Ham Games | [XOlifreX/hhg-decompilation](https://github.com/XOlifreX/hhg-decompilation) | XOlifreX |
| Mario Kart: Super Circuit | [XOlifreX/mksc-decompilation](https://github.com/XOlifreX/mksc-decompilation) | XOlifreX |
| The Legend of Zelda: The Minish Cap | [zeldaret/tmc](https://github.com/zeldaret/tmc) | zeldaret |

These mirrors are kept locally under `tools/agent/corpus-mirrors/` (gitignored); the corpus is searched but never copied into this project.
