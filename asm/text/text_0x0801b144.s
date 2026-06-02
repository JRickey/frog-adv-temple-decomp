@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801b144, 0x0801b374)  (0x230 bytes)
@
@ Post-peel chunk after sub_0801B0AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801b144
        .type   text_0801b144, %object
text_0801b144:
        .incbin "frog_us_baserom.gba", 0x0001b144, 0x00000230
        .size   text_0801b144, . - text_0801b144
