#!/usr/bin/env bash
#
# Adapted from the Metroid Fusion decompilation
# (https://github.com/metroidret/mf). MIT, Copyright (c) 2025 YohannDR.
# See LICENSE for full attribution.
#
# Wrapper for decomp-permuter: takes a .c file and produces a .o file using
# the project's actual compile pipeline (preproc | cpp-15 | agbcc | as).
#
# Invoked by permuter as: permuter_compile.sh <input.c> -o <output.o>
# (the -o flag and OUTPUT path are appended by permuter's compile.sh wrapper)
#
# Run from the repo root.

set -euo pipefail

INPUT=""
OUTPUT=""

# permuter passes extra cpp flags (-D, -I, -U, -nostdinc) on the cmdline so it
# can scan them for its own preprocessing — they're harmless here because our
# pipeline bakes the real flags into the script. Just skip them.
while [ $# -gt 0 ]; do
    case "$1" in
        -o)
            OUTPUT="$2"
            shift 2
            ;;
        -D*|-U*|-I*|-nostdinc)
            shift
            ;;
        -D|-U|-I)
            shift 2
            ;;
        *)
            if [ -z "$INPUT" ]; then
                INPUT="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
    echo "usage: $0 <input.c> -o <output.o>" >&2
    exit 1
fi

# Same flags as Makefile for src/sprites_AI/*.c
CFLAGS="-Werror -O2 -mthumb-interwork -fhex-asm"
CPPFLAGS="-P -DREGION_US -nostdinc -Iinclude/"

TMP_S="$(mktemp -t permuter_compile.XXXXXX.s)"
trap "rm -f '$TMP_S'" EXIT

tools/preproc/preproc "$INPUT" charmap.txt \
    | cpp-15 $CPPFLAGS \
    | tools/agbcc/bin/old_agbcc -o "$TMP_S" $CFLAGS
printf '\t.align 2, 0 @ dont insert nops\n' >> "$TMP_S"

arm-none-eabi-as --defsym REGION_US=1 -mcpu=arm7tdmi "$TMP_S" -o "$OUTPUT"
