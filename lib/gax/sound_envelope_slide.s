@ GAX Sound System (Shin'en) — third-party audio library, kept byte-exact.
@ Bytes verbatim from ROM; not decompiled. See lib/gax/README.md.
        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Sound_TickEnvelopeC
Sound_TickEnvelopeC:
        .incbin "frog_us_baserom.gba", 0x2f054, 0x2a8
        thumb_func_end Sound_TickEnvelopeC

