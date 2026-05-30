@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800803c, 0x08008174)  (0x138 bytes)
@
@ Post-peel chunk after sub_08007F88.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800803c
        .type   text_0800803c, %object
text_0800803c:
        .incbin "frog_us_baserom.gba", 0x0000803c, 0x00000138
        .size   text_0800803c, . - text_0800803c
