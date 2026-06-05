@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024304, 0x08024328)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024304 --end 0x8024328 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024304: b500        push	{lr}
@   0x08024306: b081        sub	sp, #4
@   0x08024308: 4905        ldr	r1, [pc, #20]	@ (0x24320)
@   0x0802430a: 4b06        ldr	r3, [pc, #24]	@ (0x24324)
@   0x0802430c: 2000        movs	r0, #0
@   0x0802430e: 9000        str	r0, [sp, #0]
@   0x08024310: 2065        movs	r0, #101	@ 0x65
@   0x08024312: 220b        movs	r2, #11
@   0x08024314: f7fd        f8fc 	bl	0x21510
@   0x08024318: b001        add	sp, #4
@   0x0802431a: bc01        pop	{r0}
@   0x0802431c: 4700        bx	r0
@   0x0802431e: 0000        movs	r0, r0
@   0x08024320: 2270        movs	r2, #112	@ 0x70
@   0x08024322: 0831        lsrs	r1, r6, #32
@   0x08024324: 6110        str	r0, [r2, #16]
@   0x08024326: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024304
sub_08024304: @ 0x08024304
        .incbin "frog_us_baserom.gba", 0x24304, 0x24
        thumb_func_end sub_08024304
