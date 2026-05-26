@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006aac, 0x08006adc)  (0x30 bytes)
@
@ Post-peel chunk after sub_08006A74.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006aac
        .type   text_08006aac, %object
text_08006aac:
        .incbin "frog_us_baserom.gba", 0x00006aac, 0x00000030
        .size   text_08006aac, . - text_08006aac
