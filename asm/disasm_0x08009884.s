@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009884, 0x08009984)  (256 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009884 --end 0x8009984 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009884: b570        push	{r4, r5, r6, lr}
@   0x08009886: 0600        lsls	r0, r0, #24
@   0x08009888: 0e06        lsrs	r6, r0, #24
@   0x0800988a: 4911        ldr	r1, [pc, #68]	@ (0x98d0)
@   0x0800988c: 2004        movs	r0, #4
@   0x0800988e: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08009890: 4008        ands	r0, r1
@   0x08009892: 2800        cmp	r0, #0
@   0x08009894: d16f        bne.n	0x9976
@   0x08009896: 4c0f        ldr	r4, [pc, #60]	@ (0x98d4)
@   0x08009898: 7e20        ldrb	r0, [r4, #24]
@   0x0800989a: 7e61        ldrb	r1, [r4, #25]
@   0x0800989c: 2308        movs	r3, #8
@   0x0800989e: 5ee2        ldrsh	r2, [r4, r3]
@   0x080098a0: 250a        movs	r5, #10
@   0x080098a2: 5f63        ldrsh	r3, [r4, r5]
@   0x080098a4: f003        fab4 	bl	0xce10
@   0x080098a8: 0600        lsls	r0, r0, #24
@   0x080098aa: 0e00        lsrs	r0, r0, #24
@   0x080098ac: 1c35        adds	r5, r6, #0
@   0x080098ae: 3d1e        subs	r5, #30
@   0x080098b0: 2803        cmp	r0, #3
@   0x080098b2: d131        bne.n	0x9918
@   0x080098b4: 2104        movs	r1, #4
@   0x080098b6: 5661        ldrsb	r1, [r4, r1]
@   0x080098b8: 4807        ldr	r0, [pc, #28]	@ (0x98d8)
@   0x080098ba: 7880        ldrb	r0, [r0, #2]
@   0x080098bc: 4281        cmp	r1, r0
@   0x080098be: db0d        blt.n	0x98dc
@   0x080098c0: 2180        movs	r1, #128	@ 0x80
@   0x080098c2: 0049        lsls	r1, r1, #1
@   0x080098c4: 1c08        adds	r0, r1, #0
@   0x080098c6: 8a22        ldrh	r2, [r4, #16]
@   0x080098c8: 4310        orrs	r0, r2
@   0x080098ca: 8220        strh	r0, [r4, #16]
@   0x080098cc: e024        b.n	0x9918
@   0x080098ce: 0000        movs	r0, r0
@   0x080098d0: 3720        adds	r7, #32
@   0x080098d2: 0300        lsls	r0, r0, #12
@   0x080098d4: 35e0        adds	r5, #224	@ 0xe0
@   0x080098d6: 0300        lsls	r0, r0, #12
@   0x080098d8: 6110        str	r0, [r2, #16]
@   0x080098da: 0300        lsls	r0, r0, #12
@   0x080098dc: 4806        ldr	r0, [pc, #24]	@ (0x98f8)
@   0x080098de: 7a80        ldrb	r0, [r0, #10]
@   0x080098e0: 2103        movs	r1, #3
@   0x080098e2: f02a        fb3b 	bl	0x33f5c
@   0x080098e6: 0600        lsls	r0, r0, #24
@   0x080098e8: 0e00        lsrs	r0, r0, #24
@   0x080098ea: 2801        cmp	r0, #1
@   0x080098ec: d106        bne.n	0x98fc
@   0x080098ee: 2005        movs	r0, #5
@   0x080098f0: f004        fe86 	bl	0xe600
@   0x080098f4: e007        b.n	0x9906
@   0x080098f6: 0000        movs	r0, r0
@   0x080098f8: 5330        strh	r0, [r6, r4]
@   0x080098fa: 0300        lsls	r0, r0, #12
@   0x080098fc: 2802        cmp	r0, #2
@   0x080098fe: d102        bne.n	0x9906
@   0x08009900: 2006        movs	r0, #6
@   0x08009902: f004        fe7d 	bl	0xe600
@   0x08009906: 1c35        adds	r5, r6, #0
@   0x08009908: 3d1e        subs	r5, #30
@   0x0800990a: e001        b.n	0x9910
@   0x0800990c: f7f6        ffe6 	bl	0x8dc
@   0x08009910: f006        fa1e 	bl	0xfd50
@   0x08009914: 2800        cmp	r0, #0
@   0x08009916: d1f9        bne.n	0x990c
@   0x08009918: 4b18        ldr	r3, [pc, #96]	@ (0x997c)
@   0x0800991a: 7e18        ldrb	r0, [r3, #24]
@   0x0800991c: 7e59        ldrb	r1, [r3, #25]
@   0x0800991e: 2408        movs	r4, #8
@   0x08009920: 5f1a        ldrsh	r2, [r3, r4]
@   0x08009922: 240a        movs	r4, #10
@   0x08009924: 5f1b        ldrsh	r3, [r3, r4]
@   0x08009926: f003        fa73 	bl	0xce10
@   0x0800992a: 0600        lsls	r0, r0, #24
@   0x0800992c: 0e00        lsrs	r0, r0, #24
@   0x0800992e: 2801        cmp	r0, #1
@   0x08009930: d104        bne.n	0x993c
@   0x08009932: 4813        ldr	r0, [pc, #76]	@ (0x9980)
@   0x08009934: 2104        movs	r1, #4
@   0x08009936: 8dc2        ldrh	r2, [r0, #46]	@ 0x2e
@   0x08009938: 4311        orrs	r1, r2
@   0x0800993a: 85c1        strh	r1, [r0, #46]	@ 0x2e
@   0x0800993c: f000        f930 	bl	0x9ba0
@   0x08009940: 0600        lsls	r0, r0, #24
@   0x08009942: 2800        cmp	r0, #0
@   0x08009944: d008        beq.n	0x9958
@   0x08009946: 4a0e        ldr	r2, [pc, #56]	@ (0x9980)
@   0x08009948: 8dd1        ldrh	r1, [r2, #46]	@ 0x2e
@   0x0800994a: 2002        movs	r0, #2
@   0x0800994c: 4008        ands	r0, r1
@   0x0800994e: 2800        cmp	r0, #0
@   0x08009950: d102        bne.n	0x9958
@   0x08009952: 2002        movs	r0, #2
@   0x08009954: 4308        orrs	r0, r1
@   0x08009956: 85d0        strh	r0, [r2, #46]	@ 0x2e
@   0x08009958: 0628        lsls	r0, r5, #24
@   0x0800995a: 0e00        lsrs	r0, r0, #24
@   0x0800995c: 2807        cmp	r0, #7
@   0x0800995e: d80a        bhi.n	0x9976
@   0x08009960: 4906        ldr	r1, [pc, #24]	@ (0x997c)
@   0x08009962: 2005        movs	r0, #5
@   0x08009964: 5608        ldrsb	r0, [r1, r0]
@   0x08009966: 42a8        cmp	r0, r5
@   0x08009968: da05        bge.n	0x9976
@   0x0800996a: 714d        strb	r5, [r1, #5]
@   0x0800996c: f000        fde8 	bl	0xa540
@   0x08009970: 2004        movs	r0, #4
@   0x08009972: f017        f981 	bl	0x20c78
@   0x08009976: bc70        pop	{r4, r5, r6}
@   0x08009978: bc01        pop	{r0}
@   0x0800997a: 4700        bx	r0
@   0x0800997c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800997e: 0300        lsls	r0, r0, #12
@   0x08009980: 6110        str	r0, [r2, #16]
@   0x08009982: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08009884
sub_08009884: @ 0x08009884
        .incbin "frog_us_baserom.gba", 0x9884, 0x100
        thumb_func_end sub_08009884
