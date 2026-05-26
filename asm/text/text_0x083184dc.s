@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083184dc, 0x08320000)  (0x7b24 bytes)
@
@ Post-cluster tail of the original [0x08318020, 0x08320000) blob,
@ following src/data/level_layout_dispatch_3181bc.o(.rodata) at
@ 0x083181bc..0x083184dc.
@
@ Variable-length payload referenced by sLevelLayoutOffsets_3181E0
@ (first 191 records, occupying [0x083184dc..0x08318598) by walker
@ analysis) plus six more section-pointer sub-regions referenced by
@ sLevelLayoutSectionTable_3181C4 entries (0x000023d8 / 0x000027f4 /
@ 0x000177c0). Deferred to next data pass -- needs the consumer family
@ at 0x08020388 in C before record shape can be inferred.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_083184dc
        .type   text_083184dc, %object
text_083184dc:
        .incbin "frog_us_baserom.gba", 0x003184dc, 0x00007b24
        .size   text_083184dc, . - text_083184dc
