@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d0f8, 0x0800dc50)  (0xb58 bytes)
@
@ Post-peel chunk after sub_0800D070.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d0f8
        .type   text_0800d0f8, %object
text_0800d0f8:
        .incbin "frog_us_baserom.gba", 0x0000d0f8, 0x00000b58
        .size   text_0800d0f8, . - text_0800d0f8
