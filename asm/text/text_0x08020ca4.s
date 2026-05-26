@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020ca4, 0x0802d558)  (0xc8b4 bytes)
@
@ Post-peel chunk after sub_08020C78.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020ca4
        .type   text_08020ca4, %object
text_08020ca4:
        .incbin "frog_us_baserom.gba", 0x00020ca4, 0x0000c8b4
        .size   text_08020ca4, . - text_08020ca4
