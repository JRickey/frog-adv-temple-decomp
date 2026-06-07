@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundSlot_InitParams
SoundSlot_InitParams:
        .incbin "frog_us_baserom.gba", 0x32894, 0x70
        thumb_func_end SoundSlot_InitParams
