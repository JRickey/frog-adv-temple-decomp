@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083170d4, 0x08320000)  (0x8f2c bytes)
@
@ Post-anchor tail of the original [0x08310000, 0x08320000) blob,
@ following src/data/level_layout.c at 0x08316f24..0x083170d4.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_083170d4
        .type   text_083170d4, %object
text_083170d4:
        .incbin "frog_us_baserom.gba", 0x003170d4, 0x00008f2c
        .size   text_083170d4, . - text_083170d4
