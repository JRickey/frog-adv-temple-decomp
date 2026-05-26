@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08008570, 0x080090b0)  (0xb40 bytes)
@
@ Pre-peel chunk before sub_080090B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08008570
        .type   text_08008570, %object
text_08008570:
        .incbin "frog_us_baserom.gba", 0x00008570, 0x00000b40
        .size   text_08008570, . - text_08008570
