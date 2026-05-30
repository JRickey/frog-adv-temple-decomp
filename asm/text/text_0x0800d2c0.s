@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d2c0, 0x0800dc50)  (0x990 bytes)
@
@ Post-peel chunk after sub_0800D270.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d2c0
        .type   text_0800d2c0, %object
text_0800d2c0:
        .incbin "frog_us_baserom.gba", 0x0000d2c0, 0x00000990
        .size   text_0800d2c0, . - text_0800d2c0
