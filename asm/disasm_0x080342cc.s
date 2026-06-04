@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080342cc, 0x080342f8)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80342cc --end 0x80342f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080342cc: b510        push	{r4, lr}
@   0x080342ce: b08e        sub	sp, #56	@ 0x38
@   0x080342d0: 900c        str	r0, [sp, #48]	@ 0x30
@   0x080342d2: 910d        str	r1, [sp, #52]	@ 0x34
@   0x080342d4: a80c        add	r0, sp, #48	@ 0x30
@   0x080342d6: 4669        mov	r1, sp
@   0x080342d8: f7ff        fefc 	bl	0x340d4
@   0x080342dc: a80d        add	r0, sp, #52	@ 0x34
@   0x080342de: ac04        add	r4, sp, #16
@   0x080342e0: 1c21        adds	r1, r4, #0
@   0x080342e2: f7ff        fef7 	bl	0x340d4
@   0x080342e6: aa08        add	r2, sp, #32
@   0x080342e8: 4668        mov	r0, sp
@   0x080342ea: 1c21        adds	r1, r4, #0
@   0x080342ec: f7ff        ff30 	bl	0x34150
@   0x080342f0: f7ff        fe94 	bl	0x3401c
@   0x080342f4: b00e        add	sp, #56	@ 0x38
@   0x080342f6: bd10        pop	{r4, pc}

        thumb_func_start sub_080342CC
sub_080342CC: @ 0x080342cc
        .incbin "frog_us_baserom.gba", 0x342cc, 0x2c
        thumb_func_end sub_080342CC
