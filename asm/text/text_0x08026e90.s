@ Auto-emitted by peeler — raw bytes after sub_08026E6C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08026e90, 0x0802a2f0)  (0x3460 bytes)
@
@ Post-peel chunk after sub_08026E6C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08026e90
        .type   text_08026e90, %object
text_08026e90:
        .incbin "frog_us_baserom.gba", 0x026e90, 0x3460
        .size   text_08026e90, . - text_08026e90
