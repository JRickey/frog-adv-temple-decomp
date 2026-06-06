@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800f814, 0x0800fcc8)  (1204 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800f814 --end 0x800fcc8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800f814: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800f816: 4657        mov	r7, sl
@   0x0800f818: 464e        mov	r6, r9
@   0x0800f81a: 4645        mov	r5, r8
@   0x0800f81c: b4e0        push	{r5, r6, r7}
@   0x0800f81e: b08d        sub	sp, #52	@ 0x34
@   0x0800f820: 0600        lsls	r0, r0, #24
@   0x0800f822: 0e00        lsrs	r0, r0, #24
@   0x0800f824: 9000        str	r0, [sp, #0]
@   0x0800f826: 2000        movs	r0, #0
@   0x0800f828: e234        b.n	0xfc94
@   0x0800f82a: 9a03        ldr	r2, [sp, #12]
@   0x0800f82c: 2a01        cmp	r2, #1
@   0x0800f82e: d00c        beq.n	0xf84a
@   0x0800f830: 2a01        cmp	r2, #1
@   0x0800f832: dc02        bgt.n	0xf83a
@   0x0800f834: 2a00        cmp	r2, #0
@   0x0800f836: d004        beq.n	0xf842
@   0x0800f838: e00e        b.n	0xf858
@   0x0800f83a: 9b03        ldr	r3, [sp, #12]
@   0x0800f83c: 2b02        cmp	r3, #2
@   0x0800f83e: d009        beq.n	0xf854
@   0x0800f840: e00a        b.n	0xf858
@   0x0800f842: 2680        movs	r6, #128	@ 0x80
@   0x0800f844: 04b6        lsls	r6, r6, #18
@   0x0800f846: 9604        str	r6, [sp, #16]
@   0x0800f848: e006        b.n	0xf858
@   0x0800f84a: 4f01        ldr	r7, [pc, #4]	@ (0xf850)
@   0x0800f84c: 9704        str	r7, [sp, #16]
@   0x0800f84e: e003        b.n	0xf858
@   0x0800f850: 0000        movs	r0, r0
@   0x0800f852: 0201        lsls	r1, r0, #8
@   0x0800f854: 4805        ldr	r0, [pc, #20]	@ (0xf86c)
@   0x0800f856: 9004        str	r0, [sp, #16]
@   0x0800f858: 9904        ldr	r1, [sp, #16]
@   0x0800f85a: 9101        str	r1, [sp, #4]
@   0x0800f85c: 9a03        ldr	r2, [sp, #12]
@   0x0800f85e: 2a01        cmp	r2, #1
@   0x0800f860: d010        beq.n	0xf884
@   0x0800f862: 2a01        cmp	r2, #1
@   0x0800f864: dc04        bgt.n	0xf870
@   0x0800f866: 2a00        cmp	r2, #0
@   0x0800f868: d006        beq.n	0xf878
@   0x0800f86a: e013        b.n	0xf894
@   0x0800f86c: 0000        movs	r0, r0
@   0x0800f86e: 0202        lsls	r2, r0, #8
@   0x0800f870: 9b03        ldr	r3, [sp, #12]
@   0x0800f872: 2b02        cmp	r3, #2
@   0x0800f874: d00c        beq.n	0xf890
@   0x0800f876: e00d        b.n	0xf894
@   0x0800f878: 4e01        ldr	r6, [pc, #4]	@ (0xf880)
@   0x0800f87a: 9605        str	r6, [sp, #20]
@   0x0800f87c: e00a        b.n	0xf894
@   0x0800f87e: 0000        movs	r0, r0
@   0x0800f880: e000        b.n	0xf884
@   0x0800f882: 0600        lsls	r0, r0, #24
@   0x0800f884: 4f01        ldr	r7, [pc, #4]	@ (0xf88c)
@   0x0800f886: 9705        str	r7, [sp, #20]
@   0x0800f888: e004        b.n	0xf894
@   0x0800f88a: 0000        movs	r0, r0
@   0x0800f88c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0800f890: 480e        ldr	r0, [pc, #56]	@ (0xf8cc)
@   0x0800f892: 9005        str	r0, [sp, #20]
@   0x0800f894: 9905        ldr	r1, [sp, #20]
@   0x0800f896: 9102        str	r1, [sp, #8]
@   0x0800f898: 4c0d        ldr	r4, [pc, #52]	@ (0xf8d0)
@   0x0800f89a: 9b03        ldr	r3, [sp, #12]
@   0x0800f89c: 015a        lsls	r2, r3, #5
@   0x0800f89e: 1c21        adds	r1, r4, #0
@   0x0800f8a0: 3110        adds	r1, #16
@   0x0800f8a2: 1851        adds	r1, r2, r1
@   0x0800f8a4: 1c20        adds	r0, r4, #0
@   0x0800f8a6: 3008        adds	r0, #8
@   0x0800f8a8: 1810        adds	r0, r2, r0
@   0x0800f8aa: 6809        ldr	r1, [r1, #0]
@   0x0800f8ac: 6803        ldr	r3, [r0, #0]
@   0x0800f8ae: 920c        str	r2, [sp, #48]	@ 0x30
@   0x0800f8b0: 9e03        ldr	r6, [sp, #12]
@   0x0800f8b2: 3601        adds	r6, #1
@   0x0800f8b4: 960b        str	r6, [sp, #44]	@ 0x2c
@   0x0800f8b6: 4299        cmp	r1, r3
@   0x0800f8b8: d100        bne.n	0xf8bc
@   0x0800f8ba: e1e8        b.n	0xfc8e
@   0x0800f8bc: 1ac8        subs	r0, r1, r3
@   0x0800f8be: 0fc2        lsrs	r2, r0, #31
@   0x0800f8c0: 2a00        cmp	r2, #0
@   0x0800f8c2: d007        beq.n	0xf8d4
@   0x0800f8c4: 2a01        cmp	r2, #1
@   0x0800f8c6: d100        bne.n	0xf8ca
@   0x0800f8c8: e0fa        b.n	0xfac0
@   0x0800f8ca: e1e0        b.n	0xfc8e
@   0x0800f8cc: f000        0600 	and.w	r6, r0, #0
@   0x0800f8d0: 60a0        str	r0, [r4, #8]
@   0x0800f8d2: 0300        lsls	r0, r0, #12
@   0x0800f8d4: 0400        lsls	r0, r0, #16
@   0x0800f8d6: 0c00        lsrs	r0, r0, #16
@   0x0800f8d8: 4682        mov	sl, r0
@   0x0800f8da: 2800        cmp	r0, #0
@   0x0800f8dc: d100        bne.n	0xf8e0
@   0x0800f8de: e1d6        b.n	0xfc8e
@   0x0800f8e0: 9f0c        ldr	r7, [sp, #48]	@ 0x30
@   0x0800f8e2: 9706        str	r7, [sp, #24]
@   0x0800f8e4: 1c38        adds	r0, r7, #0
@   0x0800f8e6: 4970        ldr	r1, [pc, #448]	@ (0xfaa8)
@   0x0800f8e8: 1846        adds	r6, r0, r1
@   0x0800f8ea: 1c08        adds	r0, r1, #0
@   0x0800f8ec: 3004        adds	r0, #4
@   0x0800f8ee: 1c3a        adds	r2, r7, #0
@   0x0800f8f0: 1810        adds	r0, r2, r0
@   0x0800f8f2: 9007        str	r0, [sp, #28]
@   0x0800f8f4: 486c        ldr	r0, [pc, #432]	@ (0xfaa8)
@   0x0800f8f6: 3010        adds	r0, #16
@   0x0800f8f8: 9b06        ldr	r3, [sp, #24]
@   0x0800f8fa: 1818        adds	r0, r3, r0
@   0x0800f8fc: 8b37        ldrh	r7, [r6, #24]
@   0x0800f8fe: 00f9        lsls	r1, r7, #3
@   0x0800f900: 39a0        subs	r1, #160	@ 0xa0
@   0x0800f902: 6800        ldr	r0, [r0, #0]
@   0x0800f904: 4655        mov	r5, sl
@   0x0800f906: 3d01        subs	r5, #1
@   0x0800f908: 4288        cmp	r0, r1
@   0x0800f90a: dd00        ble.n	0xf90e
@   0x0800f90c: e0c5        b.n	0xfa9a
@   0x0800f90e: 8af0        ldrh	r0, [r6, #22]
@   0x0800f910: 3001        adds	r0, #1
@   0x0800f912: 27ff        movs	r7, #255	@ 0xff
@   0x0800f914: 4038        ands	r0, r7
@   0x0800f916: 82f0        strh	r0, [r6, #22]
@   0x0800f918: 4863        ldr	r0, [pc, #396]	@ (0xfaa8)
@   0x0800f91a: 3008        adds	r0, #8
@   0x0800f91c: 990c        ldr	r1, [sp, #48]	@ 0x30
@   0x0800f91e: 180c        adds	r4, r1, r0
@   0x0800f920: 6820        ldr	r0, [r4, #0]
@   0x0800f922: 3001        adds	r0, #1
@   0x0800f924: 6020        str	r0, [r4, #0]
@   0x0800f926: 2001        movs	r0, #1
@   0x0800f928: 9903        ldr	r1, [sp, #12]
@   0x0800f92a: f7ff        fce5 	bl	0xf2f8
@   0x0800f92e: 8af3        ldrh	r3, [r6, #22]
@   0x0800f930: 2007        movs	r0, #7
@   0x0800f932: 4018        ands	r0, r3
@   0x0800f934: 2800        cmp	r0, #0
@   0x0800f936: d000        beq.n	0xf93a
@   0x0800f938: e0af        b.n	0xfa9a
@   0x0800f93a: 6821        ldr	r1, [r4, #0]
@   0x0800f93c: 2937        cmp	r1, #55	@ 0x37
@   0x0800f93e: dc00        bgt.n	0xf942
@   0x0800f940: e0ab        b.n	0xfa9a
@   0x0800f942: 8b32        ldrh	r2, [r6, #24]
@   0x0800f944: 00d0        lsls	r0, r2, #3
@   0x0800f946: 38d0        subs	r0, #208	@ 0xd0
@   0x0800f948: 4281        cmp	r1, r0
@   0x0800f94a: dd00        ble.n	0xf94e
@   0x0800f94c: e0a5        b.n	0xfa9a
@   0x0800f94e: 2020        movs	r0, #32
@   0x0800f950: 4681        mov	r9, r0
@   0x0800f952: 9801        ldr	r0, [sp, #4]
@   0x0800f954: 4680        mov	r8, r0
@   0x0800f956: 9c02        ldr	r4, [sp, #8]
@   0x0800f958: 1c08        adds	r0, r1, #0
@   0x0800f95a: 2800        cmp	r0, #0
@   0x0800f95c: da00        bge.n	0xf960
@   0x0800f95e: 3007        adds	r0, #7
@   0x0800f960: 10c0        asrs	r0, r0, #3
@   0x0800f962: 3019        adds	r0, #25
@   0x0800f964: 8b72        ldrh	r2, [r6, #26]
@   0x0800f966: 4350        muls	r0, r2
@   0x0800f968: 0400        lsls	r0, r0, #16
@   0x0800f96a: 0c00        lsrs	r0, r0, #16
@   0x0800f96c: 4684        mov	ip, r0
@   0x0800f96e: 1c18        adds	r0, r3, #0
@   0x0800f970: 3838        subs	r0, #56	@ 0x38
@   0x0800f972: 4038        ands	r0, r7
@   0x0800f974: 10c0        asrs	r0, r0, #3
@   0x0800f976: 0141        lsls	r1, r0, #5
@   0x0800f978: 1c08        adds	r0, r1, #0
@   0x0800f97a: 1280        asrs	r0, r0, #10
@   0x0800f97c: 0280        lsls	r0, r0, #10
@   0x0800f97e: 1a08        subs	r0, r1, r0
@   0x0800f980: 0400        lsls	r0, r0, #16
@   0x0800f982: 0c05        lsrs	r5, r0, #16
@   0x0800f984: 4949        ldr	r1, [pc, #292]	@ (0xfaac)
@   0x0800f986: 9b03        ldr	r3, [sp, #12]
@   0x0800f988: 0118        lsls	r0, r3, #4
@   0x0800f98a: 1840        adds	r0, r0, r1
@   0x0800f98c: 2102        movs	r1, #2
@   0x0800f98e: 5e40        ldrsh	r0, [r0, r1]
@   0x0800f990: 281e        cmp	r0, #30
@   0x0800f992: dd03        ble.n	0xf99c
@   0x0800f994: 4846        ldr	r0, [pc, #280]	@ (0xfab0)
@   0x0800f996: 7940        ldrb	r0, [r0, #5]
@   0x0800f998: 2800        cmp	r0, #0
@   0x0800f99a: d150        bne.n	0xfa3e
@   0x0800f99c: 9807        ldr	r0, [sp, #28]
@   0x0800f99e: 6803        ldr	r3, [r0, #0]
@   0x0800f9a0: 2b0f        cmp	r3, #15
@   0x0800f9a2: dd24        ble.n	0xf9ee
@   0x0800f9a4: 00d0        lsls	r0, r2, #3
@   0x0800f9a6: 38f8        subs	r0, #248	@ 0xf8
@   0x0800f9a8: 4a3f        ldr	r2, [pc, #252]	@ (0xfaa8)
@   0x0800f9aa: 4283        cmp	r3, r0
@   0x0800f9ac: dc27        bgt.n	0xf9fe
@   0x0800f9ae: 1c19        adds	r1, r3, #0
@   0x0800f9b0: 3910        subs	r1, #16
@   0x0800f9b2: 2900        cmp	r1, #0
@   0x0800f9b4: da00        bge.n	0xf9b8
@   0x0800f9b6: 3107        adds	r1, #7
@   0x0800f9b8: 10c9        asrs	r1, r1, #3
@   0x0800f9ba: 3101        adds	r1, #1
@   0x0800f9bc: 4662        mov	r2, ip
@   0x0800f9be: 0410        lsls	r0, r2, #16
@   0x0800f9c0: 1400        asrs	r0, r0, #16
@   0x0800f9c2: 1840        adds	r0, r0, r1
@   0x0800f9c4: 0400        lsls	r0, r0, #16
@   0x0800f9c6: 0c00        lsrs	r0, r0, #16
@   0x0800f9c8: 4684        mov	ip, r0
@   0x0800f9ca: 8ab1        ldrh	r1, [r6, #20]
@   0x0800f9cc: 3910        subs	r1, #16
@   0x0800f9ce: 4039        ands	r1, r7
@   0x0800f9d0: 1c08        adds	r0, r1, #0
@   0x0800f9d2: 10c3        asrs	r3, r0, #3
@   0x0800f9d4: 1c5a        adds	r2, r3, #1
@   0x0800f9d6: 1c10        adds	r0, r2, #0
@   0x0800f9d8: 1280        asrs	r0, r0, #10
@   0x0800f9da: 0280        lsls	r0, r0, #10
@   0x0800f9dc: 1a10        subs	r0, r2, r0
@   0x0800f9de: 1828        adds	r0, r5, r0
@   0x0800f9e0: 0400        lsls	r0, r0, #16
@   0x0800f9e2: 0c05        lsrs	r5, r0, #16
@   0x0800f9e4: 201f        movs	r0, #31
@   0x0800f9e6: 1ac0        subs	r0, r0, r3
@   0x0800f9e8: 0400        lsls	r0, r0, #16
@   0x0800f9ea: 0c00        lsrs	r0, r0, #16
@   0x0800f9ec: 4681        mov	r9, r0
@   0x0800f9ee: 8b71        ldrh	r1, [r6, #26]
@   0x0800f9f0: 00c8        lsls	r0, r1, #3
@   0x0800f9f2: 38f8        subs	r0, #248	@ 0xf8
@   0x0800f9f4: 9a07        ldr	r2, [sp, #28]
@   0x0800f9f6: 6811        ldr	r1, [r2, #0]
@   0x0800f9f8: 4a2b        ldr	r2, [pc, #172]	@ (0xfaa8)
@   0x0800f9fa: 4281        cmp	r1, r0
@   0x0800f9fc: dd1f        ble.n	0xfa3e
@   0x0800f9fe: 482d        ldr	r0, [pc, #180]	@ (0xfab4)
@   0x0800fa00: 4460        add	r0, ip
@   0x0800fa02: 9b0c        ldr	r3, [sp, #48]	@ 0x30
@   0x0800fa04: 1899        adds	r1, r3, r2
@   0x0800fa06: 8b4f        ldrh	r7, [r1, #26]
@   0x0800fa08: 1838        adds	r0, r7, r0
@   0x0800fa0a: 0400        lsls	r0, r0, #16
@   0x0800fa0c: 0c00        lsrs	r0, r0, #16
@   0x0800fa0e: 4684        mov	ip, r0
@   0x0800fa10: 8b4a        ldrh	r2, [r1, #26]
@   0x0800fa12: 1c13        adds	r3, r2, #0
@   0x0800fa14: 3b20        subs	r3, #32
@   0x0800fa16: 1c18        adds	r0, r3, #0
@   0x0800fa18: 2b00        cmp	r3, #0
@   0x0800fa1a: da00        bge.n	0xfa1e
@   0x0800fa1c: 1e50        subs	r0, r2, #1
@   0x0800fa1e: 1140        asrs	r0, r0, #5
@   0x0800fa20: 0140        lsls	r0, r0, #5
@   0x0800fa22: 1a18        subs	r0, r3, r0
@   0x0800fa24: 1828        adds	r0, r5, r0
@   0x0800fa26: 0400        lsls	r0, r0, #16
@   0x0800fa28: 0c05        lsrs	r5, r0, #16
@   0x0800fa2a: 8a89        ldrh	r1, [r1, #20]
@   0x0800fa2c: 3910        subs	r1, #16
@   0x0800fa2e: 20ff        movs	r0, #255	@ 0xff
@   0x0800fa30: 4001        ands	r1, r0
@   0x0800fa32: 10c9        asrs	r1, r1, #3
@   0x0800fa34: 2020        movs	r0, #32
@   0x0800fa36: 1a40        subs	r0, r0, r1
@   0x0800fa38: 0400        lsls	r0, r0, #16
@   0x0800fa3a: 0c00        lsrs	r0, r0, #16
@   0x0800fa3c: 4681        mov	r9, r0
@   0x0800fa3e: 4661        mov	r1, ip
@   0x0800fa40: 0048        lsls	r0, r1, #1
@   0x0800fa42: 4480        add	r8, r0
@   0x0800fa44: 0069        lsls	r1, r5, #1
@   0x0800fa46: 1864        adds	r4, r4, r1
@   0x0800fa48: 481b        ldr	r0, [pc, #108]	@ (0xfab8)
@   0x0800fa4a: 4285        cmp	r5, r0
@   0x0800fa4c: d903        bls.n	0xfa56
@   0x0800fa4e: 4a1b        ldr	r2, [pc, #108]	@ (0xfabc)
@   0x0800fa50: 1888        adds	r0, r1, r2
@   0x0800fa52: 9b02        ldr	r3, [sp, #8]
@   0x0800fa54: 181c        adds	r4, r3, r0
@   0x0800fa56: 2100        movs	r1, #0
@   0x0800fa58: 4655        mov	r5, sl
@   0x0800fa5a: 3d01        subs	r5, #1
@   0x0800fa5c: 2280        movs	r2, #128	@ 0x80
@   0x0800fa5e: 00d2        lsls	r2, r2, #3
@   0x0800fa60: 464f        mov	r7, r9
@   0x0800fa62: 2f00        cmp	r7, #0
@   0x0800fa64: d100        bne.n	0xfa68
@   0x0800fa66: 3c40        subs	r4, #64	@ 0x40
@   0x0800fa68: 9802        ldr	r0, [sp, #8]
@   0x0800fa6a: 4284        cmp	r4, r0
@   0x0800fa6c: d205        bcs.n	0xfa7a
@   0x0800fa6e: 1b00        subs	r0, r0, r4
@   0x0800fa70: 1040        asrs	r0, r0, #1
@   0x0800fa72: 1a10        subs	r0, r2, r0
@   0x0800fa74: 0040        lsls	r0, r0, #1
@   0x0800fa76: 9b02        ldr	r3, [sp, #8]
@   0x0800fa78: 181c        adds	r4, r3, r0
@   0x0800fa7a: 4647        mov	r7, r8
@   0x0800fa7c: 8838        ldrh	r0, [r7, #0]
@   0x0800fa7e: 8020        strh	r0, [r4, #0]
@   0x0800fa80: 3402        adds	r4, #2
@   0x0800fa82: 2002        movs	r0, #2
@   0x0800fa84: 4480        add	r8, r0
@   0x0800fa86: 4648        mov	r0, r9
@   0x0800fa88: 3801        subs	r0, #1
@   0x0800fa8a: 0400        lsls	r0, r0, #16
@   0x0800fa8c: 0c00        lsrs	r0, r0, #16
@   0x0800fa8e: 4681        mov	r9, r0
@   0x0800fa90: 1c48        adds	r0, r1, #1
@   0x0800fa92: 0400        lsls	r0, r0, #16
@   0x0800fa94: 0c01        lsrs	r1, r0, #16
@   0x0800fa96: 291f        cmp	r1, #31
@   0x0800fa98: d9e2        bls.n	0xfa60
@   0x0800fa9a: 0428        lsls	r0, r5, #16
@   0x0800fa9c: 0c00        lsrs	r0, r0, #16
@   0x0800fa9e: 4682        mov	sl, r0
@   0x0800faa0: 2800        cmp	r0, #0
@   0x0800faa2: d000        beq.n	0xfaa6
@   0x0800faa4: e726        b.n	0xf8f4
@   0x0800faa6: e0f2        b.n	0xfc8e
@   0x0800faa8: 60a0        str	r0, [r4, #8]
@   0x0800faaa: 0300        lsls	r0, r0, #12
@   0x0800faac: 63c0        str	r0, [r0, #60]	@ 0x3c
@   0x0800faae: 0300        lsls	r0, r0, #12
@   0x0800fab0: 3608        adds	r6, #8
@   0x0800fab2: 0300        lsls	r0, r0, #12
@   0x0800fab4: ffe0        0000 	vaddl.u32	q8, d0, d0
@   0x0800fab8: 03ff        lsls	r7, r7, #15
@   0x0800faba: 0000        movs	r0, r0
@   0x0800fabc: f800        ffff 	strb.w	pc, [r0, #255]!
@   0x0800fac0: 2800        cmp	r0, #0
@   0x0800fac2: db00        blt.n	0xfac6
@   0x0800fac4: e0e3        b.n	0xfc8e
@   0x0800fac6: 1a58        subs	r0, r3, r1
@   0x0800fac8: 0400        lsls	r0, r0, #16
@   0x0800faca: 0c00        lsrs	r0, r0, #16
@   0x0800facc: 4682        mov	sl, r0
@   0x0800face: 2800        cmp	r0, #0
@   0x0800fad0: d100        bne.n	0xfad4
@   0x0800fad2: e0dc        b.n	0xfc8e
@   0x0800fad4: 990c        ldr	r1, [sp, #48]	@ 0x30
@   0x0800fad6: 9108        str	r1, [sp, #32]
@   0x0800fad8: 4875        ldr	r0, [pc, #468]	@ (0xfcb0)
@   0x0800fada: 3004        adds	r0, #4
@   0x0800fadc: 1808        adds	r0, r1, r0
@   0x0800fade: 9009        str	r0, [sp, #36]	@ 0x24
@   0x0800fae0: 4a73        ldr	r2, [pc, #460]	@ (0xfcb0)
@   0x0800fae2: 188a        adds	r2, r1, r2
@   0x0800fae4: 920a        str	r2, [sp, #40]	@ 0x28
@   0x0800fae6: 4872        ldr	r0, [pc, #456]	@ (0xfcb0)
@   0x0800fae8: 3010        adds	r0, #16
@   0x0800faea: 9b08        ldr	r3, [sp, #32]
@   0x0800faec: 1818        adds	r0, r3, r0
@   0x0800faee: 6800        ldr	r0, [r0, #0]
@   0x0800faf0: 4655        mov	r5, sl
@   0x0800faf2: 3d01        subs	r5, #1
@   0x0800faf4: 2800        cmp	r0, #0
@   0x0800faf6: da00        bge.n	0xfafa
@   0x0800faf8: e0c3        b.n	0xfc82
@   0x0800fafa: 9f0c        ldr	r7, [sp, #48]	@ 0x30
@   0x0800fafc: 486c        ldr	r0, [pc, #432]	@ (0xfcb0)
@   0x0800fafe: 183e        adds	r6, r7, r0
@   0x0800fb00: 8af0        ldrh	r0, [r6, #22]
@   0x0800fb02: 3801        subs	r0, #1
@   0x0800fb04: 21ff        movs	r1, #255	@ 0xff
@   0x0800fb06: 4008        ands	r0, r1
@   0x0800fb08: 82f0        strh	r0, [r6, #22]
@   0x0800fb0a: 4869        ldr	r0, [pc, #420]	@ (0xfcb0)
@   0x0800fb0c: 3008        adds	r0, #8
@   0x0800fb0e: 183c        adds	r4, r7, r0
@   0x0800fb10: 6820        ldr	r0, [r4, #0]
@   0x0800fb12: 3801        subs	r0, #1
@   0x0800fb14: 6020        str	r0, [r4, #0]
@   0x0800fb16: 2001        movs	r0, #1
@   0x0800fb18: 9903        ldr	r1, [sp, #12]
@   0x0800fb1a: f7ff        fbed 	bl	0xf2f8
@   0x0800fb1e: 8af2        ldrh	r2, [r6, #22]
@   0x0800fb20: 2007        movs	r0, #7
@   0x0800fb22: 4010        ands	r0, r2
@   0x0800fb24: 2800        cmp	r0, #0
@   0x0800fb26: d000        beq.n	0xfb2a
@   0x0800fb28: e0ab        b.n	0xfc82
@   0x0800fb2a: 6821        ldr	r1, [r4, #0]
@   0x0800fb2c: 292f        cmp	r1, #47	@ 0x2f
@   0x0800fb2e: dc00        bgt.n	0xfb32
@   0x0800fb30: e0a7        b.n	0xfc82
@   0x0800fb32: 8b33        ldrh	r3, [r6, #24]
@   0x0800fb34: 00d8        lsls	r0, r3, #3
@   0x0800fb36: 38d8        subs	r0, #216	@ 0xd8
@   0x0800fb38: 4281        cmp	r1, r0
@   0x0800fb3a: dd00        ble.n	0xfb3e
@   0x0800fb3c: e0a1        b.n	0xfc82
@   0x0800fb3e: 2720        movs	r7, #32
@   0x0800fb40: 46b9        mov	r9, r7
@   0x0800fb42: 9801        ldr	r0, [sp, #4]
@   0x0800fb44: 4680        mov	r8, r0
@   0x0800fb46: 9c02        ldr	r4, [sp, #8]
@   0x0800fb48: 1c08        adds	r0, r1, #0
@   0x0800fb4a: 3830        subs	r0, #48	@ 0x30
@   0x0800fb4c: 2800        cmp	r0, #0
@   0x0800fb4e: da00        bge.n	0xfb52
@   0x0800fb50: 3007        adds	r0, #7
@   0x0800fb52: 10c0        asrs	r0, r0, #3
@   0x0800fb54: 8b77        ldrh	r7, [r6, #26]
@   0x0800fb56: 4378        muls	r0, r7
@   0x0800fb58: 0400        lsls	r0, r0, #16
@   0x0800fb5a: 0c00        lsrs	r0, r0, #16
@   0x0800fb5c: 4684        mov	ip, r0
@   0x0800fb5e: 1c10        adds	r0, r2, #0
@   0x0800fb60: 3830        subs	r0, #48	@ 0x30
@   0x0800fb62: 21ff        movs	r1, #255	@ 0xff
@   0x0800fb64: 4008        ands	r0, r1
@   0x0800fb66: 10c0        asrs	r0, r0, #3
@   0x0800fb68: 0145        lsls	r5, r0, #5
@   0x0800fb6a: 4952        ldr	r1, [pc, #328]	@ (0xfcb4)
@   0x0800fb6c: 9a03        ldr	r2, [sp, #12]
@   0x0800fb6e: 0110        lsls	r0, r2, #4
@   0x0800fb70: 1840        adds	r0, r0, r1
@   0x0800fb72: 2300        movs	r3, #0
@   0x0800fb74: 5ec0        ldrsh	r0, [r0, r3]
@   0x0800fb76: 2800        cmp	r0, #0
@   0x0800fb78: dc03        bgt.n	0xfb82
@   0x0800fb7a: 484f        ldr	r0, [pc, #316]	@ (0xfcb8)
@   0x0800fb7c: 7940        ldrb	r0, [r0, #5]
@   0x0800fb7e: 2800        cmp	r0, #0
@   0x0800fb80: d152        bne.n	0xfc28
@   0x0800fb82: 9809        ldr	r0, [sp, #36]	@ 0x24
@   0x0800fb84: 6803        ldr	r3, [r0, #0]
@   0x0800fb86: 2b0f        cmp	r3, #15
@   0x0800fb88: dd25        ble.n	0xfbd6
@   0x0800fb8a: 00f8        lsls	r0, r7, #3
@   0x0800fb8c: 38f8        subs	r0, #248	@ 0xf8
@   0x0800fb8e: 4a48        ldr	r2, [pc, #288]	@ (0xfcb0)
@   0x0800fb90: 4283        cmp	r3, r0
@   0x0800fb92: dc29        bgt.n	0xfbe8
@   0x0800fb94: 1c19        adds	r1, r3, #0
@   0x0800fb96: 3910        subs	r1, #16
@   0x0800fb98: 2900        cmp	r1, #0
@   0x0800fb9a: da00        bge.n	0xfb9e
@   0x0800fb9c: 3107        adds	r1, #7
@   0x0800fb9e: 10c9        asrs	r1, r1, #3
@   0x0800fba0: 3101        adds	r1, #1
@   0x0800fba2: 4662        mov	r2, ip
@   0x0800fba4: 0410        lsls	r0, r2, #16
@   0x0800fba6: 1400        asrs	r0, r0, #16
@   0x0800fba8: 1840        adds	r0, r0, r1
@   0x0800fbaa: 0400        lsls	r0, r0, #16
@   0x0800fbac: 0c00        lsrs	r0, r0, #16
@   0x0800fbae: 4684        mov	ip, r0
@   0x0800fbb0: 8ab1        ldrh	r1, [r6, #20]
@   0x0800fbb2: 3910        subs	r1, #16
@   0x0800fbb4: 23ff        movs	r3, #255	@ 0xff
@   0x0800fbb6: 4019        ands	r1, r3
@   0x0800fbb8: 1c08        adds	r0, r1, #0
@   0x0800fbba: 10c3        asrs	r3, r0, #3
@   0x0800fbbc: 1c5a        adds	r2, r3, #1
@   0x0800fbbe: 1c10        adds	r0, r2, #0
@   0x0800fbc0: 1280        asrs	r0, r0, #10
@   0x0800fbc2: 0280        lsls	r0, r0, #10
@   0x0800fbc4: 1a10        subs	r0, r2, r0
@   0x0800fbc6: 1828        adds	r0, r5, r0
@   0x0800fbc8: 0400        lsls	r0, r0, #16
@   0x0800fbca: 0c05        lsrs	r5, r0, #16
@   0x0800fbcc: 201f        movs	r0, #31
@   0x0800fbce: 1ac0        subs	r0, r0, r3
@   0x0800fbd0: 0400        lsls	r0, r0, #16
@   0x0800fbd2: 0c00        lsrs	r0, r0, #16
@   0x0800fbd4: 4681        mov	r9, r0
@   0x0800fbd6: 9f0a        ldr	r7, [sp, #40]	@ 0x28
@   0x0800fbd8: 8b7f        ldrh	r7, [r7, #26]
@   0x0800fbda: 00f8        lsls	r0, r7, #3
@   0x0800fbdc: 38f8        subs	r0, #248	@ 0xf8
@   0x0800fbde: 9a09        ldr	r2, [sp, #36]	@ 0x24
@   0x0800fbe0: 6811        ldr	r1, [r2, #0]
@   0x0800fbe2: 4a33        ldr	r2, [pc, #204]	@ (0xfcb0)
@   0x0800fbe4: 4281        cmp	r1, r0
@   0x0800fbe6: dd1f        ble.n	0xfc28
@   0x0800fbe8: 4834        ldr	r0, [pc, #208]	@ (0xfcbc)
@   0x0800fbea: 4460        add	r0, ip
@   0x0800fbec: 9b0c        ldr	r3, [sp, #48]	@ 0x30
@   0x0800fbee: 1899        adds	r1, r3, r2
@   0x0800fbf0: 8b4e        ldrh	r6, [r1, #26]
@   0x0800fbf2: 1830        adds	r0, r6, r0
@   0x0800fbf4: 0400        lsls	r0, r0, #16
@   0x0800fbf6: 0c00        lsrs	r0, r0, #16
@   0x0800fbf8: 4684        mov	ip, r0
@   0x0800fbfa: 8b4a        ldrh	r2, [r1, #26]
@   0x0800fbfc: 1c13        adds	r3, r2, #0
@   0x0800fbfe: 3b20        subs	r3, #32
@   0x0800fc00: 1c18        adds	r0, r3, #0
@   0x0800fc02: 2b00        cmp	r3, #0
@   0x0800fc04: da00        bge.n	0xfc08
@   0x0800fc06: 1e50        subs	r0, r2, #1
@   0x0800fc08: 1140        asrs	r0, r0, #5
@   0x0800fc0a: 0140        lsls	r0, r0, #5
@   0x0800fc0c: 1a18        subs	r0, r3, r0
@   0x0800fc0e: 1828        adds	r0, r5, r0
@   0x0800fc10: 0400        lsls	r0, r0, #16
@   0x0800fc12: 0c05        lsrs	r5, r0, #16
@   0x0800fc14: 8a89        ldrh	r1, [r1, #20]
@   0x0800fc16: 3910        subs	r1, #16
@   0x0800fc18: 20ff        movs	r0, #255	@ 0xff
@   0x0800fc1a: 4001        ands	r1, r0
@   0x0800fc1c: 10c9        asrs	r1, r1, #3
@   0x0800fc1e: 2020        movs	r0, #32
@   0x0800fc20: 1a40        subs	r0, r0, r1
@   0x0800fc22: 0400        lsls	r0, r0, #16
@   0x0800fc24: 0c00        lsrs	r0, r0, #16
@   0x0800fc26: 4681        mov	r9, r0
@   0x0800fc28: 0069        lsls	r1, r5, #1
@   0x0800fc2a: 1864        adds	r4, r4, r1
@   0x0800fc2c: 4667        mov	r7, ip
@   0x0800fc2e: 0078        lsls	r0, r7, #1
@   0x0800fc30: 4480        add	r8, r0
@   0x0800fc32: 4823        ldr	r0, [pc, #140]	@ (0xfcc0)
@   0x0800fc34: 4285        cmp	r5, r0
@   0x0800fc36: d903        bls.n	0xfc40
@   0x0800fc38: 4a22        ldr	r2, [pc, #136]	@ (0xfcc4)
@   0x0800fc3a: 1888        adds	r0, r1, r2
@   0x0800fc3c: 9b02        ldr	r3, [sp, #8]
@   0x0800fc3e: 181c        adds	r4, r3, r0
@   0x0800fc40: 2100        movs	r1, #0
@   0x0800fc42: 4655        mov	r5, sl
@   0x0800fc44: 3d01        subs	r5, #1
@   0x0800fc46: 2280        movs	r2, #128	@ 0x80
@   0x0800fc48: 00d2        lsls	r2, r2, #3
@   0x0800fc4a: 464e        mov	r6, r9
@   0x0800fc4c: 2e00        cmp	r6, #0
@   0x0800fc4e: d100        bne.n	0xfc52
@   0x0800fc50: 3c40        subs	r4, #64	@ 0x40
@   0x0800fc52: 9f02        ldr	r7, [sp, #8]
@   0x0800fc54: 42bc        cmp	r4, r7
@   0x0800fc56: d204        bcs.n	0xfc62
@   0x0800fc58: 1b38        subs	r0, r7, r4
@   0x0800fc5a: 1040        asrs	r0, r0, #1
@   0x0800fc5c: 1a10        subs	r0, r2, r0
@   0x0800fc5e: 0040        lsls	r0, r0, #1
@   0x0800fc60: 183c        adds	r4, r7, r0
@   0x0800fc62: 4643        mov	r3, r8
@   0x0800fc64: 8818        ldrh	r0, [r3, #0]
@   0x0800fc66: 8020        strh	r0, [r4, #0]
@   0x0800fc68: 3402        adds	r4, #2
@   0x0800fc6a: 2602        movs	r6, #2
@   0x0800fc6c: 44b0        add	r8, r6
@   0x0800fc6e: 4648        mov	r0, r9
@   0x0800fc70: 3801        subs	r0, #1
@   0x0800fc72: 0400        lsls	r0, r0, #16
@   0x0800fc74: 0c00        lsrs	r0, r0, #16
@   0x0800fc76: 4681        mov	r9, r0
@   0x0800fc78: 1c48        adds	r0, r1, #1
@   0x0800fc7a: 0400        lsls	r0, r0, #16
@   0x0800fc7c: 0c01        lsrs	r1, r0, #16
@   0x0800fc7e: 291f        cmp	r1, #31
@   0x0800fc80: d9e3        bls.n	0xfc4a
@   0x0800fc82: 0428        lsls	r0, r5, #16
@   0x0800fc84: 0c00        lsrs	r0, r0, #16
@   0x0800fc86: 4682        mov	sl, r0
@   0x0800fc88: 2800        cmp	r0, #0
@   0x0800fc8a: d000        beq.n	0xfc8e
@   0x0800fc8c: e72b        b.n	0xfae6
@   0x0800fc8e: 9f0b        ldr	r7, [sp, #44]	@ 0x2c
@   0x0800fc90: 0638        lsls	r0, r7, #24
@   0x0800fc92: 0e00        lsrs	r0, r0, #24
@   0x0800fc94: 9003        str	r0, [sp, #12]
@   0x0800fc96: 9900        ldr	r1, [sp, #0]
@   0x0800fc98: 4288        cmp	r0, r1
@   0x0800fc9a: d200        bcs.n	0xfc9e
@   0x0800fc9c: e5c5        b.n	0xf82a
@   0x0800fc9e: b00d        add	sp, #52	@ 0x34
@   0x0800fca0: bc38        pop	{r3, r4, r5}
@   0x0800fca2: 4698        mov	r8, r3
@   0x0800fca4: 46a1        mov	r9, r4
@   0x0800fca6: 46aa        mov	sl, r5
@   0x0800fca8: bcf0        pop	{r4, r5, r6, r7}
@   0x0800fcaa: bc01        pop	{r0}
@   0x0800fcac: 4700        bx	r0
@   0x0800fcae: 0000        movs	r0, r0
@   0x0800fcb0: 60a0        str	r0, [r4, #8]
@   0x0800fcb2: 0300        lsls	r0, r0, #12
@   0x0800fcb4: 63c0        str	r0, [r0, #60]	@ 0x3c
@   0x0800fcb6: 0300        lsls	r0, r0, #12
@   0x0800fcb8: 3608        adds	r6, #8
@   0x0800fcba: 0300        lsls	r0, r0, #12
@   0x0800fcbc: ffe0        0000 	vaddl.u32	q8, d0, d0
@   0x0800fcc0: 03ff        lsls	r7, r7, #15
@   0x0800fcc2: 0000        movs	r0, r0
@   0x0800fcc4: f800        ffff 	strb.w	pc, [r0, #255]!

        thumb_func_start ScrollUpdate_Pass0
ScrollUpdate_Pass0: @ 0x0800f814
        .incbin "frog_us_baserom.gba", 0xf814, 0x4b4
        thumb_func_end ScrollUpdate_Pass0
