@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019984, 0x08019aec)  (0x168 bytes)
@
@ Pre-peel chunk before sub_08019AEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019984
        .type   text_08019984, %object
text_08019984:
        .incbin "frog_us_baserom.gba", 0x00019984, 0x00000168
        .size   text_08019984, . - text_08019984
