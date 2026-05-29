@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801c2b4, 0x0801c464)  (0x1b0 bytes)
@
@ Post-peel chunk after sub_0801C078.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801c2b4
        .type   text_0801c2b4, %object
text_0801c2b4:
        .incbin "frog_us_baserom.gba", 0x0001c2b4, 0x000001b0
        .size   text_0801c2b4, . - text_0801c2b4
