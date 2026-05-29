@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080018a8, 0x080018f8)  (0x50 bytes)
@
@ Post-peel chunk after sub_0800189C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080018a8
        .type   text_080018a8, %object
text_080018a8:
        .incbin "frog_us_baserom.gba", 0x000018a8, 0x00000050
        .size   text_080018a8, . - text_080018a8
