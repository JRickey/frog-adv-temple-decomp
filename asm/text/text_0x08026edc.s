@ Auto-emitted by peeler — raw bytes after sub_08026E90.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08026edc, 0x0802a2f0)  (0x3414 bytes)
@
@ Post-peel chunk after sub_08026E90.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08026edc
        .type   text_08026edc, %object
text_08026edc:
        .incbin "frog_us_baserom.gba", 0x026edc, 0x3414
        .size   text_08026edc, . - text_08026edc
