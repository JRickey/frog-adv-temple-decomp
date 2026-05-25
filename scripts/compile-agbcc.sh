#!/usr/bin/env bash
# Default agbcc compiler script for use with tools/agent/ts/shared/c-compiler/CCompiler.
#
# Args:
#   $1 = cFilePath    — absolute path to a cpp-preprocessed .c file
#   $2 = objFilePath  — absolute path to the desired output .o
#   $3 = functionName — accepted but unused (file naming is the caller's job)
#
# CWD is the project root (CCompiler sets it). Flags mirror the canonical
# agbcc invocation in the project Makefile:
#   CFLAGS  = -Werror -O2 -mthumb-interwork -fhex-asm
#   ASFLAGS = -mcpu=arm7tdmi
# plus the trailing `.align 2, 0` directive the Makefile appends to every .s.
#
# Note: the input is ALREADY cpp-preprocessed by the TypeScript wrapper, so
# this script skips the project's PREPROC charmap stage and `cpp -nostdinc
# -Iinclude/` stage. If your contextContent needs charmap `_("…")` strings
# or project header resolution, expand the contextContent inline before
# calling CCompiler — the wrapper deliberately doesn't pass project flags
# to its `cpp -P` step.

set -euo pipefail

c_file="$1"
obj_file="$2"
# function_name="$3"  # unused

asm_file="${c_file%.c}.s"

AGBCC="${AGBCC:-tools/agbcc/bin/agbcc}"
AS="${AS:-arm-none-eabi-as}"

# 1. Compile C → Thumb asm with agbcc.
"$AGBCC" -Werror -O2 -mthumb-interwork -fhex-asm -o "$asm_file" < "$c_file"

# 2. Replicate the Makefile's trailing alignment directive so the assembled
#    object has identical padding behaviour to a normal build.
printf '\t.align 2, 0 @ dont insert nops\n' >> "$asm_file"

# 3. Assemble. (Note: the project Makefile passes only -mcpu=arm7tdmi to as,
#    not -mthumb-interwork — the interwork flag is an agbcc/CC-side concern.)
"$AS" -mcpu=arm7tdmi "$asm_file" -o "$obj_file"
