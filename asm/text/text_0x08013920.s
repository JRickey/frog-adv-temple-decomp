@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013920, 0x08013c60)  (0x340 bytes)
@
@ Pre-peel chunk before sub_08013C60.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013920
        .type   text_08013920, %object
text_08013920:
        .incbin "frog_us_baserom.gba", 0x00013920, 0x00000340
        .size   text_08013920, . - text_08013920
