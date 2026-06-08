@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_AllocVoice
Sound_AllocVoice:
        .incbin "frog_us_baserom.gba", 0x2d9ec, 0x230
        thumb_func_end Sound_AllocVoice
