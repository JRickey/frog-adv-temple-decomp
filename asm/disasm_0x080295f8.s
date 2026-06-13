@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080295f8, 0x08029620)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80295f8 --end 0x8029620 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080295f8: b500        push	{lr}
@   0x080295fa: b083        sub	sp, #12
@   0x080295fc: 4907        ldr	r1, [pc, #28]	@ (0x2961c)
@   0x080295fe: 2051        movs	r0, #81	@ 0x51
@   0x08029600: 9000        str	r0, [sp, #0]
@   0x08029602: 2002        movs	r0, #2
@   0x08029604: 9001        str	r0, [sp, #4]
@   0x08029606: 2000        movs	r0, #0
@   0x08029608: 9002        str	r0, [sp, #8]
@   0x0802960a: 2019        movs	r0, #25
@   0x0802960c: 2210        movs	r2, #16
@   0x0802960e: 2304        movs	r3, #4
@   0x08029610: f7f7        fd96 	bl	0x21140
@   0x08029614: b003        add	sp, #12
@   0x08029616: bc01        pop	{r0}
@   0x08029618: 4700        bx	r0
@   0x0802961a: 0000        movs	r0, r0
@   0x0802961c: 7024        strb	r4, [r4, #0]
@   0x0802961e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080295F8
sub_080295F8: @ 0x080295f8
        .incbin "baserom.gba", 0x295f8, 0x28
        thumb_func_end sub_080295F8
