@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Inter-symbol pad between sEepromSignatureBlock (0x081bd8cc..0x081bd90c)
@ and sWinPoseHeader (0x081bd910..) — 4 zero bytes of alignment padding
@ that exist in the original ROM.

        .section .text, "ax", %progbits
        .align  2
        .global text_081bd90c
        .type   text_081bd90c, %object
text_081bd90c:
        .incbin "frog_us_baserom.gba", 0x001bd90c, 0x00000004
        .size   text_081bd90c, . - text_081bd90c
