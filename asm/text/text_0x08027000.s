@ Auto-emitted by peeler — raw bytes after sub_08026F8C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027000, 0x0802a2f0)  (0x32f0 bytes)
@
@ Post-peel chunk after sub_08026F8C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027000
        .type   text_08027000, %object
text_08027000:
        .incbin "frog_us_baserom.gba", 0x027000, 0x32f0
        .size   text_08027000, . - text_08027000
