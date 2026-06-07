@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundOpcode_TriggerStream
SoundOpcode_TriggerStream:
        .incbin "frog_us_baserom.gba", 0x309a0, 0xa4
        thumb_func_end SoundOpcode_TriggerStream
