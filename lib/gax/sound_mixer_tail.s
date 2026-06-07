@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_ProcessRequests
Sound_ProcessRequests:
        .incbin "frog_us_baserom.gba", 0x325b0, 0x2e4
        thumb_func_end Sound_ProcessRequests

