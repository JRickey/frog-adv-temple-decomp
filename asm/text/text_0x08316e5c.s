@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08316e5c, 0x08316f24)  (0xc8 bytes)
@
@ Tail section of the original [0x08310000, 0x08320000) blob, sliced
@ between src/data/level_layout_dispatch_316dc8.c (preceding) and
@ src/data/level_layout.c (following).
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08316e5c
        .type   text_08316e5c, %object
text_08316e5c:
        .incbin "frog_us_baserom.gba", 0x00316e5c, 0x000000c8
        .size   text_08316e5c, . - text_08316e5c
