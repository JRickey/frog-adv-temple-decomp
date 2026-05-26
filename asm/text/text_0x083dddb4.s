@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x083dddb4, 0x083e0000)  (0x224c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.
@
@ Carved out of the original 0x083d0000 bucket when sSoundOpcodeHandlers
@ was extracted into src/data/sound_opcode_handlers.c. The entire range
@ from 0x083dddb4 to end-of-ROM (0x08400000) is 0xff padding in the
@ baserom, but we keep it as raw bytes for now — the .o output (and
@ subsequent --pad-to in the Makefile) lays it down identically.

        .section .text, "ax", %progbits
        .align  2
        .global text_083dddb4
        .type   text_083dddb4, %object
text_083dddb4:
        .incbin "frog_us_baserom.gba", 0x003dddb4, 0x0000224c
        .size   text_083dddb4, . - text_083dddb4
