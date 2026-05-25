@ ============================================================================
@ Remainder of the baserom (0x080000C0 onward).
@ ============================================================================
@
@ Everything from the end of the GBA header to ROM end is included here as
@ an opaque blob until disassembly peels it apart into asm/disasm_*.s
@ slices (one thumb_func_start per function, per the pick_target.py
@ contract).
@
@ As chunks get peeled off, the INCBIN's skip/count gets advanced so this
@ file shrinks. Once everything is disassembled, this file disappears.

        .section .text, "ax", %progbits
        .arm
        .align  2
        .global rom_remainder
        .type   rom_remainder, %function
rom_remainder:
        .incbin "frog_us_baserom.gba", 0x003c0000
        .size   rom_remainder, . - rom_remainder
