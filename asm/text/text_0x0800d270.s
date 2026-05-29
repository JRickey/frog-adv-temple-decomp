@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d270, 0x0800dc50)  (0x9e0 bytes)
@
@ Post-peel chunk after sub_0800D1F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d270
        .type   text_0800d270, %object
text_0800d270:
        .incbin "frog_us_baserom.gba", 0x0000d270, 0x000009e0
        .size   text_0800d270, . - text_0800d270
