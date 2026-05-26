@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019580, 0x0801a268)  (0xce8 bytes)
@
@ Pre-peel chunk before sub_0801A268.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019580
        .type   text_08019580, %object
text_08019580:
        .incbin "frog_us_baserom.gba", 0x00019580, 0x00000ce8
        .size   text_08019580, . - text_08019580
