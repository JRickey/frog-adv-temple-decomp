@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080118d8, 0x08012664)  (0xd8c bytes)
@
@ Post-peel chunk after sub_08011884.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080118d8
        .type   text_080118d8, %object
text_080118d8:
        .incbin "frog_us_baserom.gba", 0x000118d8, 0x00000d8c
        .size   text_080118d8, . - text_080118d8
