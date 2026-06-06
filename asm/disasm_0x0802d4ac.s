@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d4ac, 0x0802d4f8)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d4ac --end 0x802d4f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d4ac: b510        push	{r4, lr}
@   0x0802d4ae: 1c04        adds	r4, r0, #0
@   0x0802d4b0: 2000        movs	r0, #0
@   0x0802d4b2: 76a0        strb	r0, [r4, #26]
@   0x0802d4b4: 1c20        adds	r0, r4, #0
@   0x0802d4b6: 2100        movs	r1, #0
@   0x0802d4b8: 2200        movs	r2, #0
@   0x0802d4ba: 2300        movs	r3, #0
@   0x0802d4bc: f7dd        f860 	bl	0xa580
@   0x0802d4c0: 2002        movs	r0, #2
@   0x0802d4c2: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802d4c4: 4308        orrs	r0, r1
@   0x0802d4c6: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802d4c8: 4c07        ldr	r4, [pc, #28]	@ (0x2d4e8)
@   0x0802d4ca: 6920        ldr	r0, [r4, #16]
@   0x0802d4cc: 3801        subs	r0, #1
@   0x0802d4ce: 6120        str	r0, [r4, #16]
@   0x0802d4d0: 1c20        adds	r0, r4, #0
@   0x0802d4d2: 2108        movs	r1, #8
@   0x0802d4d4: 2203        movs	r2, #3
@   0x0802d4d6: f7d9        f893 	bl	0x6600
@   0x0802d4da: 6920        ldr	r0, [r4, #16]
@   0x0802d4dc: 2800        cmp	r0, #0
@   0x0802d4de: d105        bne.n	0x2d4ec
@   0x0802d4e0: 2069        movs	r0, #105	@ 0x69
@   0x0802d4e2: f7f3        fbc9 	bl	0x20c78
@   0x0802d4e6: e004        b.n	0x2d4f2
@   0x0802d4e8: 6110        str	r0, [r2, #16]
@   0x0802d4ea: 0300        lsls	r0, r0, #12
@   0x0802d4ec: 207a        movs	r0, #122	@ 0x7a
@   0x0802d4ee: f7f3        fbc3 	bl	0x20c78
@   0x0802d4f2: bc10        pop	{r4}
@   0x0802d4f4: bc01        pop	{r0}
@   0x0802d4f6: 4700        bx	r0

        thumb_func_start sub_0802D4AC
sub_0802D4AC: @ 0x0802d4ac
        .incbin "frog_us_baserom.gba", 0x2d4ac, 0x4c
        thumb_func_end sub_0802D4AC
