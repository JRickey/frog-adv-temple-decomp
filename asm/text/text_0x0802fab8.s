@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802fab8, 0x08030000)  (0x548 bytes)
@
@ Post-peel chunk after sub_0802FA60.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802fab8
        .type   text_0802fab8, %object
text_0802fab8:
        .incbin "frog_us_baserom.gba", 0x0002fab8, 0x00000548
        .size   text_0802fab8, . - text_0802fab8
