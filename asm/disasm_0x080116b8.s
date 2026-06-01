@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080116b8, 0x0801185c)  (420 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80116b8 --end 0x801185c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080116b8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080116ba: 4657        mov	r7, sl
@   0x080116bc: 464e        mov	r6, r9
@   0x080116be: 4645        mov	r5, r8
@   0x080116c0: b4e0        push	{r5, r6, r7}
@   0x080116c2: b083        sub	sp, #12
@   0x080116c4: 0600        lsls	r0, r0, #24
@   0x080116c6: 0e00        lsrs	r0, r0, #24
@   0x080116c8: 4682        mov	sl, r0
@   0x080116ca: 4c05        ldr	r4, [pc, #20]	@ (0x116e0)
@   0x080116cc: 1c25        adds	r5, r4, #0
@   0x080116ce: 35c8        adds	r5, #200	@ 0xc8
@   0x080116d0: 7828        ldrb	r0, [r5, #0]
@   0x080116d2: 2801        cmp	r0, #1
@   0x080116d4: d074        beq.n	0x117c0
@   0x080116d6: 2801        cmp	r0, #1
@   0x080116d8: dc04        bgt.n	0x116e4
@   0x080116da: 2800        cmp	r0, #0
@   0x080116dc: d008        beq.n	0x116f0
@   0x080116de: e0b5        b.n	0x1184c
@   0x080116e0: 3610        adds	r6, #16
@   0x080116e2: 0300        lsls	r0, r0, #12
@   0x080116e4: 2802        cmp	r0, #2
@   0x080116e6: d075        beq.n	0x117d4
@   0x080116e8: 2803        cmp	r0, #3
@   0x080116ea: d100        bne.n	0x116ee
@   0x080116ec: e0a4        b.n	0x11838
@   0x080116ee: e0ad        b.n	0x1184c
@   0x080116f0: f7fd        f870 	bl	0xe7d4
@   0x080116f4: 4a2c        ldr	r2, [pc, #176]	@ (0x117a8)
@   0x080116f6: 200f        movs	r0, #15
@   0x080116f8: 1c01        adds	r1, r0, #0
@   0x080116fa: 8cd3        ldrh	r3, [r2, #38]	@ 0x26
@   0x080116fc: 4019        ands	r1, r3
@   0x080116fe: 8d13        ldrh	r3, [r2, #40]	@ 0x28
@   0x08011700: 4018        ands	r0, r3
@   0x08011702: 4281        cmp	r1, r0
@   0x08011704: d100        bne.n	0x11708
@   0x08011706: e0a1        b.n	0x1184c
@   0x08011708: 2600        movs	r6, #0
@   0x0801170a: 4556        cmp	r6, sl
@   0x0801170c: d300        bcc.n	0x11710
@   0x0801170e: e09d        b.n	0x1184c
@   0x08011710: 4690        mov	r8, r2
@   0x08011712: 2701        movs	r7, #1
@   0x08011714: 4644        mov	r4, r8
@   0x08011716: 8ce1        ldrh	r1, [r4, #38]	@ 0x26
@   0x08011718: 4131        asrs	r1, r6
@   0x0801171a: 4039        ands	r1, r7
@   0x0801171c: 8d20        ldrh	r0, [r4, #40]	@ 0x28
@   0x0801171e: 4130        asrs	r0, r6
@   0x08011720: 4038        ands	r0, r7
@   0x08011722: 4281        cmp	r1, r0
@   0x08011724: d039        beq.n	0x1179a
@   0x08011726: 2019        movs	r0, #25
@   0x08011728: f00f        faa6 	bl	0x20c78
@   0x0801172c: 201c        movs	r0, #28
@   0x0801172e: f00f        faa3 	bl	0x20c78
@   0x08011732: 0075        lsls	r5, r6, #1
@   0x08011734: 19ad        adds	r5, r5, r6
@   0x08011736: 00ed        lsls	r5, r5, #3
@   0x08011738: 481c        ldr	r0, [pc, #112]	@ (0x117ac)
@   0x0801173a: 182c        adds	r4, r5, r0
@   0x0801173c: 7a20        ldrb	r0, [r4, #8]
@   0x0801173e: 8821        ldrh	r1, [r4, #0]
@   0x08011740: 8862        ldrh	r2, [r4, #2]
@   0x08011742: 88a3        ldrh	r3, [r4, #4]
@   0x08011744: 88e4        ldrh	r4, [r4, #6]
@   0x08011746: 9400        str	r4, [sp, #0]
@   0x08011748: 4c19        ldr	r4, [pc, #100]	@ (0x117b0)
@   0x0801174a: 192d        adds	r5, r5, r4
@   0x0801174c: 682c        ldr	r4, [r5, #0]
@   0x0801174e: 9401        str	r4, [sp, #4]
@   0x08011750: 9702        str	r7, [sp, #8]
@   0x08011752: f001        fa37 	bl	0x12bc4
@   0x08011756: 1c38        adds	r0, r7, #0
@   0x08011758: 40b0        lsls	r0, r6
@   0x0801175a: 4645        mov	r5, r8
@   0x0801175c: 8d2d        ldrh	r5, [r5, #40]	@ 0x28
@   0x0801175e: 4328        orrs	r0, r5
@   0x08011760: 2100        movs	r1, #0
@   0x08011762: 4689        mov	r9, r1
@   0x08011764: 4642        mov	r2, r8
@   0x08011766: 8510        strh	r0, [r2, #40]	@ 0x28
@   0x08011768: 2e03        cmp	r6, #3
@   0x0801176a: d002        beq.n	0x11772
@   0x0801176c: 201e        movs	r0, #30
@   0x0801176e: f00f        fa83 	bl	0x20c78
@   0x08011772: 4810        ldr	r0, [pc, #64]	@ (0x117b4)
@   0x08011774: 30c9        adds	r0, #201	@ 0xc9
@   0x08011776: 7006        strb	r6, [r0, #0]
@   0x08011778: 4b0f        ldr	r3, [pc, #60]	@ (0x117b8)
@   0x0801177a: 701f        strb	r7, [r3, #0]
@   0x0801177c: 2e03        cmp	r6, #3
@   0x0801177e: d10c        bne.n	0x1179a
@   0x08011780: 4d0e        ldr	r5, [pc, #56]	@ (0x117bc)
@   0x08011782: 7a28        ldrb	r0, [r5, #8]
@   0x08011784: 8829        ldrh	r1, [r5, #0]
@   0x08011786: 886a        ldrh	r2, [r5, #2]
@   0x08011788: 88ab        ldrh	r3, [r5, #4]
@   0x0801178a: 88ec        ldrh	r4, [r5, #6]
@   0x0801178c: 9400        str	r4, [sp, #0]
@   0x0801178e: 692c        ldr	r4, [r5, #16]
@   0x08011790: 9401        str	r4, [sp, #4]
@   0x08011792: 464c        mov	r4, r9
@   0x08011794: 9402        str	r4, [sp, #8]
@   0x08011796: f001        fa15 	bl	0x12bc4
@   0x0801179a: 1c70        adds	r0, r6, #1
@   0x0801179c: 0600        lsls	r0, r0, #24
@   0x0801179e: 0e06        lsrs	r6, r0, #24
@   0x080117a0: 4556        cmp	r6, sl
@   0x080117a2: d3b7        bcc.n	0x11714
@   0x080117a4: e052        b.n	0x1184c
@   0x080117a6: 0000        movs	r0, r0
@   0x080117a8: 6110        str	r0, [r2, #16]
@   0x080117aa: 0300        lsls	r0, r0, #12
@   0x080117ac: 6ad4        ldr	r4, [r2, #44]	@ 0x2c
@   0x080117ae: 0830        lsrs	r0, r6, #32
@   0x080117b0: 6ae4        ldr	r4, [r4, #44]	@ 0x2c
@   0x080117b2: 0830        lsrs	r0, r6, #32
@   0x080117b4: 3610        adds	r6, #16
@   0x080117b6: 0300        lsls	r0, r0, #12
@   0x080117b8: 36d8        adds	r6, #216	@ 0xd8
@   0x080117ba: 0300        lsls	r0, r0, #12
@   0x080117bc: 6abc        ldr	r4, [r7, #40]	@ 0x28
@   0x080117be: 0830        lsrs	r0, r6, #32
@   0x080117c0: f000        fe86 	bl	0x124d0
@   0x080117c4: 4802        ldr	r0, [pc, #8]	@ (0x117d0)
@   0x080117c6: 2100        movs	r1, #0
@   0x080117c8: 7281        strb	r1, [r0, #10]
@   0x080117ca: 2002        movs	r0, #2
@   0x080117cc: e03d        b.n	0x1184a
@   0x080117ce: 0000        movs	r0, r0
@   0x080117d0: 6580        str	r0, [r0, #88]	@ 0x58
@   0x080117d2: 0300        lsls	r0, r0, #12
@   0x080117d4: 1c20        adds	r0, r4, #0
@   0x080117d6: 30c9        adds	r0, #201	@ 0xc9
@   0x080117d8: 7800        ldrb	r0, [r0, #0]
@   0x080117da: f7ff        fecb 	bl	0x11574
@   0x080117de: 2400        movs	r4, #0
@   0x080117e0: 4910        ldr	r1, [pc, #64]	@ (0x11824)
@   0x080117e2: 6848        ldr	r0, [r1, #4]
@   0x080117e4: 6949        ldr	r1, [r1, #20]
@   0x080117e6: 4a10        ldr	r2, [pc, #64]	@ (0x11828)
@   0x080117e8: 6853        ldr	r3, [r2, #4]
@   0x080117ea: 250e        movs	r5, #14
@   0x080117ec: 5f52        ldrsh	r2, [r2, r5]
@   0x080117ee: 9200        str	r2, [sp, #0]
@   0x080117f0: 1c1a        adds	r2, r3, #0
@   0x080117f2: f000        fd23 	bl	0x1223c
@   0x080117f6: f000        fcc3 	bl	0x12180
@   0x080117fa: 480c        ldr	r0, [pc, #48]	@ (0x1182c)
@   0x080117fc: 6840        ldr	r0, [r0, #4]
@   0x080117fe: 2800        cmp	r0, #0
@   0x08011800: d108        bne.n	0x11814
@   0x08011802: 490b        ldr	r1, [pc, #44]	@ (0x11830)
@   0x08011804: 6848        ldr	r0, [r1, #4]
@   0x08011806: 2800        cmp	r0, #0
@   0x08011808: d104        bne.n	0x11814
@   0x0801180a: 220e        movs	r2, #14
@   0x0801180c: 5e88        ldrsh	r0, [r1, r2]
@   0x0801180e: 2800        cmp	r0, #0
@   0x08011810: d100        bne.n	0x11814
@   0x08011812: 2401        movs	r4, #1
@   0x08011814: 2c00        cmp	r4, #0
@   0x08011816: d019        beq.n	0x1184c
@   0x08011818: 4806        ldr	r0, [pc, #24]	@ (0x11834)
@   0x0801181a: 30c8        adds	r0, #200	@ 0xc8
@   0x0801181c: 2103        movs	r1, #3
@   0x0801181e: 7001        strb	r1, [r0, #0]
@   0x08011820: e014        b.n	0x1184c
@   0x08011822: 0000        movs	r0, r0
@   0x08011824: 6e08        ldr	r0, [r1, #96]	@ 0x60
@   0x08011826: 0830        lsrs	r0, r6, #32
@   0x08011828: 6e28        ldr	r0, [r5, #96]	@ 0x60
@   0x0801182a: 0830        lsrs	r0, r6, #32
@   0x0801182c: 6150        str	r0, [r2, #20]
@   0x0801182e: 0300        lsls	r0, r0, #12
@   0x08011830: 5360        strh	r0, [r4, r5]
@   0x08011832: 0300        lsls	r0, r0, #12
@   0x08011834: 3610        adds	r6, #16
@   0x08011836: 0300        lsls	r0, r0, #12
@   0x08011838: 1c20        adds	r0, r4, #0
@   0x0801183a: 30c9        adds	r0, #201	@ 0xc9
@   0x0801183c: 7800        ldrb	r0, [r0, #0]
@   0x0801183e: f7ff        fe99 	bl	0x11574
@   0x08011842: 0600        lsls	r0, r0, #24
@   0x08011844: 2800        cmp	r0, #0
@   0x08011846: d001        beq.n	0x1184c
@   0x08011848: 2000        movs	r0, #0
@   0x0801184a: 7028        strb	r0, [r5, #0]
@   0x0801184c: b003        add	sp, #12
@   0x0801184e: bc38        pop	{r3, r4, r5}
@   0x08011850: 4698        mov	r8, r3
@   0x08011852: 46a1        mov	r9, r4
@   0x08011854: 46aa        mov	sl, r5
@   0x08011856: bcf0        pop	{r4, r5, r6, r7}
@   0x08011858: bc01        pop	{r0}
@   0x0801185a: 4700        bx	r0

        thumb_func_start sub_080116B8
sub_080116B8: @ 0x080116b8
        .incbin "frog_us_baserom.gba", 0x116b8, 0x1a4
        thumb_func_end sub_080116B8
