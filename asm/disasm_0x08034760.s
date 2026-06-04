@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034760, 0x080347a8)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034760 --end 0x80347a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034760: b510        push	{r4, lr}
@   0x08034762: b08a        sub	sp, #40	@ 0x28
@   0x08034764: 9008        str	r0, [sp, #32]
@   0x08034766: 9109        str	r1, [sp, #36]	@ 0x24
@   0x08034768: a808        add	r0, sp, #32
@   0x0803476a: 4669        mov	r1, sp
@   0x0803476c: f7ff        fcb2 	bl	0x340d4
@   0x08034770: a809        add	r0, sp, #36	@ 0x24
@   0x08034772: ac04        add	r4, sp, #16
@   0x08034774: 1c21        adds	r1, r4, #0
@   0x08034776: f7ff        fcad 	bl	0x340d4
@   0x0803477a: 2100        movs	r1, #0
@   0x0803477c: 9800        ldr	r0, [sp, #0]
@   0x0803477e: 2801        cmp	r0, #1
@   0x08034780: d800        bhi.n	0x34784
@   0x08034782: 2101        movs	r1, #1
@   0x08034784: 2900        cmp	r1, #0
@   0x08034786: d106        bne.n	0x34796
@   0x08034788: 2100        movs	r1, #0
@   0x0803478a: 9804        ldr	r0, [sp, #16]
@   0x0803478c: 2801        cmp	r0, #1
@   0x0803478e: d800        bhi.n	0x34792
@   0x08034790: 2101        movs	r1, #1
@   0x08034792: 2900        cmp	r1, #0
@   0x08034794: d002        beq.n	0x3479c
@   0x08034796: 2001        movs	r0, #1
@   0x08034798: 4240        negs	r0, r0
@   0x0803479a: e003        b.n	0x347a4
@   0x0803479c: 4668        mov	r0, sp
@   0x0803479e: 1c21        adds	r1, r4, #0
@   0x080347a0: f7ff        feec 	bl	0x3457c
@   0x080347a4: b00a        add	sp, #40	@ 0x28
@   0x080347a6: bd10        pop	{r4, pc}

        thumb_func_start sub_08034760
sub_08034760: @ 0x08034760
        .incbin "frog_us_baserom.gba", 0x34760, 0x48
        thumb_func_end sub_08034760
