@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080227b4, 0x0802ab64)  (0x83b0 bytes)
@
@ Post-peel chunk after sub_0802277C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080227b4
        .type   text_080227b4, %object
text_080227b4:
        .incbin "frog_us_baserom.gba", 0x000227b4, 0x000083b0
        .size   text_080227b4, . - text_080227b4
