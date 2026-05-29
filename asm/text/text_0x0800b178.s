@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800b178, 0x0800b7b0)  (0x638 bytes)
@
@ Post-peel chunk after sub_0800B07C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800b178
        .type   text_0800b178, %object
text_0800b178:
        .incbin "frog_us_baserom.gba", 0x0000b178, 0x00000638
        .size   text_0800b178, . - text_0800b178
