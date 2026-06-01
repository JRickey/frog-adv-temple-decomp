@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012588, 0x08012664)  (0xdc bytes)
@
@ Post-peel chunk after sub_0801255C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012588
        .type   text_08012588, %object
text_08012588:
        .incbin "frog_us_baserom.gba", 0x00012588, 0x000000dc
        .size   text_08012588, . - text_08012588
