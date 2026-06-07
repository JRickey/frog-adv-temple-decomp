@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_SetChannelPan
Sound_SetChannelPan:
        .incbin "frog_us_baserom.gba", 0x2dcbc, 0xf4
        thumb_func_end Sound_SetChannelPan

        thumb_func_start Sound_GetChannelPan
Sound_GetChannelPan:
        .incbin "frog_us_baserom.gba", 0x2ddb0, 0x74
        thumb_func_end Sound_GetChannelPan

