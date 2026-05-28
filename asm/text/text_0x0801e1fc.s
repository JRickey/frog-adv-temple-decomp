@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801e1fc, 0x0801e270)  (0x74 bytes)
@
@ Post-peel chunk after sub_0801E1AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801e1fc
        .type   text_0801e1fc, %object
text_0801e1fc:
        .incbin "frog_us_baserom.gba", 0x0001e1fc, 0x00000074
        .size   text_0801e1fc, . - text_0801e1fc
