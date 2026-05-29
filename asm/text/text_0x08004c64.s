@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004c64, 0x08004fac)  (0x348 bytes)
@
@ Post-peel chunk after sub_08004C30.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004c64
        .type   text_08004c64, %object
text_08004c64:
        .incbin "frog_us_baserom.gba", 0x00004c64, 0x00000348
        .size   text_08004c64, . - text_08004c64
