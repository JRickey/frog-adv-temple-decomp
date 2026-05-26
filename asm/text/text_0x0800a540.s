@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a540, 0x0800a7a8)  (0x268 bytes)
@
@ Pre-peel chunk before sub_0800A7A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a540
        .type   text_0800a540, %object
text_0800a540:
        .incbin "frog_us_baserom.gba", 0x0000a540, 0x00000268
        .size   text_0800a540, . - text_0800a540
