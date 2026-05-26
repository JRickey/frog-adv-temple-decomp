@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08009a58, 0x08009c14)  (0x1bc bytes)
@
@ Pre-peel chunk before sub_08009C14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08009a58
        .type   text_08009a58, %object
text_08009a58:
        .incbin "frog_us_baserom.gba", 0x00009a58, 0x000001bc
        .size   text_08009a58, . - text_08009a58
