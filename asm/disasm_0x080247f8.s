@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080247f8, 0x08024820)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80247f8 --end 0x8024820 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080247f8: b500        push	{lr}
@   0x080247fa: b083        sub	sp, #12
@   0x080247fc: 4907        ldr	r1, [pc, #28]	@ (0x2481c)
@   0x080247fe: 2061        movs	r0, #97	@ 0x61
@   0x08024800: 9000        str	r0, [sp, #0]
@   0x08024802: 2002        movs	r0, #2
@   0x08024804: 9001        str	r0, [sp, #4]
@   0x08024806: 2000        movs	r0, #0
@   0x08024808: 9002        str	r0, [sp, #8]
@   0x0802480a: 2020        movs	r0, #32
@   0x0802480c: 2210        movs	r2, #16
@   0x0802480e: 2304        movs	r3, #4
@   0x08024810: f7fc        fc96 	bl	0x21140
@   0x08024814: b003        add	sp, #12
@   0x08024816: bc01        pop	{r0}
@   0x08024818: 4700        bx	r0
@   0x0802481a: 0000        movs	r0, r0
@   0x0802481c: 2fe4        cmp	r7, #228	@ 0xe4
@   0x0802481e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080247F8
sub_080247F8: @ 0x080247f8
        .incbin "baserom.gba", 0x247f8, 0x28
        thumb_func_end sub_080247F8
