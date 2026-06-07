@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_TickDualEnvelopes
Sound_TickDualEnvelopes:
        .incbin "frog_us_baserom.gba", 0x2e934, 0xf8
        thumb_func_end Sound_TickDualEnvelopes

        thumb_func_start SoundEnvelope_SetOscillator
SoundEnvelope_SetOscillator:
        .incbin "frog_us_baserom.gba", 0x2ea2c, 0x54
        thumb_func_end SoundEnvelope_SetOscillator

