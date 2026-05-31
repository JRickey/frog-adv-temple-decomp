@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080135b8, 0x08013694)  (220 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80135b8 --end 0x8013694 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080135b8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080135ba: 464f        mov	r7, r9
@   0x080135bc: 4646        mov	r6, r8
@   0x080135be: b4c0        push	{r6, r7}
@   0x080135c0: 0400        lsls	r0, r0, #16
@   0x080135c2: 0c00        lsrs	r0, r0, #16
@   0x080135c4: 4684        mov	ip, r0
@   0x080135c6: 0609        lsls	r1, r1, #24
@   0x080135c8: 0e0e        lsrs	r6, r1, #24
@   0x080135ca: 0412        lsls	r2, r2, #16
@   0x080135cc: 0c12        lsrs	r2, r2, #16
@   0x080135ce: 4690        mov	r8, r2
@   0x080135d0: 061b        lsls	r3, r3, #24
@   0x080135d2: 0e1f        lsrs	r7, r3, #24
@   0x080135d4: 482c        ldr	r0, [pc, #176]	@ (0x13688)
@   0x080135d6: 2100        movs	r1, #0
@   0x080135d8: 8581        strh	r1, [r0, #44]	@ 0x2c
@   0x080135da: 4a2c        ldr	r2, [pc, #176]	@ (0x1368c)
@   0x080135dc: 85d1        strh	r1, [r2, #46]	@ 0x2e
@   0x080135de: 7a45        ldrb	r5, [r0, #9]
@   0x080135e0: 1c03        adds	r3, r0, #0
@   0x080135e2: 1c14        adds	r4, r2, #0
@   0x080135e4: 2d00        cmp	r5, #0
@   0x080135e6: d022        beq.n	0x1362e
@   0x080135e8: 4829        ldr	r0, [pc, #164]	@ (0x13690)
@   0x080135ea: 6801        ldr	r1, [r0, #0]
@   0x080135ec: 685a        ldr	r2, [r3, #4]
@   0x080135ee: 1a89        subs	r1, r1, r2
@   0x080135f0: 4681        mov	r9, r0
@   0x080135f2: 7ad8        ldrb	r0, [r3, #11]
@   0x080135f4: 4281        cmp	r1, r0
@   0x080135f6: d31a        bcc.n	0x1362e
@   0x080135f8: 2d04        cmp	r5, #4
@   0x080135fa: d108        bne.n	0x1360e
@   0x080135fc: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x080135fe: 4665        mov	r5, ip
@   0x08013600: 0429        lsls	r1, r5, #16
@   0x08013602: 0410        lsls	r0, r2, #16
@   0x08013604: 4288        cmp	r0, r1
@   0x08013606: dc01        bgt.n	0x1360c
@   0x08013608: 1990        adds	r0, r2, r6
@   0x0801360a: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x0801360c: 859e        strh	r6, [r3, #44]	@ 0x2c
@   0x0801360e: 7a58        ldrb	r0, [r3, #9]
@   0x08013610: 2803        cmp	r0, #3
@   0x08013612: d109        bne.n	0x13628
@   0x08013614: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x08013616: 4665        mov	r5, ip
@   0x08013618: 0429        lsls	r1, r5, #16
@   0x0801361a: 0410        lsls	r0, r2, #16
@   0x0801361c: 4288        cmp	r0, r1
@   0x0801361e: db01        blt.n	0x13624
@   0x08013620: 1b90        subs	r0, r2, r6
@   0x08013622: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x08013624: 4270        negs	r0, r6
@   0x08013626: 8598        strh	r0, [r3, #44]	@ 0x2c
@   0x08013628: 4649        mov	r1, r9
@   0x0801362a: 6808        ldr	r0, [r1, #0]
@   0x0801362c: 6058        str	r0, [r3, #4]
@   0x0801362e: 7a63        ldrb	r3, [r4, #9]
@   0x08013630: 2b00        cmp	r3, #0
@   0x08013632: d022        beq.n	0x1367a
@   0x08013634: 4816        ldr	r0, [pc, #88]	@ (0x13690)
@   0x08013636: 6801        ldr	r1, [r0, #0]
@   0x08013638: 6862        ldr	r2, [r4, #4]
@   0x0801363a: 1a89        subs	r1, r1, r2
@   0x0801363c: 4681        mov	r9, r0
@   0x0801363e: 7ae5        ldrb	r5, [r4, #11]
@   0x08013640: 42a9        cmp	r1, r5
@   0x08013642: d31a        bcc.n	0x1367a
@   0x08013644: 2b01        cmp	r3, #1
@   0x08013646: d108        bne.n	0x1365a
@   0x08013648: 8ee2        ldrh	r2, [r4, #54]	@ 0x36
@   0x0801364a: 4640        mov	r0, r8
@   0x0801364c: 0401        lsls	r1, r0, #16
@   0x0801364e: 0410        lsls	r0, r2, #16
@   0x08013650: 4288        cmp	r0, r1
@   0x08013652: dc01        bgt.n	0x13658
@   0x08013654: 19d0        adds	r0, r2, r7
@   0x08013656: 86e0        strh	r0, [r4, #54]	@ 0x36
@   0x08013658: 85e7        strh	r7, [r4, #46]	@ 0x2e
@   0x0801365a: 7a61        ldrb	r1, [r4, #9]
@   0x0801365c: 2902        cmp	r1, #2
@   0x0801365e: d109        bne.n	0x13674
@   0x08013660: 8ee2        ldrh	r2, [r4, #54]	@ 0x36
@   0x08013662: 4643        mov	r3, r8
@   0x08013664: 0419        lsls	r1, r3, #16
@   0x08013666: 0410        lsls	r0, r2, #16
@   0x08013668: 4288        cmp	r0, r1
@   0x0801366a: db01        blt.n	0x13670
@   0x0801366c: 1bd0        subs	r0, r2, r7
@   0x0801366e: 86e0        strh	r0, [r4, #54]	@ 0x36
@   0x08013670: 4278        negs	r0, r7
@   0x08013672: 85e0        strh	r0, [r4, #46]	@ 0x2e
@   0x08013674: 464d        mov	r5, r9
@   0x08013676: 6828        ldr	r0, [r5, #0]
@   0x08013678: 6060        str	r0, [r4, #4]
@   0x0801367a: bc18        pop	{r3, r4}
@   0x0801367c: 4698        mov	r8, r3
@   0x0801367e: 46a1        mov	r9, r4
@   0x08013680: bcf0        pop	{r4, r5, r6, r7}
@   0x08013682: bc01        pop	{r0}
@   0x08013684: 4700        bx	r0
@   0x08013686: 0000        movs	r0, r0
@   0x08013688: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0801368a: 0300        lsls	r0, r0, #12
@   0x0801368c: 6480        str	r0, [r0, #72]	@ 0x48
@   0x0801368e: 0300        lsls	r0, r0, #12
@   0x08013690: 5330        strh	r0, [r6, r4]
@   0x08013692: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080135B8
sub_080135B8: @ 0x080135b8
        .incbin "frog_us_baserom.gba", 0x135b8, 0xdc
        thumb_func_end sub_080135B8
