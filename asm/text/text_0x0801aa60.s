@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801aa60, 0x0801b514)  (0xab4 bytes)
@
@ Post-peel chunk after sub_0801A980.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801aa60
        .type   text_0801aa60, %object
text_0801aa60:
        .incbin "frog_us_baserom.gba", 0x0001aa60, 0x00000ab4
        .size   text_0801aa60, . - text_0801aa60
