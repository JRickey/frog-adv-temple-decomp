@ Auto-emitted by peeler — raw bytes after sub_08027338.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802735c, 0x0802a2f0)  (0x2f94 bytes)
@
@ Post-peel chunk after sub_08027338.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802735c
        .type   text_0802735c, %object
text_0802735c:
        .incbin "frog_us_baserom.gba", 0x2735c, 0x2f94
        .size   text_0802735c, . - text_0802735c
