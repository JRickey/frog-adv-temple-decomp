@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800ef58, 0x0800ef90)  (0x38 bytes)
@
@ Post-peel chunk after sub_0800EE94.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800ef58
        .type   text_0800ef58, %object
text_0800ef58:
        .incbin "frog_us_baserom.gba", 0x0000ef58, 0x00000038
        .size   text_0800ef58, . - text_0800ef58
