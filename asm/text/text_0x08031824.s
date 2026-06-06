@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08031824, 0x0803189c)  (0x78 bytes)
@
@ Post-peel chunk after sub_080317E0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08031824
        .type   text_08031824, %object
text_08031824:
        .incbin "frog_us_baserom.gba", 0x00031824, 0x00000078
        .size   text_08031824, . - text_08031824
