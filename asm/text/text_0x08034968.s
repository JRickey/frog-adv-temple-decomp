@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08034968, 0x0803578c)  (0xe24 bytes)
@
@ Post-peel chunk after sub_0803493C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08034968
        .type   text_08034968, %object
text_08034968:
        .incbin "frog_us_baserom.gba", 0x00034968, 0x00000e24
        .size   text_08034968, . - text_08034968
