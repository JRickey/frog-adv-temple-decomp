@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005fc8, 0x0800658c)  (1476 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005fc8 --end 0x800658c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005fc8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08005fca: 4657        mov	r7, sl
@   0x08005fcc: 464e        mov	r6, r9
@   0x08005fce: 4645        mov	r5, r8
@   0x08005fd0: b4e0        push	{r5, r6, r7}
@   0x08005fd2: b085        sub	sp, #20
@   0x08005fd4: 2000        movs	r0, #0
@   0x08005fd6: 9001        str	r0, [sp, #4]
@   0x08005fd8: 2100        movs	r1, #0
@   0x08005fda: 9100        str	r1, [sp, #0]
@   0x08005fdc: 482d        ldr	r0, [pc, #180]	@ (0x6094)
@   0x08005fde: 1c01        adds	r1, r0, #0
@   0x08005fe0: 3131        adds	r1, #49	@ 0x31
@   0x08005fe2: 1c06        adds	r6, r0, #0
@   0x08005fe4: 9a00        ldr	r2, [sp, #0]
@   0x08005fe6: 7809        ldrb	r1, [r1, #0]
@   0x08005fe8: 428a        cmp	r2, r1
@   0x08005fea: db00        blt.n	0x5fee
@   0x08005fec: e1d5        b.n	0x639a
@   0x08005fee: 482a        ldr	r0, [pc, #168]	@ (0x6098)
@   0x08005ff0: 9c00        ldr	r4, [sp, #0]
@   0x08005ff2: 00e3        lsls	r3, r4, #3
@   0x08005ff4: 1818        adds	r0, r3, r0
@   0x08005ff6: 7800        ldrb	r0, [r0, #0]
@   0x08005ff8: 4682        mov	sl, r0
@   0x08005ffa: 00c0        lsls	r0, r0, #3
@   0x08005ffc: 4655        mov	r5, sl
@   0x08005ffe: 1b40        subs	r0, r0, r5
@   0x08006000: 00c0        lsls	r0, r0, #3
@   0x08006002: 4f26        ldr	r7, [pc, #152]	@ (0x609c)
@   0x08006004: 19c0        adds	r0, r0, r7
@   0x08006006: 7801        ldrb	r1, [r0, #0]
@   0x08006008: 00ca        lsls	r2, r1, #3
@   0x0800600a: 4c25        ldr	r4, [pc, #148]	@ (0x60a0)
@   0x0800600c: 1912        adds	r2, r2, r4
@   0x0800600e: 7e85        ldrb	r5, [r0, #26]
@   0x08006010: 0069        lsls	r1, r5, #1
@   0x08006012: 1949        adds	r1, r1, r5
@   0x08006014: 0089        lsls	r1, r1, #2
@   0x08006016: 6810        ldr	r0, [r2, #0]
@   0x08006018: 1840        adds	r0, r0, r1
@   0x0800601a: 4681        mov	r9, r0
@   0x0800601c: 4821        ldr	r0, [pc, #132]	@ (0x60a4)
@   0x0800601e: 7a80        ldrb	r0, [r0, #10]
@   0x08006020: 3807        subs	r0, #7
@   0x08006022: 0600        lsls	r0, r0, #24
@   0x08006024: 0e00        lsrs	r0, r0, #24
@   0x08006026: 9303        str	r3, [sp, #12]
@   0x08006028: 1c3d        adds	r5, r7, #0
@   0x0800602a: 2802        cmp	r0, #2
@   0x0800602c: d813        bhi.n	0x6056
@   0x0800602e: 4657        mov	r7, sl
@   0x08006030: 2f00        cmp	r7, #0
@   0x08006032: d110        bne.n	0x6056
@   0x08006034: 1c29        adds	r1, r5, #0
@   0x08006036: 7809        ldrb	r1, [r1, #0]
@   0x08006038: 00c8        lsls	r0, r1, #3
@   0x0800603a: 1900        adds	r0, r0, r4
@   0x0800603c: 1c2a        adds	r2, r5, #0
@   0x0800603e: 7e92        ldrb	r2, [r2, #26]
@   0x08006040: 0051        lsls	r1, r2, #1
@   0x08006042: 1c2b        adds	r3, r5, #0
@   0x08006044: 7e9b        ldrb	r3, [r3, #26]
@   0x08006046: 18c9        adds	r1, r1, r3
@   0x08006048: 0089        lsls	r1, r1, #2
@   0x0800604a: 24f0        movs	r4, #240	@ 0xf0
@   0x0800604c: 0064        lsls	r4, r4, #1
@   0x0800604e: 1909        adds	r1, r1, r4
@   0x08006050: 6800        ldr	r0, [r0, #0]
@   0x08006052: 1840        adds	r0, r0, r1
@   0x08006054: 4681        mov	r9, r0
@   0x08006056: 4657        mov	r7, sl
@   0x08006058: 00f9        lsls	r1, r7, #3
@   0x0800605a: 1bc8        subs	r0, r1, r7
@   0x0800605c: 00c0        lsls	r0, r0, #3
@   0x0800605e: 9002        str	r0, [sp, #8]
@   0x08006060: 1947        adds	r7, r0, r5
@   0x08006062: 8eba        ldrh	r2, [r7, #52]	@ 0x34
@   0x08006064: 2380        movs	r3, #128	@ 0x80
@   0x08006066: 01db        lsls	r3, r3, #7
@   0x08006068: 1c18        adds	r0, r3, #0
@   0x0800606a: 4010        ands	r0, r2
@   0x0800606c: 9104        str	r1, [sp, #16]
@   0x0800606e: 2800        cmp	r0, #0
@   0x08006070: d01e        beq.n	0x60b0
@   0x08006072: 9c03        ldr	r4, [sp, #12]
@   0x08006074: 4d0c        ldr	r5, [pc, #48]	@ (0x60a8)
@   0x08006076: 1961        adds	r1, r4, r5
@   0x08006078: 2200        movs	r2, #0
@   0x0800607a: 20f0        movs	r0, #240	@ 0xf0
@   0x0800607c: 8008        strh	r0, [r1, #0]
@   0x0800607e: 1c28        adds	r0, r5, #0
@   0x08006080: 3002        adds	r0, #2
@   0x08006082: 1820        adds	r0, r4, r0
@   0x08006084: 8002        strh	r2, [r0, #0]
@   0x08006086: 4f09        ldr	r7, [pc, #36]	@ (0x60ac)
@   0x08006088: 19e0        adds	r0, r4, r7
@   0x0800608a: 8002        strh	r2, [r0, #0]
@   0x0800608c: 9c00        ldr	r4, [sp, #0]
@   0x0800608e: 3401        adds	r4, #1
@   0x08006090: e17c        b.n	0x638c
@   0x08006092: 0000        movs	r0, r0
@   0x08006094: 6110        str	r0, [r2, #16]
@   0x08006096: 0300        lsls	r0, r0, #12
@   0x08006098: 6160        str	r0, [r4, #20]
@   0x0800609a: 0300        lsls	r0, r0, #12
@   0x0800609c: 3720        adds	r7, #32
@   0x0800609e: 0300        lsls	r0, r0, #12
@   0x080060a0: 8adc        ldrh	r4, [r3, #22]
@   0x080060a2: 082f        lsrs	r7, r5, #32
@   0x080060a4: 5330        strh	r0, [r6, r4]
@   0x080060a6: 0300        lsls	r0, r0, #12
@   0x080060a8: 54a0        strb	r0, [r4, r2]
@   0x080060aa: 0300        lsls	r0, r0, #12
@   0x080060ac: 54a4        strb	r4, [r4, r2]
@   0x080060ae: 0300        lsls	r0, r0, #12
@   0x080060b0: 2040        movs	r0, #64	@ 0x40
@   0x080060b2: 4010        ands	r0, r2
@   0x080060b4: 2800        cmp	r0, #0
@   0x080060b6: d06f        beq.n	0x6198
@   0x080060b8: 2110        movs	r1, #16
@   0x080060ba: 5e78        ldrsh	r0, [r7, r1]
@   0x080060bc: 3040        adds	r0, #64	@ 0x40
@   0x080060be: 0040        lsls	r0, r0, #1
@   0x080060c0: 4a57        ldr	r2, [pc, #348]	@ (0x6220)
@   0x080060c2: 1880        adds	r0, r0, r2
@   0x080060c4: 2300        movs	r3, #0
@   0x080060c6: 5ec4        ldrsh	r4, [r0, r3]
@   0x080060c8: 250c        movs	r5, #12
@   0x080060ca: 5f78        ldrsh	r0, [r7, r5]
@   0x080060cc: f007        ffbc 	bl	0xe048
@   0x080060d0: 1c01        adds	r1, r0, #0
@   0x080060d2: 0409        lsls	r1, r1, #16
@   0x080060d4: 1409        asrs	r1, r1, #16
@   0x080060d6: 1c20        adds	r0, r4, #0
@   0x080060d8: f007        ff90 	bl	0xdffc
@   0x080060dc: 4680        mov	r8, r0
@   0x080060de: 4646        mov	r6, r8
@   0x080060e0: 0436        lsls	r6, r6, #16
@   0x080060e2: 0c36        lsrs	r6, r6, #16
@   0x080060e4: 46b0        mov	r8, r6
@   0x080060e6: 2110        movs	r1, #16
@   0x080060e8: 5e78        ldrsh	r0, [r7, r1]
@   0x080060ea: 0040        lsls	r0, r0, #1
@   0x080060ec: 4a4c        ldr	r2, [pc, #304]	@ (0x6220)
@   0x080060ee: 1880        adds	r0, r0, r2
@   0x080060f0: 2300        movs	r3, #0
@   0x080060f2: 5ec4        ldrsh	r4, [r0, r3]
@   0x080060f4: 250c        movs	r5, #12
@   0x080060f6: 5f78        ldrsh	r0, [r7, r5]
@   0x080060f8: f007        ffa6 	bl	0xe048
@   0x080060fc: 1c01        adds	r1, r0, #0
@   0x080060fe: 0409        lsls	r1, r1, #16
@   0x08006100: 1409        asrs	r1, r1, #16
@   0x08006102: 1c20        adds	r0, r4, #0
@   0x08006104: f007        ff7a 	bl	0xdffc
@   0x08006108: 1c06        adds	r6, r0, #0
@   0x0800610a: 0436        lsls	r6, r6, #16
@   0x0800610c: 0c36        lsrs	r6, r6, #16
@   0x0800610e: 2110        movs	r1, #16
@   0x08006110: 5e78        ldrsh	r0, [r7, r1]
@   0x08006112: 0040        lsls	r0, r0, #1
@   0x08006114: 4a42        ldr	r2, [pc, #264]	@ (0x6220)
@   0x08006116: 1880        adds	r0, r0, r2
@   0x08006118: 8800        ldrh	r0, [r0, #0]
@   0x0800611a: 4244        negs	r4, r0
@   0x0800611c: 0424        lsls	r4, r4, #16
@   0x0800611e: 1424        asrs	r4, r4, #16
@   0x08006120: 230e        movs	r3, #14
@   0x08006122: 5ef8        ldrsh	r0, [r7, r3]
@   0x08006124: f007        ff90 	bl	0xe048
@   0x08006128: 1c01        adds	r1, r0, #0
@   0x0800612a: 0409        lsls	r1, r1, #16
@   0x0800612c: 1409        asrs	r1, r1, #16
@   0x0800612e: 1c20        adds	r0, r4, #0
@   0x08006130: f007        ff64 	bl	0xdffc
@   0x08006134: 1c04        adds	r4, r0, #0
@   0x08006136: 0424        lsls	r4, r4, #16
@   0x08006138: 0c24        lsrs	r4, r4, #16
@   0x0800613a: 2510        movs	r5, #16
@   0x0800613c: 5f78        ldrsh	r0, [r7, r5]
@   0x0800613e: 3040        adds	r0, #64	@ 0x40
@   0x08006140: 0040        lsls	r0, r0, #1
@   0x08006142: 4937        ldr	r1, [pc, #220]	@ (0x6220)
@   0x08006144: 1840        adds	r0, r0, r1
@   0x08006146: 2200        movs	r2, #0
@   0x08006148: 5e85        ldrsh	r5, [r0, r2]
@   0x0800614a: 230e        movs	r3, #14
@   0x0800614c: 5ef8        ldrsh	r0, [r7, r3]
@   0x0800614e: f007        ff7b 	bl	0xe048
@   0x08006152: 1c01        adds	r1, r0, #0
@   0x08006154: 0409        lsls	r1, r1, #16
@   0x08006156: 1409        asrs	r1, r1, #16
@   0x08006158: 1c28        adds	r0, r5, #0
@   0x0800615a: f007        ff4f 	bl	0xdffc
@   0x0800615e: 9d01        ldr	r5, [sp, #4]
@   0x08006160: 062b        lsls	r3, r5, #24
@   0x08006162: 161b        asrs	r3, r3, #24
@   0x08006164: 0159        lsls	r1, r3, #5
@   0x08006166: 4a2f        ldr	r2, [pc, #188]	@ (0x6224)
@   0x08006168: 1889        adds	r1, r1, r2
@   0x0800616a: 4645        mov	r5, r8
@   0x0800616c: 800d        strh	r5, [r1, #0]
@   0x0800616e: 009a        lsls	r2, r3, #2
@   0x08006170: 1c51        adds	r1, r2, #1
@   0x08006172: 00c9        lsls	r1, r1, #3
@   0x08006174: 4d2b        ldr	r5, [pc, #172]	@ (0x6224)
@   0x08006176: 1949        adds	r1, r1, r5
@   0x08006178: 800e        strh	r6, [r1, #0]
@   0x0800617a: 1c91        adds	r1, r2, #2
@   0x0800617c: 00c9        lsls	r1, r1, #3
@   0x0800617e: 1949        adds	r1, r1, r5
@   0x08006180: 800c        strh	r4, [r1, #0]
@   0x08006182: 3203        adds	r2, #3
@   0x08006184: 00d2        lsls	r2, r2, #3
@   0x08006186: 1952        adds	r2, r2, r5
@   0x08006188: 8010        strh	r0, [r2, #0]
@   0x0800618a: 466e        mov	r6, sp
@   0x0800618c: 7936        ldrb	r6, [r6, #4]
@   0x0800618e: 74be        strb	r6, [r7, #18]
@   0x08006190: 3301        adds	r3, #1
@   0x08006192: 061b        lsls	r3, r3, #24
@   0x08006194: 0e1b        lsrs	r3, r3, #24
@   0x08006196: 9301        str	r3, [sp, #4]
@   0x08006198: 2180        movs	r1, #128	@ 0x80
@   0x0800619a: 0049        lsls	r1, r1, #1
@   0x0800619c: 1c08        adds	r0, r1, #0
@   0x0800619e: 8ebf        ldrh	r7, [r7, #52]	@ 0x34
@   0x080061a0: 4038        ands	r0, r7
@   0x080061a2: 4e21        ldr	r6, [pc, #132]	@ (0x6228)
@   0x080061a4: 4d21        ldr	r5, [pc, #132]	@ (0x622c)
@   0x080061a6: 9c00        ldr	r4, [sp, #0]
@   0x080061a8: 3401        adds	r4, #1
@   0x080061aa: 2800        cmp	r0, #0
@   0x080061ac: d100        bne.n	0x61b0
@   0x080061ae: e095        b.n	0x62dc
@   0x080061b0: 2300        movs	r3, #0
@   0x080061b2: 9a00        ldr	r2, [sp, #0]
@   0x080061b4: 4293        cmp	r3, r2
@   0x080061b6: da0d        bge.n	0x61d4
@   0x080061b8: 9f02        ldr	r7, [sp, #8]
@   0x080061ba: 1c29        adds	r1, r5, #0
@   0x080061bc: 1878        adds	r0, r7, r1
@   0x080061be: 8a82        ldrh	r2, [r0, #20]
@   0x080061c0: 491b        ldr	r1, [pc, #108]	@ (0x6230)
@   0x080061c2: 9800        ldr	r0, [sp, #0]
@   0x080061c4: 888f        ldrh	r7, [r1, #4]
@   0x080061c6: 4297        cmp	r7, r2
@   0x080061c8: d100        bne.n	0x61cc
@   0x080061ca: 2301        movs	r3, #1
@   0x080061cc: 3108        adds	r1, #8
@   0x080061ce: 3801        subs	r0, #1
@   0x080061d0: 2800        cmp	r0, #0
@   0x080061d2: d1f7        bne.n	0x61c4
@   0x080061d4: 2b00        cmp	r3, #0
@   0x080061d6: d000        beq.n	0x61da
@   0x080061d8: e080        b.n	0x62dc
@   0x080061da: 4649        mov	r1, r9
@   0x080061dc: 6848        ldr	r0, [r1, #4]
@   0x080061de: 4a15        ldr	r2, [pc, #84]	@ (0x6234)
@   0x080061e0: 6010        str	r0, [r2, #0]
@   0x080061e2: 9b04        ldr	r3, [sp, #16]
@   0x080061e4: 4657        mov	r7, sl
@   0x080061e6: 1bd9        subs	r1, r3, r7
@   0x080061e8: 00c9        lsls	r1, r1, #3
@   0x080061ea: 1949        adds	r1, r1, r5
@   0x080061ec: 7d8a        ldrb	r2, [r1, #22]
@   0x080061ee: 0150        lsls	r0, r2, #5
@   0x080061f0: 4b11        ldr	r3, [pc, #68]	@ (0x6238)
@   0x080061f2: 18c0        adds	r0, r0, r3
@   0x080061f4: 4f0f        ldr	r7, [pc, #60]	@ (0x6234)
@   0x080061f6: 6078        str	r0, [r7, #4]
@   0x080061f8: 4810        ldr	r0, [pc, #64]	@ (0x623c)
@   0x080061fa: 60b8        str	r0, [r7, #8]
@   0x080061fc: 68b8        ldr	r0, [r7, #8]
@   0x080061fe: 2280        movs	r2, #128	@ 0x80
@   0x08006200: 00d2        lsls	r2, r2, #3
@   0x08006202: 1c10        adds	r0, r2, #0
@   0x08006204: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08006206: 4008        ands	r0, r1
@   0x08006208: 2800        cmp	r0, #0
@   0x0800620a: d15d        bne.n	0x62c8
@   0x0800620c: 464b        mov	r3, r9
@   0x0800620e: 7a58        ldrb	r0, [r3, #9]
@   0x08006210: 7a99        ldrb	r1, [r3, #10]
@   0x08006212: 2800        cmp	r0, #0
@   0x08006214: d014        beq.n	0x6240
@   0x08006216: 2800        cmp	r0, #0
@   0x08006218: db3c        blt.n	0x6294
@   0x0800621a: 2802        cmp	r0, #2
@   0x0800621c: dc3a        bgt.n	0x6294
@   0x0800621e: e023        b.n	0x6268
@   0x08006220: 0ea8        lsrs	r0, r5, #26
@   0x08006222: 080c        lsrs	r4, r1, #32
@   0x08006224: 54a6        strb	r6, [r4, r2]
@   0x08006226: 0300        lsls	r0, r0, #12
@   0x08006228: 6110        str	r0, [r2, #16]
@   0x0800622a: 0300        lsls	r0, r0, #12
@   0x0800622c: 3720        adds	r7, #32
@   0x0800622e: 0300        lsls	r0, r0, #12
@   0x08006230: 6160        str	r0, [r4, #20]
@   0x08006232: 0300        lsls	r0, r0, #12
@   0x08006234: 00d4        lsls	r4, r2, #3
@   0x08006236: 0400        lsls	r0, r0, #16
@   0x08006238: 0200        lsls	r0, r0, #8
@   0x0800623a: 0500        lsls	r0, r0, #20
@   0x0800623c: 0010        movs	r0, r2
@   0x0800623e: 8000        strh	r0, [r0, #0]
@   0x08006240: 2901        cmp	r1, #1
@   0x08006242: d01f        beq.n	0x6284
@   0x08006244: 2901        cmp	r1, #1
@   0x08006246: dc02        bgt.n	0x624e
@   0x08006248: 2900        cmp	r1, #0
@   0x0800624a: d005        beq.n	0x6258
@   0x0800624c: e00c        b.n	0x6268
@   0x0800624e: 2902        cmp	r1, #2
@   0x08006250: d004        beq.n	0x625c
@   0x08006252: 2903        cmp	r1, #3
@   0x08006254: d005        beq.n	0x6262
@   0x08006256: e007        b.n	0x6268
@   0x08006258: 2320        movs	r3, #32
@   0x0800625a: e01c        b.n	0x6296
@   0x0800625c: 2380        movs	r3, #128	@ 0x80
@   0x0800625e: 009b        lsls	r3, r3, #2
@   0x08006260: e019        b.n	0x6296
@   0x08006262: 2380        movs	r3, #128	@ 0x80
@   0x08006264: 011b        lsls	r3, r3, #4
@   0x08006266: e016        b.n	0x6296
@   0x08006268: 2901        cmp	r1, #1
@   0x0800626a: d00b        beq.n	0x6284
@   0x0800626c: 2901        cmp	r1, #1
@   0x0800626e: dc02        bgt.n	0x6276
@   0x08006270: 2900        cmp	r1, #0
@   0x08006272: d005        beq.n	0x6280
@   0x08006274: e00e        b.n	0x6294
@   0x08006276: 2902        cmp	r1, #2
@   0x08006278: d006        beq.n	0x6288
@   0x0800627a: 2903        cmp	r1, #3
@   0x0800627c: d007        beq.n	0x628e
@   0x0800627e: e009        b.n	0x6294
@   0x08006280: 2340        movs	r3, #64	@ 0x40
@   0x08006282: e008        b.n	0x6296
@   0x08006284: 2380        movs	r3, #128	@ 0x80
@   0x08006286: e006        b.n	0x6296
@   0x08006288: 2380        movs	r3, #128	@ 0x80
@   0x0800628a: 005b        lsls	r3, r3, #1
@   0x0800628c: e003        b.n	0x6296
@   0x0800628e: 2380        movs	r3, #128	@ 0x80
@   0x08006290: 00db        lsls	r3, r3, #3
@   0x08006292: e000        b.n	0x6296
@   0x08006294: 4b24        ldr	r3, [pc, #144]	@ (0x6328)
@   0x08006296: 041b        lsls	r3, r3, #16
@   0x08006298: 9f04        ldr	r7, [sp, #16]
@   0x0800629a: 4650        mov	r0, sl
@   0x0800629c: 1a39        subs	r1, r7, r0
@   0x0800629e: 00c9        lsls	r1, r1, #3
@   0x080062a0: 1949        adds	r1, r1, r5
@   0x080062a2: 464f        mov	r7, r9
@   0x080062a4: 683a        ldr	r2, [r7, #0]
@   0x080062a6: 7ecf        ldrb	r7, [r1, #27]
@   0x080062a8: 0138        lsls	r0, r7, #4
@   0x080062aa: 1880        adds	r0, r0, r2
@   0x080062ac: 6840        ldr	r0, [r0, #4]
@   0x080062ae: 4a1f        ldr	r2, [pc, #124]	@ (0x632c)
@   0x080062b0: 6010        str	r0, [r2, #0]
@   0x080062b2: 8a89        ldrh	r1, [r1, #20]
@   0x080062b4: 0148        lsls	r0, r1, #5
@   0x080062b6: 4f1e        ldr	r7, [pc, #120]	@ (0x6330)
@   0x080062b8: 19c0        adds	r0, r0, r7
@   0x080062ba: 6050        str	r0, [r2, #4]
@   0x080062bc: 0c5b        lsrs	r3, r3, #17
@   0x080062be: 2080        movs	r0, #128	@ 0x80
@   0x080062c0: 0600        lsls	r0, r0, #24
@   0x080062c2: 4303        orrs	r3, r0
@   0x080062c4: 6093        str	r3, [r2, #8]
@   0x080062c6: 6890        ldr	r0, [r2, #8]
@   0x080062c8: 481a        ldr	r0, [pc, #104]	@ (0x6334)
@   0x080062ca: 9903        ldr	r1, [sp, #12]
@   0x080062cc: 1808        adds	r0, r1, r0
@   0x080062ce: 9a04        ldr	r2, [sp, #16]
@   0x080062d0: 4653        mov	r3, sl
@   0x080062d2: 1ad1        subs	r1, r2, r3
@   0x080062d4: 00c9        lsls	r1, r1, #3
@   0x080062d6: 1949        adds	r1, r1, r5
@   0x080062d8: 8a89        ldrh	r1, [r1, #20]
@   0x080062da: 8081        strh	r1, [r0, #4]
@   0x080062dc: 9f04        ldr	r7, [sp, #16]
@   0x080062de: 4651        mov	r1, sl
@   0x080062e0: 1a78        subs	r0, r7, r1
@   0x080062e2: 00c0        lsls	r0, r0, #3
@   0x080062e4: 1943        adds	r3, r0, r5
@   0x080062e6: 2040        movs	r0, #64	@ 0x40
@   0x080062e8: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x080062ea: 4010        ands	r0, r2
@   0x080062ec: 2800        cmp	r0, #0
@   0x080062ee: d027        beq.n	0x6340
@   0x080062f0: 9f03        ldr	r7, [sp, #12]
@   0x080062f2: 4811        ldr	r0, [pc, #68]	@ (0x6338)
@   0x080062f4: 183a        adds	r2, r7, r0
@   0x080062f6: 4649        mov	r1, r9
@   0x080062f8: 7a49        ldrb	r1, [r1, #9]
@   0x080062fa: 0388        lsls	r0, r1, #14
@   0x080062fc: 7a9f        ldrb	r7, [r3, #10]
@   0x080062fe: 4338        orrs	r0, r7
@   0x08006300: 2780        movs	r7, #128	@ 0x80
@   0x08006302: 007f        lsls	r7, r7, #1
@   0x08006304: 1c39        adds	r1, r7, #0
@   0x08006306: 4308        orrs	r0, r1
@   0x08006308: 8010        strh	r0, [r2, #0]
@   0x0800630a: 4a0b        ldr	r2, [pc, #44]	@ (0x6338)
@   0x0800630c: 3202        adds	r2, #2
@   0x0800630e: 9803        ldr	r0, [sp, #12]
@   0x08006310: 1882        adds	r2, r0, r2
@   0x08006312: 464f        mov	r7, r9
@   0x08006314: 7abf        ldrb	r7, [r7, #10]
@   0x08006316: 03b9        lsls	r1, r7, #14
@   0x08006318: 4f08        ldr	r7, [pc, #32]	@ (0x633c)
@   0x0800631a: 1c38        adds	r0, r7, #0
@   0x0800631c: 891f        ldrh	r7, [r3, #8]
@   0x0800631e: 4038        ands	r0, r7
@   0x08006320: 4301        orrs	r1, r0
@   0x08006322: 7c9b        ldrb	r3, [r3, #18]
@   0x08006324: 0258        lsls	r0, r3, #9
@   0x08006326: e01f        b.n	0x6368
@   0x08006328: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0800632c: 00d4        lsls	r4, r2, #3
@   0x0800632e: 0400        lsls	r0, r0, #16
@   0x08006330: 0000        movs	r0, r0
@   0x08006332: 0601        lsls	r1, r0, #24
@   0x08006334: 6160        str	r0, [r4, #20]
@   0x08006336: 0300        lsls	r0, r0, #12
@   0x08006338: 54a0        strb	r0, [r4, r2]
@   0x0800633a: 0300        lsls	r0, r0, #12
@   0x0800633c: 01ff        lsls	r7, r7, #7
@   0x0800633e: 0000        movs	r0, r0
@   0x08006340: 9803        ldr	r0, [sp, #12]
@   0x08006342: 4a27        ldr	r2, [pc, #156]	@ (0x63e0)
@   0x08006344: 1881        adds	r1, r0, r2
@   0x08006346: 464f        mov	r7, r9
@   0x08006348: 7a7f        ldrb	r7, [r7, #9]
@   0x0800634a: 03b8        lsls	r0, r7, #14
@   0x0800634c: 7a9a        ldrb	r2, [r3, #10]
@   0x0800634e: 4310        orrs	r0, r2
@   0x08006350: 8008        strh	r0, [r1, #0]
@   0x08006352: 4a23        ldr	r2, [pc, #140]	@ (0x63e0)
@   0x08006354: 3202        adds	r2, #2
@   0x08006356: 9f03        ldr	r7, [sp, #12]
@   0x08006358: 18ba        adds	r2, r7, r2
@   0x0800635a: 4648        mov	r0, r9
@   0x0800635c: 7a80        ldrb	r0, [r0, #10]
@   0x0800635e: 0381        lsls	r1, r0, #14
@   0x08006360: 4f20        ldr	r7, [pc, #128]	@ (0x63e4)
@   0x08006362: 1c38        adds	r0, r7, #0
@   0x08006364: 891b        ldrh	r3, [r3, #8]
@   0x08006366: 4018        ands	r0, r3
@   0x08006368: 4301        orrs	r1, r0
@   0x0800636a: 8011        strh	r1, [r2, #0]
@   0x0800636c: 9803        ldr	r0, [sp, #12]
@   0x0800636e: 491e        ldr	r1, [pc, #120]	@ (0x63e8)
@   0x08006370: 1843        adds	r3, r0, r1
@   0x08006372: 9a04        ldr	r2, [sp, #16]
@   0x08006374: 4657        mov	r7, sl
@   0x08006376: 1bd0        subs	r0, r2, r7
@   0x08006378: 00c0        lsls	r0, r0, #3
@   0x0800637a: 1940        adds	r0, r0, r5
@   0x0800637c: 7d82        ldrb	r2, [r0, #22]
@   0x0800637e: 0311        lsls	r1, r2, #12
@   0x08006380: 7dc5        ldrb	r5, [r0, #23]
@   0x08006382: 02aa        lsls	r2, r5, #10
@   0x08006384: 4311        orrs	r1, r2
@   0x08006386: 8a80        ldrh	r0, [r0, #20]
@   0x08006388: 4301        orrs	r1, r0
@   0x0800638a: 8019        strh	r1, [r3, #0]
@   0x0800638c: 9400        str	r4, [sp, #0]
@   0x0800638e: 1c30        adds	r0, r6, #0
@   0x08006390: 3031        adds	r0, #49	@ 0x31
@   0x08006392: 7800        ldrb	r0, [r0, #0]
@   0x08006394: 4284        cmp	r4, r0
@   0x08006396: da00        bge.n	0x639a
@   0x08006398: e629        b.n	0x5fee
@   0x0800639a: 1c34        adds	r4, r6, #0
@   0x0800639c: 3431        adds	r4, #49	@ 0x31
@   0x0800639e: 7826        ldrb	r6, [r4, #0]
@   0x080063a0: 9600        str	r6, [sp, #0]
@   0x080063a2: 1c30        adds	r0, r6, #0
@   0x080063a4: 300a        adds	r0, #10
@   0x080063a6: 4286        cmp	r6, r0
@   0x080063a8: da12        bge.n	0x63d0
@   0x080063aa: 490d        ldr	r1, [pc, #52]	@ (0x63e0)
@   0x080063ac: 2300        movs	r3, #0
@   0x080063ae: 25f0        movs	r5, #240	@ 0xf0
@   0x080063b0: 00f0        lsls	r0, r6, #3
@   0x080063b2: 1842        adds	r2, r0, r1
@   0x080063b4: 3002        adds	r0, #2
@   0x080063b6: 1841        adds	r1, r0, r1
@   0x080063b8: 8015        strh	r5, [r2, #0]
@   0x080063ba: 800b        strh	r3, [r1, #0]
@   0x080063bc: 8093        strh	r3, [r2, #4]
@   0x080063be: 3208        adds	r2, #8
@   0x080063c0: 3108        adds	r1, #8
@   0x080063c2: 9f00        ldr	r7, [sp, #0]
@   0x080063c4: 3701        adds	r7, #1
@   0x080063c6: 9700        str	r7, [sp, #0]
@   0x080063c8: 7820        ldrb	r0, [r4, #0]
@   0x080063ca: 300a        adds	r0, #10
@   0x080063cc: 4287        cmp	r7, r0
@   0x080063ce: dbf3        blt.n	0x63b8
@   0x080063d0: b005        add	sp, #20
@   0x080063d2: bc38        pop	{r3, r4, r5}
@   0x080063d4: 4698        mov	r8, r3
@   0x080063d6: 46a1        mov	r9, r4
@   0x080063d8: 46aa        mov	sl, r5
@   0x080063da: bcf0        pop	{r4, r5, r6, r7}
@   0x080063dc: bc01        pop	{r0}
@   0x080063de: 4700        bx	r0
@   0x080063e0: 54a0        strb	r0, [r4, r2]
@   0x080063e2: 0300        lsls	r0, r0, #12
@   0x080063e4: 01ff        lsls	r7, r7, #7
@   0x080063e6: 0000        movs	r0, r0
@   0x080063e8: 54a4        strb	r4, [r4, r2]
@   0x080063ea: 0300        lsls	r0, r0, #12
@   0x080063ec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080063ee: 1c07        adds	r7, r0, #0
@   0x080063f0: 4e19        ldr	r6, [pc, #100]	@ (0x6458)
@   0x080063f2: 00f9        lsls	r1, r7, #3
@   0x080063f4: 1bc9        subs	r1, r1, r7
@   0x080063f6: 00c9        lsls	r1, r1, #3
@   0x080063f8: 1989        adds	r1, r1, r6
@   0x080063fa: 2280        movs	r2, #128	@ 0x80
@   0x080063fc: 00d2        lsls	r2, r2, #3
@   0x080063fe: 1c10        adds	r0, r2, #0
@   0x08006400: 8e8b        ldrh	r3, [r1, #52]	@ 0x34
@   0x08006402: 4318        orrs	r0, r3
@   0x08006404: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08006406: 4a15        ldr	r2, [pc, #84]	@ (0x645c)
@   0x08006408: 4d15        ldr	r5, [pc, #84]	@ (0x6460)
@   0x0800640a: 780b        ldrb	r3, [r1, #0]
@   0x0800640c: 00d8        lsls	r0, r3, #3
@   0x0800640e: 1d2c        adds	r4, r5, #4
@   0x08006410: 1900        adds	r0, r0, r4
@   0x08006412: 6800        ldr	r0, [r0, #0]
@   0x08006414: 4684        mov	ip, r0
@   0x08006416: 7e8b        ldrb	r3, [r1, #26]
@   0x08006418: 0058        lsls	r0, r3, #1
@   0x0800641a: 18c0        adds	r0, r0, r3
@   0x0800641c: 0080        lsls	r0, r0, #2
@   0x0800641e: 4460        add	r0, ip
@   0x08006420: 6840        ldr	r0, [r0, #4]
@   0x08006422: 6010        str	r0, [r2, #0]
@   0x08006424: 7d8b        ldrb	r3, [r1, #22]
@   0x08006426: 0158        lsls	r0, r3, #5
@   0x08006428: 4b0e        ldr	r3, [pc, #56]	@ (0x6464)
@   0x0800642a: 18c0        adds	r0, r0, r3
@   0x0800642c: 6050        str	r0, [r2, #4]
@   0x0800642e: 480e        ldr	r0, [pc, #56]	@ (0x6468)
@   0x08006430: 6090        str	r0, [r2, #8]
@   0x08006432: 6890        ldr	r0, [r2, #8]
@   0x08006434: 780a        ldrb	r2, [r1, #0]
@   0x08006436: 00d0        lsls	r0, r2, #3
@   0x08006438: 1900        adds	r0, r0, r4
@   0x0800643a: 6802        ldr	r2, [r0, #0]
@   0x0800643c: 7e8b        ldrb	r3, [r1, #26]
@   0x0800643e: 0058        lsls	r0, r3, #1
@   0x08006440: 18c0        adds	r0, r0, r3
@   0x08006442: 0080        lsls	r0, r0, #2
@   0x08006444: 1880        adds	r0, r0, r2
@   0x08006446: 7a43        ldrb	r3, [r0, #9]
@   0x08006448: 7a81        ldrb	r1, [r0, #10]
@   0x0800644a: 2b00        cmp	r3, #0
@   0x0800644c: d00e        beq.n	0x646c
@   0x0800644e: 2b00        cmp	r3, #0
@   0x08006450: db36        blt.n	0x64c0
@   0x08006452: 2b02        cmp	r3, #2
@   0x08006454: dc34        bgt.n	0x64c0
@   0x08006456: e01d        b.n	0x6494
@   0x08006458: 3720        adds	r7, #32
@   0x0800645a: 0300        lsls	r0, r0, #12
@   0x0800645c: 00d4        lsls	r4, r2, #3
@   0x0800645e: 0400        lsls	r0, r0, #16
@   0x08006460: 8ad8        ldrh	r0, [r3, #22]
@   0x08006462: 082f        lsrs	r7, r5, #32
@   0x08006464: 0200        lsls	r0, r0, #8
@   0x08006466: 0500        lsls	r0, r0, #20
@   0x08006468: 0010        movs	r0, r2
@   0x0800646a: 8000        strh	r0, [r0, #0]
@   0x0800646c: 2901        cmp	r1, #1
@   0x0800646e: d01f        beq.n	0x64b0
@   0x08006470: 2901        cmp	r1, #1
@   0x08006472: dc02        bgt.n	0x647a
@   0x08006474: 2900        cmp	r1, #0
@   0x08006476: d005        beq.n	0x6484
@   0x08006478: e00c        b.n	0x6494
@   0x0800647a: 2902        cmp	r1, #2
@   0x0800647c: d004        beq.n	0x6488
@   0x0800647e: 2903        cmp	r1, #3
@   0x08006480: d005        beq.n	0x648e
@   0x08006482: e007        b.n	0x6494
@   0x08006484: 2320        movs	r3, #32
@   0x08006486: e01c        b.n	0x64c2
@   0x08006488: 2380        movs	r3, #128	@ 0x80
@   0x0800648a: 009b        lsls	r3, r3, #2
@   0x0800648c: e019        b.n	0x64c2
@   0x0800648e: 2380        movs	r3, #128	@ 0x80
@   0x08006490: 011b        lsls	r3, r3, #4
@   0x08006492: e016        b.n	0x64c2
@   0x08006494: 2901        cmp	r1, #1
@   0x08006496: d00b        beq.n	0x64b0
@   0x08006498: 2901        cmp	r1, #1
@   0x0800649a: dc02        bgt.n	0x64a2
@   0x0800649c: 2900        cmp	r1, #0
@   0x0800649e: d005        beq.n	0x64ac
@   0x080064a0: e00e        b.n	0x64c0
@   0x080064a2: 2902        cmp	r1, #2
@   0x080064a4: d006        beq.n	0x64b4
@   0x080064a6: 2903        cmp	r1, #3
@   0x080064a8: d007        beq.n	0x64ba
@   0x080064aa: e009        b.n	0x64c0
@   0x080064ac: 2340        movs	r3, #64	@ 0x40
@   0x080064ae: e008        b.n	0x64c2
@   0x080064b0: 2380        movs	r3, #128	@ 0x80
@   0x080064b2: e006        b.n	0x64c2
@   0x080064b4: 2380        movs	r3, #128	@ 0x80
@   0x080064b6: 005b        lsls	r3, r3, #1
@   0x080064b8: e003        b.n	0x64c2
@   0x080064ba: 2380        movs	r3, #128	@ 0x80
@   0x080064bc: 00db        lsls	r3, r3, #3
@   0x080064be: e000        b.n	0x64c2
@   0x080064c0: 4b12        ldr	r3, [pc, #72]	@ (0x650c)
@   0x080064c2: 041b        lsls	r3, r3, #16
@   0x080064c4: 4c12        ldr	r4, [pc, #72]	@ (0x6510)
@   0x080064c6: 00f9        lsls	r1, r7, #3
@   0x080064c8: 1bc9        subs	r1, r1, r7
@   0x080064ca: 00c9        lsls	r1, r1, #3
@   0x080064cc: 1989        adds	r1, r1, r6
@   0x080064ce: 780a        ldrb	r2, [r1, #0]
@   0x080064d0: 00d0        lsls	r0, r2, #3
@   0x080064d2: 1d2a        adds	r2, r5, #4
@   0x080064d4: 1880        adds	r0, r0, r2
@   0x080064d6: 6802        ldr	r2, [r0, #0]
@   0x080064d8: 7e8d        ldrb	r5, [r1, #26]
@   0x080064da: 0068        lsls	r0, r5, #1
@   0x080064dc: 1940        adds	r0, r0, r5
@   0x080064de: 0080        lsls	r0, r0, #2
@   0x080064e0: 1880        adds	r0, r0, r2
@   0x080064e2: 6802        ldr	r2, [r0, #0]
@   0x080064e4: 7ecd        ldrb	r5, [r1, #27]
@   0x080064e6: 0128        lsls	r0, r5, #4
@   0x080064e8: 1880        adds	r0, r0, r2
@   0x080064ea: 6840        ldr	r0, [r0, #4]
@   0x080064ec: 6020        str	r0, [r4, #0]
@   0x080064ee: 8a89        ldrh	r1, [r1, #20]
@   0x080064f0: 0148        lsls	r0, r1, #5
@   0x080064f2: 4908        ldr	r1, [pc, #32]	@ (0x6514)
@   0x080064f4: 1840        adds	r0, r0, r1
@   0x080064f6: 6060        str	r0, [r4, #4]
@   0x080064f8: 0c5b        lsrs	r3, r3, #17
@   0x080064fa: 2080        movs	r0, #128	@ 0x80
@   0x080064fc: 0600        lsls	r0, r0, #24
@   0x080064fe: 4303        orrs	r3, r0
@   0x08006500: 60a3        str	r3, [r4, #8]
@   0x08006502: 68a0        ldr	r0, [r4, #8]
@   0x08006504: bcf0        pop	{r4, r5, r6, r7}
@   0x08006506: bc01        pop	{r0}
@   0x08006508: 4700        bx	r0
@   0x0800650a: 0000        movs	r0, r0
@   0x0800650c: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08006510: 00d4        lsls	r4, r2, #3
@   0x08006512: 0400        lsls	r0, r0, #16
@   0x08006514: 0000        movs	r0, r0
@   0x08006516: 0601        lsls	r1, r0, #24
@   0x08006518: 0600        lsls	r0, r0, #24
@   0x0800651a: 0e00        lsrs	r0, r0, #24
@   0x0800651c: 0609        lsls	r1, r1, #24
@   0x0800651e: 0e09        lsrs	r1, r1, #24
@   0x08006520: 2800        cmp	r0, #0
@   0x08006522: d004        beq.n	0x652e
@   0x08006524: 2800        cmp	r0, #0
@   0x08006526: db2c        blt.n	0x6582
@   0x08006528: 2802        cmp	r0, #2
@   0x0800652a: dc2a        bgt.n	0x6582
@   0x0800652c: e013        b.n	0x6556
@   0x0800652e: 2901        cmp	r1, #1
@   0x08006530: d01f        beq.n	0x6572
@   0x08006532: 2901        cmp	r1, #1
@   0x08006534: dc02        bgt.n	0x653c
@   0x08006536: 2900        cmp	r1, #0
@   0x08006538: d005        beq.n	0x6546
@   0x0800653a: e00c        b.n	0x6556
@   0x0800653c: 2902        cmp	r1, #2
@   0x0800653e: d004        beq.n	0x654a
@   0x08006540: 2903        cmp	r1, #3
@   0x08006542: d005        beq.n	0x6550
@   0x08006544: e007        b.n	0x6556
@   0x08006546: 2020        movs	r0, #32
@   0x08006548: e01c        b.n	0x6584
@   0x0800654a: 2080        movs	r0, #128	@ 0x80
@   0x0800654c: 0080        lsls	r0, r0, #2
@   0x0800654e: e019        b.n	0x6584
@   0x08006550: 2080        movs	r0, #128	@ 0x80
@   0x08006552: 0100        lsls	r0, r0, #4
@   0x08006554: e016        b.n	0x6584
@   0x08006556: 2901        cmp	r1, #1
@   0x08006558: d00b        beq.n	0x6572
@   0x0800655a: 2901        cmp	r1, #1
@   0x0800655c: dc02        bgt.n	0x6564
@   0x0800655e: 2900        cmp	r1, #0
@   0x08006560: d005        beq.n	0x656e
@   0x08006562: e00e        b.n	0x6582
@   0x08006564: 2902        cmp	r1, #2
@   0x08006566: d006        beq.n	0x6576
@   0x08006568: 2903        cmp	r1, #3
@   0x0800656a: d007        beq.n	0x657c
@   0x0800656c: e009        b.n	0x6582
@   0x0800656e: 2040        movs	r0, #64	@ 0x40
@   0x08006570: e008        b.n	0x6584
@   0x08006572: 2080        movs	r0, #128	@ 0x80
@   0x08006574: e006        b.n	0x6584
@   0x08006576: 2080        movs	r0, #128	@ 0x80
@   0x08006578: 0040        lsls	r0, r0, #1
@   0x0800657a: e003        b.n	0x6584
@   0x0800657c: 2080        movs	r0, #128	@ 0x80
@   0x0800657e: 00c0        lsls	r0, r0, #3
@   0x08006580: e000        b.n	0x6584
@   0x08006582: 4801        ldr	r0, [pc, #4]	@ (0x6588)
@   0x08006584: 4770        bx	lr
@   0x08006586: 0000        movs	r0, r0
@   0x08006588: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0

        thumb_func_start sub_08005FC8
sub_08005FC8: @ 0x08005fc8
        .incbin "frog_us_baserom.gba", 0x5fc8, 0x5c4
        thumb_func_end sub_08005FC8
