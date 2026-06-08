@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800b178, 0x0800b7b0)  (1592 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800b178 --end 0x800b7b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800b178: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800b17a: 4657        mov	r7, sl
@   0x0800b17c: 464e        mov	r6, r9
@   0x0800b17e: 4645        mov	r5, r8
@   0x0800b180: b4e0        push	{r5, r6, r7}
@   0x0800b182: b086        sub	sp, #24
@   0x0800b184: 9003        str	r0, [sp, #12]
@   0x0800b186: 2018        movs	r0, #24
@   0x0800b188: 2200        movs	r2, #0
@   0x0800b18a: 492a        ldr	r1, [pc, #168]	@ (0xb234)
@   0x0800b18c: 468c        mov	ip, r1
@   0x0800b18e: 0603        lsls	r3, r0, #24
@   0x0800b190: 161e        asrs	r6, r3, #24
@   0x0800b192: 0070        lsls	r0, r6, #1
@   0x0800b194: 1980        adds	r0, r0, r6
@   0x0800b196: 0087        lsls	r7, r0, #2
@   0x0800b198: 187d        adds	r5, r7, r1
@   0x0800b19a: 7aac        ldrb	r4, [r5, #10]
@   0x0800b19c: 9404        str	r4, [sp, #16]
@   0x0800b19e: 0611        lsls	r1, r2, #24
@   0x0800b1a0: 1548        asrs	r0, r1, #21
@   0x0800b1a2: 9c03        ldr	r4, [sp, #12]
@   0x0800b1a4: 1902        adds	r2, r0, r4
@   0x0800b1a6: 4699        mov	r9, r3
@   0x0800b1a8: 9105        str	r1, [sp, #20]
@   0x0800b1aa: 7910        ldrb	r0, [r2, #4]
@   0x0800b1ac: 2802        cmp	r0, #2
@   0x0800b1ae: d000        beq.n	0xb1b2
@   0x0800b1b0: e179        b.n	0xb4a6
@   0x0800b1b2: 7951        ldrb	r1, [r2, #5]
@   0x0800b1b4: 2901        cmp	r1, #1
@   0x0800b1b6: d179        bne.n	0xb2ac
@   0x0800b1b8: 2400        movs	r4, #0
@   0x0800b1ba: 2000        movs	r0, #0
@   0x0800b1bc: 5628        ldrsb	r0, [r5, r0]
@   0x0800b1be: 4284        cmp	r4, r0
@   0x0800b1c0: da65        bge.n	0xb28e
@   0x0800b1c2: 9e04        ldr	r6, [sp, #16]
@   0x0800b1c4: 46b0        mov	r8, r6
@   0x0800b1c6: 4692        mov	sl, r2
@   0x0800b1c8: 491b        ldr	r1, [pc, #108]	@ (0xb238)
@   0x0800b1ca: 7e08        ldrb	r0, [r1, #24]
@   0x0800b1cc: 7e49        ldrb	r1, [r1, #25]
@   0x0800b1ce: 161b        asrs	r3, r3, #24
@   0x0800b1d0: 005a        lsls	r2, r3, #1
@   0x0800b1d2: 18d2        adds	r2, r2, r3
@   0x0800b1d4: 0092        lsls	r2, r2, #2
@   0x0800b1d6: 4663        mov	r3, ip
@   0x0800b1d8: 3304        adds	r3, #4
@   0x0800b1da: 18d5        adds	r5, r2, r3
@   0x0800b1dc: 0624        lsls	r4, r4, #24
@   0x0800b1de: 682b        ldr	r3, [r5, #0]
@   0x0800b1e0: 15a6        asrs	r6, r4, #22
@   0x0800b1e2: 18f3        adds	r3, r6, r3
@   0x0800b1e4: 2700        movs	r7, #0
@   0x0800b1e6: 5fda        ldrsh	r2, [r3, r7]
@   0x0800b1e8: 885b        ldrh	r3, [r3, #2]
@   0x0800b1ea: 3301        adds	r3, #1
@   0x0800b1ec: 041b        lsls	r3, r3, #16
@   0x0800b1ee: 141b        asrs	r3, r3, #16
@   0x0800b1f0: f001        fdca 	bl	0xcd88
@   0x0800b1f4: 0600        lsls	r0, r0, #24
@   0x0800b1f6: 0e00        lsrs	r0, r0, #24
@   0x0800b1f8: 2808        cmp	r0, #8
@   0x0800b1fa: d001        beq.n	0xb200
@   0x0800b1fc: 280b        cmp	r0, #11
@   0x0800b1fe: d11d        bne.n	0xb23c
@   0x0800b200: 6829        ldr	r1, [r5, #0]
@   0x0800b202: 1871        adds	r1, r6, r1
@   0x0800b204: 2200        movs	r2, #0
@   0x0800b206: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b208: 0043        lsls	r3, r0, #1
@   0x0800b20a: 181b        adds	r3, r3, r0
@   0x0800b20c: 041b        lsls	r3, r3, #16
@   0x0800b20e: 0c1b        lsrs	r3, r3, #16
@   0x0800b210: 2602        movs	r6, #2
@   0x0800b212: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b214: 0048        lsls	r0, r1, #1
@   0x0800b216: 1840        adds	r0, r0, r1
@   0x0800b218: 0400        lsls	r0, r0, #16
@   0x0800b21a: 0c00        lsrs	r0, r0, #16
@   0x0800b21c: 9000        str	r0, [sp, #0]
@   0x0800b21e: 4647        mov	r7, r8
@   0x0800b220: 9701        str	r7, [sp, #4]
@   0x0800b222: 4651        mov	r1, sl
@   0x0800b224: 7988        ldrb	r0, [r1, #6]
@   0x0800b226: 9002        str	r0, [sp, #8]
@   0x0800b228: 2000        movs	r0, #0
@   0x0800b22a: 2104        movs	r1, #4
@   0x0800b22c: 2203        movs	r2, #3
@   0x0800b22e: f006        f847 	bl	0x112c0
@   0x0800b232: e01c        b.n	0xb26e
@   0x0800b234: 0b00        lsrs	r0, r0, #12
@   0x0800b236: 080c        lsrs	r4, r1, #32
@   0x0800b238: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b23a: 0300        lsls	r0, r0, #12
@   0x0800b23c: 6829        ldr	r1, [r5, #0]
@   0x0800b23e: 1871        adds	r1, r6, r1
@   0x0800b240: 2200        movs	r2, #0
@   0x0800b242: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b244: 0043        lsls	r3, r0, #1
@   0x0800b246: 181b        adds	r3, r3, r0
@   0x0800b248: 041b        lsls	r3, r3, #16
@   0x0800b24a: 0c1b        lsrs	r3, r3, #16
@   0x0800b24c: 2602        movs	r6, #2
@   0x0800b24e: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b250: 0048        lsls	r0, r1, #1
@   0x0800b252: 1840        adds	r0, r0, r1
@   0x0800b254: 0400        lsls	r0, r0, #16
@   0x0800b256: 0c00        lsrs	r0, r0, #16
@   0x0800b258: 9000        str	r0, [sp, #0]
@   0x0800b25a: 4647        mov	r7, r8
@   0x0800b25c: 9701        str	r7, [sp, #4]
@   0x0800b25e: 4651        mov	r1, sl
@   0x0800b260: 7988        ldrb	r0, [r1, #6]
@   0x0800b262: 9002        str	r0, [sp, #8]
@   0x0800b264: 2000        movs	r0, #0
@   0x0800b266: 2103        movs	r1, #3
@   0x0800b268: 2203        movs	r2, #3
@   0x0800b26a: f006        f829 	bl	0x112c0
@   0x0800b26e: 2380        movs	r3, #128	@ 0x80
@   0x0800b270: 045b        lsls	r3, r3, #17
@   0x0800b272: 18e2        adds	r2, r4, r3
@   0x0800b274: 4c0b        ldr	r4, [pc, #44]	@ (0xb2a4)
@   0x0800b276: 46a4        mov	ip, r4
@   0x0800b278: 464b        mov	r3, r9
@   0x0800b27a: 1619        asrs	r1, r3, #24
@   0x0800b27c: 0048        lsls	r0, r1, #1
@   0x0800b27e: 1840        adds	r0, r0, r1
@   0x0800b280: 0080        lsls	r0, r0, #2
@   0x0800b282: 4460        add	r0, ip
@   0x0800b284: 0e14        lsrs	r4, r2, #24
@   0x0800b286: 7800        ldrb	r0, [r0, #0]
@   0x0800b288: 0600        lsls	r0, r0, #24
@   0x0800b28a: 4282        cmp	r2, r0
@   0x0800b28c: db9c        blt.n	0xb1c8
@   0x0800b28e: 9e05        ldr	r6, [sp, #20]
@   0x0800b290: 1571        asrs	r1, r6, #21
@   0x0800b292: 9f03        ldr	r7, [sp, #12]
@   0x0800b294: 19c9        adds	r1, r1, r7
@   0x0800b296: 4804        ldr	r0, [pc, #16]	@ (0xb2a8)
@   0x0800b298: 6800        ldr	r0, [r0, #0]
@   0x0800b29a: 6008        str	r0, [r1, #0]
@   0x0800b29c: 2002        movs	r0, #2
@   0x0800b29e: 7148        strb	r0, [r1, #5]
@   0x0800b2a0: e101        b.n	0xb4a6
@   0x0800b2a2: 0000        movs	r0, r0
@   0x0800b2a4: 0b00        lsrs	r0, r0, #12
@   0x0800b2a6: 080c        lsrs	r4, r1, #32
@   0x0800b2a8: 5330        strh	r0, [r6, r4]
@   0x0800b2aa: 0300        lsls	r0, r0, #12
@   0x0800b2ac: 4838        ldr	r0, [pc, #224]	@ (0xb390)
@   0x0800b2ae: 6800        ldr	r0, [r0, #0]
@   0x0800b2b0: 6811        ldr	r1, [r2, #0]
@   0x0800b2b2: 1a40        subs	r0, r0, r1
@   0x0800b2b4: 283c        cmp	r0, #60	@ 0x3c
@   0x0800b2b6: d800        bhi.n	0xb2ba
@   0x0800b2b8: e0f5        b.n	0xb4a6
@   0x0800b2ba: 2000        movs	r0, #0
@   0x0800b2bc: 7190        strb	r0, [r2, #6]
@   0x0800b2be: 2400        movs	r4, #0
@   0x0800b2c0: 2000        movs	r0, #0
@   0x0800b2c2: 5628        ldrsb	r0, [r5, r0]
@   0x0800b2c4: 4284        cmp	r4, r0
@   0x0800b2c6: db00        blt.n	0xb2ca
@   0x0800b2c8: e091        b.n	0xb3ee
@   0x0800b2ca: 46b2        mov	sl, r6
@   0x0800b2cc: 4831        ldr	r0, [pc, #196]	@ (0xb394)
@   0x0800b2ce: 19c0        adds	r0, r0, r7
@   0x0800b2d0: 4680        mov	r8, r0
@   0x0800b2d2: 4931        ldr	r1, [pc, #196]	@ (0xb398)
@   0x0800b2d4: 1878        adds	r0, r7, r1
@   0x0800b2d6: 2700        movs	r7, #0
@   0x0800b2d8: 57c7        ldrsb	r7, [r0, r7]
@   0x0800b2da: 4a30        ldr	r2, [pc, #192]	@ (0xb39c)
@   0x0800b2dc: 7e10        ldrb	r0, [r2, #24]
@   0x0800b2de: 0625        lsls	r5, r4, #24
@   0x0800b2e0: 4653        mov	r3, sl
@   0x0800b2e2: 005c        lsls	r4, r3, #1
@   0x0800b2e4: 4454        add	r4, sl
@   0x0800b2e6: 00a4        lsls	r4, r4, #2
@   0x0800b2e8: 4e2a        ldr	r6, [pc, #168]	@ (0xb394)
@   0x0800b2ea: 19a1        adds	r1, r4, r6
@   0x0800b2ec: 680a        ldr	r2, [r1, #0]
@   0x0800b2ee: 0da9        lsrs	r1, r5, #22
@   0x0800b2f0: 1889        adds	r1, r1, r2
@   0x0800b2f2: 2300        movs	r3, #0
@   0x0800b2f4: 5eca        ldrsh	r2, [r1, r3]
@   0x0800b2f6: 2602        movs	r6, #2
@   0x0800b2f8: 5f8b        ldrsh	r3, [r1, r6]
@   0x0800b2fa: 4927        ldr	r1, [pc, #156]	@ (0xb398)
@   0x0800b2fc: 1864        adds	r4, r4, r1
@   0x0800b2fe: 7a21        ldrb	r1, [r4, #8]
@   0x0800b300: 9100        str	r1, [sp, #0]
@   0x0800b302: 2100        movs	r1, #0
@   0x0800b304: f001        fc3c 	bl	0xcb80
@   0x0800b308: 4643        mov	r3, r8
@   0x0800b30a: 681a        ldr	r2, [r3, #0]
@   0x0800b30c: 15ae        asrs	r6, r5, #22
@   0x0800b30e: 18b2        adds	r2, r6, r2
@   0x0800b310: 2402        movs	r4, #2
@   0x0800b312: 5f11        ldrsh	r1, [r2, r4]
@   0x0800b314: 00c8        lsls	r0, r1, #3
@   0x0800b316: 1a40        subs	r0, r0, r1
@   0x0800b318: 0040        lsls	r0, r0, #1
@   0x0800b31a: 2300        movs	r3, #0
@   0x0800b31c: 5ed1        ldrsh	r1, [r2, r3]
@   0x0800b31e: 1840        adds	r0, r0, r1
@   0x0800b320: 4c1f        ldr	r4, [pc, #124]	@ (0xb3a0)
@   0x0800b322: 1900        adds	r0, r0, r4
@   0x0800b324: 2101        movs	r1, #1
@   0x0800b326: 7001        strb	r1, [r0, #0]
@   0x0800b328: 491c        ldr	r1, [pc, #112]	@ (0xb39c)
@   0x0800b32a: 7e08        ldrb	r0, [r1, #24]
@   0x0800b32c: 7e49        ldrb	r1, [r1, #25]
@   0x0800b32e: 4642        mov	r2, r8
@   0x0800b330: 6813        ldr	r3, [r2, #0]
@   0x0800b332: 18f3        adds	r3, r6, r3
@   0x0800b334: 2400        movs	r4, #0
@   0x0800b336: 5f1a        ldrsh	r2, [r3, r4]
@   0x0800b338: 885b        ldrh	r3, [r3, #2]
@   0x0800b33a: 3301        adds	r3, #1
@   0x0800b33c: 041b        lsls	r3, r3, #16
@   0x0800b33e: 141b        asrs	r3, r3, #16
@   0x0800b340: f001        fd22 	bl	0xcd88
@   0x0800b344: 0600        lsls	r0, r0, #24
@   0x0800b346: 0e00        lsrs	r0, r0, #24
@   0x0800b348: 1c2c        adds	r4, r5, #0
@   0x0800b34a: 2808        cmp	r0, #8
@   0x0800b34c: d001        beq.n	0xb352
@   0x0800b34e: 280b        cmp	r0, #11
@   0x0800b350: d128        bne.n	0xb3a4
@   0x0800b352: 4640        mov	r0, r8
@   0x0800b354: 6801        ldr	r1, [r0, #0]
@   0x0800b356: 1871        adds	r1, r6, r1
@   0x0800b358: 2200        movs	r2, #0
@   0x0800b35a: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b35c: 0043        lsls	r3, r0, #1
@   0x0800b35e: 181b        adds	r3, r3, r0
@   0x0800b360: 041b        lsls	r3, r3, #16
@   0x0800b362: 0c1b        lsrs	r3, r3, #16
@   0x0800b364: 2602        movs	r6, #2
@   0x0800b366: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b368: 0048        lsls	r0, r1, #1
@   0x0800b36a: 1840        adds	r0, r0, r1
@   0x0800b36c: 0400        lsls	r0, r0, #16
@   0x0800b36e: 0c00        lsrs	r0, r0, #16
@   0x0800b370: 9000        str	r0, [sp, #0]
@   0x0800b372: 9804        ldr	r0, [sp, #16]
@   0x0800b374: 9001        str	r0, [sp, #4]
@   0x0800b376: 9905        ldr	r1, [sp, #20]
@   0x0800b378: 1548        asrs	r0, r1, #21
@   0x0800b37a: 9a03        ldr	r2, [sp, #12]
@   0x0800b37c: 1880        adds	r0, r0, r2
@   0x0800b37e: 7980        ldrb	r0, [r0, #6]
@   0x0800b380: 9002        str	r0, [sp, #8]
@   0x0800b382: 2000        movs	r0, #0
@   0x0800b384: 2104        movs	r1, #4
@   0x0800b386: 2203        movs	r2, #3
@   0x0800b388: f005        ff9a 	bl	0x112c0
@   0x0800b38c: e027        b.n	0xb3de
@   0x0800b38e: 0000        movs	r0, r0
@   0x0800b390: 5330        strh	r0, [r6, r4]
@   0x0800b392: 0300        lsls	r0, r0, #12
@   0x0800b394: 0b04        lsrs	r4, r0, #12
@   0x0800b396: 080c        lsrs	r4, r1, #32
@   0x0800b398: 0b00        lsrs	r0, r0, #12
@   0x0800b39a: 080c        lsrs	r4, r1, #32
@   0x0800b39c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b39e: 0300        lsls	r0, r0, #12
@   0x0800b3a0: 3610        adds	r6, #16
@   0x0800b3a2: 0300        lsls	r0, r0, #12
@   0x0800b3a4: 4643        mov	r3, r8
@   0x0800b3a6: 6819        ldr	r1, [r3, #0]
@   0x0800b3a8: 1871        adds	r1, r6, r1
@   0x0800b3aa: 2600        movs	r6, #0
@   0x0800b3ac: 5f88        ldrsh	r0, [r1, r6]
@   0x0800b3ae: 0043        lsls	r3, r0, #1
@   0x0800b3b0: 181b        adds	r3, r3, r0
@   0x0800b3b2: 041b        lsls	r3, r3, #16
@   0x0800b3b4: 0c1b        lsrs	r3, r3, #16
@   0x0800b3b6: 2002        movs	r0, #2
@   0x0800b3b8: 5e09        ldrsh	r1, [r1, r0]
@   0x0800b3ba: 0048        lsls	r0, r1, #1
@   0x0800b3bc: 1840        adds	r0, r0, r1
@   0x0800b3be: 0400        lsls	r0, r0, #16
@   0x0800b3c0: 0c00        lsrs	r0, r0, #16
@   0x0800b3c2: 9000        str	r0, [sp, #0]
@   0x0800b3c4: 9904        ldr	r1, [sp, #16]
@   0x0800b3c6: 9101        str	r1, [sp, #4]
@   0x0800b3c8: 9a05        ldr	r2, [sp, #20]
@   0x0800b3ca: 1550        asrs	r0, r2, #21
@   0x0800b3cc: 9e03        ldr	r6, [sp, #12]
@   0x0800b3ce: 1980        adds	r0, r0, r6
@   0x0800b3d0: 7980        ldrb	r0, [r0, #6]
@   0x0800b3d2: 9002        str	r0, [sp, #8]
@   0x0800b3d4: 2000        movs	r0, #0
@   0x0800b3d6: 2103        movs	r1, #3
@   0x0800b3d8: 2203        movs	r2, #3
@   0x0800b3da: f005        ff71 	bl	0x112c0
@   0x0800b3de: 2180        movs	r1, #128	@ 0x80
@   0x0800b3e0: 0449        lsls	r1, r1, #17
@   0x0800b3e2: 1860        adds	r0, r4, r1
@   0x0800b3e4: 0e04        lsrs	r4, r0, #24
@   0x0800b3e6: 1600        asrs	r0, r0, #24
@   0x0800b3e8: 42b8        cmp	r0, r7
@   0x0800b3ea: da00        bge.n	0xb3ee
@   0x0800b3ec: e775        b.n	0xb2da
@   0x0800b3ee: 4c59        ldr	r4, [pc, #356]	@ (0xb554)
@   0x0800b3f0: 1c20        adds	r0, r4, #0
@   0x0800b3f2: 2105        movs	r1, #5
@   0x0800b3f4: 2200        movs	r2, #0
@   0x0800b3f6: f7fb        f9d1 	bl	0x679c
@   0x0800b3fa: 0600        lsls	r0, r0, #24
@   0x0800b3fc: 2800        cmp	r0, #0
@   0x0800b3fe: d00b        beq.n	0xb418
@   0x0800b400: 1c21        adds	r1, r4, #0
@   0x0800b402: 3133        adds	r1, #51	@ 0x33
@   0x0800b404: 2001        movs	r0, #1
@   0x0800b406: 7809        ldrb	r1, [r1, #0]
@   0x0800b408: 4008        ands	r0, r1
@   0x0800b40a: 2800        cmp	r0, #0
@   0x0800b40c: d104        bne.n	0xb418
@   0x0800b40e: 1c20        adds	r0, r4, #0
@   0x0800b410: 2105        movs	r1, #5
@   0x0800b412: 2200        movs	r2, #0
@   0x0800b414: f7fb        f956 	bl	0x66c4
@   0x0800b418: 4c4e        ldr	r4, [pc, #312]	@ (0xb554)
@   0x0800b41a: 1c20        adds	r0, r4, #0
@   0x0800b41c: 2105        movs	r1, #5
@   0x0800b41e: 2201        movs	r2, #1
@   0x0800b420: f7fb        f9bc 	bl	0x679c
@   0x0800b424: 0600        lsls	r0, r0, #24
@   0x0800b426: 2800        cmp	r0, #0
@   0x0800b428: d00b        beq.n	0xb442
@   0x0800b42a: 1c21        adds	r1, r4, #0
@   0x0800b42c: 3133        adds	r1, #51	@ 0x33
@   0x0800b42e: 2002        movs	r0, #2
@   0x0800b430: 7809        ldrb	r1, [r1, #0]
@   0x0800b432: 4008        ands	r0, r1
@   0x0800b434: 2800        cmp	r0, #0
@   0x0800b436: d104        bne.n	0xb442
@   0x0800b438: 1c20        adds	r0, r4, #0
@   0x0800b43a: 2105        movs	r1, #5
@   0x0800b43c: 2201        movs	r2, #1
@   0x0800b43e: f7fb        f941 	bl	0x66c4
@   0x0800b442: 4c44        ldr	r4, [pc, #272]	@ (0xb554)
@   0x0800b444: 1c20        adds	r0, r4, #0
@   0x0800b446: 2105        movs	r1, #5
@   0x0800b448: 2202        movs	r2, #2
@   0x0800b44a: f7fb        f9a7 	bl	0x679c
@   0x0800b44e: 0600        lsls	r0, r0, #24
@   0x0800b450: 2800        cmp	r0, #0
@   0x0800b452: d00b        beq.n	0xb46c
@   0x0800b454: 1c21        adds	r1, r4, #0
@   0x0800b456: 3133        adds	r1, #51	@ 0x33
@   0x0800b458: 2004        movs	r0, #4
@   0x0800b45a: 7809        ldrb	r1, [r1, #0]
@   0x0800b45c: 4008        ands	r0, r1
@   0x0800b45e: 2800        cmp	r0, #0
@   0x0800b460: d104        bne.n	0xb46c
@   0x0800b462: 1c20        adds	r0, r4, #0
@   0x0800b464: 2105        movs	r1, #5
@   0x0800b466: 2202        movs	r2, #2
@   0x0800b468: f7fb        f92c 	bl	0x66c4
@   0x0800b46c: 4c39        ldr	r4, [pc, #228]	@ (0xb554)
@   0x0800b46e: 1c20        adds	r0, r4, #0
@   0x0800b470: 2105        movs	r1, #5
@   0x0800b472: 2203        movs	r2, #3
@   0x0800b474: f7fb        f992 	bl	0x679c
@   0x0800b478: 0600        lsls	r0, r0, #24
@   0x0800b47a: 2800        cmp	r0, #0
@   0x0800b47c: d00b        beq.n	0xb496
@   0x0800b47e: 1c21        adds	r1, r4, #0
@   0x0800b480: 3133        adds	r1, #51	@ 0x33
@   0x0800b482: 2008        movs	r0, #8
@   0x0800b484: 7809        ldrb	r1, [r1, #0]
@   0x0800b486: 4008        ands	r0, r1
@   0x0800b488: 2800        cmp	r0, #0
@   0x0800b48a: d104        bne.n	0xb496
@   0x0800b48c: 1c20        adds	r0, r4, #0
@   0x0800b48e: 2105        movs	r1, #5
@   0x0800b490: 2203        movs	r2, #3
@   0x0800b492: f7fb        f917 	bl	0x66c4
@   0x0800b496: 9a05        ldr	r2, [sp, #20]
@   0x0800b498: 1550        asrs	r0, r2, #21
@   0x0800b49a: 9b03        ldr	r3, [sp, #12]
@   0x0800b49c: 18c0        adds	r0, r0, r3
@   0x0800b49e: 7901        ldrb	r1, [r0, #4]
@   0x0800b4a0: 2200        movs	r2, #0
@   0x0800b4a2: 7141        strb	r1, [r0, #5]
@   0x0800b4a4: 7102        strb	r2, [r0, #4]
@   0x0800b4a6: 9c05        ldr	r4, [sp, #20]
@   0x0800b4a8: 1560        asrs	r0, r4, #21
@   0x0800b4aa: 9e03        ldr	r6, [sp, #12]
@   0x0800b4ac: 1982        adds	r2, r0, r6
@   0x0800b4ae: 7913        ldrb	r3, [r2, #4]
@   0x0800b4b0: 2b01        cmp	r3, #1
@   0x0800b4b2: d000        beq.n	0xb4b6
@   0x0800b4b4: e165        b.n	0xb782
@   0x0800b4b6: 7950        ldrb	r0, [r2, #5]
@   0x0800b4b8: 2800        cmp	r0, #0
@   0x0800b4ba: d000        beq.n	0xb4be
@   0x0800b4bc: e088        b.n	0xb5d0
@   0x0800b4be: 4826        ldr	r0, [pc, #152]	@ (0xb558)
@   0x0800b4c0: 6801        ldr	r1, [r0, #0]
@   0x0800b4c2: 6810        ldr	r0, [r2, #0]
@   0x0800b4c4: 4281        cmp	r1, r0
@   0x0800b4c6: d100        bne.n	0xb4ca
@   0x0800b4c8: e15b        b.n	0xb782
@   0x0800b4ca: 7193        strb	r3, [r2, #6]
@   0x0800b4cc: 2400        movs	r4, #0
@   0x0800b4ce: 4d23        ldr	r5, [pc, #140]	@ (0xb55c)
@   0x0800b4d0: 464b        mov	r3, r9
@   0x0800b4d2: 1618        asrs	r0, r3, #24
@   0x0800b4d4: 0041        lsls	r1, r0, #1
@   0x0800b4d6: 1809        adds	r1, r1, r0
@   0x0800b4d8: 0089        lsls	r1, r1, #2
@   0x0800b4da: 1949        adds	r1, r1, r5
@   0x0800b4dc: 2000        movs	r0, #0
@   0x0800b4de: 5608        ldrsb	r0, [r1, r0]
@   0x0800b4e0: 4284        cmp	r4, r0
@   0x0800b4e2: da67        bge.n	0xb5b4
@   0x0800b4e4: 9f04        ldr	r7, [sp, #16]
@   0x0800b4e6: 46b8        mov	r8, r7
@   0x0800b4e8: 4692        mov	sl, r2
@   0x0800b4ea: 491d        ldr	r1, [pc, #116]	@ (0xb560)
@   0x0800b4ec: 7e08        ldrb	r0, [r1, #24]
@   0x0800b4ee: 7e49        ldrb	r1, [r1, #25]
@   0x0800b4f0: 161b        asrs	r3, r3, #24
@   0x0800b4f2: 005a        lsls	r2, r3, #1
@   0x0800b4f4: 18d2        adds	r2, r2, r3
@   0x0800b4f6: 0092        lsls	r2, r2, #2
@   0x0800b4f8: 1d2b        adds	r3, r5, #4
@   0x0800b4fa: 18d5        adds	r5, r2, r3
@   0x0800b4fc: 0624        lsls	r4, r4, #24
@   0x0800b4fe: 682b        ldr	r3, [r5, #0]
@   0x0800b500: 15a6        asrs	r6, r4, #22
@   0x0800b502: 18f3        adds	r3, r6, r3
@   0x0800b504: 2700        movs	r7, #0
@   0x0800b506: 5fda        ldrsh	r2, [r3, r7]
@   0x0800b508: 885b        ldrh	r3, [r3, #2]
@   0x0800b50a: 3301        adds	r3, #1
@   0x0800b50c: 041b        lsls	r3, r3, #16
@   0x0800b50e: 141b        asrs	r3, r3, #16
@   0x0800b510: f001        fc3a 	bl	0xcd88
@   0x0800b514: 0600        lsls	r0, r0, #24
@   0x0800b516: 0e00        lsrs	r0, r0, #24
@   0x0800b518: 2808        cmp	r0, #8
@   0x0800b51a: d001        beq.n	0xb520
@   0x0800b51c: 280b        cmp	r0, #11
@   0x0800b51e: d121        bne.n	0xb564
@   0x0800b520: 6829        ldr	r1, [r5, #0]
@   0x0800b522: 1871        adds	r1, r6, r1
@   0x0800b524: 2200        movs	r2, #0
@   0x0800b526: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b528: 0043        lsls	r3, r0, #1
@   0x0800b52a: 181b        adds	r3, r3, r0
@   0x0800b52c: 041b        lsls	r3, r3, #16
@   0x0800b52e: 0c1b        lsrs	r3, r3, #16
@   0x0800b530: 2602        movs	r6, #2
@   0x0800b532: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b534: 0048        lsls	r0, r1, #1
@   0x0800b536: 1840        adds	r0, r0, r1
@   0x0800b538: 0400        lsls	r0, r0, #16
@   0x0800b53a: 0c00        lsrs	r0, r0, #16
@   0x0800b53c: 9000        str	r0, [sp, #0]
@   0x0800b53e: 4647        mov	r7, r8
@   0x0800b540: 9701        str	r7, [sp, #4]
@   0x0800b542: 4651        mov	r1, sl
@   0x0800b544: 7988        ldrb	r0, [r1, #6]
@   0x0800b546: 9002        str	r0, [sp, #8]
@   0x0800b548: 2000        movs	r0, #0
@   0x0800b54a: 2104        movs	r1, #4
@   0x0800b54c: 2203        movs	r2, #3
@   0x0800b54e: f005        feb7 	bl	0x112c0
@   0x0800b552: e020        b.n	0xb596
@   0x0800b554: 6110        str	r0, [r2, #16]
@   0x0800b556: 0300        lsls	r0, r0, #12
@   0x0800b558: 5330        strh	r0, [r6, r4]
@   0x0800b55a: 0300        lsls	r0, r0, #12
@   0x0800b55c: 0b00        lsrs	r0, r0, #12
@   0x0800b55e: 080c        lsrs	r4, r1, #32
@   0x0800b560: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b562: 0300        lsls	r0, r0, #12
@   0x0800b564: 6829        ldr	r1, [r5, #0]
@   0x0800b566: 1871        adds	r1, r6, r1
@   0x0800b568: 2200        movs	r2, #0
@   0x0800b56a: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b56c: 0043        lsls	r3, r0, #1
@   0x0800b56e: 181b        adds	r3, r3, r0
@   0x0800b570: 041b        lsls	r3, r3, #16
@   0x0800b572: 0c1b        lsrs	r3, r3, #16
@   0x0800b574: 2602        movs	r6, #2
@   0x0800b576: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b578: 0048        lsls	r0, r1, #1
@   0x0800b57a: 1840        adds	r0, r0, r1
@   0x0800b57c: 0400        lsls	r0, r0, #16
@   0x0800b57e: 0c00        lsrs	r0, r0, #16
@   0x0800b580: 9000        str	r0, [sp, #0]
@   0x0800b582: 4647        mov	r7, r8
@   0x0800b584: 9701        str	r7, [sp, #4]
@   0x0800b586: 4651        mov	r1, sl
@   0x0800b588: 7988        ldrb	r0, [r1, #6]
@   0x0800b58a: 9002        str	r0, [sp, #8]
@   0x0800b58c: 2000        movs	r0, #0
@   0x0800b58e: 2103        movs	r1, #3
@   0x0800b590: 2203        movs	r2, #3
@   0x0800b592: f005        fe95 	bl	0x112c0
@   0x0800b596: 2380        movs	r3, #128	@ 0x80
@   0x0800b598: 045b        lsls	r3, r3, #17
@   0x0800b59a: 18e2        adds	r2, r4, r3
@   0x0800b59c: 4d0a        ldr	r5, [pc, #40]	@ (0xb5c8)
@   0x0800b59e: 464b        mov	r3, r9
@   0x0800b5a0: 1619        asrs	r1, r3, #24
@   0x0800b5a2: 0048        lsls	r0, r1, #1
@   0x0800b5a4: 1840        adds	r0, r0, r1
@   0x0800b5a6: 0080        lsls	r0, r0, #2
@   0x0800b5a8: 1940        adds	r0, r0, r5
@   0x0800b5aa: 0e14        lsrs	r4, r2, #24
@   0x0800b5ac: 7800        ldrb	r0, [r0, #0]
@   0x0800b5ae: 0600        lsls	r0, r0, #24
@   0x0800b5b0: 4282        cmp	r2, r0
@   0x0800b5b2: db9a        blt.n	0xb4ea
@   0x0800b5b4: 9c05        ldr	r4, [sp, #20]
@   0x0800b5b6: 1561        asrs	r1, r4, #21
@   0x0800b5b8: 9e03        ldr	r6, [sp, #12]
@   0x0800b5ba: 1989        adds	r1, r1, r6
@   0x0800b5bc: 4803        ldr	r0, [pc, #12]	@ (0xb5cc)
@   0x0800b5be: 6800        ldr	r0, [r0, #0]
@   0x0800b5c0: 6008        str	r0, [r1, #0]
@   0x0800b5c2: 2001        movs	r0, #1
@   0x0800b5c4: 7148        strb	r0, [r1, #5]
@   0x0800b5c6: e0dc        b.n	0xb782
@   0x0800b5c8: 0b00        lsrs	r0, r0, #12
@   0x0800b5ca: 080c        lsrs	r4, r1, #32
@   0x0800b5cc: 5330        strh	r0, [r6, r4]
@   0x0800b5ce: 0300        lsls	r0, r0, #12
@   0x0800b5d0: 4806        ldr	r0, [pc, #24]	@ (0xb5ec)
@   0x0800b5d2: 6800        ldr	r0, [r0, #0]
@   0x0800b5d4: 6811        ldr	r1, [r2, #0]
@   0x0800b5d6: 1a40        subs	r0, r0, r1
@   0x0800b5d8: 280a        cmp	r0, #10
@   0x0800b5da: d800        bhi.n	0xb5de
@   0x0800b5dc: e0d1        b.n	0xb782
@   0x0800b5de: 7990        ldrb	r0, [r2, #6]
@   0x0800b5e0: 2805        cmp	r0, #5
@   0x0800b5e2: d105        bne.n	0xb5f0
@   0x0800b5e4: 2002        movs	r0, #2
@   0x0800b5e6: 7110        strb	r0, [r2, #4]
@   0x0800b5e8: e0cb        b.n	0xb782
@   0x0800b5ea: 0000        movs	r0, r0
@   0x0800b5ec: 5330        strh	r0, [r6, r4]
@   0x0800b5ee: 0300        lsls	r0, r0, #12
@   0x0800b5f0: 2801        cmp	r0, #1
@   0x0800b5f2: d145        bne.n	0xb680
@   0x0800b5f4: 2400        movs	r4, #0
@   0x0800b5f6: 46ca        mov	sl, r9
@   0x0800b5f8: 464f        mov	r7, r9
@   0x0800b5fa: 1638        asrs	r0, r7, #24
@   0x0800b5fc: 0041        lsls	r1, r0, #1
@   0x0800b5fe: 1809        adds	r1, r1, r0
@   0x0800b600: 0089        lsls	r1, r1, #2
@   0x0800b602: 4845        ldr	r0, [pc, #276]	@ (0xb718)
@   0x0800b604: 1809        adds	r1, r1, r0
@   0x0800b606: 2000        movs	r0, #0
@   0x0800b608: 5608        ldrsb	r0, [r1, r0]
@   0x0800b60a: 4284        cmp	r4, r0
@   0x0800b60c: da38        bge.n	0xb680
@   0x0800b60e: 4942        ldr	r1, [pc, #264]	@ (0xb718)
@   0x0800b610: 3104        adds	r1, #4
@   0x0800b612: 4688        mov	r8, r1
@   0x0800b614: 4652        mov	r2, sl
@   0x0800b616: 1616        asrs	r6, r2, #24
@   0x0800b618: 4840        ldr	r0, [pc, #256]	@ (0xb71c)
@   0x0800b61a: 7e00        ldrb	r0, [r0, #24]
@   0x0800b61c: 0625        lsls	r5, r4, #24
@   0x0800b61e: 0074        lsls	r4, r6, #1
@   0x0800b620: 19a4        adds	r4, r4, r6
@   0x0800b622: 00a4        lsls	r4, r4, #2
@   0x0800b624: 4643        mov	r3, r8
@   0x0800b626: 18e1        adds	r1, r4, r3
@   0x0800b628: 680a        ldr	r2, [r1, #0]
@   0x0800b62a: 0da9        lsrs	r1, r5, #22
@   0x0800b62c: 1889        adds	r1, r1, r2
@   0x0800b62e: 2700        movs	r7, #0
@   0x0800b630: 5fca        ldrsh	r2, [r1, r7]
@   0x0800b632: 2702        movs	r7, #2
@   0x0800b634: 5fcb        ldrsh	r3, [r1, r7]
@   0x0800b636: 4938        ldr	r1, [pc, #224]	@ (0xb718)
@   0x0800b638: 1864        adds	r4, r4, r1
@   0x0800b63a: 7a61        ldrb	r1, [r4, #9]
@   0x0800b63c: 9100        str	r1, [sp, #0]
@   0x0800b63e: 2100        movs	r1, #0
@   0x0800b640: f001        fa9e 	bl	0xcb80
@   0x0800b644: 0073        lsls	r3, r6, #1
@   0x0800b646: 199b        adds	r3, r3, r6
@   0x0800b648: 009b        lsls	r3, r3, #2
@   0x0800b64a: 4642        mov	r2, r8
@   0x0800b64c: 1898        adds	r0, r3, r2
@   0x0800b64e: 162d        asrs	r5, r5, #24
@   0x0800b650: 6800        ldr	r0, [r0, #0]
@   0x0800b652: 00aa        lsls	r2, r5, #2
@   0x0800b654: 1812        adds	r2, r2, r0
@   0x0800b656: 2402        movs	r4, #2
@   0x0800b658: 5f11        ldrsh	r1, [r2, r4]
@   0x0800b65a: 00c8        lsls	r0, r1, #3
@   0x0800b65c: 1a40        subs	r0, r0, r1
@   0x0800b65e: 0040        lsls	r0, r0, #1
@   0x0800b660: 2600        movs	r6, #0
@   0x0800b662: 5f91        ldrsh	r1, [r2, r6]
@   0x0800b664: 1840        adds	r0, r0, r1
@   0x0800b666: 4f2e        ldr	r7, [pc, #184]	@ (0xb720)
@   0x0800b668: 19c0        adds	r0, r0, r7
@   0x0800b66a: 2100        movs	r1, #0
@   0x0800b66c: 7001        strb	r1, [r0, #0]
@   0x0800b66e: 3501        adds	r5, #1
@   0x0800b670: 062d        lsls	r5, r5, #24
@   0x0800b672: 4829        ldr	r0, [pc, #164]	@ (0xb718)
@   0x0800b674: 181b        adds	r3, r3, r0
@   0x0800b676: 0e2c        lsrs	r4, r5, #24
@   0x0800b678: 781b        ldrb	r3, [r3, #0]
@   0x0800b67a: 0618        lsls	r0, r3, #24
@   0x0800b67c: 4285        cmp	r5, r0
@   0x0800b67e: dbc9        blt.n	0xb614
@   0x0800b680: 9905        ldr	r1, [sp, #20]
@   0x0800b682: 1548        asrs	r0, r1, #21
@   0x0800b684: 9b03        ldr	r3, [sp, #12]
@   0x0800b686: 18c2        adds	r2, r0, r3
@   0x0800b688: 7990        ldrb	r0, [r2, #6]
@   0x0800b68a: 3001        adds	r0, #1
@   0x0800b68c: 7190        strb	r0, [r2, #6]
@   0x0800b68e: 2400        movs	r4, #0
@   0x0800b690: 4d21        ldr	r5, [pc, #132]	@ (0xb718)
@   0x0800b692: 464b        mov	r3, r9
@   0x0800b694: 1619        asrs	r1, r3, #24
@   0x0800b696: 0048        lsls	r0, r1, #1
@   0x0800b698: 1840        adds	r0, r0, r1
@   0x0800b69a: 0080        lsls	r0, r0, #2
@   0x0800b69c: 1940        adds	r0, r0, r5
@   0x0800b69e: 7800        ldrb	r0, [r0, #0]
@   0x0800b6a0: 0600        lsls	r0, r0, #24
@   0x0800b6a2: 1600        asrs	r0, r0, #24
@   0x0800b6a4: 4284        cmp	r4, r0
@   0x0800b6a6: da65        bge.n	0xb774
@   0x0800b6a8: 9e04        ldr	r6, [sp, #16]
@   0x0800b6aa: 46b0        mov	r8, r6
@   0x0800b6ac: 4692        mov	sl, r2
@   0x0800b6ae: 491b        ldr	r1, [pc, #108]	@ (0xb71c)
@   0x0800b6b0: 7e08        ldrb	r0, [r1, #24]
@   0x0800b6b2: 7e49        ldrb	r1, [r1, #25]
@   0x0800b6b4: 161b        asrs	r3, r3, #24
@   0x0800b6b6: 005a        lsls	r2, r3, #1
@   0x0800b6b8: 18d2        adds	r2, r2, r3
@   0x0800b6ba: 0092        lsls	r2, r2, #2
@   0x0800b6bc: 1d2b        adds	r3, r5, #4
@   0x0800b6be: 18d5        adds	r5, r2, r3
@   0x0800b6c0: 0624        lsls	r4, r4, #24
@   0x0800b6c2: 682b        ldr	r3, [r5, #0]
@   0x0800b6c4: 15a6        asrs	r6, r4, #22
@   0x0800b6c6: 18f3        adds	r3, r6, r3
@   0x0800b6c8: 2700        movs	r7, #0
@   0x0800b6ca: 5fda        ldrsh	r2, [r3, r7]
@   0x0800b6cc: 885b        ldrh	r3, [r3, #2]
@   0x0800b6ce: 3301        adds	r3, #1
@   0x0800b6d0: 041b        lsls	r3, r3, #16
@   0x0800b6d2: 141b        asrs	r3, r3, #16
@   0x0800b6d4: f001        fb58 	bl	0xcd88
@   0x0800b6d8: 0600        lsls	r0, r0, #24
@   0x0800b6da: 0e00        lsrs	r0, r0, #24
@   0x0800b6dc: 2808        cmp	r0, #8
@   0x0800b6de: d001        beq.n	0xb6e4
@   0x0800b6e0: 280b        cmp	r0, #11
@   0x0800b6e2: d11f        bne.n	0xb724
@   0x0800b6e4: 6829        ldr	r1, [r5, #0]
@   0x0800b6e6: 1871        adds	r1, r6, r1
@   0x0800b6e8: 2200        movs	r2, #0
@   0x0800b6ea: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b6ec: 0043        lsls	r3, r0, #1
@   0x0800b6ee: 181b        adds	r3, r3, r0
@   0x0800b6f0: 041b        lsls	r3, r3, #16
@   0x0800b6f2: 0c1b        lsrs	r3, r3, #16
@   0x0800b6f4: 2602        movs	r6, #2
@   0x0800b6f6: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b6f8: 0048        lsls	r0, r1, #1
@   0x0800b6fa: 1840        adds	r0, r0, r1
@   0x0800b6fc: 0400        lsls	r0, r0, #16
@   0x0800b6fe: 0c00        lsrs	r0, r0, #16
@   0x0800b700: 9000        str	r0, [sp, #0]
@   0x0800b702: 4647        mov	r7, r8
@   0x0800b704: 9701        str	r7, [sp, #4]
@   0x0800b706: 4651        mov	r1, sl
@   0x0800b708: 7988        ldrb	r0, [r1, #6]
@   0x0800b70a: 9002        str	r0, [sp, #8]
@   0x0800b70c: 2000        movs	r0, #0
@   0x0800b70e: 2104        movs	r1, #4
@   0x0800b710: 2203        movs	r2, #3
@   0x0800b712: f005        fdd5 	bl	0x112c0
@   0x0800b716: e01e        b.n	0xb756
@   0x0800b718: 0b00        lsrs	r0, r0, #12
@   0x0800b71a: 080c        lsrs	r4, r1, #32
@   0x0800b71c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800b71e: 0300        lsls	r0, r0, #12
@   0x0800b720: 3610        adds	r6, #16
@   0x0800b722: 0300        lsls	r0, r0, #12
@   0x0800b724: 6829        ldr	r1, [r5, #0]
@   0x0800b726: 1871        adds	r1, r6, r1
@   0x0800b728: 2200        movs	r2, #0
@   0x0800b72a: 5e88        ldrsh	r0, [r1, r2]
@   0x0800b72c: 0043        lsls	r3, r0, #1
@   0x0800b72e: 181b        adds	r3, r3, r0
@   0x0800b730: 041b        lsls	r3, r3, #16
@   0x0800b732: 0c1b        lsrs	r3, r3, #16
@   0x0800b734: 2602        movs	r6, #2
@   0x0800b736: 5f89        ldrsh	r1, [r1, r6]
@   0x0800b738: 0048        lsls	r0, r1, #1
@   0x0800b73a: 1840        adds	r0, r0, r1
@   0x0800b73c: 0400        lsls	r0, r0, #16
@   0x0800b73e: 0c00        lsrs	r0, r0, #16
@   0x0800b740: 9000        str	r0, [sp, #0]
@   0x0800b742: 4647        mov	r7, r8
@   0x0800b744: 9701        str	r7, [sp, #4]
@   0x0800b746: 4651        mov	r1, sl
@   0x0800b748: 7988        ldrb	r0, [r1, #6]
@   0x0800b74a: 9002        str	r0, [sp, #8]
@   0x0800b74c: 2000        movs	r0, #0
@   0x0800b74e: 2103        movs	r1, #3
@   0x0800b750: 2203        movs	r2, #3
@   0x0800b752: f005        fdb5 	bl	0x112c0
@   0x0800b756: 2380        movs	r3, #128	@ 0x80
@   0x0800b758: 045b        lsls	r3, r3, #17
@   0x0800b75a: 18e2        adds	r2, r4, r3
@   0x0800b75c: 4d12        ldr	r5, [pc, #72]	@ (0xb7a8)
@   0x0800b75e: 464b        mov	r3, r9
@   0x0800b760: 1619        asrs	r1, r3, #24
@   0x0800b762: 0048        lsls	r0, r1, #1
@   0x0800b764: 1840        adds	r0, r0, r1
@   0x0800b766: 0080        lsls	r0, r0, #2
@   0x0800b768: 1940        adds	r0, r0, r5
@   0x0800b76a: 0e14        lsrs	r4, r2, #24
@   0x0800b76c: 7800        ldrb	r0, [r0, #0]
@   0x0800b76e: 0600        lsls	r0, r0, #24
@   0x0800b770: 4282        cmp	r2, r0
@   0x0800b772: db9c        blt.n	0xb6ae
@   0x0800b774: 9c05        ldr	r4, [sp, #20]
@   0x0800b776: 1560        asrs	r0, r4, #21
@   0x0800b778: 9e03        ldr	r6, [sp, #12]
@   0x0800b77a: 1980        adds	r0, r0, r6
@   0x0800b77c: 490b        ldr	r1, [pc, #44]	@ (0xb7ac)
@   0x0800b77e: 6809        ldr	r1, [r1, #0]
@   0x0800b780: 6001        str	r1, [r0, #0]
@   0x0800b782: 9f05        ldr	r7, [sp, #20]
@   0x0800b784: 2080        movs	r0, #128	@ 0x80
@   0x0800b786: 0440        lsls	r0, r0, #17
@   0x0800b788: 1839        adds	r1, r7, r0
@   0x0800b78a: 4448        add	r0, r9
@   0x0800b78c: 0e00        lsrs	r0, r0, #24
@   0x0800b78e: 0e0a        lsrs	r2, r1, #24
@   0x0800b790: 1609        asrs	r1, r1, #24
@   0x0800b792: 2903        cmp	r1, #3
@   0x0800b794: dc00        bgt.n	0xb798
@   0x0800b796: e4f8        b.n	0xb18a
@   0x0800b798: b006        add	sp, #24
@   0x0800b79a: bc38        pop	{r3, r4, r5}
@   0x0800b79c: 4698        mov	r8, r3
@   0x0800b79e: 46a1        mov	r9, r4
@   0x0800b7a0: 46aa        mov	sl, r5
@   0x0800b7a2: bcf0        pop	{r4, r5, r6, r7}
@   0x0800b7a4: bc01        pop	{r0}
@   0x0800b7a6: 4700        bx	r0
@   0x0800b7a8: 0b00        lsrs	r0, r0, #12
@   0x0800b7aa: 080c        lsrs	r4, r1, #32
@   0x0800b7ac: 5330        strh	r0, [r6, r4]
@   0x0800b7ae: 0300        lsls	r0, r0, #12

        thumb_func_start Entity_BlitAndCheckTiles
Entity_BlitAndCheckTiles: @ 0x0800b178
        .incbin "frog_us_baserom.gba", 0xb178, 0x638
        thumb_func_end Entity_BlitAndCheckTiles
