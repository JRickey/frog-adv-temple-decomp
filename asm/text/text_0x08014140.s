@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08014140, 0x08015a00)  (0x18c0 bytes)
@
@ Post-peel chunk after sub_080140A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08014140
        .type   text_08014140, %object
text_08014140:
        .incbin "frog_us_baserom.gba", 0x00014140, 0x000018c0
        .size   text_08014140, . - text_08014140
