@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080017a8, 0x080018f8)  (0x150 bytes)
@
@ Post-peel chunk after sub_08001794.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080017a8
        .type   text_080017a8, %object
text_080017a8:
        .incbin "frog_us_baserom.gba", 0x000017a8, 0x00000150
        .size   text_080017a8, . - text_080017a8
