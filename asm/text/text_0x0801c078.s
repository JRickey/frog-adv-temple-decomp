@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801c078, 0x0801c464)  (0x3ec bytes)
@
@ Post-peel chunk after sub_0801BE7C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801c078
        .type   text_0801c078, %object
text_0801c078:
        .incbin "frog_us_baserom.gba", 0x0001c078, 0x000003ec
        .size   text_0801c078, . - text_0801c078
