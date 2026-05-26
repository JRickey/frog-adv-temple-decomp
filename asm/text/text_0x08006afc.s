@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006afc, 0x08006b88)  (0x8c bytes)
@
@ Post-peel chunk after sub_08006ADC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006afc
        .type   text_08006afc, %object
text_08006afc:
        .incbin "frog_us_baserom.gba", 0x00006afc, 0x0000008c
        .size   text_08006afc, . - text_08006afc
