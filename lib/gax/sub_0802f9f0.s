@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_RetireChannel
Sound_RetireChannel:
        .incbin "frog_us_baserom.gba", 0x2f9f0, 0x70
        thumb_func_end Sound_RetireChannel

        thumb_func_start Sound_UpdateStreamPeriod
Sound_UpdateStreamPeriod:
        .incbin "frog_us_baserom.gba", 0x2fa60, 0x58
        thumb_func_end Sound_UpdateStreamPeriod

