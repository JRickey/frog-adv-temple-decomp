@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002ac4, 0x08002ae8)  (0x24 bytes)
@
@ Post-peel chunk after sub_08002A9C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002ac4
        .type   text_08002ac4, %object
text_08002ac4:
        .incbin "frog_us_baserom.gba", 0x00002ac4, 0x00000024
        .size   text_08002ac4, . - text_08002ac4
