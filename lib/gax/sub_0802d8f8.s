@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_Reset
Sound_Reset:
        .incbin "frog_us_baserom.gba", 0x2d8f8, 0xa4
        thumb_func_end Sound_Reset
