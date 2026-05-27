@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802dcbc, 0x0802e13c)  (0x480 bytes)
@
@ Pre-peel chunk before sub_0802E13C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802dcbc
        .type   text_0802dcbc, %object
text_0802dcbc:
        .incbin "frog_us_baserom.gba", 0x0002dcbc, 0x00000480
        .size   text_0802dcbc, . - text_0802dcbc
