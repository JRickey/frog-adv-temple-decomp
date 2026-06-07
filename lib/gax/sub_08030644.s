@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08030644
sub_08030644:
        .incbin "frog_us_baserom.gba", 0x30644, 0x158
        thumb_func_end sub_08030644

