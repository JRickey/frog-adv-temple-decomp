@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0803493c, 0x0803578c)  (0xe50 bytes)
@
@ Post-peel chunk after sub_08034924.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0803493c
        .type   text_0803493c, %object
text_0803493c:
        .incbin "frog_us_baserom.gba", 0x0003493c, 0x00000e50
        .size   text_0803493c, . - text_0803493c
