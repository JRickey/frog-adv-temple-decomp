@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800908c, 0x080090b0)  (0x24 bytes)
@
@ Post-peel chunk after sub_08008F98.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800908c
        .type   text_0800908c, %object
text_0800908c:
        .incbin "frog_us_baserom.gba", 0x0000908c, 0x00000024
        .size   text_0800908c, . - text_0800908c
