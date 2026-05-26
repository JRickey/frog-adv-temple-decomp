@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080204a4, 0x080205d8)  (308 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80204a4 --end 0x80205d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080204a4: b570        push	{r4, r5, r6, lr}
@   0x080204a6: 0600        lsls	r0, r0, #24
@   0x080204a8: 0e00        lsrs	r0, r0, #24
@   0x080204aa: 3805        subs	r0, #5
@   0x080204ac: 281a        cmp	r0, #26
@   0x080204ae: d900        bls.n	0x204b2
@   0x080204b0: e084        b.n	0x205bc
@   0x080204b2: 0080        lsls	r0, r0, #2
@   0x080204b4: 4901        ldr	r1, [pc, #4]	@ (0x204bc)
@   0x080204b6: 1840        adds	r0, r0, r1
@   0x080204b8: 6800        ldr	r0, [r0, #0]
@   0x080204ba: 4687        mov	pc, r0
@   0x080204bc: 04c0        lsls	r0, r0, #19
@   0x080204be: 0802        lsrs	r2, r0, #32
@   0x080204c0: 057c        lsls	r4, r7, #21
@   0x080204c2: 0802        lsrs	r2, r0, #32
@   0x080204c4: 053c        lsls	r4, r7, #20
@   0x080204c6: 0802        lsrs	r2, r0, #32
@   0x080204c8: 057c        lsls	r4, r7, #21
@   0x080204ca: 0802        lsrs	r2, r0, #32
@   0x080204cc: 05bc        lsls	r4, r7, #22
@   0x080204ce: 0802        lsrs	r2, r0, #32
@   0x080204d0: 05bc        lsls	r4, r7, #22
@   0x080204d2: 0802        lsrs	r2, r0, #32
@   0x080204d4: 05bc        lsls	r4, r7, #22
@   0x080204d6: 0802        lsrs	r2, r0, #32
@   0x080204d8: 05bc        lsls	r4, r7, #22
@   0x080204da: 0802        lsrs	r2, r0, #32
@   0x080204dc: 05bc        lsls	r4, r7, #22
@   0x080204de: 0802        lsrs	r2, r0, #32
@   0x080204e0: 05bc        lsls	r4, r7, #22
@   0x080204e2: 0802        lsrs	r2, r0, #32
@   0x080204e4: 05bc        lsls	r4, r7, #22
@   0x080204e6: 0802        lsrs	r2, r0, #32
@   0x080204e8: 05bc        lsls	r4, r7, #22
@   0x080204ea: 0802        lsrs	r2, r0, #32
@   0x080204ec: 05bc        lsls	r4, r7, #22
@   0x080204ee: 0802        lsrs	r2, r0, #32
@   0x080204f0: 05bc        lsls	r4, r7, #22
@   0x080204f2: 0802        lsrs	r2, r0, #32
@   0x080204f4: 05bc        lsls	r4, r7, #22
@   0x080204f6: 0802        lsrs	r2, r0, #32
@   0x080204f8: 05bc        lsls	r4, r7, #22
@   0x080204fa: 0802        lsrs	r2, r0, #32
@   0x080204fc: 05bc        lsls	r4, r7, #22
@   0x080204fe: 0802        lsrs	r2, r0, #32
@   0x08020500: 05bc        lsls	r4, r7, #22
@   0x08020502: 0802        lsrs	r2, r0, #32
@   0x08020504: 05bc        lsls	r4, r7, #22
@   0x08020506: 0802        lsrs	r2, r0, #32
@   0x08020508: 05bc        lsls	r4, r7, #22
@   0x0802050a: 0802        lsrs	r2, r0, #32
@   0x0802050c: 053c        lsls	r4, r7, #20
@   0x0802050e: 0802        lsrs	r2, r0, #32
@   0x08020510: 05bc        lsls	r4, r7, #22
@   0x08020512: 0802        lsrs	r2, r0, #32
@   0x08020514: 057c        lsls	r4, r7, #21
@   0x08020516: 0802        lsrs	r2, r0, #32
@   0x08020518: 057c        lsls	r4, r7, #21
@   0x0802051a: 0802        lsrs	r2, r0, #32
@   0x0802051c: 05bc        lsls	r4, r7, #22
@   0x0802051e: 0802        lsrs	r2, r0, #32
@   0x08020520: 05bc        lsls	r4, r7, #22
@   0x08020522: 0802        lsrs	r2, r0, #32
@   0x08020524: 05bc        lsls	r4, r7, #22
@   0x08020526: 0802        lsrs	r2, r0, #32
@   0x08020528: 052c        lsls	r4, r5, #20
@   0x0802052a: 0802        lsrs	r2, r0, #32
@   0x0802052c: 4802        ldr	r0, [pc, #8]	@ (0x20538)
@   0x0802052e: 7a80        ldrb	r0, [r0, #10]
@   0x08020530: 2801        cmp	r0, #1
@   0x08020532: d14c        bne.n	0x205ce
@   0x08020534: e022        b.n	0x2057c
@   0x08020536: 0000        movs	r0, r0
@   0x08020538: 5330        strh	r0, [r6, r4]
@   0x0802053a: 0300        lsls	r0, r0, #12
@   0x0802053c: 4d0e        ldr	r5, [pc, #56]	@ (0x20578)
@   0x0802053e: 1c2e        adds	r6, r5, #0
@   0x08020540: 3608        adds	r6, #8
@   0x08020542: 68b0        ldr	r0, [r6, #8]
@   0x08020544: f00d        fe1e 	bl	0x2e184
@   0x08020548: 2800        cmp	r0, #0
@   0x0802054a: d140        bne.n	0x205ce
@   0x0802054c: 68e9        ldr	r1, [r5, #12]
@   0x0802054e: 2401        movs	r4, #1
@   0x08020550: 4264        negs	r4, r4
@   0x08020552: 2010        movs	r0, #16
@   0x08020554: 782a        ldrb	r2, [r5, #0]
@   0x08020556: 4010        ands	r0, r2
@   0x08020558: 2800        cmp	r0, #0
@   0x0802055a: d00b        beq.n	0x20574
@   0x0802055c: 1c08        adds	r0, r1, #0
@   0x0802055e: 21ff        movs	r1, #255	@ 0xff
@   0x08020560: 22ff        movs	r2, #255	@ 0xff
@   0x08020562: 23ff        movs	r3, #255	@ 0xff
@   0x08020564: f00d        fa42 	bl	0x2d9ec
@   0x08020568: 1c04        adds	r4, r0, #0
@   0x0802056a: 217f        movs	r1, #127	@ 0x7f
@   0x0802056c: 78ad        ldrb	r5, [r5, #2]
@   0x0802056e: 4029        ands	r1, r5
@   0x08020570: f00d        fb54 	bl	0x2dc1c
@   0x08020574: 60b4        str	r4, [r6, #8]
@   0x08020576: e02a        b.n	0x205ce
@   0x08020578: 3570        adds	r5, #112	@ 0x70
@   0x0802057a: 0300        lsls	r0, r0, #12
@   0x0802057c: 4d0e        ldr	r5, [pc, #56]	@ (0x205b8)
@   0x0802057e: 68a8        ldr	r0, [r5, #8]
@   0x08020580: f00d        fe00 	bl	0x2e184
@   0x08020584: 2800        cmp	r0, #0
@   0x08020586: d122        bne.n	0x205ce
@   0x08020588: 6869        ldr	r1, [r5, #4]
@   0x0802058a: 2401        movs	r4, #1
@   0x0802058c: 4264        negs	r4, r4
@   0x0802058e: 2010        movs	r0, #16
@   0x08020590: 782a        ldrb	r2, [r5, #0]
@   0x08020592: 4010        ands	r0, r2
@   0x08020594: 2800        cmp	r0, #0
@   0x08020596: d00c        beq.n	0x205b2
@   0x08020598: 1c08        adds	r0, r1, #0
@   0x0802059a: 21ff        movs	r1, #255	@ 0xff
@   0x0802059c: 22ff        movs	r2, #255	@ 0xff
@   0x0802059e: 23ff        movs	r3, #255	@ 0xff
@   0x080205a0: f00d        fa24 	bl	0x2d9ec
@   0x080205a4: 1c04        adds	r4, r0, #0
@   0x080205a6: 217f        movs	r1, #127	@ 0x7f
@   0x080205a8: 78a8        ldrb	r0, [r5, #2]
@   0x080205aa: 4001        ands	r1, r0
@   0x080205ac: 1c20        adds	r0, r4, #0
@   0x080205ae: f00d        fb35 	bl	0x2dc1c
@   0x080205b2: 60ac        str	r4, [r5, #8]
@   0x080205b4: e00b        b.n	0x205ce
@   0x080205b6: 0000        movs	r0, r0
@   0x080205b8: 3570        adds	r5, #112	@ 0x70
@   0x080205ba: 0300        lsls	r0, r0, #12
@   0x080205bc: 4805        ldr	r0, [pc, #20]	@ (0x205d4)
@   0x080205be: 1c04        adds	r4, r0, #0
@   0x080205c0: 3408        adds	r4, #8
@   0x080205c2: 6880        ldr	r0, [r0, #8]
@   0x080205c4: f00d        fd9c 	bl	0x2e100
@   0x080205c8: 68a0        ldr	r0, [r4, #8]
@   0x080205ca: f00d        fd99 	bl	0x2e100
@   0x080205ce: bc70        pop	{r4, r5, r6}
@   0x080205d0: bc01        pop	{r0}
@   0x080205d2: 4700        bx	r0
@   0x080205d4: 3570        adds	r5, #112	@ 0x70
@   0x080205d6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080204A4
sub_080204A4: @ 0x080204a4
        .incbin "frog_us_baserom.gba", 0x204a4, 0x134
        thumb_func_end sub_080204A4
