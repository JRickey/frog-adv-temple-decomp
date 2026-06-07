@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Not decompiled; bytes come verbatim from the ROM. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundChannel_SetState
SoundChannel_SetState:
        .incbin "frog_us_baserom.gba", 0x32904, 0x98
        thumb_func_end SoundChannel_SetState
