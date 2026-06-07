@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802D9EC
sub_0802D9EC:
        .incbin "frog_us_baserom.gba", 0x2d9ec, 0x230
        thumb_func_end sub_0802D9EC
