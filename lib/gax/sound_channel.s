@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_TickSlotEnvelopeB
Sound_TickSlotEnvelopeB:
        .incbin "frog_us_baserom.gba", 0x2ed5c, 0x94
        thumb_func_end Sound_TickSlotEnvelopeB
