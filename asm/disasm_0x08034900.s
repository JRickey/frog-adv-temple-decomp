@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034900, 0x08034924)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034900 --end 0x8034924 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034900: b500        push	{lr}
@   0x08034902: b085        sub	sp, #20
@   0x08034904: 9004        str	r0, [sp, #16]
@   0x08034906: a804        add	r0, sp, #16
@   0x08034908: 4669        mov	r1, sp
@   0x0803490a: f7ff        fbe3 	bl	0x340d4
@   0x0803490e: 2100        movs	r1, #0
@   0x08034910: 9801        ldr	r0, [sp, #4]
@   0x08034912: 2800        cmp	r0, #0
@   0x08034914: d100        bne.n	0x34918
@   0x08034916: 2101        movs	r1, #1
@   0x08034918: 9101        str	r1, [sp, #4]
@   0x0803491a: 4668        mov	r0, sp
@   0x0803491c: f7ff        fb7e 	bl	0x3401c
@   0x08034920: b005        add	sp, #20
@   0x08034922: bd00        pop	{pc}

        thumb_func_start sub_08034900
sub_08034900: @ 0x08034900
        .incbin "frog_us_baserom.gba", 0x34900, 0x24
        thumb_func_end sub_08034900
