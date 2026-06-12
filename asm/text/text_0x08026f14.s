@ Auto-emitted by peeler — raw bytes after sub_08026EDC.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08026f14, 0x0802a2f0)  (0x33dc bytes)
@
@ Post-peel chunk after sub_08026EDC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08026f14
        .type   text_08026f14, %object
text_08026f14:
        .incbin "frog_us_baserom.gba", 0x026f14, 0x33dc
        .size   text_08026f14, . - text_08026f14
