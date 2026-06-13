@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029690, 0x080296b8)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029690 --end 0x80296b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029690: b500        push	{lr}
@   0x08029692: b083        sub	sp, #12
@   0x08029694: 4907        ldr	r1, [pc, #28]	@ (0x296b4)
@   0x08029696: 2071        movs	r0, #113	@ 0x71
@   0x08029698: 9000        str	r0, [sp, #0]
@   0x0802969a: 2004        movs	r0, #4
@   0x0802969c: 9001        str	r0, [sp, #4]
@   0x0802969e: 2000        movs	r0, #0
@   0x080296a0: 9002        str	r0, [sp, #8]
@   0x080296a2: 2028        movs	r0, #40	@ 0x28
@   0x080296a4: 2210        movs	r2, #16
@   0x080296a6: 2341        movs	r3, #65	@ 0x41
@   0x080296a8: f7f7        fd4a 	bl	0x21140
@   0x080296ac: b003        add	sp, #12
@   0x080296ae: bc01        pop	{r0}
@   0x080296b0: 4700        bx	r0
@   0x080296b2: 0000        movs	r0, r0
@   0x080296b4: 707c        strb	r4, [r7, #1]
@   0x080296b6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08029690
sub_08029690: @ 0x08029690
        .incbin "baserom.gba", 0x29690, 0x28
        thumb_func_end sub_08029690
