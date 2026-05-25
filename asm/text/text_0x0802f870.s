@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f870, 0x08030000)  (0x790 bytes)
@
@ Post-peel chunk after sub_0802F4B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f870
        .type   text_0802f870, %object
text_0802f870:
        .incbin "frog_us_baserom.gba", 0x0002f870, 0x00000790
        .size   text_0802f870, . - text_0802f870
