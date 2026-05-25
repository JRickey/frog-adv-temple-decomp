@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080004c4, 0x08002444)  (0x1f80 bytes)
@
@ Bucket nominally begins at the 0x080000c0 boundary; trimmed at both
@ ends as peels are extracted: 0x080004c4 is the byte after AgbMain;
@ 0x08002444 is the start of the SetGameMode_06 leaf.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080004c4
        .type   text_080004c4, %object
text_080004c4:
        .incbin "frog_us_baserom.gba", 0x000004c4, 0x00001f80
        .size   text_080004c4, . - text_080004c4
