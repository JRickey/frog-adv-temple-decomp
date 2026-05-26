@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083d0000, 0x083dda1c)  (0xda1c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.
@
@ Manually trimmed (was [0x083d0000, 0x083e0000) originally, then
@ [0x083d0000, 0x083dda2c) after sChannelRegTable+sWaveVolLut landed,
@ now [0x083d0000, 0x083dda1c) to make room for sChannelFreqRegTable.

        .section .text, "ax", %progbits
        .align  2
        .global text_083d0000
        .type   text_083d0000, %object
text_083d0000:
        .incbin "frog_us_baserom.gba", 0x003d0000, 0x0000da1c
        .size   text_083d0000, . - text_083d0000
