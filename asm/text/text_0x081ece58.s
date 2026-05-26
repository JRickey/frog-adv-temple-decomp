@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Tail bucket after src/data/obj_assets_ecc18.c cluster.
@ Range:  [0x081ece58, 0x081f0000)  (0x31a8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_081ece58
        .type   text_081ece58, %object
text_081ece58:
        .incbin "frog_us_baserom.gba", 0x001ece58, 0x000031a8
        .size   text_081ece58, . - text_081ece58
