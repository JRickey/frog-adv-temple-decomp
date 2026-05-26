@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082f9d08, 0x08300000)  (0x62f8 bytes)
@
@ Trailing portion of the original [0x082f0000, 0x08300000) blob,
@ after the sModeConfigTables_2F99E8 + sModeLookupTable_2F9CF4 cluster
@ at [0x082f99e8, 0x082f9d08) was extracted into
@ src/data/mode_config_2f99e8.c.
@
@ Contains additional (u16, u16) lookup-like data starting at 0x082f9d08
@ then more dense tables through 0x082fcxxx, then 0xff padding to
@ 0x08300000. No current pool-load refs into this range; characterized
@ but not yet extracted.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_082f9d08
        .type   text_082f9d08, %object
text_082f9d08:
        .incbin "frog_us_baserom.gba", 0x002f9d08, 0x000062f8
        .size   text_082f9d08, . - text_082f9d08
