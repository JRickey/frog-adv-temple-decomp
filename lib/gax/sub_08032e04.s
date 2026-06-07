@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start BuildRangeTable
BuildRangeTable:
        .incbin "frog_us_baserom.gba", 0x32e04, 0x18
        thumb_func_end BuildRangeTable
