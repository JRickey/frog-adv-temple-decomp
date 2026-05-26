@ Tail of the 0x080c0000 bucket after the entity-dispatch cluster
@ [0x080c0ab0, 0x080c1254) was extracted into src/data/entity_dispatch.c.
@ Range:  [0x080c1254, 0x080d0000)  (0xedac bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions or tables are identified and peeled out, they
@ will appear in linker.ld between this bucket and its neighbours.

        .section .text, "ax", %progbits
        .align  2
        .global text_080c1254
        .type   text_080c1254, %object
text_080c1254:
        .incbin "frog_us_baserom.gba", 0x000c1254, 0x0000edac
        .size   text_080c1254, . - text_080c1254
