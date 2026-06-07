@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundVolume_Emit
SoundVolume_Emit:
        .incbin "frog_us_baserom.gba", 0x2e684, 0xa0
        thumb_func_end SoundVolume_Emit

