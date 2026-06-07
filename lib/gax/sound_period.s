@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_CalcNotePeriod
Sound_CalcNotePeriod:
        .incbin "frog_us_baserom.gba", 0x301c4, 0xa0
        thumb_func_end Sound_CalcNotePeriod

        thumb_func_start SoundPeriod_Reset
SoundPeriod_Reset:
        .incbin "frog_us_baserom.gba", 0x30264, 0x2c
        thumb_func_end SoundPeriod_Reset

        thumb_func_start Sound_StartDma
Sound_StartDma:
        .incbin "frog_us_baserom.gba", 0x30290, 0x7c
        thumb_func_end Sound_StartDma

        thumb_func_start SoundOp_RetireChannel
SoundOp_RetireChannel:
        .incbin "frog_us_baserom.gba", 0x3030c, 0x80
        thumb_func_end SoundOp_RetireChannel

        thumb_func_start SoundOp_SetPeriod
SoundOp_SetPeriod:
        .incbin "frog_us_baserom.gba", 0x3038c, 0xd0
        thumb_func_end SoundOp_SetPeriod

        thumb_func_start SoundOp_GateOff
SoundOp_GateOff:
        .incbin "frog_us_baserom.gba", 0x3045c, 0x98
        thumb_func_end SoundOp_GateOff

        thumb_func_start SoundOp_Wait
SoundOp_Wait:
        .incbin "frog_us_baserom.gba", 0x304f4, 0x150
        thumb_func_end SoundOp_Wait

