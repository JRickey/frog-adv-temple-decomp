@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Tail bucket after asm/data/screen_1a3b6a.s cluster.
@ Range:  [0x081a636a, 0x081b0000)  (0x9c96 bytes)
@
@ Lowered to .balign 1 because the start address is halfword-aligned
@ but not word-aligned. See docs/codegen-notes.md "Non-u32-aligned
@ .rodata data anchors".
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .balign 1
        .global text_081a636a
        .type   text_081a636a, %object
text_081a636a:
        .incbin "frog_us_baserom.gba", 0x001a636a, 0x00009c96
        .size   text_081a636a, . - text_081a636a
