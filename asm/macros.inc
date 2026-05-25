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

        @ For Thumb functions whose entry sits at a non-word-aligned offset
        @ (e.g. immediately after a halfword instruction at the end of the
        @ previous function). Same as thumb_func_start but omits the
        @ .align 2, 0 directive that would insert a padding halfword.
        .macro non_word_aligned_thumb_func_start name
        .global \name
        .type   \name, function
        .thumb
        .thumb_func
\name:
        .endm
