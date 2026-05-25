@ Assembly macros for the Frogger's Adventures decomp.
@
@ The thumb_func_start / arm_func_start pair are recognized by
@ tools/agent/pick_target.py (it parses them to enumerate decomp targets).
@ Use them at the top of every function in asm/disasm_*.s.

        .macro arm_func_start name
        .align  2, 0
        .global \name
        .type   \name, function
        .arm
\name:
        .endm

        .macro arm_func_end name
        .size \name, . - \name
        .endm

        .macro thumb_func_start name
        .align  2, 0
        .global \name
        .type   \name, function
        .thumb
        .thumb_func
\name:
        .endm

        .macro thumb_func_end name
        .size \name, . - \name
        .endm

        .macro non_word_aligned_thumb_func_start name
        .global \name
        .type   \name, function
        .thumb
        .thumb_func
\name:
        .endm
