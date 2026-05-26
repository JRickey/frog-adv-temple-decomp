@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Gap bucket between src/data/screen_tilemaps_e9c18.c and src/data/obj_assets_ecc18.c.
@ Range:  [0x081eac18, 0x081ecc18)  (0x2000 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_081eac18
        .type   text_081eac18, %object
text_081eac18:
        .incbin "frog_us_baserom.gba", 0x001eac18, 0x00002000
        .size   text_081eac18, . - text_081eac18
