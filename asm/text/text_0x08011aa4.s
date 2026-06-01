@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011aa4, 0x08012180)  (0x6dc bytes)
@
@ Post-peel chunk after sub_08011984.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011aa4
        .type   text_08011aa4, %object
text_08011aa4:
        .incbin "frog_us_baserom.gba", 0x00011aa4, 0x000006dc
        .size   text_08011aa4, . - text_08011aa4
