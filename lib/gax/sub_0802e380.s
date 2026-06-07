@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start MemZero
MemZero:
        .incbin "frog_us_baserom.gba", 0x2e380, 0x14
        thumb_func_end MemZero

        thumb_func_start Sound_MemCopy
Sound_MemCopy:
        .incbin "frog_us_baserom.gba", 0x2e394, 0x18
        thumb_func_end Sound_MemCopy

        thumb_func_start SoundRng_Step
SoundRng_Step:
        .incbin "frog_us_baserom.gba", 0x2e3ac, 0x1c
        thumb_func_end SoundRng_Step

        thumb_func_start Sound_Rand
Sound_Rand:
        .incbin "frog_us_baserom.gba", 0x2e3c8, 0x30
        thumb_func_end Sound_Rand

