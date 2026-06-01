@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013ae8, 0x08013c60)  (0x178 bytes)
@
@ Post-peel chunk after sub_08013AAC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013ae8
        .type   text_08013ae8, %object
text_08013ae8:
        .incbin "frog_us_baserom.gba", 0x00013ae8, 0x00000178
        .size   text_08013ae8, . - text_08013ae8
