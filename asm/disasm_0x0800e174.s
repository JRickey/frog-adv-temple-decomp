@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e174, 0x0800e4bc)  (840 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e174 --end 0x800e4bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e174: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800e176: 4657        mov	r7, sl
@   0x0800e178: 464e        mov	r6, r9
@   0x0800e17a: 4645        mov	r5, r8
@   0x0800e17c: b4e0        push	{r5, r6, r7}
@   0x0800e17e: b085        sub	sp, #20
@   0x0800e180: 490f        ldr	r1, [pc, #60]	@ (0xe1c0)
@   0x0800e182: 4810        ldr	r0, [pc, #64]	@ (0xe1c4)
@   0x0800e184: 6800        ldr	r0, [r0, #0]
@   0x0800e186: 0080        lsls	r0, r0, #2
@   0x0800e188: 1840        adds	r0, r0, r1
@   0x0800e18a: 6800        ldr	r0, [r0, #0]
@   0x0800e18c: 4680        mov	r8, r0
@   0x0800e18e: 2000        movs	r0, #0
@   0x0800e190: 4682        mov	sl, r0
@   0x0800e192: 4651        mov	r1, sl
@   0x0800e194: 0088        lsls	r0, r1, #2
@   0x0800e196: 4a0c        ldr	r2, [pc, #48]	@ (0xe1c8)
@   0x0800e198: 1881        adds	r1, r0, r2
@   0x0800e19a: 780a        ldrb	r2, [r1, #0]
@   0x0800e19c: 2180        movs	r1, #128	@ 0x80
@   0x0800e19e: 4011        ands	r1, r2
@   0x0800e1a0: 9004        str	r0, [sp, #16]
@   0x0800e1a2: 4653        mov	r3, sl
@   0x0800e1a4: 3301        adds	r3, #1
@   0x0800e1a6: 9303        str	r3, [sp, #12]
@   0x0800e1a8: 2900        cmp	r1, #0
@   0x0800e1aa: d000        beq.n	0xe1ae
@   0x0800e1ac: e15c        b.n	0xe468
@   0x0800e1ae: 200f        movs	r0, #15
@   0x0800e1b0: 4010        ands	r0, r2
@   0x0800e1b2: 2802        cmp	r0, #2
@   0x0800e1b4: d05e        beq.n	0xe274
@   0x0800e1b6: 2802        cmp	r0, #2
@   0x0800e1b8: dc08        bgt.n	0xe1cc
@   0x0800e1ba: 2801        cmp	r0, #1
@   0x0800e1bc: d00d        beq.n	0xe1da
@   0x0800e1be: e153        b.n	0xe468
@   0x0800e1c0: 6824        ldr	r4, [r4, #0]
@   0x0800e1c2: 0830        lsrs	r0, r6, #32
@   0x0800e1c4: 34b0        adds	r4, #176	@ 0xb0
@   0x0800e1c6: 0300        lsls	r0, r0, #12
@   0x0800e1c8: 5370        strh	r0, [r6, r5]
@   0x0800e1ca: 0300        lsls	r0, r0, #12
@   0x0800e1cc: 2803        cmp	r0, #3
@   0x0800e1ce: d100        bne.n	0xe1d2
@   0x0800e1d0: e0a4        b.n	0xe31c
@   0x0800e1d2: 2809        cmp	r0, #9
@   0x0800e1d4: d100        bne.n	0xe1d8
@   0x0800e1d6: e103        b.n	0xe3e0
@   0x0800e1d8: e146        b.n	0xe468
@   0x0800e1da: 4d14        ldr	r5, [pc, #80]	@ (0xe22c)
@   0x0800e1dc: 4657        mov	r7, sl
@   0x0800e1de: 0079        lsls	r1, r7, #1
@   0x0800e1e0: 19c8        adds	r0, r1, r7
@   0x0800e1e2: 0080        lsls	r0, r0, #2
@   0x0800e1e4: 4440        add	r0, r8
@   0x0800e1e6: 6886        ldr	r6, [r0, #8]
@   0x0800e1e8: 2400        movs	r4, #0
@   0x0800e1ea: 8840        ldrh	r0, [r0, #2]
@   0x0800e1ec: 4284        cmp	r4, r0
@   0x0800e1ee: d206        bcs.n	0xe1fe
@   0x0800e1f0: 1c02        adds	r2, r0, #0
@   0x0800e1f2: 3540        adds	r5, #64	@ 0x40
@   0x0800e1f4: 1c60        adds	r0, r4, #1
@   0x0800e1f6: 0400        lsls	r0, r0, #16
@   0x0800e1f8: 0c04        lsrs	r4, r0, #16
@   0x0800e1fa: 4294        cmp	r4, r2
@   0x0800e1fc: d3f9        bcc.n	0xe1f2
@   0x0800e1fe: 2400        movs	r4, #0
@   0x0800e200: 1c0a        adds	r2, r1, #0
@   0x0800e202: 4653        mov	r3, sl
@   0x0800e204: 18c8        adds	r0, r1, r3
@   0x0800e206: 0080        lsls	r0, r0, #2
@   0x0800e208: 4440        add	r0, r8
@   0x0800e20a: 8887        ldrh	r7, [r0, #4]
@   0x0800e20c: 42bc        cmp	r4, r7
@   0x0800e20e: d226        bcs.n	0xe25e
@   0x0800e210: 1c0f        adds	r7, r1, #0
@   0x0800e212: 1c01        adds	r1, r0, #0
@   0x0800e214: 4653        mov	r3, sl
@   0x0800e216: 18d0        adds	r0, r2, r3
@   0x0800e218: 0080        lsls	r0, r0, #2
@   0x0800e21a: 4643        mov	r3, r8
@   0x0800e21c: 18c2        adds	r2, r0, r3
@   0x0800e21e: 8813        ldrh	r3, [r2, #0]
@   0x0800e220: 0058        lsls	r0, r3, #1
@   0x0800e222: 182d        adds	r5, r5, r0
@   0x0800e224: 2300        movs	r3, #0
@   0x0800e226: 3401        adds	r4, #1
@   0x0800e228: e009        b.n	0xe23e
@   0x0800e22a: 0000        movs	r0, r0
@   0x0800e22c: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0800e230: 8830        ldrh	r0, [r6, #0]
@   0x0800e232: 8028        strh	r0, [r5, #0]
@   0x0800e234: 3602        adds	r6, #2
@   0x0800e236: 3502        adds	r5, #2
@   0x0800e238: 1c58        adds	r0, r3, #1
@   0x0800e23a: 0400        lsls	r0, r0, #16
@   0x0800e23c: 0c03        lsrs	r3, r0, #16
@   0x0800e23e: 88d0        ldrh	r0, [r2, #6]
@   0x0800e240: 4283        cmp	r3, r0
@   0x0800e242: d3f5        bcc.n	0xe230
@   0x0800e244: 2020        movs	r0, #32
@   0x0800e246: 880a        ldrh	r2, [r1, #0]
@   0x0800e248: 1a80        subs	r0, r0, r2
@   0x0800e24a: 88cb        ldrh	r3, [r1, #6]
@   0x0800e24c: 1ac0        subs	r0, r0, r3
@   0x0800e24e: 0040        lsls	r0, r0, #1
@   0x0800e250: 182d        adds	r5, r5, r0
@   0x0800e252: 0420        lsls	r0, r4, #16
@   0x0800e254: 0c04        lsrs	r4, r0, #16
@   0x0800e256: 1c3a        adds	r2, r7, #0
@   0x0800e258: 8888        ldrh	r0, [r1, #4]
@   0x0800e25a: 4284        cmp	r4, r0
@   0x0800e25c: d3da        bcc.n	0xe214
@   0x0800e25e: 9904        ldr	r1, [sp, #16]
@   0x0800e260: 4a03        ldr	r2, [pc, #12]	@ (0xe270)
@   0x0800e262: 1888        adds	r0, r1, r2
@   0x0800e264: 2180        movs	r1, #128	@ 0x80
@   0x0800e266: 7803        ldrb	r3, [r0, #0]
@   0x0800e268: 4319        orrs	r1, r3
@   0x0800e26a: 7001        strb	r1, [r0, #0]
@   0x0800e26c: e0fc        b.n	0xe468
@   0x0800e26e: 0000        movs	r0, r0
@   0x0800e270: 5370        strh	r0, [r6, r5]
@   0x0800e272: 0300        lsls	r0, r0, #12
@   0x0800e274: 4d26        ldr	r5, [pc, #152]	@ (0xe310)
@   0x0800e276: 4657        mov	r7, sl
@   0x0800e278: 0079        lsls	r1, r7, #1
@   0x0800e27a: 19c8        adds	r0, r1, r7
@   0x0800e27c: 0080        lsls	r0, r0, #2
@   0x0800e27e: 4440        add	r0, r8
@   0x0800e280: 6886        ldr	r6, [r0, #8]
@   0x0800e282: 2400        movs	r4, #0
@   0x0800e284: 8840        ldrh	r0, [r0, #2]
@   0x0800e286: 4284        cmp	r4, r0
@   0x0800e288: d206        bcs.n	0xe298
@   0x0800e28a: 1c02        adds	r2, r0, #0
@   0x0800e28c: 3540        adds	r5, #64	@ 0x40
@   0x0800e28e: 1c60        adds	r0, r4, #1
@   0x0800e290: 0400        lsls	r0, r0, #16
@   0x0800e292: 0c04        lsrs	r4, r0, #16
@   0x0800e294: 4294        cmp	r4, r2
@   0x0800e296: d3f9        bcc.n	0xe28c
@   0x0800e298: 2400        movs	r4, #0
@   0x0800e29a: 1c0a        adds	r2, r1, #0
@   0x0800e29c: 4653        mov	r3, sl
@   0x0800e29e: 18c8        adds	r0, r1, r3
@   0x0800e2a0: 0080        lsls	r0, r0, #2
@   0x0800e2a2: 4440        add	r0, r8
@   0x0800e2a4: 8887        ldrh	r7, [r0, #4]
@   0x0800e2a6: 42bc        cmp	r4, r7
@   0x0800e2a8: d22a        bcs.n	0xe300
@   0x0800e2aa: 4689        mov	r9, r1
@   0x0800e2ac: 1c07        adds	r7, r0, #0
@   0x0800e2ae: 4651        mov	r1, sl
@   0x0800e2b0: 1850        adds	r0, r2, r1
@   0x0800e2b2: 0080        lsls	r0, r0, #2
@   0x0800e2b4: 4642        mov	r2, r8
@   0x0800e2b6: 1881        adds	r1, r0, r2
@   0x0800e2b8: 880b        ldrh	r3, [r1, #0]
@   0x0800e2ba: 0058        lsls	r0, r3, #1
@   0x0800e2bc: 182d        adds	r5, r5, r0
@   0x0800e2be: 2300        movs	r3, #0
@   0x0800e2c0: 3401        adds	r4, #1
@   0x0800e2c2: 88c8        ldrh	r0, [r1, #6]
@   0x0800e2c4: 4283        cmp	r3, r0
@   0x0800e2c6: d20e        bcs.n	0xe2e6
@   0x0800e2c8: 4a12        ldr	r2, [pc, #72]	@ (0xe314)
@   0x0800e2ca: 4694        mov	ip, r2
@   0x0800e2cc: 1c0a        adds	r2, r1, #0
@   0x0800e2ce: 8830        ldrh	r0, [r6, #0]
@   0x0800e2d0: 3602        adds	r6, #2
@   0x0800e2d2: 4661        mov	r1, ip
@   0x0800e2d4: 4001        ands	r1, r0
@   0x0800e2d6: 8029        strh	r1, [r5, #0]
@   0x0800e2d8: 3502        adds	r5, #2
@   0x0800e2da: 1c58        adds	r0, r3, #1
@   0x0800e2dc: 0400        lsls	r0, r0, #16
@   0x0800e2de: 0c03        lsrs	r3, r0, #16
@   0x0800e2e0: 88d0        ldrh	r0, [r2, #6]
@   0x0800e2e2: 4283        cmp	r3, r0
@   0x0800e2e4: d3f3        bcc.n	0xe2ce
@   0x0800e2e6: 2020        movs	r0, #32
@   0x0800e2e8: 8839        ldrh	r1, [r7, #0]
@   0x0800e2ea: 1a40        subs	r0, r0, r1
@   0x0800e2ec: 88fa        ldrh	r2, [r7, #6]
@   0x0800e2ee: 1a80        subs	r0, r0, r2
@   0x0800e2f0: 0040        lsls	r0, r0, #1
@   0x0800e2f2: 182d        adds	r5, r5, r0
@   0x0800e2f4: 0420        lsls	r0, r4, #16
@   0x0800e2f6: 0c04        lsrs	r4, r0, #16
@   0x0800e2f8: 464a        mov	r2, r9
@   0x0800e2fa: 88bb        ldrh	r3, [r7, #4]
@   0x0800e2fc: 429c        cmp	r4, r3
@   0x0800e2fe: d3d6        bcc.n	0xe2ae
@   0x0800e300: 9f04        ldr	r7, [sp, #16]
@   0x0800e302: 4905        ldr	r1, [pc, #20]	@ (0xe318)
@   0x0800e304: 1878        adds	r0, r7, r1
@   0x0800e306: 2180        movs	r1, #128	@ 0x80
@   0x0800e308: 7802        ldrb	r2, [r0, #0]
@   0x0800e30a: 4311        orrs	r1, r2
@   0x0800e30c: 7001        strb	r1, [r0, #0]
@   0x0800e30e: e0ab        b.n	0xe468
@   0x0800e310: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0800e314: efff        0000 	vext.8	d16, d15, d0, #0
@   0x0800e318: 5370        strh	r0, [r6, r5]
@   0x0800e31a: 0300        lsls	r0, r0, #12
@   0x0800e31c: 482d        ldr	r0, [pc, #180]	@ (0xe3d4)
@   0x0800e31e: 6840        ldr	r0, [r0, #4]
@   0x0800e320: 2107        movs	r1, #7
@   0x0800e322: 4008        ands	r0, r1
@   0x0800e324: 2800        cmp	r0, #0
@   0x0800e326: d000        beq.n	0xe32a
@   0x0800e328: e09e        b.n	0xe468
@   0x0800e32a: 4d2b        ldr	r5, [pc, #172]	@ (0xe3d8)
@   0x0800e32c: 4653        mov	r3, sl
@   0x0800e32e: 0059        lsls	r1, r3, #1
@   0x0800e330: 18c8        adds	r0, r1, r3
@   0x0800e332: 0080        lsls	r0, r0, #2
@   0x0800e334: 4440        add	r0, r8
@   0x0800e336: 6886        ldr	r6, [r0, #8]
@   0x0800e338: 2400        movs	r4, #0
@   0x0800e33a: 8840        ldrh	r0, [r0, #2]
@   0x0800e33c: 4284        cmp	r4, r0
@   0x0800e33e: d206        bcs.n	0xe34e
@   0x0800e340: 1c02        adds	r2, r0, #0
@   0x0800e342: 3540        adds	r5, #64	@ 0x40
@   0x0800e344: 1c60        adds	r0, r4, #1
@   0x0800e346: 0400        lsls	r0, r0, #16
@   0x0800e348: 0c04        lsrs	r4, r0, #16
@   0x0800e34a: 4294        cmp	r4, r2
@   0x0800e34c: d3f9        bcc.n	0xe342
@   0x0800e34e: 2400        movs	r4, #0
@   0x0800e350: 1c0b        adds	r3, r1, #0
@   0x0800e352: 4657        mov	r7, sl
@   0x0800e354: 19c8        adds	r0, r1, r7
@   0x0800e356: 0080        lsls	r0, r0, #2
@   0x0800e358: 4647        mov	r7, r8
@   0x0800e35a: 19c2        adds	r2, r0, r7
@   0x0800e35c: 8897        ldrh	r7, [r2, #4]
@   0x0800e35e: 42bc        cmp	r4, r7
@   0x0800e360: d300        bcc.n	0xe364
@   0x0800e362: e081        b.n	0xe468
@   0x0800e364: 9102        str	r1, [sp, #8]
@   0x0800e366: 4694        mov	ip, r2
@   0x0800e368: 9001        str	r0, [sp, #4]
@   0x0800e36a: 4651        mov	r1, sl
@   0x0800e36c: 1858        adds	r0, r3, r1
@   0x0800e36e: 0080        lsls	r0, r0, #2
@   0x0800e370: 4440        add	r0, r8
@   0x0800e372: 8802        ldrh	r2, [r0, #0]
@   0x0800e374: 0051        lsls	r1, r2, #1
@   0x0800e376: 186d        adds	r5, r5, r1
@   0x0800e378: 2300        movs	r3, #0
@   0x0800e37a: 3401        adds	r4, #1
@   0x0800e37c: 88c0        ldrh	r0, [r0, #6]
@   0x0800e37e: 4283        cmp	r3, r0
@   0x0800e380: d216        bcs.n	0xe3b0
@   0x0800e382: 4814        ldr	r0, [pc, #80]	@ (0xe3d4)
@   0x0800e384: 6842        ldr	r2, [r0, #4]
@   0x0800e386: 200f        movs	r0, #15
@   0x0800e388: 4002        ands	r2, r0
@   0x0800e38a: 4f14        ldr	r7, [pc, #80]	@ (0xe3dc)
@   0x0800e38c: 46b9        mov	r9, r7
@   0x0800e38e: 9f01        ldr	r7, [sp, #4]
@   0x0800e390: 4447        add	r7, r8
@   0x0800e392: 8831        ldrh	r1, [r6, #0]
@   0x0800e394: 8029        strh	r1, [r5, #0]
@   0x0800e396: 3602        adds	r6, #2
@   0x0800e398: 2a00        cmp	r2, #0
@   0x0800e39a: d102        bne.n	0xe3a2
@   0x0800e39c: 4648        mov	r0, r9
@   0x0800e39e: 4008        ands	r0, r1
@   0x0800e3a0: 8028        strh	r0, [r5, #0]
@   0x0800e3a2: 3502        adds	r5, #2
@   0x0800e3a4: 1c58        adds	r0, r3, #1
@   0x0800e3a6: 0400        lsls	r0, r0, #16
@   0x0800e3a8: 0c03        lsrs	r3, r0, #16
@   0x0800e3aa: 88f8        ldrh	r0, [r7, #6]
@   0x0800e3ac: 4283        cmp	r3, r0
@   0x0800e3ae: d3f0        bcc.n	0xe392
@   0x0800e3b0: 2020        movs	r0, #32
@   0x0800e3b2: 4661        mov	r1, ip
@   0x0800e3b4: 8809        ldrh	r1, [r1, #0]
@   0x0800e3b6: 1a40        subs	r0, r0, r1
@   0x0800e3b8: 4662        mov	r2, ip
@   0x0800e3ba: 88d2        ldrh	r2, [r2, #6]
@   0x0800e3bc: 1a80        subs	r0, r0, r2
@   0x0800e3be: 0040        lsls	r0, r0, #1
@   0x0800e3c0: 182d        adds	r5, r5, r0
@   0x0800e3c2: 0420        lsls	r0, r4, #16
@   0x0800e3c4: 0c04        lsrs	r4, r0, #16
@   0x0800e3c6: 9b02        ldr	r3, [sp, #8]
@   0x0800e3c8: 4667        mov	r7, ip
@   0x0800e3ca: 88bf        ldrh	r7, [r7, #4]
@   0x0800e3cc: 42bc        cmp	r4, r7
@   0x0800e3ce: d3cc        bcc.n	0xe36a
@   0x0800e3d0: e04a        b.n	0xe468
@   0x0800e3d2: 0000        movs	r0, r0
@   0x0800e3d4: 5330        strh	r0, [r6, r4]
@   0x0800e3d6: 0300        lsls	r0, r0, #12
@   0x0800e3d8: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0800e3dc: efff        0000 	vext.8	d16, d15, d0, #0
@   0x0800e3e0: 4d30        ldr	r5, [pc, #192]	@ (0xe4a4)
@   0x0800e3e2: 4650        mov	r0, sl
@   0x0800e3e4: 0041        lsls	r1, r0, #1
@   0x0800e3e6: 1808        adds	r0, r1, r0
@   0x0800e3e8: 0080        lsls	r0, r0, #2
@   0x0800e3ea: 4440        add	r0, r8
@   0x0800e3ec: 2400        movs	r4, #0
@   0x0800e3ee: 8840        ldrh	r0, [r0, #2]
@   0x0800e3f0: 4284        cmp	r4, r0
@   0x0800e3f2: d206        bcs.n	0xe402
@   0x0800e3f4: 1c02        adds	r2, r0, #0
@   0x0800e3f6: 3540        adds	r5, #64	@ 0x40
@   0x0800e3f8: 1c60        adds	r0, r4, #1
@   0x0800e3fa: 0400        lsls	r0, r0, #16
@   0x0800e3fc: 0c04        lsrs	r4, r0, #16
@   0x0800e3fe: 4294        cmp	r4, r2
@   0x0800e400: d3f9        bcc.n	0xe3f6
@   0x0800e402: 2400        movs	r4, #0
@   0x0800e404: 4652        mov	r2, sl
@   0x0800e406: 1888        adds	r0, r1, r2
@   0x0800e408: 0080        lsls	r0, r0, #2
@   0x0800e40a: 4440        add	r0, r8
@   0x0800e40c: 8883        ldrh	r3, [r0, #4]
@   0x0800e40e: 429c        cmp	r4, r3
@   0x0800e410: d225        bcs.n	0xe45e
@   0x0800e412: 1c0f        adds	r7, r1, #0
@   0x0800e414: 1c02        adds	r2, r0, #0
@   0x0800e416: 4653        mov	r3, sl
@   0x0800e418: 18c8        adds	r0, r1, r3
@   0x0800e41a: 0080        lsls	r0, r0, #2
@   0x0800e41c: 4643        mov	r3, r8
@   0x0800e41e: 18c1        adds	r1, r0, r3
@   0x0800e420: 880b        ldrh	r3, [r1, #0]
@   0x0800e422: 0058        lsls	r0, r3, #1
@   0x0800e424: 182d        adds	r5, r5, r0
@   0x0800e426: 2300        movs	r3, #0
@   0x0800e428: 3401        adds	r4, #1
@   0x0800e42a: 88c8        ldrh	r0, [r1, #6]
@   0x0800e42c: 4283        cmp	r3, r0
@   0x0800e42e: d209        bcs.n	0xe444
@   0x0800e430: 481d        ldr	r0, [pc, #116]	@ (0xe4a8)
@   0x0800e432: 1c06        adds	r6, r0, #0
@   0x0800e434: 802e        strh	r6, [r5, #0]
@   0x0800e436: 3502        adds	r5, #2
@   0x0800e438: 1c58        adds	r0, r3, #1
@   0x0800e43a: 0400        lsls	r0, r0, #16
@   0x0800e43c: 0c03        lsrs	r3, r0, #16
@   0x0800e43e: 88c8        ldrh	r0, [r1, #6]
@   0x0800e440: 4283        cmp	r3, r0
@   0x0800e442: d3f7        bcc.n	0xe434
@   0x0800e444: 2020        movs	r0, #32
@   0x0800e446: 8811        ldrh	r1, [r2, #0]
@   0x0800e448: 1a40        subs	r0, r0, r1
@   0x0800e44a: 88d3        ldrh	r3, [r2, #6]
@   0x0800e44c: 1ac0        subs	r0, r0, r3
@   0x0800e44e: 0040        lsls	r0, r0, #1
@   0x0800e450: 182d        adds	r5, r5, r0
@   0x0800e452: 0420        lsls	r0, r4, #16
@   0x0800e454: 0c04        lsrs	r4, r0, #16
@   0x0800e456: 1c39        adds	r1, r7, #0
@   0x0800e458: 8890        ldrh	r0, [r2, #4]
@   0x0800e45a: 4284        cmp	r4, r0
@   0x0800e45c: d3db        bcc.n	0xe416
@   0x0800e45e: 9a04        ldr	r2, [sp, #16]
@   0x0800e460: 4b12        ldr	r3, [pc, #72]	@ (0xe4ac)
@   0x0800e462: 18d1        adds	r1, r2, r3
@   0x0800e464: 2000        movs	r0, #0
@   0x0800e466: 7008        strb	r0, [r1, #0]
@   0x0800e468: 9f03        ldr	r7, [sp, #12]
@   0x0800e46a: 0638        lsls	r0, r7, #24
@   0x0800e46c: 0e00        lsrs	r0, r0, #24
@   0x0800e46e: 4682        mov	sl, r0
@   0x0800e470: 2804        cmp	r0, #4
@   0x0800e472: d800        bhi.n	0xe476
@   0x0800e474: e68d        b.n	0xe192
@   0x0800e476: 480e        ldr	r0, [pc, #56]	@ (0xe4b0)
@   0x0800e478: 7801        ldrb	r1, [r0, #0]
@   0x0800e47a: 2900        cmp	r1, #0
@   0x0800e47c: d10a        bne.n	0xe494
@   0x0800e47e: 4668        mov	r0, sp
@   0x0800e480: 8001        strh	r1, [r0, #0]
@   0x0800e482: 490c        ldr	r1, [pc, #48]	@ (0xe4b4)
@   0x0800e484: 6008        str	r0, [r1, #0]
@   0x0800e486: 4807        ldr	r0, [pc, #28]	@ (0xe4a4)
@   0x0800e488: 6048        str	r0, [r1, #4]
@   0x0800e48a: 480b        ldr	r0, [pc, #44]	@ (0xe4b8)
@   0x0800e48c: 6088        str	r0, [r1, #8]
@   0x0800e48e: 6888        ldr	r0, [r1, #8]
@   0x0800e490: f008        fad6 	bl	0x16a40
@   0x0800e494: b005        add	sp, #20
@   0x0800e496: bc38        pop	{r3, r4, r5}
@   0x0800e498: 4698        mov	r8, r3
@   0x0800e49a: 46a1        mov	r9, r4
@   0x0800e49c: 46aa        mov	sl, r5
@   0x0800e49e: bcf0        pop	{r4, r5, r6, r7}
@   0x0800e4a0: bc01        pop	{r0}
@   0x0800e4a2: 4700        bx	r0
@   0x0800e4a4: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0800e4a8: f039        0000 	bics.w	r0, r9, #0
@   0x0800e4ac: 5370        strh	r0, [r6, r5]
@   0x0800e4ae: 0300        lsls	r0, r0, #12
@   0x0800e4b0: 5328        strh	r0, [r5, r4]
@   0x0800e4b2: 0300        lsls	r0, r0, #12
@   0x0800e4b4: 00d4        lsls	r4, r2, #3
@   0x0800e4b6: 0400        lsls	r0, r0, #16
@   0x0800e4b8: 0400        lsls	r0, r0, #16
@   0x0800e4ba: 8100        strh	r0, [r0, #8]

        thumb_func_start UpdateBgTilemapFrames
UpdateBgTilemapFrames: @ 0x0800e174
        .incbin "frog_us_baserom.gba", 0xe174, 0x348
        thumb_func_end UpdateBgTilemapFrames
