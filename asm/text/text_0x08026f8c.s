@ Auto-emitted by peeler — raw bytes after sub_08026F14.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08026f8c, 0x0802a2f0)  (0x3364 bytes)
@
@ Post-peel chunk after sub_08026F14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08026f8c
        .type   text_08026f8c, %object
text_08026f8c:
        .incbin "frog_us_baserom.gba", 0x026f8c, 0x3364
        .size   text_08026f8c, . - text_08026f8c
