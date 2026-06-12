@ Auto-emitted by peeling sub_080252e8 — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802532c, 0x0802a2f0)  (0x4fc4 bytes)
@
@ Post-peel chunk after sub_080252e8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802532c
        .type   text_0802532c, %object
text_0802532c:
        .incbin "baserom.gba", 0x0002532c, 0x00004fc4
        .size   text_0802532c, . - text_0802532c
