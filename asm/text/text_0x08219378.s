@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Gap bucket between src/data/sprite_tiles_215778.c and src/data/sprite_tiles_219cc8.c.
@ Range:  [0x08219378, 0x08219cc8)  (0x950 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08219378
        .type   text_08219378, %object
text_08219378:
        .incbin "frog_us_baserom.gba", 0x00219378, 0x00000950
        .size   text_08219378, . - text_08219378
