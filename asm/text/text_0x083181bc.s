@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083181bc, 0x08320000)  (0x7e44 bytes)
@
@ Post-cluster tail of the original [0x08318020, 0x08320000) blob,
@ following src/data/level_layout_318020.o(.rodata) at
@ 0x08318020..0x083181bc.
@
@ Opens with a `{ptr=0x0831813c, count=0x20}` dispatch entry then a
@ long monotonically-increasing u32 offset table -- next data pass
@ candidate.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_083181bc
        .type   text_083181bc, %object
text_083181bc:
        .incbin "frog_us_baserom.gba", 0x003181bc, 0x00007e44
        .size   text_083181bc, . - text_083181bc
