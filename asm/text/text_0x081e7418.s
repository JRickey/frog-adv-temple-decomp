@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Gap bucket between src/data/tilemap_e6c18.c and src/data/screen_tilemaps_e9418.c.
@ Range:  [0x081e7418, 0x081e9418)  (0x2000 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_081e7418
        .type   text_081e7418, %object
text_081e7418:
        .incbin "frog_us_baserom.gba", 0x001e7418, 0x00002000
        .size   text_081e7418, . - text_081e7418
