@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802bc84, 0x0802bc94)  (0x10 bytes)
@
@ Post-peel chunk after sub_0802BC4C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802bc84
        .type   text_0802bc84, %object
text_0802bc84:
        .incbin "frog_us_baserom.gba", 0x0002bc84, 0x00000010
        .size   text_0802bc84, . - text_0802bc84
