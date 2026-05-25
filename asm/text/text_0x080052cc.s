@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080052cc, 0x08010000)  (0xad34 bytes)
@
@ Continuation past the SetGameMode_15 peel at 0x080052c0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080052cc
        .type   text_080052cc, %object
text_080052cc:
        .incbin "frog_us_baserom.gba", 0x000052cc, 0x0000ad34
        .size   text_080052cc, . - text_080052cc
