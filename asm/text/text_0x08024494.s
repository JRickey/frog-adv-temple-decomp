@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024494, 0x080244f8)  (0x64 bytes)
@
@ Post-peel chunk after sub_08024470.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024494
        .type   text_08024494, %object
text_08024494:
        .incbin "frog_us_baserom.gba", 0x00024494, 0x00000064
        .size   text_08024494, . - text_08024494
