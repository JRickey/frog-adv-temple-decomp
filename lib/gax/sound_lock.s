@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_Unlock
Sound_Unlock:
        .incbin "frog_us_baserom.gba", 0x2e3f8, 0x20
        thumb_func_end Sound_Unlock

        thumb_func_start Sound_Lock
Sound_Lock:
        .incbin "frog_us_baserom.gba", 0x2e418, 0x24
        thumb_func_end Sound_Lock

        thumb_func_start SoundLock_SlotOpen
SoundLock_SlotOpen:
        .incbin "frog_us_baserom.gba", 0x2e43c, 0x34
        thumb_func_end SoundLock_SlotOpen

        thumb_func_start SoundLock_SlotClose
SoundLock_SlotClose:
        .incbin "frog_us_baserom.gba", 0x2e470, 0x44
        thumb_func_end SoundLock_SlotClose

        thumb_func_start SoundLock_SetPan
SoundLock_SetPan:
        .incbin "frog_us_baserom.gba", 0x2e4b4, 0x34
        thumb_func_end SoundLock_SetPan

        thumb_func_start SoundLock_SetEnable
SoundLock_SetEnable:
        .incbin "frog_us_baserom.gba", 0x2e4e8, 0x40
        thumb_func_end SoundLock_SetEnable

        thumb_func_start SoundLock_CalcPeriod
SoundLock_CalcPeriod:
        .incbin "frog_us_baserom.gba", 0x2e528, 0x1c
        thumb_func_end SoundLock_CalcPeriod

