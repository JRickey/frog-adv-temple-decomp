@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027310, 0x08027338)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027310 --end 0x8027338 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027310: b500        push	{lr}
@   0x08027312: b083        sub	sp, #12
@   0x08027314: 4907        ldr	r1, [pc, #28]	@ (0x27334)
@   0x08027316: 2041        movs	r0, #65	@ 0x41
@   0x08027318: 9000        str	r0, [sp, #0]
@   0x0802731a: 2001        movs	r0, #1
@   0x0802731c: 9001        str	r0, [sp, #4]
@   0x0802731e: 2000        movs	r0, #0
@   0x08027320: 9002        str	r0, [sp, #8]
@   0x08027322: 2002        movs	r0, #2
@   0x08027324: 2210        movs	r2, #16
@   0x08027326: 2302        movs	r3, #2
@   0x08027328: f7f9        ff0a 	bl	0x21140
@   0x0802732c: b003        add	sp, #12
@   0x0802732e: bc01        pop	{r0}
@   0x08027330: 4700        bx	r0
@   0x08027332: 0000        movs	r0, r0
@   0x08027334: 5c10        ldrb	r0, [r2, r0]
@   0x08027336: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027310
sub_08027310: @ 0x08027310
        .incbin "baserom.gba", 0x27310, 0x28
        thumb_func_end sub_08027310
