@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Tail bucket after src/data/screen_d8b98.c cluster.
@ Range:  [0x081e4c18, 0x081f0000)  (0xb3e8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_081e4c18
        .type   text_081e4c18, %object
text_081e4c18:
        .incbin "frog_us_baserom.gba", 0x001e4c18, 0x0000b3e8
        .size   text_081e4c18, . - text_081e4c18
