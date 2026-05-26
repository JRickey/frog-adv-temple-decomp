@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802e43c, 0x0802e5d8)  (0x19c bytes)
@
@ Post-peel chunk after sub_0802E418.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802e43c
        .type   text_0802e43c, %object
text_0802e43c:
        .incbin "frog_us_baserom.gba", 0x0002e43c, 0x0000019c
        .size   text_0802e43c, . - text_0802e43c
