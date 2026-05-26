@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0830b064, 0x08310000)  (0x4f9c bytes)
@
@ Tail of the original [0x08300000, 0x08310000) blob after the sprite
@ dispatch + animation descriptor cluster (0x08306444..0x08308100),
@ the OAM/DMA-load record cluster (0x08308100..0x0830ad7c), and the
@ DMA-load dispatch table (0x0830ad7c..0x0830b064) all landed in
@ src/data/sprite_*.c.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0830b064
        .type   text_0830b064, %object
text_0830b064:
        .incbin "frog_us_baserom.gba", 0x0030b064, 0x00004f9c
        .size   text_0830b064, . - text_0830b064
