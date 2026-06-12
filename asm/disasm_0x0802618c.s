@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802618c, 0x080261f8)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802618c --end 0x80261f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802618c: b510        push	{r4, lr}
@   0x0802618e: 2400        movs	r4, #0
@   0x08026190: 00e0        lsls	r0, r4, #3
@   0x08026192: 1b00        subs	r0, r0, r4
@   0x08026194: 00c0        lsls	r0, r0, #3
@   0x08026196: 4916        ldr	r1, [pc, #88]	@ (0x261f0)
@   0x08026198: 1840        adds	r0, r0, r1
@   0x0802619a: 7e81        ldrb	r1, [r0, #26]
@   0x0802619c: 2902        cmp	r1, #2
@   0x0802619e: d001        beq.n	0x261a4
@   0x080261a0: 2904        cmp	r1, #4
@   0x080261a2: d104        bne.n	0x261ae
@   0x080261a4: 2104        movs	r1, #4
@   0x080261a6: 2201        movs	r2, #1
@   0x080261a8: 2301        movs	r3, #1
@   0x080261aa: f7fa        fe33 	bl	0x20e14
@   0x080261ae: 1c60        adds	r0, r4, #1
@   0x080261b0: 0600        lsls	r0, r0, #24
@   0x080261b2: 0e04        lsrs	r4, r0, #24
@   0x080261b4: 2c03        cmp	r4, #3
@   0x080261b6: d9eb        bls.n	0x26190
@   0x080261b8: 4c0e        ldr	r4, [pc, #56]	@ (0x261f4)
@   0x080261ba: 6820        ldr	r0, [r4, #0]
@   0x080261bc: 2144        movs	r1, #68	@ 0x44
@   0x080261be: f7fb        fbfd 	bl	0x219bc
@   0x080261c2: 6860        ldr	r0, [r4, #4]
@   0x080261c4: 2145        movs	r1, #69	@ 0x45
@   0x080261c6: f7fb        fbf9 	bl	0x219bc
@   0x080261ca: 68a0        ldr	r0, [r4, #8]
@   0x080261cc: 2146        movs	r1, #70	@ 0x46
@   0x080261ce: f7fb        fbf5 	bl	0x219bc
@   0x080261d2: 68e0        ldr	r0, [r4, #12]
@   0x080261d4: 2147        movs	r1, #71	@ 0x47
@   0x080261d6: f7fb        fbf1 	bl	0x219bc
@   0x080261da: 2044        movs	r0, #68	@ 0x44
@   0x080261dc: 2147        movs	r1, #71	@ 0x47
@   0x080261de: f7fa        ff01 	bl	0x20fe4
@   0x080261e2: 2044        movs	r0, #68	@ 0x44
@   0x080261e4: 2147        movs	r1, #71	@ 0x47
@   0x080261e6: f7df        fd93 	bl	0x5d10
@   0x080261ea: bc10        pop	{r4}
@   0x080261ec: bc01        pop	{r0}
@   0x080261ee: 4700        bx	r0
@   0x080261f0: 4600        mov	r0, r0
@   0x080261f2: 0300        lsls	r0, r0, #12
@   0x080261f4: 4a68        ldr	r2, [pc, #416]	@ (0x26398)
@   0x080261f6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802618C
sub_0802618C: @ 0x0802618c
        .incbin "baserom.gba", 0x2618c, 0x6c
        thumb_func_end sub_0802618C
