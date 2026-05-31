@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020d9c, 0x08020da0)  (0x4 bytes)
@
@ Post-peel chunk after sub_08020D2C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020d9c
        .type   text_08020d9c, %object
text_08020d9c:
        .incbin "frog_us_baserom.gba", 0x00020d9c, 0x00000004
        .size   text_08020d9c, . - text_08020d9c
