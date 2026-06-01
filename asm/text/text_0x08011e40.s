@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011e40, 0x08012180)  (0x340 bytes)
@
@ Post-peel chunk after sub_08011AA4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011e40
        .type   text_08011e40, %object
text_08011e40:
        .incbin "frog_us_baserom.gba", 0x00011e40, 0x00000340
        .size   text_08011e40, . - text_08011e40
