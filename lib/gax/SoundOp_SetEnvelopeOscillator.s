@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOp_SetEnvelopeOscillator
SoundOp_SetEnvelopeOscillator:
        .incbin "frog_us_baserom.gba", 0x316dc, 0x20
        thumb_func_end SoundOp_SetEnvelopeOscillator
