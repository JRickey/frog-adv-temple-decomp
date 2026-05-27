@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800eb1c, 0x0800ee34)  (0x318 bytes)
@
@ Post-peel chunk after sub_0800E85C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800eb1c
        .type   text_0800eb1c, %object
text_0800eb1c:
        .incbin "frog_us_baserom.gba", 0x0000eb1c, 0x00000318
        .size   text_0800eb1c, . - text_0800eb1c
