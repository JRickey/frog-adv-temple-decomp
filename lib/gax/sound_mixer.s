@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundMixer_VBlankUpdate
SoundMixer_VBlankUpdate:
        .incbin "frog_us_baserom.gba", 0x2f4b0, 0x3c0
        thumb_func_end SoundMixer_VBlankUpdate

        thumb_func_start Sound_WritePsgDuty
Sound_WritePsgDuty:
        .incbin "frog_us_baserom.gba", 0x2f870, 0x14
        thumb_func_end Sound_WritePsgDuty

        thumb_func_start Sound_WriteNoiseFreq
Sound_WriteNoiseFreq:
        .incbin "frog_us_baserom.gba", 0x2f884, 0xc
        thumb_func_end Sound_WriteNoiseFreq

        thumb_func_start Sound_WritePsgVolume
Sound_WritePsgVolume:
        .incbin "frog_us_baserom.gba", 0x2f890, 0x60
        thumb_func_end Sound_WritePsgVolume

        thumb_func_start Sound_MarkChannelFullDirty
Sound_MarkChannelFullDirty:
        .incbin "frog_us_baserom.gba", 0x2f8f0, 0x40
        thumb_func_end Sound_MarkChannelFullDirty

        thumb_func_start Sound_LoadWaveRam
Sound_LoadWaveRam:
        .incbin "frog_us_baserom.gba", 0x2f930, 0x6c
        thumb_func_end Sound_LoadWaveRam

