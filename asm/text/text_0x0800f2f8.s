@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800f2f8, 0x08010000)  (0xd08 bytes)
@
@ Post-peel chunk after sub_0800F24C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800f2f8
        .type   text_0800f2f8, %object
text_0800f2f8:
        .incbin "frog_us_baserom.gba", 0x0000f2f8, 0x00000d08
        .size   text_0800f2f8, . - text_0800f2f8
