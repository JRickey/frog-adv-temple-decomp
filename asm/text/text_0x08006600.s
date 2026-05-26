@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006600, 0x0800793c)  (0x133c bytes)
@
@ Post-peel chunk after sub_08005FC8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006600
        .type   text_08006600, %object
text_08006600:
        .incbin "frog_us_baserom.gba", 0x00006600, 0x0000133c
        .size   text_08006600, . - text_08006600
