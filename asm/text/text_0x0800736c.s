@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800736c, 0x08007660)  (0x2f4 bytes)
@
@ Post-peel chunk after sub_080072E0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800736c
        .type   text_0800736c, %object
text_0800736c:
        .incbin "frog_us_baserom.gba", 0x0000736c, 0x000002f4
        .size   text_0800736c, . - text_0800736c
