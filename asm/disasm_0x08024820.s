@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024820, 0x08024844)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024820 --end 0x8024844 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024820: b500        push	{lr}
@   0x08024822: b081        sub	sp, #4
@   0x08024824: 4905        ldr	r1, [pc, #20]	@ (0x2483c)
@   0x08024826: 4b06        ldr	r3, [pc, #24]	@ (0x24840)
@   0x08024828: 2000        movs	r0, #0
@   0x0802482a: 9000        str	r0, [sp, #0]
@   0x0802482c: 2020        movs	r0, #32
@   0x0802482e: 2204        movs	r2, #4
@   0x08024830: f7fc        fe6e 	bl	0x21510
@   0x08024834: b001        add	sp, #4
@   0x08024836: bc01        pop	{r0}
@   0x08024838: 4700        bx	r0
@   0x0802483a: 0000        movs	r0, r0
@   0x0802483c: 2fe4        cmp	r7, #228	@ 0xe4
@   0x0802483e: 0831        lsrs	r1, r6, #32
@   0x08024840: 6110        str	r0, [r2, #16]
@   0x08024842: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024820
sub_08024820: @ 0x08024820
        .incbin "baserom.gba", 0x24820, 0x24
        thumb_func_end sub_08024820
