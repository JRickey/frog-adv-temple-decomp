@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020bf0, 0x08020c78)  (0x88 bytes)
@
@ Pre-peel chunk before sub_08020C78.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020bf0
        .type   text_08020bf0, %object
text_08020bf0:
        .incbin "frog_us_baserom.gba", 0x00020bf0, 0x00000088
        .size   text_08020bf0, . - text_08020bf0
