@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08204758, 0x0820c578)  (0x7e20 bytes; gap between screen_bd58 and screen_c578 clusters)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08204758
        .type   text_08204758, %object
text_08204758:
        .incbin "frog_us_baserom.gba", 0x00204758, 0x00007e20
        .size   text_08204758, . - text_08204758
