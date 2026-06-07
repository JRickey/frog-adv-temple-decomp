@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_DrainActiveSlots
Sound_DrainActiveSlots:
        .incbin "frog_us_baserom.gba", 0x2e13c, 0x48
        thumb_func_end Sound_DrainActiveSlots

        thumb_func_start SoundHandle_IsActive
SoundHandle_IsActive:
        .incbin "frog_us_baserom.gba", 0x2e184, 0x44
        thumb_func_end SoundHandle_IsActive

        thumb_func_start SoundHandle_GetPeriod
SoundHandle_GetPeriod:
        .incbin "frog_us_baserom.gba", 0x2e1c8, 0x58
        thumb_func_end SoundHandle_GetPeriod

