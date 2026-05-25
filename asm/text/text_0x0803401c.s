@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0803401c, 0x08040000)  (0xbfe4 bytes)
@
@ Post-peel chunk after sub_08033F5C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0803401c
        .type   text_0803401c, %object
text_0803401c:
        .incbin "frog_us_baserom.gba", 0x0003401c, 0x0000bfe4
        .size   text_0803401c, . - text_0803401c
