@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOp_Jump
SoundOp_Jump:
        .incbin "frog_us_baserom.gba", 0x31748, 0x14
        thumb_func_end SoundOp_Jump
