@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002450, 0x08010000)  (0xdbb0 bytes)
@
@ Continuation of the 0x080000c0 bucket past the SetGameMode_06 leaf
@ peel at 0x08002444. Next Thumb function starts at 0x08002450 with
@ push {lr}.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002450
        .type   text_08002450, %object
text_08002450:
        .incbin "frog_us_baserom.gba", 0x00002450, 0x0000dbb0
        .size   text_08002450, . - text_08002450
