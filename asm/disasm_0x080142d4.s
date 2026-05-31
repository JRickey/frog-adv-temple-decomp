@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080142d4, 0x0801436c)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80142d4 --end 0x801436c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080142d4: b530        push	{r4, r5, lr}
@   0x080142d6: b082        sub	sp, #8
@   0x080142d8: 481a        ldr	r0, [pc, #104]	@ (0x14344)
@   0x080142da: 8ec0        ldrh	r0, [r0, #54]	@ 0x36
@   0x080142dc: 28c0        cmp	r0, #192	@ 0xc0
@   0x080142de: d008        beq.n	0x142f2
@   0x080142e0: 4819        ldr	r0, [pc, #100]	@ (0x14348)
@   0x080142e2: 6900        ldr	r0, [r0, #16]
@   0x080142e4: 2101        movs	r1, #1
@   0x080142e6: 4008        ands	r0, r1
@   0x080142e8: 2800        cmp	r0, #0
@   0x080142ea: d002        beq.n	0x142f2
@   0x080142ec: 2002        movs	r0, #2
@   0x080142ee: f7fa        fdd1 	bl	0xee94
@   0x080142f2: 4b16        ldr	r3, [pc, #88]	@ (0x1434c)
@   0x080142f4: 7898        ldrb	r0, [r3, #2]
@   0x080142f6: 9000        str	r0, [sp, #0]
@   0x080142f8: 4815        ldr	r0, [pc, #84]	@ (0x14350)
@   0x080142fa: 9001        str	r0, [sp, #4]
@   0x080142fc: 6818        ldr	r0, [r3, #0]
@   0x080142fe: 6859        ldr	r1, [r3, #4]
@   0x08014300: 689a        ldr	r2, [r3, #8]
@   0x08014302: 68db        ldr	r3, [r3, #12]
@   0x08014304: f7ff        fcac 	bl	0x13c60
@   0x08014308: 2000        movs	r0, #0
@   0x0801430a: 2100        movs	r1, #0
@   0x0801430c: 2200        movs	r2, #0
@   0x0801430e: 2301        movs	r3, #1
@   0x08014310: f7ff        f952 	bl	0x135b8
@   0x08014314: 4a0f        ldr	r2, [pc, #60]	@ (0x14354)
@   0x08014316: 4c10        ldr	r4, [pc, #64]	@ (0x14358)
@   0x08014318: 2034        movs	r0, #52	@ 0x34
@   0x0801431a: 5e21        ldrsh	r1, [r4, r0]
@   0x0801431c: 6cd0        ldr	r0, [r2, #76]	@ 0x4c
@   0x0801431e: 1840        adds	r0, r0, r1
@   0x08014320: 64d0        str	r0, [r2, #76]	@ 0x4c
@   0x08014322: 6910        ldr	r0, [r2, #16]
@   0x08014324: 4b07        ldr	r3, [pc, #28]	@ (0x14344)
@   0x08014326: 2536        movs	r5, #54	@ 0x36
@   0x08014328: 5f59        ldrsh	r1, [r3, r5]
@   0x0801432a: 1840        adds	r0, r0, r1
@   0x0801432c: 6510        str	r0, [r2, #80]	@ 0x50
@   0x0801432e: 8ed9        ldrh	r1, [r3, #54]	@ 0x36
@   0x08014330: 229c        movs	r2, #156	@ 0x9c
@   0x08014332: 0052        lsls	r2, r2, #1
@   0x08014334: 1c10        adds	r0, r2, #0
@   0x08014336: 1a40        subs	r0, r0, r1
@   0x08014338: 86e0        strh	r0, [r4, #54]	@ 0x36
@   0x0801433a: 0409        lsls	r1, r1, #16
@   0x0801433c: 2900        cmp	r1, #0
@   0x0801433e: d00d        beq.n	0x1435c
@   0x08014340: 2000        movs	r0, #0
@   0x08014342: e00f        b.n	0x14364
@   0x08014344: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08014346: 0300        lsls	r0, r0, #12
@   0x08014348: 6110        str	r0, [r2, #16]
@   0x0801434a: 0300        lsls	r0, r0, #12
@   0x0801434c: 775c        strb	r4, [r3, #29]
@   0x0801434e: 0830        lsrs	r0, r6, #32
@   0x08014350: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08014352: 0300        lsls	r0, r0, #12
@   0x08014354: 60a0        str	r0, [r4, #8]
@   0x08014356: 0300        lsls	r0, r0, #12
@   0x08014358: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0801435a: 0300        lsls	r0, r0, #12
@   0x0801435c: 2002        movs	r0, #2
@   0x0801435e: f7fa        fd69 	bl	0xee34
@   0x08014362: 2001        movs	r0, #1
@   0x08014364: b002        add	sp, #8
@   0x08014366: bc30        pop	{r4, r5}
@   0x08014368: bc02        pop	{r1}
@   0x0801436a: 4708        bx	r1

        thumb_func_start sub_080142D4
sub_080142D4: @ 0x080142d4
        .incbin "frog_us_baserom.gba", 0x142d4, 0x98
        thumb_func_end sub_080142D4
