@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020c14, 0x08020c78)  (0x64 bytes)
@
@ Post-peel chunk after sub_08020BF0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020c14
        .type   text_08020c14, %object
text_08020c14:
        .incbin "frog_us_baserom.gba", 0x00020c14, 0x00000064
        .size   text_08020c14, . - text_08020c14
