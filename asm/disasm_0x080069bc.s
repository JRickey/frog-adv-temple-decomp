@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080069bc, 0x08006a0c)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80069bc --end 0x8006a0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080069bc: b510        push	{r4, lr}
@   0x080069be: 1c0a        adds	r2, r1, #0
@   0x080069c0: 2a3f        cmp	r2, #63	@ 0x3f
@   0x080069c2: dc0f        bgt.n	0x69e4
@   0x080069c4: 2001        movs	r0, #1
@   0x080069c6: 2100        movs	r1, #0
@   0x080069c8: f02d        f96c 	bl	0x33ca4
@   0x080069cc: 43c3        mvns	r3, r0
@   0x080069ce: 43cc        mvns	r4, r1
@   0x080069d0: 4a03        ldr	r2, [pc, #12]	@ (0x69e0)
@   0x080069d2: 6950        ldr	r0, [r2, #20]
@   0x080069d4: 6991        ldr	r1, [r2, #24]
@   0x080069d6: 4018        ands	r0, r3
@   0x080069d8: 4021        ands	r1, r4
@   0x080069da: 6150        str	r0, [r2, #20]
@   0x080069dc: 6191        str	r1, [r2, #24]
@   0x080069de: e00f        b.n	0x6a00
@   0x080069e0: 6110        str	r0, [r2, #16]
@   0x080069e2: 0300        lsls	r0, r0, #12
@   0x080069e4: 3a40        subs	r2, #64	@ 0x40
@   0x080069e6: 2001        movs	r0, #1
@   0x080069e8: 2100        movs	r1, #0
@   0x080069ea: f02d        f95b 	bl	0x33ca4
@   0x080069ee: 43c3        mvns	r3, r0
@   0x080069f0: 43cc        mvns	r4, r1
@   0x080069f2: 4a05        ldr	r2, [pc, #20]	@ (0x6a08)
@   0x080069f4: 69d0        ldr	r0, [r2, #28]
@   0x080069f6: 6a11        ldr	r1, [r2, #32]
@   0x080069f8: 4018        ands	r0, r3
@   0x080069fa: 4021        ands	r1, r4
@   0x080069fc: 61d0        str	r0, [r2, #28]
@   0x080069fe: 6211        str	r1, [r2, #32]
@   0x08006a00: bc10        pop	{r4}
@   0x08006a02: bc01        pop	{r0}
@   0x08006a04: 4700        bx	r0
@   0x08006a06: 0000        movs	r0, r0
@   0x08006a08: 6110        str	r0, [r2, #16]
@   0x08006a0a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080069BC
sub_080069BC: @ 0x080069bc
        .incbin "frog_us_baserom.gba", 0x69bc, 0x50
        thumb_func_end sub_080069BC
