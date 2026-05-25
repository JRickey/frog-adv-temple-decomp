@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080002a4, 0x08010000)  (0xfd5c bytes)
@
@ Bucket nominally begins at the 0x080000c0 boundary; trimmed to 0x080002a4
@ after the ARM crt0 region (0xC0-0x2A4) was peeled into individual
@ asm/disasm_0x080000{c0,fc,114,12c,240}.s slices. Thumb code begins at
@ 0x080002a4 (the first thumb function pointed to by IntrMain's dispatch).
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_080002a4
        .type   text_080002a4, %object
text_080002a4:
        .incbin "frog_us_baserom.gba", 0x000002a4, 0x0000fd5c
        .size   text_080002a4, . - text_080002a4
