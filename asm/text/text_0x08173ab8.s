@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08173ab8, 0x08180000)  (0xc548 bytes — tail after
@         icon-anim cluster, see src/data/icon_anim_frames.c)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_08173ab8
        .type   text_08173ab8, %object
text_08173ab8:
        .incbin "frog_us_baserom.gba", 0x00173ab8, 0x0000c548
        .size   text_08173ab8, . - text_08173ab8
