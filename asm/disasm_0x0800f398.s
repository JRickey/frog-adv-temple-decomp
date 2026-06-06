@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800f398, 0x0800f814)  (1148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800f398 --end 0x800f814 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800f398: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800f39a: 4657        mov	r7, sl
@   0x0800f39c: 464e        mov	r6, r9
@   0x0800f39e: 4645        mov	r5, r8
@   0x0800f3a0: b4e0        push	{r5, r6, r7}
@   0x0800f3a2: b091        sub	sp, #68	@ 0x44
@   0x0800f3a4: 0600        lsls	r0, r0, #24
@   0x0800f3a6: 0e00        lsrs	r0, r0, #24
@   0x0800f3a8: 9000        str	r0, [sp, #0]
@   0x0800f3aa: 2000        movs	r0, #0
@   0x0800f3ac: 9003        str	r0, [sp, #12]
@   0x0800f3ae: 9900        ldr	r1, [sp, #0]
@   0x0800f3b0: 4288        cmp	r0, r1
@   0x0800f3b2: d300        bcc.n	0xf3b6
@   0x0800f3b4: e21c        b.n	0xf7f0
@   0x0800f3b6: 9a03        ldr	r2, [sp, #12]
@   0x0800f3b8: 2a01        cmp	r2, #1
@   0x0800f3ba: d00c        beq.n	0xf3d6
@   0x0800f3bc: 2a01        cmp	r2, #1
@   0x0800f3be: dc02        bgt.n	0xf3c6
@   0x0800f3c0: 2a00        cmp	r2, #0
@   0x0800f3c2: d004        beq.n	0xf3ce
@   0x0800f3c4: e00e        b.n	0xf3e4
@   0x0800f3c6: 9b03        ldr	r3, [sp, #12]
@   0x0800f3c8: 2b02        cmp	r3, #2
@   0x0800f3ca: d009        beq.n	0xf3e0
@   0x0800f3cc: e00a        b.n	0xf3e4
@   0x0800f3ce: 2480        movs	r4, #128	@ 0x80
@   0x0800f3d0: 04a4        lsls	r4, r4, #18
@   0x0800f3d2: 9404        str	r4, [sp, #16]
@   0x0800f3d4: e006        b.n	0xf3e4
@   0x0800f3d6: 4d01        ldr	r5, [pc, #4]	@ (0xf3dc)
@   0x0800f3d8: 9504        str	r5, [sp, #16]
@   0x0800f3da: e003        b.n	0xf3e4
@   0x0800f3dc: 0000        movs	r0, r0
@   0x0800f3de: 0201        lsls	r1, r0, #8
@   0x0800f3e0: 4805        ldr	r0, [pc, #20]	@ (0xf3f8)
@   0x0800f3e2: 9004        str	r0, [sp, #16]
@   0x0800f3e4: 9904        ldr	r1, [sp, #16]
@   0x0800f3e6: 9101        str	r1, [sp, #4]
@   0x0800f3e8: 9a03        ldr	r2, [sp, #12]
@   0x0800f3ea: 2a01        cmp	r2, #1
@   0x0800f3ec: d010        beq.n	0xf410
@   0x0800f3ee: 2a01        cmp	r2, #1
@   0x0800f3f0: dc04        bgt.n	0xf3fc
@   0x0800f3f2: 2a00        cmp	r2, #0
@   0x0800f3f4: d006        beq.n	0xf404
@   0x0800f3f6: e013        b.n	0xf420
@   0x0800f3f8: 0000        movs	r0, r0
@   0x0800f3fa: 0202        lsls	r2, r0, #8
@   0x0800f3fc: 9b03        ldr	r3, [sp, #12]
@   0x0800f3fe: 2b02        cmp	r3, #2
@   0x0800f400: d00c        beq.n	0xf41c
@   0x0800f402: e00d        b.n	0xf420
@   0x0800f404: 4c01        ldr	r4, [pc, #4]	@ (0xf40c)
@   0x0800f406: 9405        str	r4, [sp, #20]
@   0x0800f408: e00a        b.n	0xf420
@   0x0800f40a: 0000        movs	r0, r0
@   0x0800f40c: e000        b.n	0xf410
@   0x0800f40e: 0600        lsls	r0, r0, #24
@   0x0800f410: 4d01        ldr	r5, [pc, #4]	@ (0xf418)
@   0x0800f412: 9505        str	r5, [sp, #20]
@   0x0800f414: e004        b.n	0xf420
@   0x0800f416: 0000        movs	r0, r0
@   0x0800f418: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0800f41c: 480d        ldr	r0, [pc, #52]	@ (0xf454)
@   0x0800f41e: 9005        str	r0, [sp, #20]
@   0x0800f420: 9905        ldr	r1, [sp, #20]
@   0x0800f422: 9102        str	r1, [sp, #8]
@   0x0800f424: 9a03        ldr	r2, [sp, #12]
@   0x0800f426: 0150        lsls	r0, r2, #5
@   0x0800f428: 4c0b        ldr	r4, [pc, #44]	@ (0xf458)
@   0x0800f42a: 340c        adds	r4, #12
@   0x0800f42c: 1901        adds	r1, r0, r4
@   0x0800f42e: 4b0b        ldr	r3, [pc, #44]	@ (0xf45c)
@   0x0800f430: 18c2        adds	r2, r0, r3
@   0x0800f432: 6809        ldr	r1, [r1, #0]
@   0x0800f434: 6812        ldr	r2, [r2, #0]
@   0x0800f436: 4682        mov	sl, r0
@   0x0800f438: 9d03        ldr	r5, [sp, #12]
@   0x0800f43a: 3501        adds	r5, #1
@   0x0800f43c: 950c        str	r5, [sp, #48]	@ 0x30
@   0x0800f43e: 4291        cmp	r1, r2
@   0x0800f440: d100        bne.n	0xf444
@   0x0800f442: e1cd        b.n	0xf7e0
@   0x0800f444: 1a88        subs	r0, r1, r2
@   0x0800f446: 0fc3        lsrs	r3, r0, #31
@   0x0800f448: 2b00        cmp	r3, #0
@   0x0800f44a: d009        beq.n	0xf460
@   0x0800f44c: 2b01        cmp	r3, #1
@   0x0800f44e: d100        bne.n	0xf452
@   0x0800f450: e0ee        b.n	0xf630
@   0x0800f452: e1c5        b.n	0xf7e0
@   0x0800f454: f000        0600 	and.w	r6, r0, #0
@   0x0800f458: 60a0        str	r0, [r4, #8]
@   0x0800f45a: 0300        lsls	r0, r0, #12
@   0x0800f45c: 60a4        str	r4, [r4, #8]
@   0x0800f45e: 0300        lsls	r0, r0, #12
@   0x0800f460: 0400        lsls	r0, r0, #16
@   0x0800f462: 0c00        lsrs	r0, r0, #16
@   0x0800f464: 4680        mov	r8, r0
@   0x0800f466: 2800        cmp	r0, #0
@   0x0800f468: d100        bne.n	0xf46c
@   0x0800f46a: e1b9        b.n	0xf7e0
@   0x0800f46c: 4650        mov	r0, sl
@   0x0800f46e: 9006        str	r0, [sp, #24]
@   0x0800f470: 4937        ldr	r1, [pc, #220]	@ (0xf550)
@   0x0800f472: 4451        add	r1, sl
@   0x0800f474: 910e        str	r1, [sp, #56]	@ 0x38
@   0x0800f476: 1f20        subs	r0, r4, #4
@   0x0800f478: 4450        add	r0, sl
@   0x0800f47a: 9007        str	r0, [sp, #28]
@   0x0800f47c: 9108        str	r1, [sp, #32]
@   0x0800f47e: 4834        ldr	r0, [pc, #208]	@ (0xf550)
@   0x0800f480: 300c        adds	r0, #12
@   0x0800f482: 9a06        ldr	r2, [sp, #24]
@   0x0800f484: 1810        adds	r0, r2, r0
@   0x0800f486: 9b0e        ldr	r3, [sp, #56]	@ 0x38
@   0x0800f488: 8b5b        ldrh	r3, [r3, #26]
@   0x0800f48a: 00d9        lsls	r1, r3, #3
@   0x0800f48c: 39f0        subs	r1, #240	@ 0xf0
@   0x0800f48e: 6800        ldr	r0, [r0, #0]
@   0x0800f490: 2401        movs	r4, #1
@   0x0800f492: 4264        negs	r4, r4
@   0x0800f494: 4444        add	r4, r8
@   0x0800f496: 46a1        mov	r9, r4
@   0x0800f498: 4288        cmp	r0, r1
@   0x0800f49a: dd00        ble.n	0xf49e
@   0x0800f49c: e0b5        b.n	0xf60a
@   0x0800f49e: 9d0e        ldr	r5, [sp, #56]	@ 0x38
@   0x0800f4a0: 8aa8        ldrh	r0, [r5, #20]
@   0x0800f4a2: 3001        adds	r0, #1
@   0x0800f4a4: 21ff        movs	r1, #255	@ 0xff
@   0x0800f4a6: 4008        ands	r0, r1
@   0x0800f4a8: 82a8        strh	r0, [r5, #20]
@   0x0800f4aa: 4c2a        ldr	r4, [pc, #168]	@ (0xf554)
@   0x0800f4ac: 4454        add	r4, sl
@   0x0800f4ae: 6820        ldr	r0, [r4, #0]
@   0x0800f4b0: 3001        adds	r0, #1
@   0x0800f4b2: 6020        str	r0, [r4, #0]
@   0x0800f4b4: 2000        movs	r0, #0
@   0x0800f4b6: 9903        ldr	r1, [sp, #12]
@   0x0800f4b8: f7ff        ff1e 	bl	0xf2f8
@   0x0800f4bc: 8aaa        ldrh	r2, [r5, #20]
@   0x0800f4be: 2007        movs	r0, #7
@   0x0800f4c0: 4010        ands	r0, r2
@   0x0800f4c2: 2800        cmp	r0, #0
@   0x0800f4c4: d000        beq.n	0xf4c8
@   0x0800f4c6: e0a0        b.n	0xf60a
@   0x0800f4c8: 6821        ldr	r1, [r4, #0]
@   0x0800f4ca: 290f        cmp	r1, #15
@   0x0800f4cc: dc00        bgt.n	0xf4d0
@   0x0800f4ce: e09c        b.n	0xf60a
@   0x0800f4d0: 8b6b        ldrh	r3, [r5, #26]
@   0x0800f4d2: 469c        mov	ip, r3
@   0x0800f4d4: 00d8        lsls	r0, r3, #3
@   0x0800f4d6: 38f8        subs	r0, #248	@ 0xf8
@   0x0800f4d8: 4281        cmp	r1, r0
@   0x0800f4da: dd00        ble.n	0xf4de
@   0x0800f4dc: e095        b.n	0xf60a
@   0x0800f4de: 9f01        ldr	r7, [sp, #4]
@   0x0800f4e0: 9e02        ldr	r6, [sp, #8]
@   0x0800f4e2: 1c08        adds	r0, r1, #0
@   0x0800f4e4: 2800        cmp	r0, #0
@   0x0800f4e6: da00        bge.n	0xf4ea
@   0x0800f4e8: 3007        adds	r0, #7
@   0x0800f4ea: 10c0        asrs	r0, r0, #3
@   0x0800f4ec: 301e        adds	r0, #30
@   0x0800f4ee: 0400        lsls	r0, r0, #16
@   0x0800f4f0: 0c04        lsrs	r4, r0, #16
@   0x0800f4f2: 1c10        adds	r0, r2, #0
@   0x0800f4f4: 3810        subs	r0, #16
@   0x0800f4f6: 25ff        movs	r5, #255	@ 0xff
@   0x0800f4f8: 4028        ands	r0, r5
@   0x0800f4fa: 10c1        asrs	r1, r0, #3
@   0x0800f4fc: 1c08        adds	r0, r1, #0
@   0x0800f4fe: 1280        asrs	r0, r0, #10
@   0x0800f500: 0280        lsls	r0, r0, #10
@   0x0800f502: 1a08        subs	r0, r1, r0
@   0x0800f504: 0400        lsls	r0, r0, #16
@   0x0800f506: 0c03        lsrs	r3, r0, #16
@   0x0800f508: 9d07        ldr	r5, [sp, #28]
@   0x0800f50a: 6829        ldr	r1, [r5, #0]
@   0x0800f50c: 2937        cmp	r1, #55	@ 0x37
@   0x0800f50e: dd23        ble.n	0xf558
@   0x0800f510: 9a0e        ldr	r2, [sp, #56]	@ 0x38
@   0x0800f512: 8b12        ldrh	r2, [r2, #24]
@   0x0800f514: 00d0        lsls	r0, r2, #3
@   0x0800f516: 38d0        subs	r0, #208	@ 0xd0
@   0x0800f518: 4281        cmp	r1, r0
@   0x0800f51a: dc23        bgt.n	0xf564
@   0x0800f51c: 1c08        adds	r0, r1, #0
@   0x0800f51e: 3838        subs	r0, #56	@ 0x38
@   0x0800f520: 2800        cmp	r0, #0
@   0x0800f522: da00        bge.n	0xf526
@   0x0800f524: 3007        adds	r0, #7
@   0x0800f526: 10c0        asrs	r0, r0, #3
@   0x0800f528: 3001        adds	r0, #1
@   0x0800f52a: 4665        mov	r5, ip
@   0x0800f52c: 4345        muls	r5, r0
@   0x0800f52e: 1c28        adds	r0, r5, #0
@   0x0800f530: 1820        adds	r0, r4, r0
@   0x0800f532: 0400        lsls	r0, r0, #16
@   0x0800f534: 0c04        lsrs	r4, r0, #16
@   0x0800f536: 990e        ldr	r1, [sp, #56]	@ 0x38
@   0x0800f538: 8ac8        ldrh	r0, [r1, #22]
@   0x0800f53a: 3838        subs	r0, #56	@ 0x38
@   0x0800f53c: 22ff        movs	r2, #255	@ 0xff
@   0x0800f53e: 4010        ands	r0, r2
@   0x0800f540: 10c0        asrs	r0, r0, #3
@   0x0800f542: 3001        adds	r0, #1
@   0x0800f544: 0141        lsls	r1, r0, #5
@   0x0800f546: 1c08        adds	r0, r1, #0
@   0x0800f548: 1280        asrs	r0, r0, #10
@   0x0800f54a: 0280        lsls	r0, r0, #10
@   0x0800f54c: 1a08        subs	r0, r1, r0
@   0x0800f54e: e01f        b.n	0xf590
@   0x0800f550: 60a0        str	r0, [r4, #8]
@   0x0800f552: 0300        lsls	r0, r0, #12
@   0x0800f554: 60a4        str	r4, [r4, #8]
@   0x0800f556: 0300        lsls	r0, r0, #12
@   0x0800f558: 9a0e        ldr	r2, [sp, #56]	@ 0x38
@   0x0800f55a: 8b12        ldrh	r2, [r2, #24]
@   0x0800f55c: 00d0        lsls	r0, r2, #3
@   0x0800f55e: 38d0        subs	r0, #208	@ 0xd0
@   0x0800f560: 4281        cmp	r1, r0
@   0x0800f562: dd18        ble.n	0xf596
@   0x0800f564: 9d08        ldr	r5, [sp, #32]
@   0x0800f566: 8b2d        ldrh	r5, [r5, #24]
@   0x0800f568: 46a9        mov	r9, r5
@   0x0800f56a: 3d20        subs	r5, #32
@   0x0800f56c: 950f        str	r5, [sp, #60]	@ 0x3c
@   0x0800f56e: 9808        ldr	r0, [sp, #32]
@   0x0800f570: 8b40        ldrh	r0, [r0, #26]
@   0x0800f572: 1c01        adds	r1, r0, #0
@   0x0800f574: 4369        muls	r1, r5
@   0x0800f576: 1860        adds	r0, r4, r1
@   0x0800f578: 0400        lsls	r0, r0, #16
@   0x0800f57a: 0c04        lsrs	r4, r0, #16
@   0x0800f57c: 1c28        adds	r0, r5, #0
@   0x0800f57e: 2d00        cmp	r5, #0
@   0x0800f580: da01        bge.n	0xf586
@   0x0800f582: 4648        mov	r0, r9
@   0x0800f584: 3801        subs	r0, #1
@   0x0800f586: 1140        asrs	r0, r0, #5
@   0x0800f588: 0140        lsls	r0, r0, #5
@   0x0800f58a: 990f        ldr	r1, [sp, #60]	@ 0x3c
@   0x0800f58c: 1a08        subs	r0, r1, r0
@   0x0800f58e: 0140        lsls	r0, r0, #5
@   0x0800f590: 1818        adds	r0, r3, r0
@   0x0800f592: 0400        lsls	r0, r0, #16
@   0x0800f594: 0c03        lsrs	r3, r0, #16
@   0x0800f596: 0060        lsls	r0, r4, #1
@   0x0800f598: 183f        adds	r7, r7, r0
@   0x0800f59a: 0058        lsls	r0, r3, #1
@   0x0800f59c: 1836        adds	r6, r6, r0
@   0x0800f59e: 2200        movs	r2, #0
@   0x0800f5a0: 9c03        ldr	r4, [sp, #12]
@   0x0800f5a2: 0124        lsls	r4, r4, #4
@   0x0800f5a4: 9410        str	r4, [sp, #64]	@ 0x40
@   0x0800f5a6: 2501        movs	r5, #1
@   0x0800f5a8: 426d        negs	r5, r5
@   0x0800f5aa: 4445        add	r5, r8
@   0x0800f5ac: 46a9        mov	r9, r5
@   0x0800f5ae: 481b        ldr	r0, [pc, #108]	@ (0xf61c)
@   0x0800f5b0: 4450        add	r0, sl
@   0x0800f5b2: 4680        mov	r8, r0
@   0x0800f5b4: 491a        ldr	r1, [pc, #104]	@ (0xf620)
@   0x0800f5b6: 468c        mov	ip, r1
@   0x0800f5b8: 4c1a        ldr	r4, [pc, #104]	@ (0xf624)
@   0x0800f5ba: 42a3        cmp	r3, r4
@   0x0800f5bc: d905        bls.n	0xf5ca
@   0x0800f5be: 0058        lsls	r0, r3, #1
@   0x0800f5c0: 4d19        ldr	r5, [pc, #100]	@ (0xf628)
@   0x0800f5c2: 1940        adds	r0, r0, r5
@   0x0800f5c4: 9902        ldr	r1, [sp, #8]
@   0x0800f5c6: 180e        adds	r6, r1, r0
@   0x0800f5c8: 2300        movs	r3, #0
@   0x0800f5ca: 9c10        ldr	r4, [sp, #64]	@ 0x40
@   0x0800f5cc: 4d17        ldr	r5, [pc, #92]	@ (0xf62c)
@   0x0800f5ce: 1961        adds	r1, r4, r5
@   0x0800f5d0: 2402        movs	r4, #2
@   0x0800f5d2: 5f08        ldrsh	r0, [r1, r4]
@   0x0800f5d4: 4282        cmp	r2, r0
@   0x0800f5d6: dc07        bgt.n	0xf5e8
@   0x0800f5d8: 2500        movs	r5, #0
@   0x0800f5da: 5f49        ldrsh	r1, [r1, r5]
@   0x0800f5dc: 428a        cmp	r2, r1
@   0x0800f5de: db03        blt.n	0xf5e8
@   0x0800f5e0: 4661        mov	r1, ip
@   0x0800f5e2: 7948        ldrb	r0, [r1, #5]
@   0x0800f5e4: 2800        cmp	r0, #0
@   0x0800f5e6: d101        bne.n	0xf5ec
@   0x0800f5e8: 8838        ldrh	r0, [r7, #0]
@   0x0800f5ea: 8030        strh	r0, [r6, #0]
@   0x0800f5ec: 1c18        adds	r0, r3, #0
@   0x0800f5ee: 3020        adds	r0, #32
@   0x0800f5f0: 0400        lsls	r0, r0, #16
@   0x0800f5f2: 0c03        lsrs	r3, r0, #16
@   0x0800f5f4: 3640        adds	r6, #64	@ 0x40
@   0x0800f5f6: 4644        mov	r4, r8
@   0x0800f5f8: 8b64        ldrh	r4, [r4, #26]
@   0x0800f5fa: 0064        lsls	r4, r4, #1
@   0x0800f5fc: 940d        str	r4, [sp, #52]	@ 0x34
@   0x0800f5fe: 193f        adds	r7, r7, r4
@   0x0800f600: 1c50        adds	r0, r2, #1
@   0x0800f602: 0400        lsls	r0, r0, #16
@   0x0800f604: 0c02        lsrs	r2, r0, #16
@   0x0800f606: 2a1f        cmp	r2, #31
@   0x0800f608: d9d6        bls.n	0xf5b8
@   0x0800f60a: 464d        mov	r5, r9
@   0x0800f60c: 0428        lsls	r0, r5, #16
@   0x0800f60e: 0c00        lsrs	r0, r0, #16
@   0x0800f610: 4680        mov	r8, r0
@   0x0800f612: 2800        cmp	r0, #0
@   0x0800f614: d000        beq.n	0xf618
@   0x0800f616: e732        b.n	0xf47e
@   0x0800f618: e0e2        b.n	0xf7e0
@   0x0800f61a: 0000        movs	r0, r0
@   0x0800f61c: 60a0        str	r0, [r4, #8]
@   0x0800f61e: 0300        lsls	r0, r0, #12
@   0x0800f620: 3608        adds	r6, #8
@   0x0800f622: 0300        lsls	r0, r0, #12
@   0x0800f624: 03ff        lsls	r7, r7, #15
@   0x0800f626: 0000        movs	r0, r0
@   0x0800f628: f800        ffff 	strb.w	pc, [r0, #255]!
@   0x0800f62c: 63c0        str	r0, [r0, #60]	@ 0x3c
@   0x0800f62e: 0300        lsls	r0, r0, #12
@   0x0800f630: 1a50        subs	r0, r2, r1
@   0x0800f632: 0400        lsls	r0, r0, #16
@   0x0800f634: 0c00        lsrs	r0, r0, #16
@   0x0800f636: 4680        mov	r8, r0
@   0x0800f638: 2800        cmp	r0, #0
@   0x0800f63a: d100        bne.n	0xf63e
@   0x0800f63c: e0d0        b.n	0xf7e0
@   0x0800f63e: 4650        mov	r0, sl
@   0x0800f640: 9009        str	r0, [sp, #36]	@ 0x24
@   0x0800f642: 1f20        subs	r0, r4, #4
@   0x0800f644: 4450        add	r0, sl
@   0x0800f646: 900a        str	r0, [sp, #40]	@ 0x28
@   0x0800f648: 4933        ldr	r1, [pc, #204]	@ (0xf718)
@   0x0800f64a: 4451        add	r1, sl
@   0x0800f64c: 910b        str	r1, [sp, #44]	@ 0x2c
@   0x0800f64e: 4832        ldr	r0, [pc, #200]	@ (0xf718)
@   0x0800f650: 300c        adds	r0, #12
@   0x0800f652: 9a09        ldr	r2, [sp, #36]	@ 0x24
@   0x0800f654: 1810        adds	r0, r2, r0
@   0x0800f656: 6800        ldr	r0, [r0, #0]
@   0x0800f658: 2301        movs	r3, #1
@   0x0800f65a: 425b        negs	r3, r3
@   0x0800f65c: 4443        add	r3, r8
@   0x0800f65e: 4699        mov	r9, r3
@   0x0800f660: 2800        cmp	r0, #0
@   0x0800f662: da00        bge.n	0xf666
@   0x0800f664: e0b5        b.n	0xf7d2
@   0x0800f666: 4d2c        ldr	r5, [pc, #176]	@ (0xf718)
@   0x0800f668: 4455        add	r5, sl
@   0x0800f66a: 8aa8        ldrh	r0, [r5, #20]
@   0x0800f66c: 3801        subs	r0, #1
@   0x0800f66e: 24ff        movs	r4, #255	@ 0xff
@   0x0800f670: 4020        ands	r0, r4
@   0x0800f672: 82a8        strh	r0, [r5, #20]
@   0x0800f674: 4c29        ldr	r4, [pc, #164]	@ (0xf71c)
@   0x0800f676: 4454        add	r4, sl
@   0x0800f678: 6820        ldr	r0, [r4, #0]
@   0x0800f67a: 3801        subs	r0, #1
@   0x0800f67c: 6020        str	r0, [r4, #0]
@   0x0800f67e: 2000        movs	r0, #0
@   0x0800f680: 9903        ldr	r1, [sp, #12]
@   0x0800f682: f7ff        fe39 	bl	0xf2f8
@   0x0800f686: 8aaa        ldrh	r2, [r5, #20]
@   0x0800f688: 2007        movs	r0, #7
@   0x0800f68a: 4010        ands	r0, r2
@   0x0800f68c: 2800        cmp	r0, #0
@   0x0800f68e: d000        beq.n	0xf692
@   0x0800f690: e09f        b.n	0xf7d2
@   0x0800f692: 6821        ldr	r1, [r4, #0]
@   0x0800f694: 2907        cmp	r1, #7
@   0x0800f696: dc00        bgt.n	0xf69a
@   0x0800f698: e09b        b.n	0xf7d2
@   0x0800f69a: 8b68        ldrh	r0, [r5, #26]
@   0x0800f69c: 4684        mov	ip, r0
@   0x0800f69e: 00c0        lsls	r0, r0, #3
@   0x0800f6a0: 4b1f        ldr	r3, [pc, #124]	@ (0xf720)
@   0x0800f6a2: 18c0        adds	r0, r0, r3
@   0x0800f6a4: 4281        cmp	r1, r0
@   0x0800f6a6: dd00        ble.n	0xf6aa
@   0x0800f6a8: e093        b.n	0xf7d2
@   0x0800f6aa: 9f01        ldr	r7, [sp, #4]
@   0x0800f6ac: 9e02        ldr	r6, [sp, #8]
@   0x0800f6ae: 1c08        adds	r0, r1, #0
@   0x0800f6b0: 3808        subs	r0, #8
@   0x0800f6b2: 2800        cmp	r0, #0
@   0x0800f6b4: da00        bge.n	0xf6b8
@   0x0800f6b6: 1e48        subs	r0, r1, #1
@   0x0800f6b8: 0340        lsls	r0, r0, #13
@   0x0800f6ba: 0c04        lsrs	r4, r0, #16
@   0x0800f6bc: 1c10        adds	r0, r2, #0
@   0x0800f6be: 3808        subs	r0, #8
@   0x0800f6c0: 21ff        movs	r1, #255	@ 0xff
@   0x0800f6c2: 4008        ands	r0, r1
@   0x0800f6c4: 10c1        asrs	r1, r0, #3
@   0x0800f6c6: 1c08        adds	r0, r1, #0
@   0x0800f6c8: 1280        asrs	r0, r0, #10
@   0x0800f6ca: 0280        lsls	r0, r0, #10
@   0x0800f6cc: 1a08        subs	r0, r1, r0
@   0x0800f6ce: 0400        lsls	r0, r0, #16
@   0x0800f6d0: 0c03        lsrs	r3, r0, #16
@   0x0800f6d2: 980a        ldr	r0, [sp, #40]	@ 0x28
@   0x0800f6d4: 6801        ldr	r1, [r0, #0]
@   0x0800f6d6: 2937        cmp	r1, #55	@ 0x37
@   0x0800f6d8: dd24        ble.n	0xf724
@   0x0800f6da: 8b2a        ldrh	r2, [r5, #24]
@   0x0800f6dc: 00d0        lsls	r0, r2, #3
@   0x0800f6de: 38d0        subs	r0, #208	@ 0xd0
@   0x0800f6e0: 4281        cmp	r1, r0
@   0x0800f6e2: dc24        bgt.n	0xf72e
@   0x0800f6e4: 1c08        adds	r0, r1, #0
@   0x0800f6e6: 3838        subs	r0, #56	@ 0x38
@   0x0800f6e8: 2800        cmp	r0, #0
@   0x0800f6ea: da00        bge.n	0xf6ee
@   0x0800f6ec: 3007        adds	r0, #7
@   0x0800f6ee: 10c0        asrs	r0, r0, #3
@   0x0800f6f0: 3001        adds	r0, #1
@   0x0800f6f2: 4661        mov	r1, ip
@   0x0800f6f4: 4341        muls	r1, r0
@   0x0800f6f6: 1c08        adds	r0, r1, #0
@   0x0800f6f8: 1820        adds	r0, r4, r0
@   0x0800f6fa: 0400        lsls	r0, r0, #16
@   0x0800f6fc: 0c04        lsrs	r4, r0, #16
@   0x0800f6fe: 8ae8        ldrh	r0, [r5, #22]
@   0x0800f700: 3838        subs	r0, #56	@ 0x38
@   0x0800f702: 22ff        movs	r2, #255	@ 0xff
@   0x0800f704: 4010        ands	r0, r2
@   0x0800f706: 10c0        asrs	r0, r0, #3
@   0x0800f708: 3001        adds	r0, #1
@   0x0800f70a: 0141        lsls	r1, r0, #5
@   0x0800f70c: 1c08        adds	r0, r1, #0
@   0x0800f70e: 1280        asrs	r0, r0, #10
@   0x0800f710: 0280        lsls	r0, r0, #10
@   0x0800f712: 1a08        subs	r0, r1, r0
@   0x0800f714: e020        b.n	0xf758
@   0x0800f716: 0000        movs	r0, r0
@   0x0800f718: 60a0        str	r0, [r4, #8]
@   0x0800f71a: 0300        lsls	r0, r0, #12
@   0x0800f71c: 60a4        str	r4, [r4, #8]
@   0x0800f71e: 0300        lsls	r0, r0, #12
@   0x0800f720: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0800f724: 8b2d        ldrh	r5, [r5, #24]
@   0x0800f726: 00e8        lsls	r0, r5, #3
@   0x0800f728: 38d0        subs	r0, #208	@ 0xd0
@   0x0800f72a: 4281        cmp	r1, r0
@   0x0800f72c: dd17        ble.n	0xf75e
@   0x0800f72e: 980b        ldr	r0, [sp, #44]	@ 0x2c
@   0x0800f730: 8b00        ldrh	r0, [r0, #24]
@   0x0800f732: 4684        mov	ip, r0
@   0x0800f734: 4661        mov	r1, ip
@   0x0800f736: 3920        subs	r1, #32
@   0x0800f738: 9a0b        ldr	r2, [sp, #44]	@ 0x2c
@   0x0800f73a: 8b52        ldrh	r2, [r2, #26]
@   0x0800f73c: 1c15        adds	r5, r2, #0
@   0x0800f73e: 434d        muls	r5, r1
@   0x0800f740: 1960        adds	r0, r4, r5
@   0x0800f742: 0400        lsls	r0, r0, #16
@   0x0800f744: 0c04        lsrs	r4, r0, #16
@   0x0800f746: 1c08        adds	r0, r1, #0
@   0x0800f748: 2900        cmp	r1, #0
@   0x0800f74a: da01        bge.n	0xf750
@   0x0800f74c: 4660        mov	r0, ip
@   0x0800f74e: 3801        subs	r0, #1
@   0x0800f750: 1140        asrs	r0, r0, #5
@   0x0800f752: 0140        lsls	r0, r0, #5
@   0x0800f754: 1a08        subs	r0, r1, r0
@   0x0800f756: 0140        lsls	r0, r0, #5
@   0x0800f758: 1818        adds	r0, r3, r0
@   0x0800f75a: 0400        lsls	r0, r0, #16
@   0x0800f75c: 0c03        lsrs	r3, r0, #16
@   0x0800f75e: 0058        lsls	r0, r3, #1
@   0x0800f760: 1836        adds	r6, r6, r0
@   0x0800f762: 0060        lsls	r0, r4, #1
@   0x0800f764: 183f        adds	r7, r7, r0
@   0x0800f766: 2200        movs	r2, #0
@   0x0800f768: 9c03        ldr	r4, [sp, #12]
@   0x0800f76a: 0124        lsls	r4, r4, #4
@   0x0800f76c: 9410        str	r4, [sp, #64]	@ 0x40
@   0x0800f76e: 2501        movs	r5, #1
@   0x0800f770: 426d        negs	r5, r5
@   0x0800f772: 4445        add	r5, r8
@   0x0800f774: 46a9        mov	r9, r5
@   0x0800f776: 4822        ldr	r0, [pc, #136]	@ (0xf800)
@   0x0800f778: 4684        mov	ip, r0
@   0x0800f77a: 4922        ldr	r1, [pc, #136]	@ (0xf804)
@   0x0800f77c: 4451        add	r1, sl
@   0x0800f77e: 910e        str	r1, [sp, #56]	@ 0x38
@   0x0800f780: 4c21        ldr	r4, [pc, #132]	@ (0xf808)
@   0x0800f782: 46a0        mov	r8, r4
@   0x0800f784: 4563        cmp	r3, ip
@   0x0800f786: d905        bls.n	0xf794
@   0x0800f788: 0058        lsls	r0, r3, #1
@   0x0800f78a: 4d20        ldr	r5, [pc, #128]	@ (0xf80c)
@   0x0800f78c: 1940        adds	r0, r0, r5
@   0x0800f78e: 9902        ldr	r1, [sp, #8]
@   0x0800f790: 180e        adds	r6, r1, r0
@   0x0800f792: 2300        movs	r3, #0
@   0x0800f794: 9c10        ldr	r4, [sp, #64]	@ 0x40
@   0x0800f796: 4d1e        ldr	r5, [pc, #120]	@ (0xf810)
@   0x0800f798: 1961        adds	r1, r4, r5
@   0x0800f79a: 2402        movs	r4, #2
@   0x0800f79c: 5f08        ldrsh	r0, [r1, r4]
@   0x0800f79e: 4282        cmp	r2, r0
@   0x0800f7a0: dc07        bgt.n	0xf7b2
@   0x0800f7a2: 2500        movs	r5, #0
@   0x0800f7a4: 5f48        ldrsh	r0, [r1, r5]
@   0x0800f7a6: 4282        cmp	r2, r0
@   0x0800f7a8: db03        blt.n	0xf7b2
@   0x0800f7aa: 4641        mov	r1, r8
@   0x0800f7ac: 7948        ldrb	r0, [r1, #5]
@   0x0800f7ae: 2800        cmp	r0, #0
@   0x0800f7b0: d101        bne.n	0xf7b6
@   0x0800f7b2: 8838        ldrh	r0, [r7, #0]
@   0x0800f7b4: 8030        strh	r0, [r6, #0]
@   0x0800f7b6: 1c18        adds	r0, r3, #0
@   0x0800f7b8: 3020        adds	r0, #32
@   0x0800f7ba: 0400        lsls	r0, r0, #16
@   0x0800f7bc: 0c03        lsrs	r3, r0, #16
@   0x0800f7be: 3640        adds	r6, #64	@ 0x40
@   0x0800f7c0: 9c0e        ldr	r4, [sp, #56]	@ 0x38
@   0x0800f7c2: 8b64        ldrh	r4, [r4, #26]
@   0x0800f7c4: 0060        lsls	r0, r4, #1
@   0x0800f7c6: 183f        adds	r7, r7, r0
@   0x0800f7c8: 1c50        adds	r0, r2, #1
@   0x0800f7ca: 0400        lsls	r0, r0, #16
@   0x0800f7cc: 0c02        lsrs	r2, r0, #16
@   0x0800f7ce: 2a1f        cmp	r2, #31
@   0x0800f7d0: d9d8        bls.n	0xf784
@   0x0800f7d2: 464d        mov	r5, r9
@   0x0800f7d4: 0428        lsls	r0, r5, #16
@   0x0800f7d6: 0c00        lsrs	r0, r0, #16
@   0x0800f7d8: 4680        mov	r8, r0
@   0x0800f7da: 2800        cmp	r0, #0
@   0x0800f7dc: d000        beq.n	0xf7e0
@   0x0800f7de: e736        b.n	0xf64e
@   0x0800f7e0: 990c        ldr	r1, [sp, #48]	@ 0x30
@   0x0800f7e2: 0608        lsls	r0, r1, #24
@   0x0800f7e4: 0e00        lsrs	r0, r0, #24
@   0x0800f7e6: 9003        str	r0, [sp, #12]
@   0x0800f7e8: 9a00        ldr	r2, [sp, #0]
@   0x0800f7ea: 4290        cmp	r0, r2
@   0x0800f7ec: d200        bcs.n	0xf7f0
@   0x0800f7ee: e5e2        b.n	0xf3b6
@   0x0800f7f0: b011        add	sp, #68	@ 0x44
@   0x0800f7f2: bc38        pop	{r3, r4, r5}
@   0x0800f7f4: 4698        mov	r8, r3
@   0x0800f7f6: 46a1        mov	r9, r4
@   0x0800f7f8: 46aa        mov	sl, r5
@   0x0800f7fa: bcf0        pop	{r4, r5, r6, r7}
@   0x0800f7fc: bc01        pop	{r0}
@   0x0800f7fe: 4700        bx	r0
@   0x0800f800: 03ff        lsls	r7, r7, #15
@   0x0800f802: 0000        movs	r0, r0
@   0x0800f804: 60a0        str	r0, [r4, #8]
@   0x0800f806: 0300        lsls	r0, r0, #12
@   0x0800f808: 3608        adds	r6, #8
@   0x0800f80a: 0300        lsls	r0, r0, #12
@   0x0800f80c: f800        ffff 	strb.w	pc, [r0, #255]!
@   0x0800f810: 63c0        str	r0, [r0, #60]	@ 0x3c
@   0x0800f812: 0300        lsls	r0, r0, #12

        thumb_func_start ScrollUpdate_Pass1
ScrollUpdate_Pass1: @ 0x0800f398
        .incbin "frog_us_baserom.gba", 0xf398, 0x47c
        thumb_func_end ScrollUpdate_Pass1
