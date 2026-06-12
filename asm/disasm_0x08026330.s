@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026330, 0x08026454)  (292 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026330 --end 0x8026454 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026330: b570        push	{r4, r5, r6, lr}
@   0x08026332: b084        sub	sp, #16
@   0x08026334: 4d04        ldr	r5, [pc, #16]	@ (0x26348)
@   0x08026336: 4805        ldr	r0, [pc, #20]	@ (0x2634c)
@   0x08026338: 182e        adds	r6, r5, r0
@   0x0802633a: 7830        ldrb	r0, [r6, #0]
@   0x0802633c: 2800        cmp	r0, #0
@   0x0802633e: d007        beq.n	0x26350
@   0x08026340: 2801        cmp	r0, #1
@   0x08026342: d017        beq.n	0x26374
@   0x08026344: e03c        b.n	0x263c0
@   0x08026346: 0000        movs	r0, r0
@   0x08026348: 3720        adds	r7, #32
@   0x0802634a: 0300        lsls	r0, r0, #12
@   0x0802634c: 09ba        lsrs	r2, r7, #6
@   0x0802634e: 0000        movs	r0, r0
@   0x08026350: 4906        ldr	r1, [pc, #24]	@ (0x2636c)
@   0x08026352: 186a        adds	r2, r5, r1
@   0x08026354: 8811        ldrh	r1, [r2, #0]
@   0x08026356: 2080        movs	r0, #128	@ 0x80
@   0x08026358: 0200        lsls	r0, r0, #8
@   0x0802635a: 4008        ands	r0, r1
@   0x0802635c: 2800        cmp	r0, #0
@   0x0802635e: d02f        beq.n	0x263c0
@   0x08026360: 2002        movs	r0, #2
@   0x08026362: 4308        orrs	r0, r1
@   0x08026364: 4902        ldr	r1, [pc, #8]	@ (0x26370)
@   0x08026366: 4008        ands	r0, r1
@   0x08026368: 8010        strh	r0, [r2, #0]
@   0x0802636a: e029        b.n	0x263c0
@   0x0802636c: 09d4        lsrs	r4, r2, #7
@   0x0802636e: 0000        movs	r0, r0
@   0x08026370: 7fff        ldrb	r7, [r7, #31]
@   0x08026372: 0000        movs	r0, r0
@   0x08026374: 4a31        ldr	r2, [pc, #196]	@ (0x2643c)
@   0x08026376: 18ac        adds	r4, r5, r2
@   0x08026378: 2080        movs	r0, #128	@ 0x80
@   0x0802637a: 0200        lsls	r0, r0, #8
@   0x0802637c: 8821        ldrh	r1, [r4, #0]
@   0x0802637e: 4008        ands	r0, r1
@   0x08026380: 2800        cmp	r0, #0
@   0x08026382: d01d        beq.n	0x263c0
@   0x08026384: 482e        ldr	r0, [pc, #184]	@ (0x26440)
@   0x08026386: 6801        ldr	r1, [r0, #0]
@   0x08026388: 2081        movs	r0, #129	@ 0x81
@   0x0802638a: 9000        str	r0, [sp, #0]
@   0x0802638c: 2005        movs	r0, #5
@   0x0802638e: 9001        str	r0, [sp, #4]
@   0x08026390: 2003        movs	r0, #3
@   0x08026392: 9002        str	r0, [sp, #8]
@   0x08026394: 9003        str	r0, [sp, #12]
@   0x08026396: 202d        movs	r0, #45	@ 0x2d
@   0x08026398: 2210        movs	r2, #16
@   0x0802639a: 231d        movs	r3, #29
@   0x0802639c: f7fa        fe80 	bl	0x210a0
@   0x080263a0: 2000        movs	r0, #0
@   0x080263a2: 7030        strb	r0, [r6, #0]
@   0x080263a4: 2002        movs	r0, #2
@   0x080263a6: 8822        ldrh	r2, [r4, #0]
@   0x080263a8: 4310        orrs	r0, r2
@   0x080263aa: 4926        ldr	r1, [pc, #152]	@ (0x26444)
@   0x080263ac: 4008        ands	r0, r1
@   0x080263ae: 8020        strh	r0, [r4, #0]
@   0x080263b0: 219a        movs	r1, #154	@ 0x9a
@   0x080263b2: 0109        lsls	r1, r1, #4
@   0x080263b4: 1868        adds	r0, r5, r1
@   0x080263b6: 2124        movs	r1, #36	@ 0x24
@   0x080263b8: 2208        movs	r2, #8
@   0x080263ba: 2302        movs	r3, #2
@   0x080263bc: f7fa        fc8e 	bl	0x20cdc
@   0x080263c0: 4c21        ldr	r4, [pc, #132]	@ (0x26448)
@   0x080263c2: 1c20        adds	r0, r4, #0
@   0x080263c4: f7df        fafe 	bl	0x59c4
@   0x080263c8: 1c25        adds	r5, r4, #0
@   0x080263ca: 356c        adds	r5, #108	@ 0x6c
@   0x080263cc: 8829        ldrh	r1, [r5, #0]
@   0x080263ce: 2008        movs	r0, #8
@   0x080263d0: 4008        ands	r0, r1
@   0x080263d2: 2800        cmp	r0, #0
@   0x080263d4: d127        bne.n	0x26426
@   0x080263d6: 1c20        adds	r0, r4, #0
@   0x080263d8: 3052        adds	r0, #82	@ 0x52
@   0x080263da: 7800        ldrb	r0, [r0, #0]
@   0x080263dc: 2804        cmp	r0, #4
@   0x080263de: d11e        bne.n	0x2641e
@   0x080263e0: 223a        movs	r2, #58	@ 0x3a
@   0x080263e2: 5ea0        ldrsh	r0, [r4, r2]
@   0x080263e4: 28e1        cmp	r0, #225	@ 0xe1
@   0x080263e6: dd0f        ble.n	0x26408
@   0x080263e8: 2001        movs	r0, #1
@   0x080263ea: 76a0        strb	r0, [r4, #26]
@   0x080263ec: 2002        movs	r0, #2
@   0x080263ee: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x080263f0: 4310        orrs	r0, r2
@   0x080263f2: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080263f4: 2008        movs	r0, #8
@   0x080263f6: 4308        orrs	r0, r1
@   0x080263f8: 8028        strh	r0, [r5, #0]
@   0x080263fa: 1c20        adds	r0, r4, #0
@   0x080263fc: 3038        adds	r0, #56	@ 0x38
@   0x080263fe: 2100        movs	r1, #0
@   0x08026400: 2200        movs	r2, #0
@   0x08026402: 2300        movs	r3, #0
@   0x08026404: f7e4        f8bc 	bl	0xa580
@   0x08026408: 8829        ldrh	r1, [r5, #0]
@   0x0802640a: 2080        movs	r0, #128	@ 0x80
@   0x0802640c: 0200        lsls	r0, r0, #8
@   0x0802640e: 4008        ands	r0, r1
@   0x08026410: 2800        cmp	r0, #0
@   0x08026412: d004        beq.n	0x2641e
@   0x08026414: 2002        movs	r0, #2
@   0x08026416: 4308        orrs	r0, r1
@   0x08026418: 490a        ldr	r1, [pc, #40]	@ (0x26444)
@   0x0802641a: 4008        ands	r0, r1
@   0x0802641c: 8028        strh	r0, [r5, #0]
@   0x0802641e: 480b        ldr	r0, [pc, #44]	@ (0x2644c)
@   0x08026420: 212d        movs	r1, #45	@ 0x2d
@   0x08026422: f7e0        faa3 	bl	0x696c
@   0x08026426: 202d        movs	r0, #45	@ 0x2d
@   0x08026428: f7fa        fd88 	bl	0x20f3c
@   0x0802642c: 4808        ldr	r0, [pc, #32]	@ (0x26450)
@   0x0802642e: f7df        fac9 	bl	0x59c4
@   0x08026432: b004        add	sp, #16
@   0x08026434: bc70        pop	{r4, r5, r6}
@   0x08026436: bc01        pop	{r0}
@   0x08026438: 4700        bx	r0
@   0x0802643a: 0000        movs	r0, r0
@   0x0802643c: 09d4        lsrs	r4, r2, #7
@   0x0802643e: 0000        movs	r0, r0
@   0x08026440: 5adc        ldrh	r4, [r3, r3]
@   0x08026442: 0831        lsrs	r1, r6, #32
@   0x08026444: 7fff        ldrb	r7, [r7, #31]
@   0x08026446: 0000        movs	r0, r0
@   0x08026448: 40c0        lsrs	r0, r0
@   0x0802644a: 0300        lsls	r0, r0, #12
@   0x0802644c: 6110        str	r0, [r2, #16]
@   0x0802644e: 0300        lsls	r0, r0, #12
@   0x08026450: 40f8        lsrs	r0, r7
@   0x08026452: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08026330
sub_08026330: @ 0x08026330
        .incbin "baserom.gba", 0x26330, 0x124
        thumb_func_end sub_08026330
