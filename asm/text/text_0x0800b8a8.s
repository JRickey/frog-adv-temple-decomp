@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800b8a8, 0x0800de80)  (0x25d8 bytes)
@
@ Post-peel chunk after sub_0800B7B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800b8a8
        .type   text_0800b8a8, %object
text_0800b8a8:
        .incbin "frog_us_baserom.gba", 0x0000b8a8, 0x000025d8
        .size   text_0800b8a8, . - text_0800b8a8
