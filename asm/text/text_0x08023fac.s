@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023fac, 0x0802a2f0)  (0x6344 bytes)
@
@ Post-peel chunk after sub_08023F68.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023fac
        .type   text_08023fac, %object
text_08023fac:
        .incbin "frog_us_baserom.gba", 0x00023fac, 0x00006344
        .size   text_08023fac, . - text_08023fac
