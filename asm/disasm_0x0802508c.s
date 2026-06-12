@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802508c, 0x08025180)  (244 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802508c --end 0x8025180 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802508c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802508e: 4657        mov	r7, sl
@   0x08025090: 464e        mov	r6, r9
@   0x08025092: 4645        mov	r5, r8
@   0x08025094: b4e0        push	{r5, r6, r7}
@   0x08025096: 255d        movs	r5, #93	@ 0x5d
@   0x08025098: 480e        ldr	r0, [pc, #56]	@ (0x250d4)
@   0x0802509a: 4680        mov	r8, r0
@   0x0802509c: 2100        movs	r1, #0
@   0x0802509e: 4689        mov	r9, r1
@   0x080250a0: 4b0d        ldr	r3, [pc, #52]	@ (0x250d8)
@   0x080250a2: 469a        mov	sl, r3
@   0x080250a4: 00e9        lsls	r1, r5, #3
@   0x080250a6: 1b48        subs	r0, r1, r5
@   0x080250a8: 00c0        lsls	r0, r0, #3
@   0x080250aa: 4643        mov	r3, r8
@   0x080250ac: 18c2        adds	r2, r0, r3
@   0x080250ae: 1c0f        adds	r7, r1, #0
@   0x080250b0: 7e90        ldrb	r0, [r2, #26]
@   0x080250b2: 2801        cmp	r0, #1
@   0x080250b4: d124        bne.n	0x25100
@   0x080250b6: 2d5d        cmp	r5, #93	@ 0x5d
@   0x080250b8: d110        bne.n	0x250dc
@   0x080250ba: 2104        movs	r1, #4
@   0x080250bc: 5e50        ldrsh	r0, [r2, r1]
@   0x080250be: 4550        cmp	r0, sl
@   0x080250c0: dc1e        bgt.n	0x25100
@   0x080250c2: 464b        mov	r3, r9
@   0x080250c4: 7693        strb	r3, [r2, #26]
@   0x080250c6: 1c10        adds	r0, r2, #0
@   0x080250c8: 2100        movs	r1, #0
@   0x080250ca: 2200        movs	r2, #0
@   0x080250cc: 2300        movs	r3, #0
@   0x080250ce: f7e5        fa57 	bl	0xa580
@   0x080250d2: e015        b.n	0x25100
@   0x080250d4: 3720        adds	r7, #32
@   0x080250d6: 0300        lsls	r0, r0, #12
@   0x080250d8: 060b        lsls	r3, r1, #24
@   0x080250da: 0000        movs	r0, r0
@   0x080250dc: 2d5e        cmp	r5, #94	@ 0x5e
@   0x080250de: d10f        bne.n	0x25100
@   0x080250e0: 2004        movs	r0, #4
@   0x080250e2: 5e11        ldrsh	r1, [r2, r0]
@   0x080250e4: 4823        ldr	r0, [pc, #140]	@ (0x25174)
@   0x080250e6: 4281        cmp	r1, r0
@   0x080250e8: dc0a        bgt.n	0x25100
@   0x080250ea: 4649        mov	r1, r9
@   0x080250ec: 7691        strb	r1, [r2, #26]
@   0x080250ee: 1c10        adds	r0, r2, #0
@   0x080250f0: 2100        movs	r1, #0
@   0x080250f2: 2200        movs	r2, #0
@   0x080250f4: 2300        movs	r3, #0
@   0x080250f6: f7e5        fa43 	bl	0xa580
@   0x080250fa: 2003        movs	r0, #3
@   0x080250fc: 4b1e        ldr	r3, [pc, #120]	@ (0x25178)
@   0x080250fe: 7018        strb	r0, [r3, #0]
@   0x08025100: 1b78        subs	r0, r7, r5
@   0x08025102: 00c0        lsls	r0, r0, #3
@   0x08025104: 4641        mov	r1, r8
@   0x08025106: 1844        adds	r4, r0, r1
@   0x08025108: 2680        movs	r6, #128	@ 0x80
@   0x0802510a: 00b6        lsls	r6, r6, #2
@   0x0802510c: 1c30        adds	r0, r6, #0
@   0x0802510e: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08025110: 4018        ands	r0, r3
@   0x08025112: 2800        cmp	r0, #0
@   0x08025114: d11a        bne.n	0x2514c
@   0x08025116: 1c28        adds	r0, r5, #0
@   0x08025118: 385d        subs	r0, #93	@ 0x5d
@   0x0802511a: 0600        lsls	r0, r0, #24
@   0x0802511c: 0e02        lsrs	r2, r0, #24
@   0x0802511e: 2a01        cmp	r2, #1
@   0x08025120: d814        bhi.n	0x2514c
@   0x08025122: 4816        ldr	r0, [pc, #88]	@ (0x2517c)
@   0x08025124: 2105        movs	r1, #5
@   0x08025126: f7e1        fb39 	bl	0x679c
@   0x0802512a: 0600        lsls	r0, r0, #24
@   0x0802512c: 2800        cmp	r0, #0
@   0x0802512e: d00d        beq.n	0x2514c
@   0x08025130: 2001        movs	r0, #1
@   0x08025132: 76a0        strb	r0, [r4, #26]
@   0x08025134: 2002        movs	r0, #2
@   0x08025136: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08025138: 4308        orrs	r0, r1
@   0x0802513a: 4330        orrs	r0, r6
@   0x0802513c: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802513e: 1c20        adds	r0, r4, #0
@   0x08025140: 2104        movs	r1, #4
@   0x08025142: 2200        movs	r2, #0
@   0x08025144: 2301        movs	r3, #1
@   0x08025146: 425b        negs	r3, r3
@   0x08025148: f7e5        fa1a 	bl	0xa580
@   0x0802514c: 1c28        adds	r0, r5, #0
@   0x0802514e: f7fb        fef5 	bl	0x20f3c
@   0x08025152: 1b78        subs	r0, r7, r5
@   0x08025154: 00c0        lsls	r0, r0, #3
@   0x08025156: 4440        add	r0, r8
@   0x08025158: f7e0        fc34 	bl	0x59c4
@   0x0802515c: 1c68        adds	r0, r5, #1
@   0x0802515e: 0600        lsls	r0, r0, #24
@   0x08025160: 0e05        lsrs	r5, r0, #24
@   0x08025162: 2d5e        cmp	r5, #94	@ 0x5e
@   0x08025164: d99e        bls.n	0x250a4
@   0x08025166: bc38        pop	{r3, r4, r5}
@   0x08025168: 4698        mov	r8, r3
@   0x0802516a: 46a1        mov	r9, r4
@   0x0802516c: 46aa        mov	sl, r5
@   0x0802516e: bcf0        pop	{r4, r5, r6, r7}
@   0x08025170: bc01        pop	{r0}
@   0x08025172: 4700        bx	r0
@   0x08025174: 063b        lsls	r3, r7, #24
@   0x08025176: 0000        movs	r0, r0
@   0x08025178: 4bb6        ldr	r3, [pc, #728]	@ (0x25454)
@   0x0802517a: 0300        lsls	r0, r0, #12
@   0x0802517c: 6110        str	r0, [r2, #16]
@   0x0802517e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802508C
sub_0802508C: @ 0x0802508c
        .incbin "baserom.gba", 0x2508c, 0xf4
        thumb_func_end sub_0802508C
