@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082f9994, 0x08300000)  (0x666c bytes)
@
@ Trailing portion of the original [0x082f0000, 0x08300000) blob,
@ after sUnkDispatchData_82F9920 / sUnkPtrPair_82F998C were extracted
@ at [0x082f9920, 0x082f9994) into src/data/unk_dispatch_2f9920.c.
@
@ Contains another stride-12 data block at 0x082f9994..0x082f99e8
@ with a 1-entry pointer record at 0x082f99e8, plus continuing data
@ tables through 0x082fcxxx then 0xff padding to 0x08300000. No
@ current pool-load refs into this range; characterized but not yet
@ extracted.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_082f9994
        .type   text_082f9994, %object
text_082f9994:
        .incbin "frog_us_baserom.gba", 0x002f9994, 0x0000666c
        .size   text_082f9994, . - text_082f9994
