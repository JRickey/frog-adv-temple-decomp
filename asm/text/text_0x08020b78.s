@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020b78, 0x08020b88)  (0x10 bytes)
@
@ Post-peel chunk after sub_08020B60.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020b78
        .type   text_08020b78, %object
text_08020b78:
        .incbin "frog_us_baserom.gba", 0x00020b78, 0x00000010
        .size   text_08020b78, . - text_08020b78
