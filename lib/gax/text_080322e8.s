@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080322e8, 0x080323cc)  (0xe4 bytes)
@
@ Post-peel chunk after sub_08032200.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080322e8
        .type   text_080322e8, %object
text_080322e8:
        .incbin "frog_us_baserom.gba", 0x000322e8, 0x000000e4
        .size   text_080322e8, . - text_080322e8
