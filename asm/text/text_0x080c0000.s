@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080c0000, 0x080c0ab0)  (shrunk from 0x10000 — entity-dispatch
@         cluster [0x080c0ab0, 0x080c1254) extracted into
@         src/data/entity_dispatch.c, tail [0x080c1254, 0x080d0000)
@         continues in asm/text/text_0x080c1254.s)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_080c0000
        .type   text_080c0000, %object
text_080c0000:
        .incbin "frog_us_baserom.gba", 0x000c0000, 0x00000ab0
        .size   text_080c0000, . - text_080c0000
