@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800dc3c, 0x0800dc50)  (0x14 bytes)
@
@ Post-peel chunk after sub_0800DAB8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800dc3c
        .type   text_0800dc3c, %object
text_0800dc3c:
        .incbin "frog_us_baserom.gba", 0x0000dc3c, 0x00000014
        .size   text_0800dc3c, . - text_0800dc3c
