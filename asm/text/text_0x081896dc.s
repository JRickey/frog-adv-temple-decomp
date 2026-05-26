@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Tail bucket after src/data/screen_188edc.c cluster.
@ Range:  [0x081896dc, 0x08190000)  (0x6924 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_081896dc
        .type   text_081896dc, %object
text_081896dc:
        .incbin "frog_us_baserom.gba", 0x001896dc, 0x00006924
        .size   text_081896dc, . - text_081896dc
