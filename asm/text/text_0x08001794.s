@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08001794, 0x080018f8)  (0x164 bytes)
@
@ Pre-peel chunk before sub_080018F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08001794
        .type   text_08001794, %object
text_08001794:
        .incbin "frog_us_baserom.gba", 0x00001794, 0x00000164
        .size   text_08001794, . - text_08001794
