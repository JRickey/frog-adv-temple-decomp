@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start SoundRequestSlot_Drain
SoundRequestSlot_Drain:
        .incbin "frog_us_baserom.gba", 0x32094, 0xb4
        thumb_func_end SoundRequestSlot_Drain
