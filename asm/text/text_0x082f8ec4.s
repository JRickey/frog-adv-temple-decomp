@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082f8ec4, 0x08300000)  (0x713c bytes)
@
@ Tail half of the original [0x082f0000, 0x08300000) blob. Carved out
@ when sSoundDmaBufCfg / sSoundDmaMaster were extracted at 0x082f8e98
@ into src/data/sound_dma_records.c. Contains ARM literal pools for
@ the sound system at 0x080338xx, then 0xff padding.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_082f8ec4
        .type   text_082f8ec4, %object
text_082f8ec4:
        .incbin "frog_us_baserom.gba", 0x002f8ec4, 0x0000713c
        .size   text_082f8ec4, . - text_082f8ec4
