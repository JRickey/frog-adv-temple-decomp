@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800088c, 0x08001478)  (0xbec bytes)
@
@ Post-peel chunk after sub_08000820.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800088c
        .type   text_0800088c, %object
text_0800088c:
        .incbin "frog_us_baserom.gba", 0x0000088c, 0x00000bec
        .size   text_0800088c, . - text_0800088c
