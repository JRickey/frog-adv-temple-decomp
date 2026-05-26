@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Tail bucket after src/data/bg_tilemap_19c312.c cluster.
@ Range:  [0x0819dcaa, 0x081a0000)  (0x2356 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .balign 1
        .global text_0819dcaa
        .type   text_0819dcaa, %object
text_0819dcaa:
        .incbin "frog_us_baserom.gba", 0x0019dcaa, 0x00002356
        .size   text_0819dcaa, . - text_0819dcaa
