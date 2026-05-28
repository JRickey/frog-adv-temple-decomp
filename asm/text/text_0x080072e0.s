@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080072e0, 0x08007660)  (0x380 bytes)
@
@ Post-peel chunk after sub_08007228.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080072e0
        .type   text_080072e0, %object
text_080072e0:
        .incbin "frog_us_baserom.gba", 0x000072e0, 0x00000380
        .size   text_080072e0, . - text_080072e0
