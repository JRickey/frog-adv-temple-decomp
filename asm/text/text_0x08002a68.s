@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002a68, 0x080052c0)  (0x2858 bytes)
@
@ Continuation past the SetGameMode_08 peel at 0x08002a5c.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002a68
        .type   text_08002a68, %object
text_08002a68:
        .incbin "frog_us_baserom.gba", 0x00002a68, 0x00002858
        .size   text_08002a68, . - text_08002a68
