@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012664, 0x0801288c)  (552 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012664 --end 0x801288c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012664: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08012666: 4647        mov	r7, r8
@   0x08012668: b480        push	{r7}
@   0x0801266a: b086        sub	sp, #24
@   0x0801266c: 4846        ldr	r0, [pc, #280]	@ (0x12788)
@   0x0801266e: 7a02        ldrb	r2, [r0, #8]
@   0x08012670: 0611        lsls	r1, r2, #24
@   0x08012672: 7a80        ldrb	r0, [r0, #10]
@   0x08012674: 0600        lsls	r0, r0, #24
@   0x08012676: 26fd        movs	r6, #253	@ 0xfd
@   0x08012678: 0636        lsls	r6, r6, #24
@   0x0801267a: 1989        adds	r1, r1, r6
@   0x0801267c: 0e0b        lsrs	r3, r1, #24
@   0x0801267e: 1980        adds	r0, r0, r6
@   0x08012680: 0e04        lsrs	r4, r0, #24
@   0x08012682: 2200        movs	r2, #0
@   0x08012684: ad02        add	r5, sp, #8
@   0x08012686: a803        add	r0, sp, #12
@   0x08012688: 4680        mov	r8, r0
@   0x0801268a: 466e        mov	r6, sp
@   0x0801268c: 18b1        adds	r1, r6, r2
@   0x0801268e: 18d0        adds	r0, r2, r3
@   0x08012690: 7008        strb	r0, [r1, #0]
@   0x08012692: 1c50        adds	r0, r2, #1
@   0x08012694: 0600        lsls	r0, r0, #24
@   0x08012696: 0e02        lsrs	r2, r0, #24
@   0x08012698: 2a04        cmp	r2, #4
@   0x0801269a: d9f6        bls.n	0x1268a
@   0x0801269c: 2200        movs	r2, #0
@   0x0801269e: 1c2b        adds	r3, r5, #0
@   0x080126a0: 1899        adds	r1, r3, r2
@   0x080126a2: 1910        adds	r0, r2, r4
@   0x080126a4: 7008        strb	r0, [r1, #0]
@   0x080126a6: 1c50        adds	r0, r2, #1
@   0x080126a8: 0600        lsls	r0, r0, #24
@   0x080126aa: 0e02        lsrs	r2, r0, #24
@   0x080126ac: 2a02        cmp	r2, #2
@   0x080126ae: d9f7        bls.n	0x126a0
@   0x080126b0: 2300        movs	r3, #0
@   0x080126b2: 469c        mov	ip, r3
@   0x080126b4: 2200        movs	r2, #0
@   0x080126b6: 4644        mov	r4, r8
@   0x080126b8: 2100        movs	r1, #0
@   0x080126ba: 466e        mov	r6, sp
@   0x080126bc: 1870        adds	r0, r6, r1
@   0x080126be: 7800        ldrb	r0, [r0, #0]
@   0x080126c0: 4282        cmp	r2, r0
@   0x080126c2: d100        bne.n	0x126c6
@   0x080126c4: 2301        movs	r3, #1
@   0x080126c6: 1c48        adds	r0, r1, #1
@   0x080126c8: 0600        lsls	r0, r0, #24
@   0x080126ca: 0e01        lsrs	r1, r0, #24
@   0x080126cc: 2904        cmp	r1, #4
@   0x080126ce: d9f4        bls.n	0x126ba
@   0x080126d0: 2b00        cmp	r3, #0
@   0x080126d2: d106        bne.n	0x126e2
@   0x080126d4: 4661        mov	r1, ip
@   0x080126d6: 1c48        adds	r0, r1, #1
@   0x080126d8: 0600        lsls	r0, r0, #24
@   0x080126da: 0e00        lsrs	r0, r0, #24
@   0x080126dc: 4684        mov	ip, r0
@   0x080126de: 1861        adds	r1, r4, r1
@   0x080126e0: 700a        strb	r2, [r1, #0]
@   0x080126e2: 2300        movs	r3, #0
@   0x080126e4: 1c50        adds	r0, r2, #1
@   0x080126e6: 0600        lsls	r0, r0, #24
@   0x080126e8: 0e02        lsrs	r2, r0, #24
@   0x080126ea: 2a07        cmp	r2, #7
@   0x080126ec: d9e4        bls.n	0x126b8
@   0x080126ee: 2600        movs	r6, #0
@   0x080126f0: 2200        movs	r2, #0
@   0x080126f2: af05        add	r7, sp, #20
@   0x080126f4: 2100        movs	r1, #0
@   0x080126f6: 1c54        adds	r4, r2, #1
@   0x080126f8: 1868        adds	r0, r5, r1
@   0x080126fa: 7800        ldrb	r0, [r0, #0]
@   0x080126fc: 4282        cmp	r2, r0
@   0x080126fe: d100        bne.n	0x12702
@   0x08012700: 2301        movs	r3, #1
@   0x08012702: 1c48        adds	r0, r1, #1
@   0x08012704: 0600        lsls	r0, r0, #24
@   0x08012706: 0e01        lsrs	r1, r0, #24
@   0x08012708: 2902        cmp	r1, #2
@   0x0801270a: d9f5        bls.n	0x126f8
@   0x0801270c: 2b00        cmp	r3, #0
@   0x0801270e: d105        bne.n	0x1271c
@   0x08012710: 1c31        adds	r1, r6, #0
@   0x08012712: 1c48        adds	r0, r1, #1
@   0x08012714: 0600        lsls	r0, r0, #24
@   0x08012716: 0e06        lsrs	r6, r0, #24
@   0x08012718: 1879        adds	r1, r7, r1
@   0x0801271a: 700a        strb	r2, [r1, #0]
@   0x0801271c: 2300        movs	r3, #0
@   0x0801271e: 0620        lsls	r0, r4, #24
@   0x08012720: 0e02        lsrs	r2, r0, #24
@   0x08012722: 2a04        cmp	r2, #4
@   0x08012724: d9e6        bls.n	0x126f4
@   0x08012726: 4660        mov	r0, ip
@   0x08012728: f7ff        f898 	bl	0x1185c
@   0x0801272c: 4c17        ldr	r4, [pc, #92]	@ (0x1278c)
@   0x0801272e: 4440        add	r0, r8
@   0x08012730: 7800        ldrb	r0, [r0, #0]
@   0x08012732: 3001        adds	r0, #1
@   0x08012734: 4916        ldr	r1, [pc, #88]	@ (0x12790)
@   0x08012736: 1865        adds	r5, r4, r1
@   0x08012738: 8028        strh	r0, [r5, #0]
@   0x0801273a: 1c30        adds	r0, r6, #0
@   0x0801273c: f7ff        f88e 	bl	0x1185c
@   0x08012740: 4440        add	r0, r8
@   0x08012742: 7800        ldrb	r0, [r0, #0]
@   0x08012744: 3002        adds	r0, #2
@   0x08012746: 4a13        ldr	r2, [pc, #76]	@ (0x12794)
@   0x08012748: 18a4        adds	r4, r4, r2
@   0x0801274a: 8020        strh	r0, [r4, #0]
@   0x0801274c: 2600        movs	r6, #0
@   0x0801274e: 5fa8        ldrsh	r0, [r5, r6]
@   0x08012750: 2800        cmp	r0, #0
@   0x08012752: dc01        bgt.n	0x12758
@   0x08012754: 2001        movs	r0, #1
@   0x08012756: 8028        strh	r0, [r5, #0]
@   0x08012758: 2100        movs	r1, #0
@   0x0801275a: 5e68        ldrsh	r0, [r5, r1]
@   0x0801275c: 2808        cmp	r0, #8
@   0x0801275e: dd01        ble.n	0x12764
@   0x08012760: 2008        movs	r0, #8
@   0x08012762: 8028        strh	r0, [r5, #0]
@   0x08012764: 2200        movs	r2, #0
@   0x08012766: 5ea0        ldrsh	r0, [r4, r2]
@   0x08012768: 2801        cmp	r0, #1
@   0x0801276a: dc01        bgt.n	0x12770
@   0x0801276c: 2002        movs	r0, #2
@   0x0801276e: 8020        strh	r0, [r4, #0]
@   0x08012770: 2600        movs	r6, #0
@   0x08012772: 5fa0        ldrsh	r0, [r4, r6]
@   0x08012774: 2806        cmp	r0, #6
@   0x08012776: dd01        ble.n	0x1277c
@   0x08012778: 2006        movs	r0, #6
@   0x0801277a: 8020        strh	r0, [r4, #0]
@   0x0801277c: b006        add	sp, #24
@   0x0801277e: bc08        pop	{r3}
@   0x08012780: 4698        mov	r8, r3
@   0x08012782: bcf0        pop	{r4, r5, r6, r7}
@   0x08012784: bc01        pop	{r0}
@   0x08012786: 4700        bx	r0
@   0x08012788: 35e0        adds	r5, #224	@ 0xe0
@   0x0801278a: 0300        lsls	r0, r0, #12
@   0x0801278c: 3720        adds	r7, #32
@   0x0801278e: 0300        lsls	r0, r0, #12
@   0x08012790: 0692        lsls	r2, r2, #26
@   0x08012792: 0000        movs	r0, r0
@   0x08012794: 0694        lsls	r4, r2, #26
@   0x08012796: 0000        movs	r0, r0
@   0x08012798: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801279a: 464f        mov	r7, r9
@   0x0801279c: 4646        mov	r6, r8
@   0x0801279e: b4c0        push	{r6, r7}
@   0x080127a0: 4b26        ldr	r3, [pc, #152]	@ (0x1283c)
@   0x080127a2: 4927        ldr	r1, [pc, #156]	@ (0x12840)
@   0x080127a4: 4a27        ldr	r2, [pc, #156]	@ (0x12844)
@   0x080127a6: 1888        adds	r0, r1, r2
@   0x080127a8: 2700        movs	r7, #0
@   0x080127aa: 5fc0        ldrsh	r0, [r0, r7]
@   0x080127ac: 0042        lsls	r2, r0, #1
@   0x080127ae: 1812        adds	r2, r2, r0
@   0x080127b0: 0412        lsls	r2, r2, #16
@   0x080127b2: 4825        ldr	r0, [pc, #148]	@ (0x12848)
@   0x080127b4: 1809        adds	r1, r1, r0
@   0x080127b6: 2700        movs	r7, #0
@   0x080127b8: 5fc9        ldrsh	r1, [r1, r7]
@   0x080127ba: 0048        lsls	r0, r1, #1
@   0x080127bc: 1840        adds	r0, r0, r1
@   0x080127be: 0400        lsls	r0, r0, #16
@   0x080127c0: 0c00        lsrs	r0, r0, #16
@   0x080127c2: 4684        mov	ip, r0
@   0x080127c4: 0c12        lsrs	r2, r2, #16
@   0x080127c6: 4690        mov	r8, r2
@   0x080127c8: 791c        ldrb	r4, [r3, #4]
@   0x080127ca: 7998        ldrb	r0, [r3, #6]
@   0x080127cc: 4681        mov	r9, r0
@   0x080127ce: 691e        ldr	r6, [r3, #16]
@   0x080127d0: 7a1b        ldrb	r3, [r3, #8]
@   0x080127d2: 091b        lsrs	r3, r3, #4
@   0x080127d4: 2101        movs	r1, #1
@   0x080127d6: 1c18        adds	r0, r3, #0
@   0x080127d8: 4008        ands	r0, r1
@   0x080127da: 2280        movs	r2, #128	@ 0x80
@   0x080127dc: 0492        lsls	r2, r2, #18
@   0x080127de: 2800        cmp	r0, #0
@   0x080127e0: d000        beq.n	0x127e4
@   0x080127e2: 4a1a        ldr	r2, [pc, #104]	@ (0x1284c)
@   0x080127e4: 4d1a        ldr	r5, [pc, #104]	@ (0x12850)
@   0x080127e6: 8b69        ldrh	r1, [r5, #26]
@   0x080127e8: 4660        mov	r0, ip
@   0x080127ea: 4348        muls	r0, r1
@   0x080127ec: 4440        add	r0, r8
@   0x080127ee: 0040        lsls	r0, r0, #1
@   0x080127f0: 1812        adds	r2, r2, r0
@   0x080127f2: 6831        ldr	r1, [r6, #0]
@   0x080127f4: 2000        movs	r0, #0
@   0x080127f6: 1c1e        adds	r6, r3, #0
@   0x080127f8: 4548        cmp	r0, r9
@   0x080127fa: d216        bcs.n	0x1282a
@   0x080127fc: 46ac        mov	ip, r5
@   0x080127fe: 2300        movs	r3, #0
@   0x08012800: 1c45        adds	r5, r0, #1
@   0x08012802: 42a3        cmp	r3, r4
@   0x08012804: d208        bcs.n	0x12818
@   0x08012806: 8808        ldrh	r0, [r1, #0]
@   0x08012808: 8010        strh	r0, [r2, #0]
@   0x0801280a: 3102        adds	r1, #2
@   0x0801280c: 3202        adds	r2, #2
@   0x0801280e: 1c58        adds	r0, r3, #1
@   0x08012810: 0600        lsls	r0, r0, #24
@   0x08012812: 0e03        lsrs	r3, r0, #24
@   0x08012814: 42a3        cmp	r3, r4
@   0x08012816: d3f6        bcc.n	0x12806
@   0x08012818: 4663        mov	r3, ip
@   0x0801281a: 8b5b        ldrh	r3, [r3, #26]
@   0x0801281c: 1b18        subs	r0, r3, r4
@   0x0801281e: 0040        lsls	r0, r0, #1
@   0x08012820: 1812        adds	r2, r2, r0
@   0x08012822: 0628        lsls	r0, r5, #24
@   0x08012824: 0e00        lsrs	r0, r0, #24
@   0x08012826: 4548        cmp	r0, r9
@   0x08012828: d3e9        bcc.n	0x127fe
@   0x0801282a: 2101        movs	r1, #1
@   0x0801282c: 1c30        adds	r0, r6, #0
@   0x0801282e: 4008        ands	r0, r1
@   0x08012830: 2800        cmp	r0, #0
@   0x08012832: d011        beq.n	0x12858
@   0x08012834: 4905        ldr	r1, [pc, #20]	@ (0x1284c)
@   0x08012836: 4a07        ldr	r2, [pc, #28]	@ (0x12854)
@   0x08012838: e011        b.n	0x1285e
@   0x0801283a: 0000        movs	r0, r0
@   0x0801283c: 6e64        ldr	r4, [r4, #100]	@ 0x64
@   0x0801283e: 0830        lsrs	r0, r6, #32
@   0x08012840: 3720        adds	r7, #32
@   0x08012842: 0300        lsls	r0, r0, #12
@   0x08012844: 0692        lsls	r2, r2, #26
@   0x08012846: 0000        movs	r0, r0
@   0x08012848: 0694        lsls	r4, r2, #26
@   0x0801284a: 0000        movs	r0, r0
@   0x0801284c: 0000        movs	r0, r0
@   0x0801284e: 0201        lsls	r1, r0, #8
@   0x08012850: 60a0        str	r0, [r4, #8]
@   0x08012852: 0300        lsls	r0, r0, #12
@   0x08012854: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08012858: 2180        movs	r1, #128	@ 0x80
@   0x0801285a: 0489        lsls	r1, r1, #18
@   0x0801285c: 4a08        ldr	r2, [pc, #32]	@ (0x12880)
@   0x0801285e: 2001        movs	r0, #1
@   0x08012860: 4006        ands	r6, r0
@   0x08012862: 1c30        adds	r0, r6, #0
@   0x08012864: f7fd        fc3e 	bl	0x100e4
@   0x08012868: 4906        ldr	r1, [pc, #24]	@ (0x12884)
@   0x0801286a: 2000        movs	r0, #0
@   0x0801286c: 7288        strb	r0, [r1, #10]
@   0x0801286e: 4906        ldr	r1, [pc, #24]	@ (0x12888)
@   0x08012870: 2001        movs	r0, #1
@   0x08012872: 7008        strb	r0, [r1, #0]
@   0x08012874: bc18        pop	{r3, r4}
@   0x08012876: 4698        mov	r8, r3
@   0x08012878: 46a1        mov	r9, r4
@   0x0801287a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801287c: bc01        pop	{r0}
@   0x0801287e: 4700        bx	r0
@   0x08012880: e000        b.n	0x12884
@   0x08012882: 0600        lsls	r0, r0, #24
@   0x08012884: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08012886: 0300        lsls	r0, r0, #12
@   0x08012888: 3610        adds	r6, #16
@   0x0801288a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08012664
sub_08012664: @ 0x08012664
        .incbin "frog_us_baserom.gba", 0x12664, 0x134
        thumb_func_end sub_08012664

        thumb_func_start sub_08012798
sub_08012798: @ 0x08012798
        .incbin "frog_us_baserom.gba", 0x12798, 0xf4
        thumb_func_end sub_08012798
