@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013f68, 0x08013fa0)  (0x38 bytes)
@
@ Post-peel chunk after sub_08013E94.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013f68
        .type   text_08013f68, %object
text_08013f68:
        .incbin "frog_us_baserom.gba", 0x00013f68, 0x00000038
        .size   text_08013f68, . - text_08013f68
