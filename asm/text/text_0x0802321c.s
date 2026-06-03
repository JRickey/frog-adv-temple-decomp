@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802321c, 0x0802a394)  (0x7178 bytes)
@
@ Post-peel chunk after sub_080231F4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802321c
        .type   text_0802321c, %object
text_0802321c:
        .incbin "frog_us_baserom.gba", 0x0002321c, 0x00007178
        .size   text_0802321c, . - text_0802321c
