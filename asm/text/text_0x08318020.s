@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08318020, 0x08320000)  (0x7fe0 bytes)
@
@ Post-anchor tail of the original [0x08310000, 0x08320000) blob,
@ following src/data/level_layout.o(.rodata) at 0x08316f24..0x08318020.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08318020
        .type   text_08318020, %object
text_08318020:
        .incbin "frog_us_baserom.gba", 0x00318020, 0x00007fe0
        .size   text_08318020, . - text_08318020
