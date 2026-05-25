@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800276c, 0x08010000)  (0xd894 bytes)
@
@ Continuation past the SetGameMode_07 peel at 0x08002760.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800276c
        .type   text_0800276c, %object
text_0800276c:
        .incbin "frog_us_baserom.gba", 0x0000276c, 0x0000d894
        .size   text_0800276c, . - text_0800276c
