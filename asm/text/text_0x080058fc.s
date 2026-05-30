@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080058fc, 0x080059c4)  (0xc8 bytes)
@
@ Post-peel chunk after sub_080058CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080058fc
        .type   text_080058fc, %object
text_080058fc:
        .incbin "frog_us_baserom.gba", 0x000058fc, 0x000000c8
        .size   text_080058fc, . - text_080058fc
