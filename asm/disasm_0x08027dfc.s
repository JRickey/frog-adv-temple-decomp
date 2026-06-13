@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027dfc, 0x08027e3c)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027dfc --end 0x8027e3c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027dfc: b530        push	{r4, r5, lr}
@   0x08027dfe: b083        sub	sp, #12
@   0x08027e00: 490c        ldr	r1, [pc, #48]	@ (0x27e34)
@   0x08027e02: 2071        movs	r0, #113	@ 0x71
@   0x08027e04: 9000        str	r0, [sp, #0]
@   0x08027e06: 2504        movs	r5, #4
@   0x08027e08: 9501        str	r5, [sp, #4]
@   0x08027e0a: 2400        movs	r4, #0
@   0x08027e0c: 9402        str	r4, [sp, #8]
@   0x08027e0e: 2020        movs	r0, #32
@   0x08027e10: 2210        movs	r2, #16
@   0x08027e12: 2311        movs	r3, #17
@   0x08027e14: f7f9        f994 	bl	0x21140
@   0x08027e18: 4907        ldr	r1, [pc, #28]	@ (0x27e38)
@   0x08027e1a: 2079        movs	r0, #121	@ 0x79
@   0x08027e1c: 9000        str	r0, [sp, #0]
@   0x08027e1e: 9501        str	r5, [sp, #4]
@   0x08027e20: 9402        str	r4, [sp, #8]
@   0x08027e22: 2023        movs	r0, #35	@ 0x23
@   0x08027e24: 2210        movs	r2, #16
@   0x08027e26: 2311        movs	r3, #17
@   0x08027e28: f7f9        f98a 	bl	0x21140
@   0x08027e2c: b003        add	sp, #12
@   0x08027e2e: bc30        pop	{r4, r5}
@   0x08027e30: bc01        pop	{r0}
@   0x08027e32: 4700        bx	r0
@   0x08027e34: 68a8        ldr	r0, [r5, #8]
@   0x08027e36: 0831        lsrs	r1, r6, #32
@   0x08027e38: 68c8        ldr	r0, [r1, #12]
@   0x08027e3a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027DFC
sub_08027DFC: @ 0x08027dfc
        .incbin "baserom.gba", 0x27dfc, 0x40
        thumb_func_end sub_08027DFC
