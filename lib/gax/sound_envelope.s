@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundEnvelope_TickA0
SoundEnvelope_TickA0:
        .incbin "frog_us_baserom.gba", 0x2ea80, 0xb4
        thumb_func_end SoundEnvelope_TickA0

        thumb_func_start SoundEnvelope_SetRamp
SoundEnvelope_SetRamp:
        .incbin "frog_us_baserom.gba", 0x2eb34, 0xc4
        thumb_func_end SoundEnvelope_SetRamp

        thumb_func_start SoundEnvelope_InitClamp
SoundEnvelope_InitClamp:
        .incbin "frog_us_baserom.gba", 0x2ebf8, 0x84
        thumb_func_end SoundEnvelope_InitClamp

