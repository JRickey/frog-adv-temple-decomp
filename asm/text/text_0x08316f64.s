@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08316f64, 0x08320000)  (0x909c bytes)
@
@ Post-anchor tail of the original [0x08310000, 0x08320000) blob,
@ following src/data/level_layout.c at 0x08316f24..0x08316f64.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08316f64
        .type   text_08316f64, %object
text_08316f64:
        .incbin "frog_us_baserom.gba", 0x00316f64, 0x0000909c
        .size   text_08316f64, . - text_08316f64
