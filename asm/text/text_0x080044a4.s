@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080044a4, 0x08004508)  (0x64 bytes)
@
@ Post-peel chunk after sub_08004470.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080044a4
        .type   text_080044a4, %object
text_080044a4:
        .incbin "frog_us_baserom.gba", 0x000044a4, 0x00000064
        .size   text_080044a4, . - text_080044a4
