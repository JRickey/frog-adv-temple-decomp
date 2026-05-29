@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020cdc, 0x08020dc4)  (0xe8 bytes)
@
@ Post-peel chunk after sub_08020CA4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020cdc
        .type   text_08020cdc, %object
text_08020cdc:
        .incbin "frog_us_baserom.gba", 0x00020cdc, 0x000000e8
        .size   text_08020cdc, . - text_08020cdc
