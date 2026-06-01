@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013aac, 0x08013c60)  (0x1b4 bytes)
@
@ Post-peel chunk after sub_08013A70.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013aac
        .type   text_08013aac, %object
text_08013aac:
        .incbin "frog_us_baserom.gba", 0x00013aac, 0x000001b4
        .size   text_08013aac, . - text_08013aac
