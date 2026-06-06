@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08006ab8, 0x08006adc)  (0x24 bytes)
@
@ Post-peel chunk after PlayerState_SetByte.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08006ab8
        .type   text_08006ab8, %object
text_08006ab8:
        .incbin "frog_us_baserom.gba", 0x00006ab8, 0x00000024
        .size   text_08006ab8, . - text_08006ab8
