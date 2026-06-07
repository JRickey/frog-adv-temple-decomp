@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundSlot_PickByPriority
SoundSlot_PickByPriority:
        .incbin "frog_us_baserom.gba", 0x32b18, 0x88
        thumb_func_end SoundSlot_PickByPriority

        thumb_func_start SoundChannel_CheckPriority
SoundChannel_CheckPriority:
        .incbin "frog_us_baserom.gba", 0x32ba0, 0x28
        thumb_func_end SoundChannel_CheckPriority

        thumb_func_start SoundVoice_Init
SoundVoice_Init:
        .incbin "frog_us_baserom.gba", 0x32bc8, 0x50
        thumb_func_end SoundVoice_Init

