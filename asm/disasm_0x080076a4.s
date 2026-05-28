@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080076a4, 0x080077ac)  (264 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80076a4 --end 0x80077ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080076a4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080076a6: b081        sub	sp, #4
@   0x080076a8: 4684        mov	ip, r0
@   0x080076aa: 1c0b        adds	r3, r1, #0
@   0x080076ac: 2800        cmp	r0, #0
@   0x080076ae: d001        beq.n	0x76b4
@   0x080076b0: 2b00        cmp	r3, #0
@   0x080076b2: d101        bne.n	0x76b8
@   0x080076b4: 2000        movs	r0, #0
@   0x080076b6: e024        b.n	0x7702
@   0x080076b8: 88d8        ldrh	r0, [r3, #6]
@   0x080076ba: 0405        lsls	r5, r0, #16
@   0x080076bc: 0c68        lsrs	r0, r5, #17
@   0x080076be: 8859        ldrh	r1, [r3, #2]
@   0x080076c0: 1a08        subs	r0, r1, r0
@   0x080076c2: 0400        lsls	r0, r0, #16
@   0x080076c4: 0c00        lsrs	r0, r0, #16
@   0x080076c6: 4a11        ldr	r2, [pc, #68]	@ (0x770c)
@   0x080076c8: 1c11        adds	r1, r2, #0
@   0x080076ca: 4031        ands	r1, r6
@   0x080076cc: 4301        orrs	r1, r0
@   0x080076ce: 889c        ldrh	r4, [r3, #4]
@   0x080076d0: 0420        lsls	r0, r4, #16
@   0x080076d2: 0c04        lsrs	r4, r0, #16
@   0x080076d4: 0c40        lsrs	r0, r0, #17
@   0x080076d6: 881b        ldrh	r3, [r3, #0]
@   0x080076d8: 1a18        subs	r0, r3, r0
@   0x080076da: 3801        subs	r0, #1
@   0x080076dc: 0400        lsls	r0, r0, #16
@   0x080076de: 4b0c        ldr	r3, [pc, #48]	@ (0x7710)
@   0x080076e0: 4019        ands	r1, r3
@   0x080076e2: 1c0e        adds	r6, r1, #0
@   0x080076e4: 4306        orrs	r6, r0
@   0x080076e6: 403a        ands	r2, r7
@   0x080076e8: 4322        orrs	r2, r4
@   0x080076ea: 1c17        adds	r7, r2, #0
@   0x080076ec: 401a        ands	r2, r3
@   0x080076ee: 1c17        adds	r7, r2, #0
@   0x080076f0: 432f        orrs	r7, r5
@   0x080076f2: 2000        movs	r0, #0
@   0x080076f4: 9000        str	r0, [sp, #0]
@   0x080076f6: 4660        mov	r0, ip
@   0x080076f8: 1c3a        adds	r2, r7, #0
@   0x080076fa: 1c31        adds	r1, r6, #0
@   0x080076fc: 2300        movs	r3, #0
@   0x080076fe: f005        fbe7 	bl	0xced0
@   0x08007702: b001        add	sp, #4
@   0x08007704: bcf0        pop	{r4, r5, r6, r7}
@   0x08007706: bc02        pop	{r1}
@   0x08007708: 4708        bx	r1
@   0x0800770a: 0000        movs	r0, r0
@   0x0800770c: 0000        movs	r0, r0
@   0x0800770e: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x08007712: 0000        movs	r0, r0
@   0x08007714: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08007716: 4657        mov	r7, sl
@   0x08007718: 464e        mov	r6, r9
@   0x0800771a: 4645        mov	r5, r8
@   0x0800771c: b4e0        push	{r5, r6, r7}
@   0x0800771e: b081        sub	sp, #4
@   0x08007720: 4680        mov	r8, r0
@   0x08007722: 1c0c        adds	r4, r1, #0
@   0x08007724: 0412        lsls	r2, r2, #16
@   0x08007726: 0c12        lsrs	r2, r2, #16
@   0x08007728: 4691        mov	r9, r2
@   0x0800772a: 041b        lsls	r3, r3, #16
@   0x0800772c: 0c1b        lsrs	r3, r3, #16
@   0x0800772e: 469a        mov	sl, r3
@   0x08007730: 2800        cmp	r0, #0
@   0x08007732: d001        beq.n	0x7738
@   0x08007734: 2c00        cmp	r4, #0
@   0x08007736: d101        bne.n	0x773c
@   0x08007738: 2000        movs	r0, #0
@   0x0800773a: e02a        b.n	0x7792
@   0x0800773c: 88e0        ldrh	r0, [r4, #6]
@   0x0800773e: 0405        lsls	r5, r0, #16
@   0x08007740: 0c68        lsrs	r0, r5, #17
@   0x08007742: 8861        ldrh	r1, [r4, #2]
@   0x08007744: 1a08        subs	r0, r1, r0
@   0x08007746: 0400        lsls	r0, r0, #16
@   0x08007748: 0c00        lsrs	r0, r0, #16
@   0x0800774a: 4a16        ldr	r2, [pc, #88]	@ (0x77a4)
@   0x0800774c: 1c11        adds	r1, r2, #0
@   0x0800774e: 4031        ands	r1, r6
@   0x08007750: 4301        orrs	r1, r0
@   0x08007752: 88a3        ldrh	r3, [r4, #4]
@   0x08007754: 0418        lsls	r0, r3, #16
@   0x08007756: 0c03        lsrs	r3, r0, #16
@   0x08007758: 469c        mov	ip, r3
@   0x0800775a: 0c40        lsrs	r0, r0, #17
@   0x0800775c: 8824        ldrh	r4, [r4, #0]
@   0x0800775e: 1a20        subs	r0, r4, r0
@   0x08007760: 3801        subs	r0, #1
@   0x08007762: 0400        lsls	r0, r0, #16
@   0x08007764: 4b10        ldr	r3, [pc, #64]	@ (0x77a8)
@   0x08007766: 4019        ands	r1, r3
@   0x08007768: 1c0e        adds	r6, r1, #0
@   0x0800776a: 4306        orrs	r6, r0
@   0x0800776c: 403a        ands	r2, r7
@   0x0800776e: 4660        mov	r0, ip
@   0x08007770: 4302        orrs	r2, r0
@   0x08007772: 1c17        adds	r7, r2, #0
@   0x08007774: 401a        ands	r2, r3
@   0x08007776: 1c17        adds	r7, r2, #0
@   0x08007778: 432f        orrs	r7, r5
@   0x0800777a: 4649        mov	r1, r9
@   0x0800777c: 040b        lsls	r3, r1, #16
@   0x0800777e: 141b        asrs	r3, r3, #16
@   0x08007780: 4651        mov	r1, sl
@   0x08007782: 0408        lsls	r0, r1, #16
@   0x08007784: 1400        asrs	r0, r0, #16
@   0x08007786: 9000        str	r0, [sp, #0]
@   0x08007788: 4640        mov	r0, r8
@   0x0800778a: 1c3a        adds	r2, r7, #0
@   0x0800778c: 1c31        adds	r1, r6, #0
@   0x0800778e: f005        fb9f 	bl	0xced0
@   0x08007792: b001        add	sp, #4
@   0x08007794: bc38        pop	{r3, r4, r5}
@   0x08007796: 4698        mov	r8, r3
@   0x08007798: 46a1        mov	r9, r4
@   0x0800779a: 46aa        mov	sl, r5
@   0x0800779c: bcf0        pop	{r4, r5, r6, r7}
@   0x0800779e: bc02        pop	{r1}
@   0x080077a0: 4708        bx	r1
@   0x080077a2: 0000        movs	r0, r0
@   0x080077a4: 0000        movs	r0, r0
@   0x080077a6: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff

        thumb_func_start sub_080076A4
sub_080076A4: @ 0x080076a4
        .incbin "frog_us_baserom.gba", 0x76a4, 0x108
        thumb_func_end sub_080076A4
