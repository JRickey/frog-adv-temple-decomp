@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080004c4, 0x08001478)  (0xfb4 bytes)
@
@ Bucket trimmed at 0x08001478 by the SetGameMode_03 peel.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080004c4
        .type   text_080004c4, %object
text_080004c4:
        .incbin "frog_us_baserom.gba", 0x000004c4, 0x00000fb4
        .size   text_080004c4, . - text_080004c4
