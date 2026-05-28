@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080045ec, 0x08004938)  (844 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80045ec --end 0x8004938 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080045ec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080045ee: 1c06        adds	r6, r0, #0
@   0x080045f0: 1c0f        adds	r7, r1, #0
@   0x080045f2: 2211        movs	r2, #17
@   0x080045f4: f007        f990 	bl	0xb918
@   0x080045f8: 4cb9        ldr	r4, [pc, #740]	@ (0x48e0)
@   0x080045fa: 7e20        ldrb	r0, [r4, #24]
@   0x080045fc: 7e61        ldrb	r1, [r4, #25]
@   0x080045fe: 2308        movs	r3, #8
@   0x08004600: 5ee2        ldrsh	r2, [r4, r3]
@   0x08004602: 250a        movs	r5, #10
@   0x08004604: 5f63        ldrsh	r3, [r4, r5]
@   0x08004606: f008        fbbf 	bl	0xcd88
@   0x0800460a: 0600        lsls	r0, r0, #24
@   0x0800460c: 0e05        lsrs	r5, r0, #24
@   0x0800460e: 2010        movs	r0, #16
@   0x08004610: 8a21        ldrh	r1, [r4, #16]
@   0x08004612: 4008        ands	r0, r1
@   0x08004614: 2800        cmp	r0, #0
@   0x08004616: d008        beq.n	0x462a
@   0x08004618: 1c30        adds	r0, r6, #0
@   0x0800461a: 1c39        adds	r1, r7, #0
@   0x0800461c: 2211        movs	r2, #17
@   0x0800461e: 1c2b        adds	r3, r5, #0
@   0x08004620: f007        f942 	bl	0xb8a8
@   0x08004624: 1c28        adds	r0, r5, #0
@   0x08004626: f006        fa23 	bl	0xaa70
@   0x0800462a: 1c20        adds	r0, r4, #0
@   0x0800462c: 2140        movs	r1, #64	@ 0x40
@   0x0800462e: f002        fab9 	bl	0x6ba4
@   0x08004632: 0600        lsls	r0, r0, #24
@   0x08004634: 2800        cmp	r0, #0
@   0x08004636: d100        bne.n	0x463a
@   0x08004638: e0ab        b.n	0x4792
@   0x0800463a: 2208        movs	r2, #8
@   0x0800463c: 5ea0        ldrsh	r0, [r4, r2]
@   0x0800463e: 280d        cmp	r0, #13
@   0x08004640: d001        beq.n	0x4646
@   0x08004642: 2806        cmp	r0, #6
@   0x08004644: d10a        bne.n	0x465c
@   0x08004646: 230a        movs	r3, #10
@   0x08004648: 5ee0        ldrsh	r0, [r4, r3]
@   0x0800464a: 2817        cmp	r0, #23
@   0x0800464c: d001        beq.n	0x4652
@   0x0800464e: 2815        cmp	r0, #21
@   0x08004650: d104        bne.n	0x465c
@   0x08004652: 48a4        ldr	r0, [pc, #656]	@ (0x48e4)
@   0x08004654: 2200        movs	r2, #0
@   0x08004656: 2103        movs	r1, #3
@   0x08004658: 7181        strb	r1, [r0, #6]
@   0x0800465a: 76a2        strb	r2, [r4, #26]
@   0x0800465c: 48a0        ldr	r0, [pc, #640]	@ (0x48e0)
@   0x0800465e: 2508        movs	r5, #8
@   0x08004660: 5f41        ldrsh	r1, [r0, r5]
@   0x08004662: 1c03        adds	r3, r0, #0
@   0x08004664: 290c        cmp	r1, #12
@   0x08004666: d001        beq.n	0x466c
@   0x08004668: 2905        cmp	r1, #5
@   0x0800466a: d10a        bne.n	0x4682
@   0x0800466c: 210a        movs	r1, #10
@   0x0800466e: 5e58        ldrsh	r0, [r3, r1]
@   0x08004670: 2817        cmp	r0, #23
@   0x08004672: d001        beq.n	0x4678
@   0x08004674: 2815        cmp	r0, #21
@   0x08004676: d104        bne.n	0x4682
@   0x08004678: 489a        ldr	r0, [pc, #616]	@ (0x48e4)
@   0x0800467a: 2200        movs	r2, #0
@   0x0800467c: 2102        movs	r1, #2
@   0x0800467e: 7181        strb	r1, [r0, #6]
@   0x08004680: 769a        strb	r2, [r3, #26]
@   0x08004682: 2208        movs	r2, #8
@   0x08004684: 5e98        ldrsh	r0, [r3, r2]
@   0x08004686: 2808        cmp	r0, #8
@   0x08004688: d001        beq.n	0x468e
@   0x0800468a: 2802        cmp	r0, #2
@   0x0800468c: d10a        bne.n	0x46a4
@   0x0800468e: 250a        movs	r5, #10
@   0x08004690: 5f58        ldrsh	r0, [r3, r5]
@   0x08004692: 2817        cmp	r0, #23
@   0x08004694: d001        beq.n	0x469a
@   0x08004696: 2815        cmp	r0, #21
@   0x08004698: d104        bne.n	0x46a4
@   0x0800469a: 4892        ldr	r0, [pc, #584]	@ (0x48e4)
@   0x0800469c: 2200        movs	r2, #0
@   0x0800469e: 2103        movs	r1, #3
@   0x080046a0: 7181        strb	r1, [r0, #6]
@   0x080046a2: 769a        strb	r2, [r3, #26]
@   0x080046a4: 2108        movs	r1, #8
@   0x080046a6: 5e58        ldrsh	r0, [r3, r1]
@   0x080046a8: 2809        cmp	r0, #9
@   0x080046aa: d001        beq.n	0x46b0
@   0x080046ac: 2803        cmp	r0, #3
@   0x080046ae: d10a        bne.n	0x46c6
@   0x080046b0: 220a        movs	r2, #10
@   0x080046b2: 5e98        ldrsh	r0, [r3, r2]
@   0x080046b4: 2817        cmp	r0, #23
@   0x080046b6: d001        beq.n	0x46bc
@   0x080046b8: 2815        cmp	r0, #21
@   0x080046ba: d104        bne.n	0x46c6
@   0x080046bc: 4889        ldr	r0, [pc, #548]	@ (0x48e4)
@   0x080046be: 2200        movs	r2, #0
@   0x080046c0: 2102        movs	r1, #2
@   0x080046c2: 7181        strb	r1, [r0, #6]
@   0x080046c4: 769a        strb	r2, [r3, #26]
@   0x080046c6: 895d        ldrh	r5, [r3, #10]
@   0x080046c8: 2d03        cmp	r5, #3
@   0x080046ca: d110        bne.n	0x46ee
@   0x080046cc: 2108        movs	r1, #8
@   0x080046ce: 5e58        ldrsh	r0, [r3, r1]
@   0x080046d0: 280d        cmp	r0, #13
@   0x080046d2: d007        beq.n	0x46e4
@   0x080046d4: 2810        cmp	r0, #16
@   0x080046d6: d005        beq.n	0x46e4
@   0x080046d8: 2812        cmp	r0, #18
@   0x080046da: d003        beq.n	0x46e4
@   0x080046dc: 2813        cmp	r0, #19
@   0x080046de: d001        beq.n	0x46e4
@   0x080046e0: 2814        cmp	r0, #20
@   0x080046e2: d104        bne.n	0x46ee
@   0x080046e4: 487f        ldr	r0, [pc, #508]	@ (0x48e4)
@   0x080046e6: 2200        movs	r2, #0
@   0x080046e8: 2102        movs	r1, #2
@   0x080046ea: 7181        strb	r1, [r0, #6]
@   0x080046ec: 769a        strb	r2, [r3, #26]
@   0x080046ee: 895a        ldrh	r2, [r3, #10]
@   0x080046f0: 2a05        cmp	r2, #5
@   0x080046f2: d111        bne.n	0x4718
@   0x080046f4: 8919        ldrh	r1, [r3, #8]
@   0x080046f6: 1c08        adds	r0, r1, #0
@   0x080046f8: 380c        subs	r0, #12
@   0x080046fa: 0400        lsls	r0, r0, #16
@   0x080046fc: 0c00        lsrs	r0, r0, #16
@   0x080046fe: 2804        cmp	r0, #4
@   0x08004700: d905        bls.n	0x470e
@   0x08004702: 0408        lsls	r0, r1, #16
@   0x08004704: 1400        asrs	r0, r0, #16
@   0x08004706: 2813        cmp	r0, #19
@   0x08004708: d001        beq.n	0x470e
@   0x0800470a: 2814        cmp	r0, #20
@   0x0800470c: d104        bne.n	0x4718
@   0x0800470e: 4875        ldr	r0, [pc, #468]	@ (0x48e4)
@   0x08004710: 2200        movs	r2, #0
@   0x08004712: 2102        movs	r1, #2
@   0x08004714: 7181        strb	r1, [r0, #6]
@   0x08004716: 769a        strb	r2, [r3, #26]
@   0x08004718: 8918        ldrh	r0, [r3, #8]
@   0x0800471a: 380e        subs	r0, #14
@   0x0800471c: 0400        lsls	r0, r0, #16
@   0x0800471e: 0c00        lsrs	r0, r0, #16
@   0x08004720: 2801        cmp	r0, #1
@   0x08004722: d807        bhi.n	0x4734
@   0x08004724: 250a        movs	r5, #10
@   0x08004726: 5f5a        ldrsh	r2, [r3, r5]
@   0x08004728: 2a03        cmp	r2, #3
@   0x0800472a: d103        bne.n	0x4734
@   0x0800472c: 486d        ldr	r0, [pc, #436]	@ (0x48e4)
@   0x0800472e: 2100        movs	r1, #0
@   0x08004730: 7182        strb	r2, [r0, #6]
@   0x08004732: 7699        strb	r1, [r3, #26]
@   0x08004734: 8918        ldrh	r0, [r3, #8]
@   0x08004736: 3811        subs	r0, #17
@   0x08004738: 0400        lsls	r0, r0, #16
@   0x0800473a: 0c00        lsrs	r0, r0, #16
@   0x0800473c: 2801        cmp	r0, #1
@   0x0800473e: d807        bhi.n	0x4750
@   0x08004740: 8958        ldrh	r0, [r3, #10]
@   0x08004742: 2805        cmp	r0, #5
@   0x08004744: d104        bne.n	0x4750
@   0x08004746: 4867        ldr	r0, [pc, #412]	@ (0x48e4)
@   0x08004748: 2200        movs	r2, #0
@   0x0800474a: 2103        movs	r1, #3
@   0x0800474c: 7181        strb	r1, [r0, #6]
@   0x0800474e: 769a        strb	r2, [r3, #26]
@   0x08004750: 8918        ldrh	r0, [r3, #8]
@   0x08004752: 380c        subs	r0, #12
@   0x08004754: 0400        lsls	r0, r0, #16
@   0x08004756: 0c00        lsrs	r0, r0, #16
@   0x08004758: 2809        cmp	r0, #9
@   0x0800475a: d807        bhi.n	0x476c
@   0x0800475c: 8959        ldrh	r1, [r3, #10]
@   0x0800475e: 2904        cmp	r1, #4
@   0x08004760: d104        bne.n	0x476c
@   0x08004762: 4860        ldr	r0, [pc, #384]	@ (0x48e4)
@   0x08004764: 2200        movs	r2, #0
@   0x08004766: 2103        movs	r1, #3
@   0x08004768: 7181        strb	r1, [r0, #6]
@   0x0800476a: 769a        strb	r2, [r3, #26]
@   0x0800476c: 6899        ldr	r1, [r3, #8]
@   0x0800476e: 485e        ldr	r0, [pc, #376]	@ (0x48e8)
@   0x08004770: 4281        cmp	r1, r0
@   0x08004772: d008        beq.n	0x4786
@   0x08004774: 485d        ldr	r0, [pc, #372]	@ (0x48ec)
@   0x08004776: 4281        cmp	r1, r0
@   0x08004778: d005        beq.n	0x4786
@   0x0800477a: 485d        ldr	r0, [pc, #372]	@ (0x48f0)
@   0x0800477c: 4281        cmp	r1, r0
@   0x0800477e: d002        beq.n	0x4786
@   0x08004780: 3001        adds	r0, #1
@   0x08004782: 4281        cmp	r1, r0
@   0x08004784: d105        bne.n	0x4792
@   0x08004786: 4957        ldr	r1, [pc, #348]	@ (0x48e4)
@   0x08004788: 2200        movs	r2, #0
@   0x0800478a: 2003        movs	r0, #3
@   0x0800478c: 7188        strb	r0, [r1, #6]
@   0x0800478e: 4854        ldr	r0, [pc, #336]	@ (0x48e0)
@   0x08004790: 7682        strb	r2, [r0, #26]
@   0x08004792: 4953        ldr	r1, [pc, #332]	@ (0x48e0)
@   0x08004794: 894a        ldrh	r2, [r1, #10]
@   0x08004796: 2a17        cmp	r2, #23
@   0x08004798: d11f        bne.n	0x47da
@   0x0800479a: 4852        ldr	r0, [pc, #328]	@ (0x48e4)
@   0x0800479c: 7e83        ldrb	r3, [r0, #26]
@   0x0800479e: 2b03        cmp	r3, #3
@   0x080047a0: d809        bhi.n	0x47b6
@   0x080047a2: 8840        ldrh	r0, [r0, #2]
@   0x080047a4: 38d8        subs	r0, #216	@ 0xd8
@   0x080047a6: 0400        lsls	r0, r0, #16
@   0x080047a8: 0c00        lsrs	r0, r0, #16
@   0x080047aa: 280b        cmp	r0, #11
@   0x080047ac: d803        bhi.n	0x47b6
@   0x080047ae: 1c08        adds	r0, r1, #0
@   0x080047b0: 2102        movs	r1, #2
@   0x080047b2: f002        f9ef 	bl	0x6b94
@   0x080047b6: 494a        ldr	r1, [pc, #296]	@ (0x48e0)
@   0x080047b8: 894d        ldrh	r5, [r1, #10]
@   0x080047ba: 2d17        cmp	r5, #23
@   0x080047bc: d10d        bne.n	0x47da
@   0x080047be: 4849        ldr	r0, [pc, #292]	@ (0x48e4)
@   0x080047c0: 7e82        ldrb	r2, [r0, #26]
@   0x080047c2: 2a03        cmp	r2, #3
@   0x080047c4: d809        bhi.n	0x47da
@   0x080047c6: 8840        ldrh	r0, [r0, #2]
@   0x080047c8: 3848        subs	r0, #72	@ 0x48
@   0x080047ca: 0400        lsls	r0, r0, #16
@   0x080047cc: 0c00        lsrs	r0, r0, #16
@   0x080047ce: 280b        cmp	r0, #11
@   0x080047d0: d803        bhi.n	0x47da
@   0x080047d2: 1c08        adds	r0, r1, #0
@   0x080047d4: 2102        movs	r1, #2
@   0x080047d6: f002        f9dd 	bl	0x6b94
@   0x080047da: 4941        ldr	r1, [pc, #260]	@ (0x48e0)
@   0x080047dc: 894b        ldrh	r3, [r1, #10]
@   0x080047de: 2b15        cmp	r3, #21
@   0x080047e0: d120        bne.n	0x4824
@   0x080047e2: 4840        ldr	r0, [pc, #256]	@ (0x48e4)
@   0x080047e4: 7e85        ldrb	r5, [r0, #26]
@   0x080047e6: 2d03        cmp	r5, #3
@   0x080047e8: d809        bhi.n	0x47fe
@   0x080047ea: 8840        ldrh	r0, [r0, #2]
@   0x080047ec: 3883        subs	r0, #131	@ 0x83
@   0x080047ee: 0400        lsls	r0, r0, #16
@   0x080047f0: 0c00        lsrs	r0, r0, #16
@   0x080047f2: 280d        cmp	r0, #13
@   0x080047f4: d803        bhi.n	0x47fe
@   0x080047f6: 1c08        adds	r0, r1, #0
@   0x080047f8: 2102        movs	r1, #2
@   0x080047fa: f002        f9cb 	bl	0x6b94
@   0x080047fe: 4938        ldr	r1, [pc, #224]	@ (0x48e0)
@   0x08004800: 8948        ldrh	r0, [r1, #10]
@   0x08004802: 2815        cmp	r0, #21
@   0x08004804: d10e        bne.n	0x4824
@   0x08004806: 4837        ldr	r0, [pc, #220]	@ (0x48e4)
@   0x08004808: 7e82        ldrb	r2, [r0, #26]
@   0x0800480a: 2a03        cmp	r2, #3
@   0x0800480c: d80a        bhi.n	0x4824
@   0x0800480e: 8840        ldrh	r0, [r0, #2]
@   0x08004810: 4b38        ldr	r3, [pc, #224]	@ (0x48f4)
@   0x08004812: 18c0        adds	r0, r0, r3
@   0x08004814: 0400        lsls	r0, r0, #16
@   0x08004816: 0c00        lsrs	r0, r0, #16
@   0x08004818: 280d        cmp	r0, #13
@   0x0800481a: d803        bhi.n	0x4824
@   0x0800481c: 1c08        adds	r0, r1, #0
@   0x0800481e: 2102        movs	r1, #2
@   0x08004820: f002        f9b8 	bl	0x6b94
@   0x08004824: 492e        ldr	r1, [pc, #184]	@ (0x48e0)
@   0x08004826: 894d        ldrh	r5, [r1, #10]
@   0x08004828: 2d03        cmp	r5, #3
@   0x0800482a: d121        bne.n	0x4870
@   0x0800482c: 482d        ldr	r0, [pc, #180]	@ (0x48e4)
@   0x0800482e: 7e82        ldrb	r2, [r0, #26]
@   0x08004830: 2a03        cmp	r2, #3
@   0x08004832: d80a        bhi.n	0x484a
@   0x08004834: 8840        ldrh	r0, [r0, #2]
@   0x08004836: 4b30        ldr	r3, [pc, #192]	@ (0x48f8)
@   0x08004838: 18c0        adds	r0, r0, r3
@   0x0800483a: 0400        lsls	r0, r0, #16
@   0x0800483c: 0c00        lsrs	r0, r0, #16
@   0x0800483e: 2808        cmp	r0, #8
@   0x08004840: d803        bhi.n	0x484a
@   0x08004842: 1c08        adds	r0, r1, #0
@   0x08004844: 2102        movs	r1, #2
@   0x08004846: f002        f9a5 	bl	0x6b94
@   0x0800484a: 4925        ldr	r1, [pc, #148]	@ (0x48e0)
@   0x0800484c: 894d        ldrh	r5, [r1, #10]
@   0x0800484e: 2d03        cmp	r5, #3
@   0x08004850: d10e        bne.n	0x4870
@   0x08004852: 4824        ldr	r0, [pc, #144]	@ (0x48e4)
@   0x08004854: 7e82        ldrb	r2, [r0, #26]
@   0x08004856: 2a03        cmp	r2, #3
@   0x08004858: d80a        bhi.n	0x4870
@   0x0800485a: 8840        ldrh	r0, [r0, #2]
@   0x0800485c: 4b27        ldr	r3, [pc, #156]	@ (0x48fc)
@   0x0800485e: 18c0        adds	r0, r0, r3
@   0x08004860: 0400        lsls	r0, r0, #16
@   0x08004862: 0c00        lsrs	r0, r0, #16
@   0x08004864: 2805        cmp	r0, #5
@   0x08004866: d803        bhi.n	0x4870
@   0x08004868: 1c08        adds	r0, r1, #0
@   0x0800486a: 2102        movs	r1, #2
@   0x0800486c: f002        f992 	bl	0x6b94
@   0x08004870: 491b        ldr	r1, [pc, #108]	@ (0x48e0)
@   0x08004872: 894d        ldrh	r5, [r1, #10]
@   0x08004874: 2d05        cmp	r5, #5
@   0x08004876: d121        bne.n	0x48bc
@   0x08004878: 481a        ldr	r0, [pc, #104]	@ (0x48e4)
@   0x0800487a: 7e82        ldrb	r2, [r0, #26]
@   0x0800487c: 2a03        cmp	r2, #3
@   0x0800487e: d80a        bhi.n	0x4896
@   0x08004880: 8840        ldrh	r0, [r0, #2]
@   0x08004882: 4b1f        ldr	r3, [pc, #124]	@ (0x4900)
@   0x08004884: 18c0        adds	r0, r0, r3
@   0x08004886: 0400        lsls	r0, r0, #16
@   0x08004888: 0c00        lsrs	r0, r0, #16
@   0x0800488a: 2806        cmp	r0, #6
@   0x0800488c: d803        bhi.n	0x4896
@   0x0800488e: 1c08        adds	r0, r1, #0
@   0x08004890: 2102        movs	r1, #2
@   0x08004892: f002        f97f 	bl	0x6b94
@   0x08004896: 4912        ldr	r1, [pc, #72]	@ (0x48e0)
@   0x08004898: 894d        ldrh	r5, [r1, #10]
@   0x0800489a: 2d05        cmp	r5, #5
@   0x0800489c: d10e        bne.n	0x48bc
@   0x0800489e: 4811        ldr	r0, [pc, #68]	@ (0x48e4)
@   0x080048a0: 7e82        ldrb	r2, [r0, #26]
@   0x080048a2: 2a03        cmp	r2, #3
@   0x080048a4: d80a        bhi.n	0x48bc
@   0x080048a6: 8840        ldrh	r0, [r0, #2]
@   0x080048a8: 4b16        ldr	r3, [pc, #88]	@ (0x4904)
@   0x080048aa: 18c0        adds	r0, r0, r3
@   0x080048ac: 0400        lsls	r0, r0, #16
@   0x080048ae: 0c00        lsrs	r0, r0, #16
@   0x080048b0: 2805        cmp	r0, #5
@   0x080048b2: d803        bhi.n	0x48bc
@   0x080048b4: 1c08        adds	r0, r1, #0
@   0x080048b6: 2102        movs	r1, #2
@   0x080048b8: f002        f96c 	bl	0x6b94
@   0x080048bc: 4d08        ldr	r5, [pc, #32]	@ (0x48e0)
@   0x080048be: 8928        ldrh	r0, [r5, #8]
@   0x080048c0: 3806        subs	r0, #6
@   0x080048c2: 0400        lsls	r0, r0, #16
@   0x080048c4: 0c00        lsrs	r0, r0, #16
@   0x080048c6: 2804        cmp	r0, #4
@   0x080048c8: d831        bhi.n	0x492e
@   0x080048ca: 4c06        ldr	r4, [pc, #24]	@ (0x48e4)
@   0x080048cc: 7ea0        ldrb	r0, [r4, #26]
@   0x080048ce: 2803        cmp	r0, #3
@   0x080048d0: d82d        bhi.n	0x492e
@   0x080048d2: 88a0        ldrh	r0, [r4, #4]
@   0x080048d4: 3860        subs	r0, #96	@ 0x60
@   0x080048d6: 0400        lsls	r0, r0, #16
@   0x080048d8: 0c00        lsrs	r0, r0, #16
@   0x080048da: 280b        cmp	r0, #11
@   0x080048dc: e014        b.n	0x4908
@   0x080048de: 0000        movs	r0, r0
@   0x080048e0: 35e0        adds	r5, #224	@ 0xe0
@   0x080048e2: 0300        lsls	r0, r0, #12
@   0x080048e4: 3720        adds	r7, #32
@   0x080048e6: 0300        lsls	r0, r0, #12
@   0x080048e8: 0010        movs	r0, r2
@   0x080048ea: 0001        movs	r1, r0
@   0x080048ec: 000b        movs	r3, r1
@   0x080048ee: 0005        movs	r5, r0
@   0x080048f0: 000e        movs	r6, r1
@   0x080048f2: 0007        movs	r7, r0
@   0x080048f4: fed5        ffff 			@ <UNDEFINED> instruction: 0xfed5ffff
@   0x080048f8: feb8        ffff 			@ <UNDEFINED> instruction: 0xfeb8ffff
@   0x080048fc: fe80        ffff 			@ <UNDEFINED> instruction: 0xfe80ffff
@   0x08004900: fe6e        ffff 			@ <UNDEFINED> instruction: 0xfe6effff
@   0x08004904: fe38        ffff 			@ <UNDEFINED> instruction: 0xfe38ffff
@   0x08004908: d803        bhi.n	0x4912
@   0x0800490a: 1c28        adds	r0, r5, #0
@   0x0800490c: 2102        movs	r1, #2
@   0x0800490e: f002        f941 	bl	0x6b94
@   0x08004912: 7ea1        ldrb	r1, [r4, #26]
@   0x08004914: 2903        cmp	r1, #3
@   0x08004916: d80a        bhi.n	0x492e
@   0x08004918: 88a4        ldrh	r4, [r4, #4]
@   0x0800491a: 4a06        ldr	r2, [pc, #24]	@ (0x4934)
@   0x0800491c: 18a0        adds	r0, r4, r2
@   0x0800491e: 0400        lsls	r0, r0, #16
@   0x08004920: 0c00        lsrs	r0, r0, #16
@   0x08004922: 2823        cmp	r0, #35	@ 0x23
@   0x08004924: d803        bhi.n	0x492e
@   0x08004926: 1c28        adds	r0, r5, #0
@   0x08004928: 2102        movs	r1, #2
@   0x0800492a: f002        f933 	bl	0x6b94
@   0x0800492e: bcf0        pop	{r4, r5, r6, r7}
@   0x08004930: bc01        pop	{r0}
@   0x08004932: 4700        bx	r0
@   0x08004934: fed3        ffff 			@ <UNDEFINED> instruction: 0xfed3ffff

        thumb_func_start sub_080045EC
sub_080045EC: @ 0x080045ec
        .incbin "frog_us_baserom.gba", 0x45ec, 0x34c
        thumb_func_end sub_080045EC
