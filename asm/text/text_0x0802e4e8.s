@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802e4e8, 0x0802e5d8)  (0xf0 bytes)
@
@ Post-peel chunk after sub_0802E43C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802e4e8
        .type   text_0802e4e8, %object
text_0802e4e8:
        .incbin "frog_us_baserom.gba", 0x0002e4e8, 0x000000f0
        .size   text_0802e4e8, . - text_0802e4e8
