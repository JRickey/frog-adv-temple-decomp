@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080004c4, 0x08010000)  (0xfb3c bytes)
@
@ Bucket nominally begins at the 0x080000c0 boundary; trimmed to 0x080004c4
@ after the ARM crt0 region (0xC0-0x2A4) and AgbMain (0x2A4-0x4C4) were
@ peeled into asm/disasm_*.s slices.
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global text_080004c4
        .type   text_080004c4, %object
text_080004c4:
        .incbin "frog_us_baserom.gba", 0x000004c4, 0x0000fb3c
        .size   text_080004c4, . - text_080004c4
