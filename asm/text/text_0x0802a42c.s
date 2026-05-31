@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802a42c, 0x0802a4a4)  (0x78 bytes)
@
@ Post-peel chunk after sub_0802A394.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802a42c
        .type   text_0802a42c, %object
text_0802a42c:
        .incbin "frog_us_baserom.gba", 0x0002a42c, 0x00000078
        .size   text_0802a42c, . - text_0802a42c
