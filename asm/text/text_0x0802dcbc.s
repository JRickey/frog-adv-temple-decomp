@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802dcbc, 0x0802e3f8)  (0x73c bytes)
@
@ Post-peel chunk after sub_0802D9EC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802dcbc
        .type   text_0802dcbc, %object
text_0802dcbc:
        .incbin "frog_us_baserom.gba", 0x0002dcbc, 0x0000073c
        .size   text_0802dcbc, . - text_0802dcbc
