@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800c4e8, 0x0800cb80)  (0x698 bytes)
@
@ Post-peel chunk after sub_0800C4A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800c4e8
        .type   text_0800c4e8, %object
text_0800c4e8:
        .incbin "frog_us_baserom.gba", 0x0000c4e8, 0x00000698
        .size   text_0800c4e8, . - text_0800c4e8
