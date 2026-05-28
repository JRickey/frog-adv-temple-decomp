@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801d438, 0x0801d4cc)  (0x94 bytes)
@
@ Pre-peel chunk before sub_0801D4CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801d438
        .type   text_0801d438, %object
text_0801d438:
        .incbin "frog_us_baserom.gba", 0x0001d438, 0x00000094
        .size   text_0801d438, . - text_0801d438
