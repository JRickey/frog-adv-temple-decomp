@ Auto-emitted by peeling sub_08025218 — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025240, 0x0802a2f0)  (0x50b0 bytes)
@
@ Post-peel chunk after sub_08025218.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08025218
        .type   text_08025218, %object
text_08025218:
        .incbin "frog_us_baserom.gba", 0x00025240, 0x000050b0
        .size   text_08025218, . - text_08025218
