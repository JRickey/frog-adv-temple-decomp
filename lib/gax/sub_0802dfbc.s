@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundSlot_SetPitchScale
SoundSlot_SetPitchScale:
        .incbin "frog_us_baserom.gba", 0x2dfbc, 0x50
        thumb_func_end SoundSlot_SetPitchScale
