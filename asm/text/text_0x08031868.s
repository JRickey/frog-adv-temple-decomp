@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08031868, 0x0803189c)  (0x34 bytes)
@
@ Post-peel chunk after sub_08031824.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08031868
        .type   text_08031868, %object
text_08031868:
        .incbin "frog_us_baserom.gba", 0x00031868, 0x00000034
        .size   text_08031868, . - text_08031868
