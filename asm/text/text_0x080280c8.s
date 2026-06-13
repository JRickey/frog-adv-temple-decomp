/* This file contains raw (untranslated) ROM bytes from the baserom.
 * The asm/disasm_* rules peel named functions out of the ROM and this
 * file covers the gaps. Shrink + re-run linker.ld when peeling adjacent
 * functions. */

        .include "asm/macros.inc"

        .section .text, "ax", %progbits
        .align 2

        .incbin "baserom.gba", 0x280c8, 0x2228
