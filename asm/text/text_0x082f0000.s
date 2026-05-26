@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082f0000, 0x082f8ad8)  (0x8ad8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.
@
@ Manually trimmed (was [0x082f0000, 0x08300000) originally, then
@ [0x082f0000, 0x082f8de0) after the sound LUTs landed, now
@ [0x082f0000, 0x082f8ad8) to make room for sSpriteAssetTable).

        .section .text, "ax", %progbits
        .align  2
        .global text_082f0000
        .type   text_082f0000, %object
text_082f0000:
        .incbin "frog_us_baserom.gba", 0x002f0000, 0x00008ad8
        .size   text_082f0000, . - text_082f0000
