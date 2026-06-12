@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080269e4, 0x08026a0c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80269e4 --end 0x8026a0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080269e4: b500        push	{lr}
@   0x080269e6: b083        sub	sp, #12
@   0x080269e8: 4907        ldr	r1, [pc, #28]	@ (0x26a08)
@   0x080269ea: 2051        movs	r0, #81	@ 0x51
@   0x080269ec: 9000        str	r0, [sp, #0]
@   0x080269ee: 2003        movs	r0, #3
@   0x080269f0: 9001        str	r0, [sp, #4]
@   0x080269f2: 2000        movs	r0, #0
@   0x080269f4: 9002        str	r0, [sp, #8]
@   0x080269f6: 2029        movs	r0, #41	@ 0x29
@   0x080269f8: 2210        movs	r2, #16
@   0x080269fa: 2304        movs	r3, #4
@   0x080269fc: f7fa        fba0 	bl	0x21140
@   0x08026a00: b003        add	sp, #12
@   0x08026a02: bc01        pop	{r0}
@   0x08026a04: 4700        bx	r0
@   0x08026a06: 0000        movs	r0, r0
@   0x08026a08: 50f0        str	r0, [r6, r3]
@   0x08026a0a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080269E4
sub_080269E4: @ 0x080269e4
        .incbin "baserom.gba", 0x269e4, 0x28
        thumb_func_end sub_080269E4
