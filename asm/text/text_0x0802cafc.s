@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802cafc, 0x0802d554)  (0xa58 bytes)
@
@ Post-peel chunk after sub_0802CA80.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802cafc
        .type   text_0802cafc, %object
text_0802cafc:
        .incbin "frog_us_baserom.gba", 0x0002cafc, 0x00000a58
        .size   text_0802cafc, . - text_0802cafc
