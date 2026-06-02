@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801f970, 0x0801fd0c)  (0x39c bytes)
@
@ Pre-peel chunk before sub_0801FD0C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801f970
        .type   text_0801f970, %object
text_0801f970:
        .incbin "frog_us_baserom.gba", 0x0001f970, 0x0000039c
        .size   text_0801f970, . - text_0801f970
