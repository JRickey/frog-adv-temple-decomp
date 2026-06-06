@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d504, 0x0802d524)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d504 --end 0x802d524 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d504: b500        push	{lr}
@   0x0802d506: f7ff        fcab 	bl	0x2ce60
@   0x0802d50a: f7ff        fe31 	bl	0x2d170
@   0x0802d50e: bc01        pop	{r0}
@   0x0802d510: 4700        bx	r0
@   0x0802d512: 0000        movs	r0, r0
@   0x0802d514: 4b33        ldr	r3, [pc, #204]	@ (0x2d5e4)
@   0x0802d516: 2201        movs	r2, #1
@   0x0802d518: 701a        strb	r2, [r3, #0]
@   0x0802d51a: 4933        ldr	r1, [pc, #204]	@ (0x2d5e8)
@   0x0802d51c: 468d        mov	sp, r1
@   0x0802d51e: df01        svc	1
@   0x0802d520: df00        svc	0
@   0x0802d522: 4770        bx	lr

        thumb_func_start sub_0802D504
sub_0802D504: @ 0x0802d504
        .incbin "frog_us_baserom.gba", 0x2d504, 0x20
        thumb_func_end sub_0802D504
