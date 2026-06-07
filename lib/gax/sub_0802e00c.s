@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundStream_UpdateCursor
SoundStream_UpdateCursor:
        .incbin "frog_us_baserom.gba", 0x2e00c, 0xb0
        thumb_func_end SoundStream_UpdateCursor

        thumb_func_start Sound_SetActiveCount
Sound_SetActiveCount:
        .incbin "frog_us_baserom.gba", 0x2e0bc, 0x44
        thumb_func_end Sound_SetActiveCount

