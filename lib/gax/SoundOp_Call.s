@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOp_Call
SoundOp_Call:
        .incbin "frog_us_baserom.gba", 0x31798, 0x18
        thumb_func_end SoundOp_Call

        thumb_func_start SoundOp_Return
SoundOp_Return:
        .incbin "frog_us_baserom.gba", 0x317b0, 0x10
        thumb_func_end SoundOp_Return

        thumb_func_start SoundOp_SetEnvelopeC
SoundOp_SetEnvelopeC:
        .incbin "frog_us_baserom.gba", 0x317c0, 0x20
        thumb_func_end SoundOp_SetEnvelopeC

