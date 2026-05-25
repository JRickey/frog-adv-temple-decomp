@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004080, 0x080052c0)  (0x1240 bytes)
@
@ Continuation past the SetGameMode_12 peel at 0x08004074.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004080
        .type   text_08004080, %object
text_08004080:
        .incbin "frog_us_baserom.gba", 0x00004080, 0x00001240
        .size   text_08004080, . - text_08004080
