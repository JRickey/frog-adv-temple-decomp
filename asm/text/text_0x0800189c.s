@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800189c, 0x080018f8)  (0x5c bytes)
@
@ Post-peel chunk after sub_08001850.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800189c
        .type   text_0800189c, %object
text_0800189c:
        .incbin "frog_us_baserom.gba", 0x0000189c, 0x0000005c
        .size   text_0800189c, . - text_0800189c
