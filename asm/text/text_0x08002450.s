@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002450, 0x08002760)  (0x310 bytes)
@
@ Bucket trimmed at both ends: 0x08002450 is the function after the
@ SetGameMode_06 peel; 0x08002760 is the start of SetGameMode_07.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002450
        .type   text_08002450, %object
text_08002450:
        .incbin "frog_us_baserom.gba", 0x00002450, 0x00000310
        .size   text_08002450, . - text_08002450
