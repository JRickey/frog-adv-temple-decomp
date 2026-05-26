@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083dda4c, 0x083ddcdc)  (0x290 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.
@
@ Carved out of the original 0x083d0000 bucket when sChannelRegTable /
@ sWaveVolLut were extracted into src/data/sound_tables.c.

        .section .text, "ax", %progbits
        .align  2
        .global text_083dda4c
        .type   text_083dda4c, %object
text_083dda4c:
        .incbin "frog_us_baserom.gba", 0x003dda4c, 0x00000290
        .size   text_083dda4c, . - text_083dda4c
