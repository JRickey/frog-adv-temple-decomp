@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800276c, 0x08002a5c)  (0x2f0 bytes)
@
@ Bucket trimmed at 0x08002a5c by the SetGameMode_08 peel.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800276c
        .type   text_0800276c, %object
text_0800276c:
        .incbin "frog_us_baserom.gba", 0x0000276c, 0x000002f0
        .size   text_0800276c, . - text_0800276c
