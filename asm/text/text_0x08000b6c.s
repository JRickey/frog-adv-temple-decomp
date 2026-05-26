@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08000b6c, 0x08000eb8)  (0x34c bytes)
@
@ Pre-peel chunk before sub_08000EB8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08000b6c
        .type   text_08000b6c, %object
text_08000b6c:
        .incbin "frog_us_baserom.gba", 0x00000b6c, 0x0000034c
        .size   text_08000b6c, . - text_08000b6c
