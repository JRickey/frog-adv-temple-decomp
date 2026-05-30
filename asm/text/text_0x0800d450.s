@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d450, 0x0800dc50)  (0x800 bytes)
@
@ Post-peel chunk after sub_0800D2C0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d450
        .type   text_0800d450, %object
text_0800d450:
        .incbin "frog_us_baserom.gba", 0x0000d450, 0x00000800
        .size   text_0800d450, . - text_0800d450
