@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080076a4, 0x080077ac)  (0x108 bytes)
@
@ Pre-peel chunk before sub_080077AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080076a4
        .type   text_080076a4, %object
text_080076a4:
        .incbin "frog_us_baserom.gba", 0x000076a4, 0x00000108
        .size   text_080076a4, . - text_080076a4
