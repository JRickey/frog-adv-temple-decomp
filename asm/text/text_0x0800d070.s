@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d070, 0x0800dc50)  (0xbe0 bytes)
@
@ Pre-peel chunk before sub_0800DC50.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d070
        .type   text_0800d070, %object
text_0800d070:
        .incbin "frog_us_baserom.gba", 0x0000d070, 0x00000be0
        .size   text_0800d070, . - text_0800d070
