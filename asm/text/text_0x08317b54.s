@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08317b54, 0x08320000)  (0x84ac bytes)
@
@ Post-anchor tail of the original [0x08310000, 0x08320000) blob,
@ following src/data/level_layout.o(.rodata) at 0x08316f24..0x08317b54.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08317b54
        .type   text_08317b54, %object
text_08317b54:
        .incbin "frog_us_baserom.gba", 0x00317b54, 0x000084ac
        .size   text_08317b54, . - text_08317b54
