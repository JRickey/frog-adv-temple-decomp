@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002a9c, 0x08002ae8)  (0x4c bytes)
@
@ Post-peel chunk after sub_08002A68.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002a9c
        .type   text_08002a9c, %object
text_08002a9c:
        .incbin "frog_us_baserom.gba", 0x00002a9c, 0x0000004c
        .size   text_08002a9c, . - text_08002a9c
