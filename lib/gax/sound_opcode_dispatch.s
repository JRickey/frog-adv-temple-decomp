@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_OpcodeDispatch
Sound_OpcodeDispatch:
        .incbin "frog_us_baserom.gba", 0x315d8, 0x60
        thumb_func_end Sound_OpcodeDispatch

