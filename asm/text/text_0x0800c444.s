@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800c444, 0x0800cd88)  (0x944 bytes)
@
@ Post-peel chunk after sub_0800C358.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800c444
        .type   text_0800c444, %object
text_0800c444:
        .incbin "frog_us_baserom.gba", 0x0000c444, 0x00000944
        .size   text_0800c444, . - text_0800c444
