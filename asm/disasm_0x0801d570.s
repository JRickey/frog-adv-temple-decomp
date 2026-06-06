@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d570, 0x0801d880)  (784 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d570 --end 0x801d880 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d570: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801d572: 464f        mov	r7, r9
@   0x0801d574: 4646        mov	r6, r8
@   0x0801d576: b4c0        push	{r6, r7}
@   0x0801d578: b082        sub	sp, #8
@   0x0801d57a: 4817        ldr	r0, [pc, #92]	@ (0x1d5d8)
@   0x0801d57c: 68c2        ldr	r2, [r0, #12]
@   0x0801d57e: 4917        ldr	r1, [pc, #92]	@ (0x1d5dc)
@   0x0801d580: 1c03        adds	r3, r0, #0
@   0x0801d582: 4817        ldr	r0, [pc, #92]	@ (0x1d5e0)
@   0x0801d584: 4681        mov	r9, r0
@   0x0801d586: 8812        ldrh	r2, [r2, #0]
@   0x0801d588: 428a        cmp	r2, r1
@   0x0801d58a: d100        bne.n	0x1d58e
@   0x0801d58c: e0dc        b.n	0x1d748
@   0x0801d58e: 1c1e        adds	r6, r3, #0
@   0x0801d590: 46c8        mov	r8, r9
@   0x0801d592: 4f14        ldr	r7, [pc, #80]	@ (0x1d5e4)
@   0x0801d594: 68f5        ldr	r5, [r6, #12]
@   0x0801d596: 8829        ldrh	r1, [r5, #0]
@   0x0801d598: 1c0a        adds	r2, r1, #0
@   0x0801d59a: 4813        ldr	r0, [pc, #76]	@ (0x1d5e8)
@   0x0801d59c: 4282        cmp	r2, r0
@   0x0801d59e: d140        bne.n	0x1d622
@   0x0801d5a0: 2500        movs	r5, #0
@   0x0801d5a2: 2400        movs	r4, #0
@   0x0801d5a4: 4649        mov	r1, r9
@   0x0801d5a6: 8808        ldrh	r0, [r1, #0]
@   0x0801d5a8: 2810        cmp	r0, #16
@   0x0801d5aa: d100        bne.n	0x1d5ae
@   0x0801d5ac: e15c        b.n	0x1d868
@   0x0801d5ae: 2820        cmp	r0, #32
@   0x0801d5b0: d100        bne.n	0x1d5b4
@   0x0801d5b2: e159        b.n	0x1d868
@   0x0801d5b4: 4a0d        ldr	r2, [pc, #52]	@ (0x1d5ec)
@   0x0801d5b6: 4e08        ldr	r6, [pc, #32]	@ (0x1d5d8)
@   0x0801d5b8: 4b09        ldr	r3, [pc, #36]	@ (0x1d5e0)
@   0x0801d5ba: 4699        mov	r9, r3
@   0x0801d5bc: 480b        ldr	r0, [pc, #44]	@ (0x1d5ec)
@   0x0801d5be: 6800        ldr	r0, [r0, #0]
@   0x0801d5c0: 1b40        subs	r0, r0, r5
@   0x0801d5c2: 2803        cmp	r0, #3
@   0x0801d5c4: d925        bls.n	0x1d612
@   0x0801d5c6: 2c00        cmp	r4, #0
@   0x0801d5c8: d014        beq.n	0x1d5f4
@   0x0801d5ca: 6970        ldr	r0, [r6, #20]
@   0x0801d5cc: 306c        adds	r0, #108	@ 0x6c
@   0x0801d5ce: 4b08        ldr	r3, [pc, #32]	@ (0x1d5f0)
@   0x0801d5d0: 1c19        adds	r1, r3, #0
@   0x0801d5d2: 8001        strh	r1, [r0, #0]
@   0x0801d5d4: e011        b.n	0x1d5fa
@   0x0801d5d6: 0000        movs	r0, r0
@   0x0801d5d8: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801d5da: 0300        lsls	r0, r0, #12
@   0x0801d5dc: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0801d5e0: 5398        strh	r0, [r3, r6]
@   0x0801d5e2: 0300        lsls	r0, r0, #12
@   0x0801d5e4: ee64        081b 	mcr	8, 3, r0, cr4, cr11, {0}
@   0x0801d5e8: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x0801d5ec: 5330        strh	r0, [r6, r4]
@   0x0801d5ee: 0300        lsls	r0, r0, #12
@   0x0801d5f0: e0e4        b.n	0x1d7bc
@   0x0801d5f2: 0000        movs	r0, r0
@   0x0801d5f4: 6970        ldr	r0, [r6, #20]
@   0x0801d5f6: 306c        adds	r0, #108	@ 0x6c
@   0x0801d5f8: 8004        strh	r4, [r0, #0]
@   0x0801d5fa: 2000        movs	r0, #0
@   0x0801d5fc: 2c00        cmp	r4, #0
@   0x0801d5fe: d100        bne.n	0x1d602
@   0x0801d600: 2001        movs	r0, #1
@   0x0801d602: 1c04        adds	r4, r0, #0
@   0x0801d604: 6815        ldr	r5, [r2, #0]
@   0x0801d606: 9201        str	r2, [sp, #4]
@   0x0801d608: f7e2        ff5c 	bl	0x4c4
@   0x0801d60c: 4641        mov	r1, r8
@   0x0801d60e: 8008        strh	r0, [r1, #0]
@   0x0801d610: 9a01        ldr	r2, [sp, #4]
@   0x0801d612: 4643        mov	r3, r8
@   0x0801d614: 8818        ldrh	r0, [r3, #0]
@   0x0801d616: 2810        cmp	r0, #16
@   0x0801d618: d100        bne.n	0x1d61c
@   0x0801d61a: e125        b.n	0x1d868
@   0x0801d61c: 2820        cmp	r0, #32
@   0x0801d61e: d1cd        bne.n	0x1d5bc
@   0x0801d620: e122        b.n	0x1d868
@   0x0801d622: 1d48        adds	r0, r1, #5
@   0x0801d624: 0400        lsls	r0, r0, #16
@   0x0801d626: 0c00        lsrs	r0, r0, #16
@   0x0801d628: 2801        cmp	r0, #1
@   0x0801d62a: d84b        bhi.n	0x1d6c4
@   0x0801d62c: 2500        movs	r5, #0
@   0x0801d62e: 4640        mov	r0, r8
@   0x0801d630: 8005        strh	r5, [r0, #0]
@   0x0801d632: 2400        movs	r4, #0
@   0x0801d634: 4a08        ldr	r2, [pc, #32]	@ (0x1d658)
@   0x0801d636: 4f09        ldr	r7, [pc, #36]	@ (0x1d65c)
@   0x0801d638: 4909        ldr	r1, [pc, #36]	@ (0x1d660)
@   0x0801d63a: 4689        mov	r9, r1
@   0x0801d63c: 4806        ldr	r0, [pc, #24]	@ (0x1d658)
@   0x0801d63e: 6800        ldr	r0, [r0, #0]
@   0x0801d640: 1b40        subs	r0, r0, r5
@   0x0801d642: 2803        cmp	r0, #3
@   0x0801d644: d91f        bls.n	0x1d686
@   0x0801d646: 2c00        cmp	r4, #0
@   0x0801d648: d00e        beq.n	0x1d668
@   0x0801d64a: 6978        ldr	r0, [r7, #20]
@   0x0801d64c: 306c        adds	r0, #108	@ 0x6c
@   0x0801d64e: 4b05        ldr	r3, [pc, #20]	@ (0x1d664)
@   0x0801d650: 1c19        adds	r1, r3, #0
@   0x0801d652: 8001        strh	r1, [r0, #0]
@   0x0801d654: e00b        b.n	0x1d66e
@   0x0801d656: 0000        movs	r0, r0
@   0x0801d658: 5330        strh	r0, [r6, r4]
@   0x0801d65a: 0300        lsls	r0, r0, #12
@   0x0801d65c: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801d65e: 0300        lsls	r0, r0, #12
@   0x0801d660: 5398        strh	r0, [r3, r6]
@   0x0801d662: 0300        lsls	r0, r0, #12
@   0x0801d664: e0e4        b.n	0x1d830
@   0x0801d666: 0000        movs	r0, r0
@   0x0801d668: 6978        ldr	r0, [r7, #20]
@   0x0801d66a: 306c        adds	r0, #108	@ 0x6c
@   0x0801d66c: 8004        strh	r4, [r0, #0]
@   0x0801d66e: 2000        movs	r0, #0
@   0x0801d670: 2c00        cmp	r4, #0
@   0x0801d672: d100        bne.n	0x1d676
@   0x0801d674: 2001        movs	r0, #1
@   0x0801d676: 1c04        adds	r4, r0, #0
@   0x0801d678: 6815        ldr	r5, [r2, #0]
@   0x0801d67a: 9201        str	r2, [sp, #4]
@   0x0801d67c: f7e2        ff22 	bl	0x4c4
@   0x0801d680: 4641        mov	r1, r8
@   0x0801d682: 8008        strh	r0, [r1, #0]
@   0x0801d684: 9a01        ldr	r2, [sp, #4]
@   0x0801d686: 4643        mov	r3, r8
@   0x0801d688: 8818        ldrh	r0, [r3, #0]
@   0x0801d68a: 2810        cmp	r0, #16
@   0x0801d68c: d001        beq.n	0x1d692
@   0x0801d68e: 2820        cmp	r0, #32
@   0x0801d690: d1d4        bne.n	0x1d63c
@   0x0801d692: 2820        cmp	r0, #32
@   0x0801d694: d100        bne.n	0x1d698
@   0x0801d696: e0e7        b.n	0x1d868
@   0x0801d698: 68f0        ldr	r0, [r6, #12]
@   0x0801d69a: 8805        ldrh	r5, [r0, #0]
@   0x0801d69c: 4807        ldr	r0, [pc, #28]	@ (0x1d6bc)
@   0x0801d69e: 4285        cmp	r5, r0
@   0x0801d6a0: d068        beq.n	0x1d774
@   0x0801d6a2: 3001        adds	r0, #1
@   0x0801d6a4: 4285        cmp	r5, r0
@   0x0801d6a6: d145        bne.n	0x1d734
@   0x0801d6a8: 4905        ldr	r1, [pc, #20]	@ (0x1d6c0)
@   0x0801d6aa: 2001        movs	r0, #1
@   0x0801d6ac: 6048        str	r0, [r1, #4]
@   0x0801d6ae: 7848        ldrb	r0, [r1, #1]
@   0x0801d6b0: 3001        adds	r0, #1
@   0x0801d6b2: 7048        strb	r0, [r1, #1]
@   0x0801d6b4: 7848        ldrb	r0, [r1, #1]
@   0x0801d6b6: f7ff        febf 	bl	0x1d438
@   0x0801d6ba: e03b        b.n	0x1d734
@   0x0801d6bc: fffb        0000 	vcvta.s32.f32	d16, d0
@   0x0801d6c0: 3540        adds	r5, #64	@ 0x40
@   0x0801d6c2: 0300        lsls	r0, r0, #12
@   0x0801d6c4: 4808        ldr	r0, [pc, #32]	@ (0x1d6e8)
@   0x0801d6c6: 4282        cmp	r2, r0
@   0x0801d6c8: d010        beq.n	0x1d6ec
@   0x0801d6ca: 6972        ldr	r2, [r6, #20]
@   0x0801d6cc: 8e31        ldrh	r1, [r6, #48]	@ 0x30
@   0x0801d6ce: 0048        lsls	r0, r1, #1
@   0x0801d6d0: 1880        adds	r0, r0, r2
@   0x0801d6d2: 2100        movs	r1, #0
@   0x0801d6d4: 8001        strh	r1, [r0, #0]
@   0x0801d6d6: 8e33        ldrh	r3, [r6, #48]	@ 0x30
@   0x0801d6d8: 0058        lsls	r0, r3, #1
@   0x0801d6da: 1880        adds	r0, r0, r2
@   0x0801d6dc: 3040        adds	r0, #64	@ 0x40
@   0x0801d6de: 8829        ldrh	r1, [r5, #0]
@   0x0801d6e0: 8001        strh	r1, [r0, #0]
@   0x0801d6e2: 1ca8        adds	r0, r5, #2
@   0x0801d6e4: 60f0        str	r0, [r6, #12]
@   0x0801d6e6: e01c        b.n	0x1d722
@   0x0801d6e8: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x0801d6ec: 1cab        adds	r3, r5, #2
@   0x0801d6ee: 60f3        str	r3, [r6, #12]
@   0x0801d6f0: 6974        ldr	r4, [r6, #20]
@   0x0801d6f2: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0801d6f4: 0042        lsls	r2, r0, #1
@   0x0801d6f6: 1912        adds	r2, r2, r4
@   0x0801d6f8: 886d        ldrh	r5, [r5, #2]
@   0x0801d6fa: 491a        ldr	r1, [pc, #104]	@ (0x1d764)
@   0x0801d6fc: 1868        adds	r0, r5, r1
@   0x0801d6fe: 0041        lsls	r1, r0, #1
@   0x0801d700: 1809        adds	r1, r1, r0
@   0x0801d702: 1c48        adds	r0, r1, #1
@   0x0801d704: 0040        lsls	r0, r0, #1
@   0x0801d706: 19c0        adds	r0, r0, r7
@   0x0801d708: 8800        ldrh	r0, [r0, #0]
@   0x0801d70a: 8010        strh	r0, [r2, #0]
@   0x0801d70c: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0801d70e: 0042        lsls	r2, r0, #1
@   0x0801d710: 1912        adds	r2, r2, r4
@   0x0801d712: 3240        adds	r2, #64	@ 0x40
@   0x0801d714: 3102        adds	r1, #2
@   0x0801d716: 0049        lsls	r1, r1, #1
@   0x0801d718: 19c9        adds	r1, r1, r7
@   0x0801d71a: 8808        ldrh	r0, [r1, #0]
@   0x0801d71c: 8010        strh	r0, [r2, #0]
@   0x0801d71e: 3302        adds	r3, #2
@   0x0801d720: 60f3        str	r3, [r6, #12]
@   0x0801d722: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0801d724: 3001        adds	r0, #1
@   0x0801d726: 8630        strh	r0, [r6, #48]	@ 0x30
@   0x0801d728: 68f1        ldr	r1, [r6, #12]
@   0x0801d72a: 480f        ldr	r0, [pc, #60]	@ (0x1d768)
@   0x0801d72c: 8809        ldrh	r1, [r1, #0]
@   0x0801d72e: 4281        cmp	r1, r0
@   0x0801d730: d000        beq.n	0x1d734
@   0x0801d732: e72f        b.n	0x1d594
@   0x0801d734: 480d        ldr	r0, [pc, #52]	@ (0x1d76c)
@   0x0801d736: 68c2        ldr	r2, [r0, #12]
@   0x0801d738: 490b        ldr	r1, [pc, #44]	@ (0x1d768)
@   0x0801d73a: 1c03        adds	r3, r0, #0
@   0x0801d73c: 480c        ldr	r0, [pc, #48]	@ (0x1d770)
@   0x0801d73e: 4681        mov	r9, r0
@   0x0801d740: 8812        ldrh	r2, [r2, #0]
@   0x0801d742: 428a        cmp	r2, r1
@   0x0801d744: d000        beq.n	0x1d748
@   0x0801d746: e081        b.n	0x1d84c
@   0x0801d748: 2000        movs	r0, #0
@   0x0801d74a: 8618        strh	r0, [r3, #48]	@ 0x30
@   0x0801d74c: 8e58        ldrh	r0, [r3, #50]	@ 0x32
@   0x0801d74e: 2800        cmp	r0, #0
@   0x0801d750: d11c        bne.n	0x1d78c
@   0x0801d752: 2001        movs	r0, #1
@   0x0801d754: 8658        strh	r0, [r3, #50]	@ 0x32
@   0x0801d756: 6a5e        ldr	r6, [r3, #36]	@ 0x24
@   0x0801d758: 6958        ldr	r0, [r3, #20]
@   0x0801d75a: 6258        str	r0, [r3, #36]	@ 0x24
@   0x0801d75c: 615e        str	r6, [r3, #20]
@   0x0801d75e: 4904        ldr	r1, [pc, #16]	@ (0x1d770)
@   0x0801d760: 4689        mov	r9, r1
@   0x0801d762: e070        b.n	0x1d846
@   0x0801d764: 1f19        subs	r1, r3, #4
@   0x0801d766: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801d76a: 0000        movs	r0, r0
@   0x0801d76c: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801d76e: 0300        lsls	r0, r0, #12
@   0x0801d770: 5398        strh	r0, [r3, r6]
@   0x0801d772: 0300        lsls	r0, r0, #12
@   0x0801d774: 4804        ldr	r0, [pc, #16]	@ (0x1d788)
@   0x0801d776: 2100        movs	r1, #0
@   0x0801d778: 6041        str	r1, [r0, #4]
@   0x0801d77a: 7841        ldrb	r1, [r0, #1]
@   0x0801d77c: 3101        adds	r1, #1
@   0x0801d77e: 7041        strb	r1, [r0, #1]
@   0x0801d780: 7840        ldrb	r0, [r0, #1]
@   0x0801d782: f7ff        fea3 	bl	0x1d4cc
@   0x0801d786: e7d5        b.n	0x1d734
@   0x0801d788: 3540        adds	r5, #64	@ 0x40
@   0x0801d78a: 0300        lsls	r0, r0, #12
@   0x0801d78c: 2500        movs	r5, #0
@   0x0801d78e: 2400        movs	r4, #0
@   0x0801d790: 480b        ldr	r0, [pc, #44]	@ (0x1d7c0)
@   0x0801d792: 8801        ldrh	r1, [r0, #0]
@   0x0801d794: 4681        mov	r9, r0
@   0x0801d796: 2910        cmp	r1, #16
@   0x0801d798: d02f        beq.n	0x1d7fa
@   0x0801d79a: 2920        cmp	r1, #32
@   0x0801d79c: d02d        beq.n	0x1d7fa
@   0x0801d79e: 4a09        ldr	r2, [pc, #36]	@ (0x1d7c4)
@   0x0801d7a0: 1c1f        adds	r7, r3, #0
@   0x0801d7a2: 464e        mov	r6, r9
@   0x0801d7a4: 4807        ldr	r0, [pc, #28]	@ (0x1d7c4)
@   0x0801d7a6: 6800        ldr	r0, [r0, #0]
@   0x0801d7a8: 1b40        subs	r0, r0, r5
@   0x0801d7aa: 2803        cmp	r0, #3
@   0x0801d7ac: d91c        bls.n	0x1d7e8
@   0x0801d7ae: 2c00        cmp	r4, #0
@   0x0801d7b0: d00c        beq.n	0x1d7cc
@   0x0801d7b2: 6978        ldr	r0, [r7, #20]
@   0x0801d7b4: 306c        adds	r0, #108	@ 0x6c
@   0x0801d7b6: 4b04        ldr	r3, [pc, #16]	@ (0x1d7c8)
@   0x0801d7b8: 1c19        adds	r1, r3, #0
@   0x0801d7ba: 8001        strh	r1, [r0, #0]
@   0x0801d7bc: e009        b.n	0x1d7d2
@   0x0801d7be: 0000        movs	r0, r0
@   0x0801d7c0: 5398        strh	r0, [r3, r6]
@   0x0801d7c2: 0300        lsls	r0, r0, #12
@   0x0801d7c4: 5330        strh	r0, [r6, r4]
@   0x0801d7c6: 0300        lsls	r0, r0, #12
@   0x0801d7c8: e0e4        b.n	0x1d994
@   0x0801d7ca: 0000        movs	r0, r0
@   0x0801d7cc: 6978        ldr	r0, [r7, #20]
@   0x0801d7ce: 306c        adds	r0, #108	@ 0x6c
@   0x0801d7d0: 8004        strh	r4, [r0, #0]
@   0x0801d7d2: 2000        movs	r0, #0
@   0x0801d7d4: 2c00        cmp	r4, #0
@   0x0801d7d6: d100        bne.n	0x1d7da
@   0x0801d7d8: 2001        movs	r0, #1
@   0x0801d7da: 1c04        adds	r4, r0, #0
@   0x0801d7dc: 6815        ldr	r5, [r2, #0]
@   0x0801d7de: 9201        str	r2, [sp, #4]
@   0x0801d7e0: f7e2        fe70 	bl	0x4c4
@   0x0801d7e4: 8030        strh	r0, [r6, #0]
@   0x0801d7e6: 9a01        ldr	r2, [sp, #4]
@   0x0801d7e8: 8830        ldrh	r0, [r6, #0]
@   0x0801d7ea: 491b        ldr	r1, [pc, #108]	@ (0x1d858)
@   0x0801d7ec: 4689        mov	r9, r1
@   0x0801d7ee: 2820        cmp	r0, #32
@   0x0801d7f0: d03a        beq.n	0x1d868
@   0x0801d7f2: 2810        cmp	r0, #16
@   0x0801d7f4: d001        beq.n	0x1d7fa
@   0x0801d7f6: 2820        cmp	r0, #32
@   0x0801d7f8: d1d4        bne.n	0x1d7a4
@   0x0801d7fa: 4d18        ldr	r5, [pc, #96]	@ (0x1d85c)
@   0x0801d7fc: 2400        movs	r4, #0
@   0x0801d7fe: 866c        strh	r4, [r5, #50]	@ 0x32
@   0x0801d800: 6a6e        ldr	r6, [r5, #36]	@ 0x24
@   0x0801d802: 696a        ldr	r2, [r5, #20]
@   0x0801d804: 626a        str	r2, [r5, #36]	@ 0x24
@   0x0801d806: 616e        str	r6, [r5, #20]
@   0x0801d808: 4668        mov	r0, sp
@   0x0801d80a: 8004        strh	r4, [r0, #0]
@   0x0801d80c: 4814        ldr	r0, [pc, #80]	@ (0x1d860)
@   0x0801d80e: 466b        mov	r3, sp
@   0x0801d810: 6003        str	r3, [r0, #0]
@   0x0801d812: 6042        str	r2, [r0, #4]
@   0x0801d814: 4b13        ldr	r3, [pc, #76]	@ (0x1d864)
@   0x0801d816: 6083        str	r3, [r0, #8]
@   0x0801d818: 6881        ldr	r1, [r0, #8]
@   0x0801d81a: 4669        mov	r1, sp
@   0x0801d81c: 800c        strh	r4, [r1, #0]
@   0x0801d81e: 6001        str	r1, [r0, #0]
@   0x0801d820: 3240        adds	r2, #64	@ 0x40
@   0x0801d822: 6042        str	r2, [r0, #4]
@   0x0801d824: 6083        str	r3, [r0, #8]
@   0x0801d826: 6881        ldr	r1, [r0, #8]
@   0x0801d828: 4669        mov	r1, sp
@   0x0801d82a: 800c        strh	r4, [r1, #0]
@   0x0801d82c: 6001        str	r1, [r0, #0]
@   0x0801d82e: 6046        str	r6, [r0, #4]
@   0x0801d830: 6083        str	r3, [r0, #8]
@   0x0801d832: 6881        ldr	r1, [r0, #8]
@   0x0801d834: 4669        mov	r1, sp
@   0x0801d836: 800c        strh	r4, [r1, #0]
@   0x0801d838: 6001        str	r1, [r0, #0]
@   0x0801d83a: 1c31        adds	r1, r6, #0
@   0x0801d83c: 3140        adds	r1, #64	@ 0x40
@   0x0801d83e: 6041        str	r1, [r0, #4]
@   0x0801d840: 6083        str	r3, [r0, #8]
@   0x0801d842: 6880        ldr	r0, [r0, #8]
@   0x0801d844: 1c2b        adds	r3, r5, #0
@   0x0801d846: 68d8        ldr	r0, [r3, #12]
@   0x0801d848: 3002        adds	r0, #2
@   0x0801d84a: 60d8        str	r0, [r3, #12]
@   0x0801d84c: 2000        movs	r0, #0
@   0x0801d84e: 4649        mov	r1, r9
@   0x0801d850: 8008        strh	r0, [r1, #0]
@   0x0801d852: 2000        movs	r0, #0
@   0x0801d854: e00c        b.n	0x1d870
@   0x0801d856: 0000        movs	r0, r0
@   0x0801d858: 5398        strh	r0, [r3, r6]
@   0x0801d85a: 0300        lsls	r0, r0, #12
@   0x0801d85c: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801d85e: 0300        lsls	r0, r0, #12
@   0x0801d860: 00d4        lsls	r4, r2, #3
@   0x0801d862: 0400        lsls	r0, r0, #16
@   0x0801d864: 0017        movs	r7, r2
@   0x0801d866: 8100        strh	r0, [r0, #8]
@   0x0801d868: 2000        movs	r0, #0
@   0x0801d86a: 464b        mov	r3, r9
@   0x0801d86c: 8018        strh	r0, [r3, #0]
@   0x0801d86e: 20fe        movs	r0, #254	@ 0xfe
@   0x0801d870: b002        add	sp, #8
@   0x0801d872: bc18        pop	{r3, r4}
@   0x0801d874: 4698        mov	r8, r3
@   0x0801d876: 46a1        mov	r9, r4
@   0x0801d878: bcf0        pop	{r4, r5, r6, r7}
@   0x0801d87a: bc02        pop	{r1}
@   0x0801d87c: 4708        bx	r1

        thumb_func_start Credits_ScrollTick
Credits_ScrollTick: @ 0x0801d570
        .incbin "frog_us_baserom.gba", 0x1d570, 0x310
        thumb_func_end Credits_ScrollTick
