@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Continuation bucket after the credits-tilemap + save-dialog extraction.
@ Range:  [0x081c2684, 0x081d0000)
@
@ The tail of what used to be text_0x081c0000.s — bytes from 0x081c0000
@ up to 0x081c2684 are now extracted as typed C symbols (see
@ src/data/credits_tilemap.c).

        .section .text, "ax", %progbits
        .align  2
        .global text_081c2684
        .type   text_081c2684, %object
text_081c2684:
        .incbin "frog_us_baserom.gba", 0x001c2684, 0x0000d97c
        .size   text_081c2684, . - text_081c2684
