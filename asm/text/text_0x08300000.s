@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08300000, 0x08306444)  (0x6444 bytes)
@
@ Head half of the original [0x08300000, 0x08310000) blob, carved when
@ the sprite-asset dispatch tables landed at 0x08306444 into
@ src/data/sprite_dispatch.c and src/data/sprite_anim_block.c.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08300000
        .type   text_08300000, %object
text_08300000:
        .incbin "frog_us_baserom.gba", 0x00300000, 0x00006444
        .size   text_08300000, . - text_08300000
