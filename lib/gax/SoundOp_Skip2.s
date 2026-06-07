@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOp_Skip2
SoundOp_Skip2:
        .incbin "frog_us_baserom.gba", 0x3189c, 0xc
        thumb_func_end SoundOp_Skip2
