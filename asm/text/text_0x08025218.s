@ Auto-emitted by peeling sub_080251F4 — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025218, 0x0802a2f0)  (0x50d8 bytes)
@
@ Post-peel chunk after sub_080251F4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08025218
        .type   text_08025218, %object
text_08025218:
        .incbin "frog_us_baserom.gba", 0x00025218, 0x000050d8
        .size   text_08025218, . - text_08025218
