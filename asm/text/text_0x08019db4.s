@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019db4, 0x08019ef0)  (0x13c bytes)
@
@ Post-peel chunk after sub_08019AEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019db4
        .type   text_08019db4, %object
text_08019db4:
        .incbin "frog_us_baserom.gba", 0x00019db4, 0x0000013c
        .size   text_08019db4, . - text_08019db4
