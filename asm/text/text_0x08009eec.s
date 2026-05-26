@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08009eec, 0x0800a104)  (0x218 bytes)
@
@ Post-peel chunk after sub_08009D9C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08009eec
        .type   text_08009eec, %object
text_08009eec:
        .incbin "frog_us_baserom.gba", 0x00009eec, 0x00000218
        .size   text_08009eec, . - text_08009eec
