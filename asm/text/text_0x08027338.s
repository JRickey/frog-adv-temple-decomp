@ Auto-emitted by peeler — raw bytes after sub_08027310.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027338, 0x0802a2f0)  (0x2fb8 bytes)
@
@ Post-peel chunk after sub_08027310.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027338
        .type   text_08027338, %object
text_08027338:
        .incbin "frog_us_baserom.gba", 0x27338, 0x2fb8
        .size   text_08027338, . - text_08027338
