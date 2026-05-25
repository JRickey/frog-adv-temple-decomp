@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002e10, 0x08004074)  (0x1264 bytes)
@
@ Bucket trimmed at 0x08004074 by the SetGameMode_12 peel.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002e10
        .type   text_08002e10, %object
text_08002e10:
        .incbin "frog_us_baserom.gba", 0x00002e10, 0x00001264
        .size   text_08002e10, . - text_08002e10
