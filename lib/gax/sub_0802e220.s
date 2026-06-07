@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_GetChannelVolume
Sound_GetChannelVolume:
        .incbin "frog_us_baserom.gba", 0x2e220, 0x5c
        thumb_func_end Sound_GetChannelVolume

