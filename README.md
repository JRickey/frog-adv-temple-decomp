# Frogger's Adventures: Temple of the Frog — Decompilation

A work-in-progress matching decompilation of *Frogger's Adventures: Temple of the Frog* (Game Boy Advance, USA region) by Konami. 

Targets byte-identical output to the original ROM using **agbcc** (gcc 2.x for thumb/ARM) and `arm-none-eabi-binutils`.

This decomp is not shiftable, thus it will not be suitable for developing rom hacks.

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
  `./install.sh "$(pwd)/../.."` from inside the clone to populate `tools/agbcc/`
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
# Extract data blobs from the baserom (no-op until database.json is populated)
python3 tools/extractor.py

# Build (parallel-safe)
make -j8

# Verify byte-match against the baserom — exits 0 only on full match
make check

# Clean (keeps data/; add DATA=1 to drop it too)
make tidy
```

## Progress

<!-- BEGIN PROGRESS (managed by tools/agent/progress_stats.py) -->

**All figures are estimates** — the function-count denominator is a
Thumb prologue scan, not a ground-truth disassembly. Treat ±20% as honest.
Regenerate with `python3 tools/agent/progress_stats.py --update-readme`.

- **Functions decompiled to C**: 147 / ~513 estimated total (**28.7%**)
  - true pure-C matches: 92
  - NAKED+NON_MATCHING (asm fallback, byte-matches but not pure C): 55
  - peeled-but-still-asm: 120
  - estimate range (lower / upper): 335 / 1140
- **Data deblobbed**: 484.6 KiB of 4.00 MiB (**11.83%**)
  - raw INCBIN bytes: 3.53 MiB (88.2% of ROM)
  - `database.json` entries: 265

Code occupies roughly [0x08000000, 0x08036000) (~216.0 KiB). Past that the
ROM is graphics, audio, level/script data, and lookup tables.

<!-- END PROGRESS -->

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). **Clean-room** — do not consult any
leaked or otherwise-obtained Konami source.

## Acknowledgements

Tooling and prompts adapted from:
- the [pret](https://github.com/pret) family of decompilation projects
  (`tools/preproc`, `tools/gbafix`)
- [Mizuchi](https://github.com/macabeus/mizuchi) (MIT) — agent prompt
  structure, attribution in `tools/agent/prompts/ATTRIBUTION.md`
