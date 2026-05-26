@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800ce98, 0x0800de80)  (0xfe8 bytes)
@
@ Post-peel chunk after sub_0800CD88.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800ce98
        .type   text_0800ce98, %object
text_0800ce98:
        .incbin "frog_us_baserom.gba", 0x0000ce98, 0x00000fe8
        .size   text_0800ce98, . - text_0800ce98
