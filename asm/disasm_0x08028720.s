@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028720, 0x0802877c)  (92 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028720 --end 0x802877c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028720: b570        push	{r4, r5, r6, lr}
@   0x08028722: 2500        movs	r5, #0
@   0x08028724: 4e13        ldr	r6, [pc, #76]	@ (0x28774)
@   0x08028726: 1c29        adds	r1, r5, #0
@   0x08028728: 3128        adds	r1, #40	@ 0x28
@   0x0802872a: 00c8        lsls	r0, r1, #3
@   0x0802872c: 1a40        subs	r0, r0, r1
@   0x0802872e: 00c0        lsls	r0, r0, #3
@   0x08028730: 1984        adds	r4, r0, r6
@   0x08028732: 2003        movs	r0, #3
@   0x08028734: 71a0        strb	r0, [r4, #6]
@   0x08028736: 4a10        ldr	r2, [pc, #64]	@ (0x28778)
@   0x08028738: 00a8        lsls	r0, r5, #2
@   0x0802873a: 1880        adds	r0, r0, r2
@   0x0802873c: 6800        ldr	r0, [r0, #0]
@   0x0802873e: f7f9        f93d 	bl	0x219bc
@   0x08028742: 88a0        ldrh	r0, [r4, #4]
@   0x08028744: 3865        subs	r0, #101	@ 0x65
@   0x08028746: 0400        lsls	r0, r0, #16
@   0x08028748: 0c00        lsrs	r0, r0, #16
@   0x0802874a: 28de        cmp	r0, #222	@ 0xde
@   0x0802874c: d901        bls.n	0x28752
@   0x0802874e: 2002        movs	r0, #2
@   0x08028750: 71a0        strb	r0, [r4, #6]
@   0x08028752: 1c68        adds	r0, r5, #1
@   0x08028754: 0600        lsls	r0, r0, #24
@   0x08028756: 0e05        lsrs	r5, r0, #24
@   0x08028758: 2d0f        cmp	r5, #15
@   0x0802875a: d9e4        bls.n	0x28726
@   0x0802875c: 2028        movs	r0, #40	@ 0x28
@   0x0802875e: 2137        movs	r1, #55	@ 0x37
@   0x08028760: f7f8        fc40 	bl	0x20fe4
@   0x08028764: 2028        movs	r0, #40	@ 0x28
@   0x08028766: 2137        movs	r1, #55	@ 0x37
@   0x08028768: f7dd        fad2 	bl	0x5d10
@   0x0802876c: bc70        pop	{r4, r5, r6}
@   0x0802876e: bc01        pop	{r0}
@   0x08028770: 4700        bx	r0
@   0x08028772: 0000        movs	r0, r0
@   0x08028774: 3720        adds	r7, #32
@   0x08028776: 0300        lsls	r0, r0, #12
@   0x08028778: 7ab8        ldrb	r0, [r7, #10]
@   0x0802877a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08028720
sub_08028720: @ 0x08028720
        .incbin "baserom.gba", 0x28720, 0x5c
        thumb_func_end sub_08028720
