@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundChannel_Init
SoundChannel_Init:
        .incbin "frog_us_baserom.gba", 0x3299c, 0x58
        thumb_func_end SoundChannel_Init

        thumb_func_start SoundSlot_QueueRequest
SoundSlot_QueueRequest:
        .incbin "frog_us_baserom.gba", 0x329f4, 0x2c
        thumb_func_end SoundSlot_QueueRequest

        thumb_func_start SoundSlot_ClearInProgress
SoundSlot_ClearInProgress:
        .incbin "frog_us_baserom.gba", 0x32a20, 0x34
        thumb_func_end SoundSlot_ClearInProgress

        thumb_func_start SoundSlot_QueueId
SoundSlot_QueueId:
        .incbin "frog_us_baserom.gba", 0x32a54, 0x44
        thumb_func_end SoundSlot_QueueId

        thumb_func_start SoundSlot_Stride
SoundSlot_Stride:
        .incbin "frog_us_baserom.gba", 0x32a98, 0x8
        thumb_func_end SoundSlot_Stride

        thumb_func_start SoundSystem_InitRequestSlot
SoundSystem_InitRequestSlot:
        .incbin "frog_us_baserom.gba", 0x32aa0, 0x78
        thumb_func_end SoundSystem_InitRequestSlot

