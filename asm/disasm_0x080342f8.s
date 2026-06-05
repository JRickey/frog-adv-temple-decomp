@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080342f8, 0x0803432c)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80342f8 --end 0x803432c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080342f8: b510        push	{r4, lr}
@   0x080342fa: b08e        sub	sp, #56	@ 0x38
@   0x080342fc: 900c        str	r0, [sp, #48]	@ 0x30
@   0x080342fe: 910d        str	r1, [sp, #52]	@ 0x34
@   0x08034300: a80c        add	r0, sp, #48	@ 0x30
@   0x08034302: 4669        mov	r1, sp
@   0x08034304: f7ff        fee6 	bl	0x340d4
@   0x08034308: a80d        add	r0, sp, #52	@ 0x34
@   0x0803430a: ac04        add	r4, sp, #16
@   0x0803430c: 1c21        adds	r1, r4, #0
@   0x0803430e: f7ff        fee1 	bl	0x340d4
@   0x08034312: 6860        ldr	r0, [r4, #4]
@   0x08034314: 2101        movs	r1, #1
@   0x08034316: 4048        eors	r0, r1
@   0x08034318: 6060        str	r0, [r4, #4]
@   0x0803431a: aa08        add	r2, sp, #32
@   0x0803431c: 4668        mov	r0, sp
@   0x0803431e: 1c21        adds	r1, r4, #0
@   0x08034320: f7ff        ff16 	bl	0x34150
@   0x08034324: f7ff        fe7a 	bl	0x3401c
@   0x08034328: b00e        add	sp, #56	@ 0x38
@   0x0803432a: bd10        pop	{r4, pc}

        thumb_func_start sub_080342F8
sub_080342F8: @ 0x080342f8
        .incbin "frog_us_baserom.gba", 0x342f8, 0x34
        thumb_func_end sub_080342F8
