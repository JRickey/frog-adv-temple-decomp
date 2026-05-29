@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080177d8, 0x0801793c)  (0x164 bytes)
@
@ Post-peel chunk after sub_080177A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080177d8
        .type   text_080177d8, %object
text_080177d8:
        .incbin "frog_us_baserom.gba", 0x000177d8, 0x00000164
        .size   text_080177d8, . - text_080177d8
