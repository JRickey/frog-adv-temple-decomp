@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023334, 0x0802a394)  (0x7060 bytes)
@
@ Post-peel chunk after sub_080232CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023334
        .type   text_08023334, %object
text_08023334:
        .incbin "frog_us_baserom.gba", 0x00023334, 0x00007060
        .size   text_08023334, . - text_08023334
