@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOp_SetPitchRel
SoundOp_SetPitchRel:
        .incbin "frog_us_baserom.gba", 0x3079c, 0x70
        thumb_func_end SoundOp_SetPitchRel

        thumb_func_start SoundOp_SetAcc1
SoundOp_SetAcc1:
        .incbin "frog_us_baserom.gba", 0x3080c, 0xa4
        thumb_func_end SoundOp_SetAcc1

