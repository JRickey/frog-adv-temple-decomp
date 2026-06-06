@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800b918, 0x0800be18)  (1280 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800b918 --end 0x800be18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800b918: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800b91a: 4657        mov	r7, sl
@   0x0800b91c: 464e        mov	r6, r9
@   0x0800b91e: 4645        mov	r5, r8
@   0x0800b920: b4e0        push	{r5, r6, r7}
@   0x0800b922: b087        sub	sp, #28
@   0x0800b924: 4682        mov	sl, r0
@   0x0800b926: 9103        str	r1, [sp, #12]
@   0x0800b928: 0612        lsls	r2, r2, #24
@   0x0800b92a: 0e12        lsrs	r2, r2, #24
@   0x0800b92c: 6808        ldr	r0, [r1, #0]
@   0x0800b92e: 6849        ldr	r1, [r1, #4]
@   0x0800b930: 4308        orrs	r0, r1
@   0x0800b932: 2800        cmp	r0, #0
@   0x0800b934: d100        bne.n	0xb938
@   0x0800b936: e262        b.n	0xbdfe
@   0x0800b938: 0613        lsls	r3, r2, #24
@   0x0800b93a: 161a        asrs	r2, r3, #24
@   0x0800b93c: 0050        lsls	r0, r2, #1
@   0x0800b93e: 1880        adds	r0, r0, r2
@   0x0800b940: 0080        lsls	r0, r0, #2
@   0x0800b942: 4929        ldr	r1, [pc, #164]	@ (0xb9e8)
@   0x0800b944: 1840        adds	r0, r0, r1
@   0x0800b946: 7a84        ldrb	r4, [r0, #10]
@   0x0800b948: 2100        movs	r1, #0
@   0x0800b94a: 7800        ldrb	r0, [r0, #0]
@   0x0800b94c: 0600        lsls	r0, r0, #24
@   0x0800b94e: 1600        asrs	r0, r0, #24
@   0x0800b950: 9305        str	r3, [sp, #20]
@   0x0800b952: 4281        cmp	r1, r0
@   0x0800b954: db00        blt.n	0xb958
@   0x0800b956: e252        b.n	0xbdfe
@   0x0800b958: 46a1        mov	r9, r4
@   0x0800b95a: 9204        str	r2, [sp, #16]
@   0x0800b95c: 4690        mov	r8, r2
@   0x0800b95e: 0609        lsls	r1, r1, #24
@   0x0800b960: 160d        asrs	r5, r1, #24
@   0x0800b962: 00e8        lsls	r0, r5, #3
@   0x0800b964: 4652        mov	r2, sl
@   0x0800b966: 1886        adds	r6, r0, r2
@   0x0800b968: 1c0f        adds	r7, r1, #0
@   0x0800b96a: 7934        ldrb	r4, [r6, #4]
@   0x0800b96c: 2c02        cmp	r4, #2
@   0x0800b96e: d000        beq.n	0xb972
@   0x0800b970: e117        b.n	0xbba2
@   0x0800b972: 7970        ldrb	r0, [r6, #5]
@   0x0800b974: 2801        cmp	r0, #1
@   0x0800b976: d15f        bne.n	0xba38
@   0x0800b978: 491c        ldr	r1, [pc, #112]	@ (0xb9ec)
@   0x0800b97a: 7e08        ldrb	r0, [r1, #24]
@   0x0800b97c: 7e4a        ldrb	r2, [r1, #25]
@   0x0800b97e: 9206        str	r2, [sp, #24]
@   0x0800b980: 161b        asrs	r3, r3, #24
@   0x0800b982: 005a        lsls	r2, r3, #1
@   0x0800b984: 18d2        adds	r2, r2, r3
@   0x0800b986: 0092        lsls	r2, r2, #2
@   0x0800b988: 4b19        ldr	r3, [pc, #100]	@ (0xb9f0)
@   0x0800b98a: 18d4        adds	r4, r2, r3
@   0x0800b98c: 6823        ldr	r3, [r4, #0]
@   0x0800b98e: 00ad        lsls	r5, r5, #2
@   0x0800b990: 18eb        adds	r3, r5, r3
@   0x0800b992: 2200        movs	r2, #0
@   0x0800b994: 5e99        ldrsh	r1, [r3, r2]
@   0x0800b996: 468c        mov	ip, r1
@   0x0800b998: 885b        ldrh	r3, [r3, #2]
@   0x0800b99a: 3301        adds	r3, #1
@   0x0800b99c: 041b        lsls	r3, r3, #16
@   0x0800b99e: 141b        asrs	r3, r3, #16
@   0x0800b9a0: 9906        ldr	r1, [sp, #24]
@   0x0800b9a2: 4662        mov	r2, ip
@   0x0800b9a4: f001        f9f0 	bl	0xcd88
@   0x0800b9a8: 0600        lsls	r0, r0, #24
@   0x0800b9aa: 0e00        lsrs	r0, r0, #24
@   0x0800b9ac: 2808        cmp	r0, #8
@   0x0800b9ae: d001        beq.n	0xb9b4
@   0x0800b9b0: 280b        cmp	r0, #11
@   0x0800b9b2: d11f        bne.n	0xb9f4
@   0x0800b9b4: 6821        ldr	r1, [r4, #0]
@   0x0800b9b6: 1869        adds	r1, r5, r1
@   0x0800b9b8: 2300        movs	r3, #0
@   0x0800b9ba: 5ec8        ldrsh	r0, [r1, r3]
@   0x0800b9bc: 0043        lsls	r3, r0, #1
@   0x0800b9be: 181b        adds	r3, r3, r0
@   0x0800b9c0: 041b        lsls	r3, r3, #16
@   0x0800b9c2: 0c1b        lsrs	r3, r3, #16
@   0x0800b9c4: 2402        movs	r4, #2
@   0x0800b9c6: 5f09        ldrsh	r1, [r1, r4]
@   0x0800b9c8: 0048        lsls	r0, r1, #1
@   0x0800b9ca: 1840        adds	r0, r0, r1
@   0x0800b9cc: 0400        lsls	r0, r0, #16
@   0x0800b9ce: 0c00        lsrs	r0, r0, #16
@   0x0800b9d0: 9000        str	r0, [sp, #0]
@   0x0800b9d2: 464d        mov	r5, r9
@   0x0800b9d4: 9501        str	r5, [sp, #4]
@   0x0800b9d6: 79b0        ldrb	r0, [r6, #6]
@   0x0800b9d8: 9002        str	r0, [sp, #8]
@   0x0800b9da: 2000        movs	r0, #0
@   0x0800b9dc: 2104        movs	r1, #4
@   0x0800b9de: 2203        movs	r2, #3
@   0x0800b9e0: f005        fc6e 	bl	0x112c0
@   0x0800b9e4: e01e        b.n	0xba24
@   0x0800b9e6: 0000        movs	r0, r0
@   0x0800b9e8: 0b00        lsrs	r0, r0, #12
@   0x0800b9ea: 080c        lsrs	r4, r1, #32
@   0x0800b9ec: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b9ee: 0300        lsls	r0, r0, #12
@   0x0800b9f0: 0b04        lsrs	r4, r0, #12
@   0x0800b9f2: 080c        lsrs	r4, r1, #32
@   0x0800b9f4: 6821        ldr	r1, [r4, #0]
@   0x0800b9f6: 1869        adds	r1, r5, r1
@   0x0800b9f8: 2200        movs	r2, #0
@   0x0800b9fa: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b9fc: 0043        lsls	r3, r0, #1
@   0x0800b9fe: 181b        adds	r3, r3, r0
@   0x0800ba00: 041b        lsls	r3, r3, #16
@   0x0800ba02: 0c1b        lsrs	r3, r3, #16
@   0x0800ba04: 2402        movs	r4, #2
@   0x0800ba06: 5f09        ldrsh	r1, [r1, r4]
@   0x0800ba08: 0048        lsls	r0, r1, #1
@   0x0800ba0a: 1840        adds	r0, r0, r1
@   0x0800ba0c: 0400        lsls	r0, r0, #16
@   0x0800ba0e: 0c00        lsrs	r0, r0, #16
@   0x0800ba10: 9000        str	r0, [sp, #0]
@   0x0800ba12: 464d        mov	r5, r9
@   0x0800ba14: 9501        str	r5, [sp, #4]
@   0x0800ba16: 79b0        ldrb	r0, [r6, #6]
@   0x0800ba18: 9002        str	r0, [sp, #8]
@   0x0800ba1a: 2000        movs	r0, #0
@   0x0800ba1c: 2103        movs	r1, #3
@   0x0800ba1e: 2203        movs	r2, #3
@   0x0800ba20: f005        fc4e 	bl	0x112c0
@   0x0800ba24: 1579        asrs	r1, r7, #21
@   0x0800ba26: 4451        add	r1, sl
@   0x0800ba28: 4802        ldr	r0, [pc, #8]	@ (0xba34)
@   0x0800ba2a: 6800        ldr	r0, [r0, #0]
@   0x0800ba2c: 6008        str	r0, [r1, #0]
@   0x0800ba2e: 2002        movs	r0, #2
@   0x0800ba30: 7148        strb	r0, [r1, #5]
@   0x0800ba32: e0b6        b.n	0xbba2
@   0x0800ba34: 5330        strh	r0, [r6, r4]
@   0x0800ba36: 0300        lsls	r0, r0, #12
@   0x0800ba38: 4812        ldr	r0, [pc, #72]	@ (0xba84)
@   0x0800ba3a: 7a82        ldrb	r2, [r0, #10]
@   0x0800ba3c: 2378        movs	r3, #120	@ 0x78
@   0x0800ba3e: 2a06        cmp	r2, #6
@   0x0800ba40: d100        bne.n	0xba44
@   0x0800ba42: 2332        movs	r3, #50	@ 0x32
@   0x0800ba44: 6800        ldr	r0, [r0, #0]
@   0x0800ba46: 6831        ldr	r1, [r6, #0]
@   0x0800ba48: 1a40        subs	r0, r0, r1
@   0x0800ba4a: 4298        cmp	r0, r3
@   0x0800ba4c: d800        bhi.n	0xba50
@   0x0800ba4e: e0a8        b.n	0xbba2
@   0x0800ba50: 2a01        cmp	r2, #1
@   0x0800ba52: d11f        bne.n	0xba94
@   0x0800ba54: 490c        ldr	r1, [pc, #48]	@ (0xba88)
@   0x0800ba56: 7e08        ldrb	r0, [r1, #24]
@   0x0800ba58: 4642        mov	r2, r8
@   0x0800ba5a: 0054        lsls	r4, r2, #1
@   0x0800ba5c: 4444        add	r4, r8
@   0x0800ba5e: 00a4        lsls	r4, r4, #2
@   0x0800ba60: 4b0a        ldr	r3, [pc, #40]	@ (0xba8c)
@   0x0800ba62: 18e1        adds	r1, r4, r3
@   0x0800ba64: 680a        ldr	r2, [r1, #0]
@   0x0800ba66: 0db9        lsrs	r1, r7, #22
@   0x0800ba68: 1889        adds	r1, r1, r2
@   0x0800ba6a: 2500        movs	r5, #0
@   0x0800ba6c: 5f4a        ldrsh	r2, [r1, r5]
@   0x0800ba6e: 2502        movs	r5, #2
@   0x0800ba70: 5f4b        ldrsh	r3, [r1, r5]
@   0x0800ba72: 4907        ldr	r1, [pc, #28]	@ (0xba90)
@   0x0800ba74: 1864        adds	r4, r4, r1
@   0x0800ba76: 7a21        ldrb	r1, [r4, #8]
@   0x0800ba78: 9100        str	r1, [sp, #0]
@   0x0800ba7a: 2101        movs	r1, #1
@   0x0800ba7c: f001        f880 	bl	0xcb80
@   0x0800ba80: e01e        b.n	0xbac0
@   0x0800ba82: 0000        movs	r0, r0
@   0x0800ba84: 5330        strh	r0, [r6, r4]
@   0x0800ba86: 0300        lsls	r0, r0, #12
@   0x0800ba88: 35e0        adds	r5, #224	@ 0xe0
@   0x0800ba8a: 0300        lsls	r0, r0, #12
@   0x0800ba8c: 0b04        lsrs	r4, r0, #12
@   0x0800ba8e: 080c        lsrs	r4, r1, #32
@   0x0800ba90: 0b00        lsrs	r0, r0, #12
@   0x0800ba92: 080c        lsrs	r4, r1, #32
@   0x0800ba94: 4a29        ldr	r2, [pc, #164]	@ (0xbb3c)
@   0x0800ba96: 7e10        ldrb	r0, [r2, #24]
@   0x0800ba98: 4643        mov	r3, r8
@   0x0800ba9a: 005c        lsls	r4, r3, #1
@   0x0800ba9c: 4444        add	r4, r8
@   0x0800ba9e: 00a4        lsls	r4, r4, #2
@   0x0800baa0: 4d27        ldr	r5, [pc, #156]	@ (0xbb40)
@   0x0800baa2: 1961        adds	r1, r4, r5
@   0x0800baa4: 680a        ldr	r2, [r1, #0]
@   0x0800baa6: 0db9        lsrs	r1, r7, #22
@   0x0800baa8: 1889        adds	r1, r1, r2
@   0x0800baaa: 2300        movs	r3, #0
@   0x0800baac: 5eca        ldrsh	r2, [r1, r3]
@   0x0800baae: 2502        movs	r5, #2
@   0x0800bab0: 5f4b        ldrsh	r3, [r1, r5]
@   0x0800bab2: 4924        ldr	r1, [pc, #144]	@ (0xbb44)
@   0x0800bab4: 1864        adds	r4, r4, r1
@   0x0800bab6: 7a21        ldrb	r1, [r4, #8]
@   0x0800bab8: 9100        str	r1, [sp, #0]
@   0x0800baba: 2100        movs	r1, #0
@   0x0800babc: f001        f860 	bl	0xcb80
@   0x0800bac0: 163c        asrs	r4, r7, #24
@   0x0800bac2: 00e0        lsls	r0, r4, #3
@   0x0800bac4: 4652        mov	r2, sl
@   0x0800bac6: 1886        adds	r6, r0, r2
@   0x0800bac8: 2000        movs	r0, #0
@   0x0800baca: 71b0        strb	r0, [r6, #6]
@   0x0800bacc: 4b1b        ldr	r3, [pc, #108]	@ (0xbb3c)
@   0x0800bace: 7e18        ldrb	r0, [r3, #24]
@   0x0800bad0: 7e5d        ldrb	r5, [r3, #25]
@   0x0800bad2: 9506        str	r5, [sp, #24]
@   0x0800bad4: 9904        ldr	r1, [sp, #16]
@   0x0800bad6: 004a        lsls	r2, r1, #1
@   0x0800bad8: 1852        adds	r2, r2, r1
@   0x0800bada: 0092        lsls	r2, r2, #2
@   0x0800badc: 4b18        ldr	r3, [pc, #96]	@ (0xbb40)
@   0x0800bade: 18d5        adds	r5, r2, r3
@   0x0800bae0: 682b        ldr	r3, [r5, #0]
@   0x0800bae2: 00a4        lsls	r4, r4, #2
@   0x0800bae4: 18e3        adds	r3, r4, r3
@   0x0800bae6: 2200        movs	r2, #0
@   0x0800bae8: 5e99        ldrsh	r1, [r3, r2]
@   0x0800baea: 468c        mov	ip, r1
@   0x0800baec: 885b        ldrh	r3, [r3, #2]
@   0x0800baee: 3301        adds	r3, #1
@   0x0800baf0: 041b        lsls	r3, r3, #16
@   0x0800baf2: 141b        asrs	r3, r3, #16
@   0x0800baf4: 9906        ldr	r1, [sp, #24]
@   0x0800baf6: 4662        mov	r2, ip
@   0x0800baf8: f001        f946 	bl	0xcd88
@   0x0800bafc: 0600        lsls	r0, r0, #24
@   0x0800bafe: 0e00        lsrs	r0, r0, #24
@   0x0800bb00: 2808        cmp	r0, #8
@   0x0800bb02: d001        beq.n	0xbb08
@   0x0800bb04: 280b        cmp	r0, #11
@   0x0800bb06: d11f        bne.n	0xbb48
@   0x0800bb08: 6829        ldr	r1, [r5, #0]
@   0x0800bb0a: 1861        adds	r1, r4, r1
@   0x0800bb0c: 2300        movs	r3, #0
@   0x0800bb0e: 5ec8        ldrsh	r0, [r1, r3]
@   0x0800bb10: 0043        lsls	r3, r0, #1
@   0x0800bb12: 181b        adds	r3, r3, r0
@   0x0800bb14: 041b        lsls	r3, r3, #16
@   0x0800bb16: 0c1b        lsrs	r3, r3, #16
@   0x0800bb18: 2402        movs	r4, #2
@   0x0800bb1a: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bb1c: 0048        lsls	r0, r1, #1
@   0x0800bb1e: 1840        adds	r0, r0, r1
@   0x0800bb20: 0400        lsls	r0, r0, #16
@   0x0800bb22: 0c00        lsrs	r0, r0, #16
@   0x0800bb24: 9000        str	r0, [sp, #0]
@   0x0800bb26: 464d        mov	r5, r9
@   0x0800bb28: 9501        str	r5, [sp, #4]
@   0x0800bb2a: 79b0        ldrb	r0, [r6, #6]
@   0x0800bb2c: 9002        str	r0, [sp, #8]
@   0x0800bb2e: 2000        movs	r0, #0
@   0x0800bb30: 2104        movs	r1, #4
@   0x0800bb32: 2203        movs	r2, #3
@   0x0800bb34: f005        fbc4 	bl	0x112c0
@   0x0800bb38: e01e        b.n	0xbb78
@   0x0800bb3a: 0000        movs	r0, r0
@   0x0800bb3c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800bb3e: 0300        lsls	r0, r0, #12
@   0x0800bb40: 0b04        lsrs	r4, r0, #12
@   0x0800bb42: 080c        lsrs	r4, r1, #32
@   0x0800bb44: 0b00        lsrs	r0, r0, #12
@   0x0800bb46: 080c        lsrs	r4, r1, #32
@   0x0800bb48: 6829        ldr	r1, [r5, #0]
@   0x0800bb4a: 1861        adds	r1, r4, r1
@   0x0800bb4c: 2200        movs	r2, #0
@   0x0800bb4e: 5e88        ldrsh	r0, [r1, r2]
@   0x0800bb50: 0043        lsls	r3, r0, #1
@   0x0800bb52: 181b        adds	r3, r3, r0
@   0x0800bb54: 041b        lsls	r3, r3, #16
@   0x0800bb56: 0c1b        lsrs	r3, r3, #16
@   0x0800bb58: 2402        movs	r4, #2
@   0x0800bb5a: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bb5c: 0048        lsls	r0, r1, #1
@   0x0800bb5e: 1840        adds	r0, r0, r1
@   0x0800bb60: 0400        lsls	r0, r0, #16
@   0x0800bb62: 0c00        lsrs	r0, r0, #16
@   0x0800bb64: 9000        str	r0, [sp, #0]
@   0x0800bb66: 464d        mov	r5, r9
@   0x0800bb68: 9501        str	r5, [sp, #4]
@   0x0800bb6a: 79b0        ldrb	r0, [r6, #6]
@   0x0800bb6c: 9002        str	r0, [sp, #8]
@   0x0800bb6e: 2000        movs	r0, #0
@   0x0800bb70: 2103        movs	r1, #3
@   0x0800bb72: 2203        movs	r2, #3
@   0x0800bb74: f005        fba4 	bl	0x112c0
@   0x0800bb78: 163a        asrs	r2, r7, #24
@   0x0800bb7a: 00d0        lsls	r0, r2, #3
@   0x0800bb7c: 4450        add	r0, sl
@   0x0800bb7e: 7901        ldrb	r1, [r0, #4]
@   0x0800bb80: 2300        movs	r3, #0
@   0x0800bb82: 7141        strb	r1, [r0, #5]
@   0x0800bb84: 7103        strb	r3, [r0, #4]
@   0x0800bb86: 2001        movs	r0, #1
@   0x0800bb88: 2100        movs	r1, #0
@   0x0800bb8a: f028        f88b 	bl	0x33ca4
@   0x0800bb8e: 43c0        mvns	r0, r0
@   0x0800bb90: 43c9        mvns	r1, r1
@   0x0800bb92: 9c03        ldr	r4, [sp, #12]
@   0x0800bb94: 6822        ldr	r2, [r4, #0]
@   0x0800bb96: 6863        ldr	r3, [r4, #4]
@   0x0800bb98: 4002        ands	r2, r0
@   0x0800bb9a: 400b        ands	r3, r1
@   0x0800bb9c: 1c25        adds	r5, r4, #0
@   0x0800bb9e: 602a        str	r2, [r5, #0]
@   0x0800bba0: 606b        str	r3, [r5, #4]
@   0x0800bba2: 163d        asrs	r5, r7, #24
@   0x0800bba4: 00e8        lsls	r0, r5, #3
@   0x0800bba6: 4651        mov	r1, sl
@   0x0800bba8: 1846        adds	r6, r0, r1
@   0x0800bbaa: 7932        ldrb	r2, [r6, #4]
@   0x0800bbac: 2a01        cmp	r2, #1
@   0x0800bbae: d000        beq.n	0xbbb2
@   0x0800bbb0: e115        b.n	0xbdde
@   0x0800bbb2: 7970        ldrb	r0, [r6, #5]
@   0x0800bbb4: 2800        cmp	r0, #0
@   0x0800bbb6: d169        bne.n	0xbc8c
@   0x0800bbb8: 481e        ldr	r0, [pc, #120]	@ (0xbc34)
@   0x0800bbba: 6800        ldr	r0, [r0, #0]
@   0x0800bbbc: 6831        ldr	r1, [r6, #0]
@   0x0800bbbe: 1a40        subs	r0, r0, r1
@   0x0800bbc0: 2832        cmp	r0, #50	@ 0x32
@   0x0800bbc2: d800        bhi.n	0xbbc6
@   0x0800bbc4: e10b        b.n	0xbdde
@   0x0800bbc6: 71b2        strb	r2, [r6, #6]
@   0x0800bbc8: 4a1b        ldr	r2, [pc, #108]	@ (0xbc38)
@   0x0800bbca: 7e10        ldrb	r0, [r2, #24]
@   0x0800bbcc: 7e53        ldrb	r3, [r2, #25]
@   0x0800bbce: 9306        str	r3, [sp, #24]
@   0x0800bbd0: 9c04        ldr	r4, [sp, #16]
@   0x0800bbd2: 0062        lsls	r2, r4, #1
@   0x0800bbd4: 1912        adds	r2, r2, r4
@   0x0800bbd6: 0092        lsls	r2, r2, #2
@   0x0800bbd8: 4918        ldr	r1, [pc, #96]	@ (0xbc3c)
@   0x0800bbda: 1854        adds	r4, r2, r1
@   0x0800bbdc: 6823        ldr	r3, [r4, #0]
@   0x0800bbde: 00ad        lsls	r5, r5, #2
@   0x0800bbe0: 18eb        adds	r3, r5, r3
@   0x0800bbe2: 2100        movs	r1, #0
@   0x0800bbe4: 5e5a        ldrsh	r2, [r3, r1]
@   0x0800bbe6: 4694        mov	ip, r2
@   0x0800bbe8: 885b        ldrh	r3, [r3, #2]
@   0x0800bbea: 3301        adds	r3, #1
@   0x0800bbec: 041b        lsls	r3, r3, #16
@   0x0800bbee: 141b        asrs	r3, r3, #16
@   0x0800bbf0: 9906        ldr	r1, [sp, #24]
@   0x0800bbf2: f001        f8c9 	bl	0xcd88
@   0x0800bbf6: 0600        lsls	r0, r0, #24
@   0x0800bbf8: 0e00        lsrs	r0, r0, #24
@   0x0800bbfa: 2808        cmp	r0, #8
@   0x0800bbfc: d001        beq.n	0xbc02
@   0x0800bbfe: 280b        cmp	r0, #11
@   0x0800bc00: d11e        bne.n	0xbc40
@   0x0800bc02: 6821        ldr	r1, [r4, #0]
@   0x0800bc04: 1869        adds	r1, r5, r1
@   0x0800bc06: 2200        movs	r2, #0
@   0x0800bc08: 5e88        ldrsh	r0, [r1, r2]
@   0x0800bc0a: 0043        lsls	r3, r0, #1
@   0x0800bc0c: 181b        adds	r3, r3, r0
@   0x0800bc0e: 041b        lsls	r3, r3, #16
@   0x0800bc10: 0c1b        lsrs	r3, r3, #16
@   0x0800bc12: 2402        movs	r4, #2
@   0x0800bc14: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bc16: 0048        lsls	r0, r1, #1
@   0x0800bc18: 1840        adds	r0, r0, r1
@   0x0800bc1a: 0400        lsls	r0, r0, #16
@   0x0800bc1c: 0c00        lsrs	r0, r0, #16
@   0x0800bc1e: 9000        str	r0, [sp, #0]
@   0x0800bc20: 464d        mov	r5, r9
@   0x0800bc22: 9501        str	r5, [sp, #4]
@   0x0800bc24: 79b0        ldrb	r0, [r6, #6]
@   0x0800bc26: 9002        str	r0, [sp, #8]
@   0x0800bc28: 2000        movs	r0, #0
@   0x0800bc2a: 2104        movs	r1, #4
@   0x0800bc2c: 2203        movs	r2, #3
@   0x0800bc2e: f005        fb47 	bl	0x112c0
@   0x0800bc32: e01d        b.n	0xbc70
@   0x0800bc34: 5330        strh	r0, [r6, r4]
@   0x0800bc36: 0300        lsls	r0, r0, #12
@   0x0800bc38: 35e0        adds	r5, #224	@ 0xe0
@   0x0800bc3a: 0300        lsls	r0, r0, #12
@   0x0800bc3c: 0b04        lsrs	r4, r0, #12
@   0x0800bc3e: 080c        lsrs	r4, r1, #32
@   0x0800bc40: 6821        ldr	r1, [r4, #0]
@   0x0800bc42: 1869        adds	r1, r5, r1
@   0x0800bc44: 2200        movs	r2, #0
@   0x0800bc46: 5e88        ldrsh	r0, [r1, r2]
@   0x0800bc48: 0043        lsls	r3, r0, #1
@   0x0800bc4a: 181b        adds	r3, r3, r0
@   0x0800bc4c: 041b        lsls	r3, r3, #16
@   0x0800bc4e: 0c1b        lsrs	r3, r3, #16
@   0x0800bc50: 2402        movs	r4, #2
@   0x0800bc52: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bc54: 0048        lsls	r0, r1, #1
@   0x0800bc56: 1840        adds	r0, r0, r1
@   0x0800bc58: 0400        lsls	r0, r0, #16
@   0x0800bc5a: 0c00        lsrs	r0, r0, #16
@   0x0800bc5c: 9000        str	r0, [sp, #0]
@   0x0800bc5e: 464d        mov	r5, r9
@   0x0800bc60: 9501        str	r5, [sp, #4]
@   0x0800bc62: 79b0        ldrb	r0, [r6, #6]
@   0x0800bc64: 9002        str	r0, [sp, #8]
@   0x0800bc66: 2000        movs	r0, #0
@   0x0800bc68: 2103        movs	r1, #3
@   0x0800bc6a: 2203        movs	r2, #3
@   0x0800bc6c: f005        fb28 	bl	0x112c0
@   0x0800bc70: 1579        asrs	r1, r7, #21
@   0x0800bc72: 4451        add	r1, sl
@   0x0800bc74: 4804        ldr	r0, [pc, #16]	@ (0xbc88)
@   0x0800bc76: 6800        ldr	r0, [r0, #0]
@   0x0800bc78: 6008        str	r0, [r1, #0]
@   0x0800bc7a: 2001        movs	r0, #1
@   0x0800bc7c: 7148        strb	r0, [r1, #5]
@   0x0800bc7e: 2015        movs	r0, #21
@   0x0800bc80: f014        fffa 	bl	0x20c78
@   0x0800bc84: e0ab        b.n	0xbdde
@   0x0800bc86: 0000        movs	r0, r0
@   0x0800bc88: 5330        strh	r0, [r6, r4]
@   0x0800bc8a: 0300        lsls	r0, r0, #12
@   0x0800bc8c: 4a06        ldr	r2, [pc, #24]	@ (0xbca8)
@   0x0800bc8e: 6810        ldr	r0, [r2, #0]
@   0x0800bc90: 6831        ldr	r1, [r6, #0]
@   0x0800bc92: 1a40        subs	r0, r0, r1
@   0x0800bc94: 2805        cmp	r0, #5
@   0x0800bc96: d800        bhi.n	0xbc9a
@   0x0800bc98: e0a1        b.n	0xbdde
@   0x0800bc9a: 79b0        ldrb	r0, [r6, #6]
@   0x0800bc9c: 2805        cmp	r0, #5
@   0x0800bc9e: d105        bne.n	0xbcac
@   0x0800bca0: 2002        movs	r0, #2
@   0x0800bca2: 7130        strb	r0, [r6, #4]
@   0x0800bca4: e09b        b.n	0xbdde
@   0x0800bca6: 0000        movs	r0, r0
@   0x0800bca8: 5330        strh	r0, [r6, r4]
@   0x0800bcaa: 0300        lsls	r0, r0, #12
@   0x0800bcac: 2803        cmp	r0, #3
@   0x0800bcae: d135        bne.n	0xbd1c
@   0x0800bcb0: 7a92        ldrb	r2, [r2, #10]
@   0x0800bcb2: 2a01        cmp	r2, #1
@   0x0800bcb4: d11c        bne.n	0xbcf0
@   0x0800bcb6: 490b        ldr	r1, [pc, #44]	@ (0xbce4)
@   0x0800bcb8: 7e08        ldrb	r0, [r1, #24]
@   0x0800bcba: 4642        mov	r2, r8
@   0x0800bcbc: 0054        lsls	r4, r2, #1
@   0x0800bcbe: 4444        add	r4, r8
@   0x0800bcc0: 00a4        lsls	r4, r4, #2
@   0x0800bcc2: 4b09        ldr	r3, [pc, #36]	@ (0xbce8)
@   0x0800bcc4: 18e1        adds	r1, r4, r3
@   0x0800bcc6: 680a        ldr	r2, [r1, #0]
@   0x0800bcc8: 0db9        lsrs	r1, r7, #22
@   0x0800bcca: 1889        adds	r1, r1, r2
@   0x0800bccc: 2500        movs	r5, #0
@   0x0800bcce: 5f4a        ldrsh	r2, [r1, r5]
@   0x0800bcd0: 2502        movs	r5, #2
@   0x0800bcd2: 5f4b        ldrsh	r3, [r1, r5]
@   0x0800bcd4: 4905        ldr	r1, [pc, #20]	@ (0xbcec)
@   0x0800bcd6: 1864        adds	r4, r4, r1
@   0x0800bcd8: 7a61        ldrb	r1, [r4, #9]
@   0x0800bcda: 9100        str	r1, [sp, #0]
@   0x0800bcdc: 2101        movs	r1, #1
@   0x0800bcde: f000        ff4f 	bl	0xcb80
@   0x0800bce2: e01b        b.n	0xbd1c
@   0x0800bce4: 35e0        adds	r5, #224	@ 0xe0
@   0x0800bce6: 0300        lsls	r0, r0, #12
@   0x0800bce8: 0b04        lsrs	r4, r0, #12
@   0x0800bcea: 080c        lsrs	r4, r1, #32
@   0x0800bcec: 0b00        lsrs	r0, r0, #12
@   0x0800bcee: 080c        lsrs	r4, r1, #32
@   0x0800bcf0: 4a29        ldr	r2, [pc, #164]	@ (0xbd98)
@   0x0800bcf2: 7e10        ldrb	r0, [r2, #24]
@   0x0800bcf4: 4643        mov	r3, r8
@   0x0800bcf6: 005c        lsls	r4, r3, #1
@   0x0800bcf8: 4444        add	r4, r8
@   0x0800bcfa: 00a4        lsls	r4, r4, #2
@   0x0800bcfc: 4d27        ldr	r5, [pc, #156]	@ (0xbd9c)
@   0x0800bcfe: 1961        adds	r1, r4, r5
@   0x0800bd00: 680a        ldr	r2, [r1, #0]
@   0x0800bd02: 0db9        lsrs	r1, r7, #22
@   0x0800bd04: 1889        adds	r1, r1, r2
@   0x0800bd06: 2300        movs	r3, #0
@   0x0800bd08: 5eca        ldrsh	r2, [r1, r3]
@   0x0800bd0a: 2502        movs	r5, #2
@   0x0800bd0c: 5f4b        ldrsh	r3, [r1, r5]
@   0x0800bd0e: 4924        ldr	r1, [pc, #144]	@ (0xbda0)
@   0x0800bd10: 1864        adds	r4, r4, r1
@   0x0800bd12: 7a61        ldrb	r1, [r4, #9]
@   0x0800bd14: 9100        str	r1, [sp, #0]
@   0x0800bd16: 2100        movs	r1, #0
@   0x0800bd18: f000        ff32 	bl	0xcb80
@   0x0800bd1c: 163c        asrs	r4, r7, #24
@   0x0800bd1e: 00e0        lsls	r0, r4, #3
@   0x0800bd20: 4652        mov	r2, sl
@   0x0800bd22: 1886        adds	r6, r0, r2
@   0x0800bd24: 79b0        ldrb	r0, [r6, #6]
@   0x0800bd26: 3001        adds	r0, #1
@   0x0800bd28: 71b0        strb	r0, [r6, #6]
@   0x0800bd2a: 4b1b        ldr	r3, [pc, #108]	@ (0xbd98)
@   0x0800bd2c: 7e18        ldrb	r0, [r3, #24]
@   0x0800bd2e: 7e5d        ldrb	r5, [r3, #25]
@   0x0800bd30: 9506        str	r5, [sp, #24]
@   0x0800bd32: 9904        ldr	r1, [sp, #16]
@   0x0800bd34: 004a        lsls	r2, r1, #1
@   0x0800bd36: 1852        adds	r2, r2, r1
@   0x0800bd38: 0092        lsls	r2, r2, #2
@   0x0800bd3a: 4b18        ldr	r3, [pc, #96]	@ (0xbd9c)
@   0x0800bd3c: 18d5        adds	r5, r2, r3
@   0x0800bd3e: 682b        ldr	r3, [r5, #0]
@   0x0800bd40: 00a4        lsls	r4, r4, #2
@   0x0800bd42: 18e3        adds	r3, r4, r3
@   0x0800bd44: 2200        movs	r2, #0
@   0x0800bd46: 5e99        ldrsh	r1, [r3, r2]
@   0x0800bd48: 468c        mov	ip, r1
@   0x0800bd4a: 885b        ldrh	r3, [r3, #2]
@   0x0800bd4c: 3301        adds	r3, #1
@   0x0800bd4e: 041b        lsls	r3, r3, #16
@   0x0800bd50: 141b        asrs	r3, r3, #16
@   0x0800bd52: 9906        ldr	r1, [sp, #24]
@   0x0800bd54: 4662        mov	r2, ip
@   0x0800bd56: f001        f817 	bl	0xcd88
@   0x0800bd5a: 0600        lsls	r0, r0, #24
@   0x0800bd5c: 0e00        lsrs	r0, r0, #24
@   0x0800bd5e: 2808        cmp	r0, #8
@   0x0800bd60: d001        beq.n	0xbd66
@   0x0800bd62: 280b        cmp	r0, #11
@   0x0800bd64: d11e        bne.n	0xbda4
@   0x0800bd66: 6829        ldr	r1, [r5, #0]
@   0x0800bd68: 1861        adds	r1, r4, r1
@   0x0800bd6a: 2300        movs	r3, #0
@   0x0800bd6c: 5ec8        ldrsh	r0, [r1, r3]
@   0x0800bd6e: 0043        lsls	r3, r0, #1
@   0x0800bd70: 181b        adds	r3, r3, r0
@   0x0800bd72: 041b        lsls	r3, r3, #16
@   0x0800bd74: 0c1b        lsrs	r3, r3, #16
@   0x0800bd76: 2402        movs	r4, #2
@   0x0800bd78: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bd7a: 0048        lsls	r0, r1, #1
@   0x0800bd7c: 1840        adds	r0, r0, r1
@   0x0800bd7e: 0400        lsls	r0, r0, #16
@   0x0800bd80: 0c00        lsrs	r0, r0, #16
@   0x0800bd82: 9000        str	r0, [sp, #0]
@   0x0800bd84: 464d        mov	r5, r9
@   0x0800bd86: 9501        str	r5, [sp, #4]
@   0x0800bd88: 79b0        ldrb	r0, [r6, #6]
@   0x0800bd8a: 9002        str	r0, [sp, #8]
@   0x0800bd8c: 2000        movs	r0, #0
@   0x0800bd8e: 2104        movs	r1, #4
@   0x0800bd90: 2203        movs	r2, #3
@   0x0800bd92: f005        fa95 	bl	0x112c0
@   0x0800bd96: e01d        b.n	0xbdd4
@   0x0800bd98: 35e0        adds	r5, #224	@ 0xe0
@   0x0800bd9a: 0300        lsls	r0, r0, #12
@   0x0800bd9c: 0b04        lsrs	r4, r0, #12
@   0x0800bd9e: 080c        lsrs	r4, r1, #32
@   0x0800bda0: 0b00        lsrs	r0, r0, #12
@   0x0800bda2: 080c        lsrs	r4, r1, #32
@   0x0800bda4: 6829        ldr	r1, [r5, #0]
@   0x0800bda6: 1861        adds	r1, r4, r1
@   0x0800bda8: 2200        movs	r2, #0
@   0x0800bdaa: 5e88        ldrsh	r0, [r1, r2]
@   0x0800bdac: 0043        lsls	r3, r0, #1
@   0x0800bdae: 181b        adds	r3, r3, r0
@   0x0800bdb0: 041b        lsls	r3, r3, #16
@   0x0800bdb2: 0c1b        lsrs	r3, r3, #16
@   0x0800bdb4: 2402        movs	r4, #2
@   0x0800bdb6: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bdb8: 0048        lsls	r0, r1, #1
@   0x0800bdba: 1840        adds	r0, r0, r1
@   0x0800bdbc: 0400        lsls	r0, r0, #16
@   0x0800bdbe: 0c00        lsrs	r0, r0, #16
@   0x0800bdc0: 9000        str	r0, [sp, #0]
@   0x0800bdc2: 464d        mov	r5, r9
@   0x0800bdc4: 9501        str	r5, [sp, #4]
@   0x0800bdc6: 79b0        ldrb	r0, [r6, #6]
@   0x0800bdc8: 9002        str	r0, [sp, #8]
@   0x0800bdca: 2000        movs	r0, #0
@   0x0800bdcc: 2103        movs	r1, #3
@   0x0800bdce: 2203        movs	r2, #3
@   0x0800bdd0: f005        fa76 	bl	0x112c0
@   0x0800bdd4: 1578        asrs	r0, r7, #21
@   0x0800bdd6: 4450        add	r0, sl
@   0x0800bdd8: 490d        ldr	r1, [pc, #52]	@ (0xbe10)
@   0x0800bdda: 6809        ldr	r1, [r1, #0]
@   0x0800bddc: 6001        str	r1, [r0, #0]
@   0x0800bdde: 2080        movs	r0, #128	@ 0x80
@   0x0800bde0: 0440        lsls	r0, r0, #17
@   0x0800bde2: 183a        adds	r2, r7, r0
@   0x0800bde4: 9b05        ldr	r3, [sp, #20]
@   0x0800bde6: 1619        asrs	r1, r3, #24
@   0x0800bde8: 0048        lsls	r0, r1, #1
@   0x0800bdea: 1840        adds	r0, r0, r1
@   0x0800bdec: 0080        lsls	r0, r0, #2
@   0x0800bdee: 4909        ldr	r1, [pc, #36]	@ (0xbe14)
@   0x0800bdf0: 1840        adds	r0, r0, r1
@   0x0800bdf2: 0e11        lsrs	r1, r2, #24
@   0x0800bdf4: 7800        ldrb	r0, [r0, #0]
@   0x0800bdf6: 0600        lsls	r0, r0, #24
@   0x0800bdf8: 4282        cmp	r2, r0
@   0x0800bdfa: da00        bge.n	0xbdfe
@   0x0800bdfc: e5af        b.n	0xb95e
@   0x0800bdfe: b007        add	sp, #28
@   0x0800be00: bc38        pop	{r3, r4, r5}
@   0x0800be02: 4698        mov	r8, r3
@   0x0800be04: 46a1        mov	r9, r4
@   0x0800be06: 46aa        mov	sl, r5
@   0x0800be08: bcf0        pop	{r4, r5, r6, r7}
@   0x0800be0a: bc01        pop	{r0}
@   0x0800be0c: 4700        bx	r0
@   0x0800be0e: 0000        movs	r0, r0
@   0x0800be10: 5330        strh	r0, [r6, r4]
@   0x0800be12: 0300        lsls	r0, r0, #12
@   0x0800be14: 0b00        lsrs	r0, r0, #12
@   0x0800be16: 080c        lsrs	r4, r1, #32

        thumb_func_start Entity_UpdateHitboxWithTile
Entity_UpdateHitboxWithTile: @ 0x0800b918
        .incbin "frog_us_baserom.gba", 0xb918, 0x500
        thumb_func_end Entity_UpdateHitboxWithTile
