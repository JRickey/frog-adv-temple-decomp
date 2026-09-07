#!/usr/bin/env bash
# Compile script for decomp-permuter, modeled on vendor/decomp-permuter/import.py's
# write_compile_command() output. Permuter invokes this with:
#   $1 = input .c file (already preprocessed via permuter's own cpp run; see
#        import.py:write_compile_command - the source written by permuter has
#        already had includes inlined.)
#   $3 = output .o file
#
# We replicate the project Makefile's pipeline:
#   PREPROC charmap | cpp-15 -P -nostdinc -Iinclude/ | agbcc -Werror -O2
#       -mthumb-interwork -fhex-asm | (append .align directive) | as
#
# Notes:
# - Permuter does its own cpp pass before calling this script (see
#   import_c_file() in import.py). The resulting C is mostly preprocessed.
#   We still re-run cpp here so the script also works when invoked on raw
#   .c sources with project headers.
# - PREPROC (tools/preproc/preproc) handles `_("…")` charmap strings. The
#   target function has none, so we skip preproc to avoid the indirection.
# - macOS-only path for cpp-15 - this is a Darwin-targeted script. On Linux,
#   adjust CPP=cpp.

set -euo pipefail

INPUT="$1"
OUTPUT="$3"

# Permuter sets cwd, but be defensive: anchor to repo root via this script.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

AGBCC="${AGBCC:-tools/agbcc/bin/agbcc}"
AS="${AS:-arm-none-eabi-as}"
CPP="${CPP:-$(tools/find_cpp.sh) -P}"
CFLAGS="-Werror -O2 -mthumb-interwork -fhex-asm"
CPPFLAGS="-nostdinc -Iinclude/"

# Temp files. Permuter calls us many times; keep them in a tmpdir.
tmpdir="$(mktemp -d -t permuter-agbcc.XXXXXX)"
trap 'rm -rf "$tmpdir"' EXIT
asm_file="$tmpdir/out.s"

# 1. Preprocess: cpp -P with project include path.
# 2. Compile to Thumb asm with agbcc.
$CPP $CPPFLAGS "$INPUT" | "$AGBCC" $CFLAGS -o "$asm_file"

# 3. Replicate Makefile's trailing alignment directive.
printf '\t.align 2, 0 @ dont insert nops\n' >> "$asm_file"

# 4. Assemble.
"$AS" -mcpu=arm7tdmi "$asm_file" -o "$OUTPUT"
