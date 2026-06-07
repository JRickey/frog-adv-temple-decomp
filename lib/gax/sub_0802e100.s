@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundHandle_Retire
SoundHandle_Retire:
        .incbin "frog_us_baserom.gba", 0x2e100, 0x3c
        thumb_func_end SoundHandle_Retire

