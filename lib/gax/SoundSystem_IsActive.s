@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundSystem_IsActive
SoundSystem_IsActive:
        .incbin "frog_us_baserom.gba", 0x32148, 0xb8
        thumb_func_end SoundSystem_IsActive
