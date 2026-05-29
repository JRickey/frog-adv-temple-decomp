@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800c2a8, 0x0800c358)  (0xb0 bytes)
@
@ Post-peel chunk after sub_0800BF24.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800c2a8
        .type   text_0800c2a8, %object
text_0800c2a8:
        .incbin "frog_us_baserom.gba", 0x0000c2a8, 0x000000b0
        .size   text_0800c2a8, . - text_0800c2a8
