@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_TickStreamHead
Sound_TickStreamHead:
        .incbin "frog_us_baserom.gba", 0x2edf0, 0x108
        thumb_func_end Sound_TickStreamHead

        thumb_func_start SoundChannel_SetEnvelopeC
SoundChannel_SetEnvelopeC:
        .incbin "frog_us_baserom.gba", 0x2eef8, 0x84
        thumb_func_end SoundChannel_SetEnvelopeC

        thumb_func_start Sound_ApplyEnvelopeC
Sound_ApplyEnvelopeC:
        .incbin "frog_us_baserom.gba", 0x2ef7c, 0xd8
        thumb_func_end Sound_ApplyEnvelopeC

