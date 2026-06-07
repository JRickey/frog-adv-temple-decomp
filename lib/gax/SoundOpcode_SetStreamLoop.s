@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOpcode_SetStreamLoop
SoundOpcode_SetStreamLoop:
        .incbin "frog_us_baserom.gba", 0x30a44, 0xf0
        thumb_func_end SoundOpcode_SetStreamLoop
