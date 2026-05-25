@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033948, 0x08040000)  (0xc6b8 bytes)
@
@ Post-peel chunk after sub_08033910.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033948
        .type   text_08033948, %object
text_08033948:
        .incbin "frog_us_baserom.gba", 0x00033948, 0x0000c6b8
        .size   text_08033948, . - text_08033948
