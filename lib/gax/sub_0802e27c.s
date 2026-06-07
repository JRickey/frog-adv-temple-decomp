@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundSystem_SetMuteByActive
SoundSystem_SetMuteByActive:
        .incbin "frog_us_baserom.gba", 0x2e27c, 0x38
        thumb_func_end SoundSystem_SetMuteByActive

        thumb_func_start SoundSystem_GetFlags
SoundSystem_GetFlags:
        .incbin "frog_us_baserom.gba", 0x2e2b4, 0xc
        thumb_func_end SoundSystem_GetFlags

        thumb_func_start SoundSystem_SetFlags
SoundSystem_SetFlags:
        .incbin "frog_us_baserom.gba", 0x2e2c0, 0x14
        thumb_func_end SoundSystem_SetFlags

        thumb_func_start SoundSystem_TestFlag
SoundSystem_TestFlag:
        .incbin "frog_us_baserom.gba", 0x2e2d4, 0x18
        thumb_func_end SoundSystem_TestFlag

        thumb_func_start SoundSystem_SetFlag
SoundSystem_SetFlag:
        .incbin "frog_us_baserom.gba", 0x2e2ec, 0x20
        thumb_func_end SoundSystem_SetFlag

        thumb_func_start SoundSystem_ClearFlag
SoundSystem_ClearFlag:
        .incbin "frog_us_baserom.gba", 0x2e30c, 0x20
        thumb_func_end SoundSystem_ClearFlag

        thumb_func_start SoundSystem_SetVolCountA
SoundSystem_SetVolCountA:
        .incbin "frog_us_baserom.gba", 0x2e32c, 0x18
        thumb_func_end SoundSystem_SetVolCountA

        thumb_func_start SoundSystem_SetVolCountB
SoundSystem_SetVolCountB:
        .incbin "frog_us_baserom.gba", 0x2e344, 0x18
        thumb_func_end SoundSystem_SetVolCountB

        thumb_func_start SoundSystem_SetMasterVolHigh
SoundSystem_SetMasterVolHigh:
        .incbin "frog_us_baserom.gba", 0x2e35c, 0x10
        thumb_func_end SoundSystem_SetMasterVolHigh

        thumb_func_start SoundSystem_SetMasterVolLow
SoundSystem_SetMasterVolLow:
        .incbin "frog_us_baserom.gba", 0x2e36c, 0x14
        thumb_func_end SoundSystem_SetMasterVolLow

