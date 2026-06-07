@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundPan_Tick
SoundPan_Tick:
        .incbin "frog_us_baserom.gba", 0x2f2fc, 0x9c
        thumb_func_end SoundPan_Tick

        thumb_func_start SoundPan_UpdateMixEntry
SoundPan_UpdateMixEntry:
        .incbin "frog_us_baserom.gba", 0x2f398, 0x118
        thumb_func_end SoundPan_UpdateMixEntry

