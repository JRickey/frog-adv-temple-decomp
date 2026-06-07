@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_EmitPsgPitch
Sound_EmitPsgPitch:
        .incbin "frog_us_baserom.gba", 0x2e5d8, 0xac
        thumb_func_end Sound_EmitPsgPitch

