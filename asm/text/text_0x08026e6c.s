@ Auto-emitted by peeler — raw bytes after sub_08026E40.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08026e6c, 0x0802a2f0)  (0x3484 bytes)
@
@ Post-peel chunk after sub_08026E40.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08026e6c
        .type   text_08026e6c, %object
text_08026e6c:
        .incbin "frog_us_baserom.gba", 0x026e6c, 0x3484
        .size   text_08026e6c, . - text_08026e6c
