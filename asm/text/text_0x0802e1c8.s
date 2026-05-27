@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802e1c8, 0x0802e3f8)  (0x230 bytes)
@
@ Post-peel chunk after sub_0802E13C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802e1c8
        .type   text_0802e1c8, %object
text_0802e1c8:
        .incbin "frog_us_baserom.gba", 0x0002e1c8, 0x00000230
        .size   text_0802e1c8, . - text_0802e1c8
