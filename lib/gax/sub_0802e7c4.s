@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802E7C4
sub_0802E7C4:
        .incbin "frog_us_baserom.gba", 0x2e7c4, 0xb0
        thumb_func_end sub_0802E7C4

        thumb_func_start Sound_AdjustPan
Sound_AdjustPan:
        .incbin "frog_us_baserom.gba", 0x2e874, 0xc0
        thumb_func_end Sound_AdjustPan

