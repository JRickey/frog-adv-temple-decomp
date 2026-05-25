@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08001484, 0x08002444)  (0xfc0 bytes)
@
@ Continuation past the SetGameMode_03 peel at 0x08001478.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08001484
        .type   text_08001484, %object
text_08001484:
        .incbin "frog_us_baserom.gba", 0x00001484, 0x00000fc0
        .size   text_08001484, . - text_08001484
