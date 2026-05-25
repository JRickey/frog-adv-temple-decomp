@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002a68, 0x08002e04)  (0x39c bytes)
@
@ Bucket trimmed at 0x08002e04 by the SetGameMode_09 peel.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002a68
        .type   text_08002a68, %object
text_08002a68:
        .incbin "frog_us_baserom.gba", 0x00002a68, 0x0000039c
        .size   text_08002a68, . - text_08002a68
