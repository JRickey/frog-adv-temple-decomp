@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002184, 0x08002444)  (704 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002184 --end 0x8002444 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002184: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08002186: b0b3        sub	sp, #204	@ 0xcc
@   0x08002188: 4668        mov	r0, sp
@   0x0800218a: 30c1        adds	r0, #193	@ 0xc1
@   0x0800218c: 2100        movs	r1, #0
@   0x0800218e: 7001        strb	r1, [r0, #0]
@   0x08002190: 4908        ldr	r1, [pc, #32]	@ (0x21b4)
@   0x08002192: 1c06        adds	r6, r0, #0
@   0x08002194: 7a49        ldrb	r1, [r1, #9]
@   0x08002196: 290d        cmp	r1, #13
@   0x08002198: d000        beq.n	0x219c
@   0x0800219a: e14c        b.n	0x2436
@   0x0800219c: f01e        fd10 	bl	0x20bc0
@   0x080021a0: 7830        ldrb	r0, [r6, #0]
@   0x080021a2: 2809        cmp	r0, #9
@   0x080021a4: d900        bls.n	0x21a8
@   0x080021a6: e141        b.n	0x242c
@   0x080021a8: 0080        lsls	r0, r0, #2
@   0x080021aa: 4903        ldr	r1, [pc, #12]	@ (0x21b8)
@   0x080021ac: 1840        adds	r0, r0, r1
@   0x080021ae: 6800        ldr	r0, [r0, #0]
@   0x080021b0: 4687        mov	pc, r0
@   0x080021b2: 0000        movs	r0, r0
@   0x080021b4: 5330        strh	r0, [r6, r4]
@   0x080021b6: 0300        lsls	r0, r0, #12
@   0x080021b8: 21bc        movs	r1, #188	@ 0xbc
@   0x080021ba: 0800        lsrs	r0, r0, #32
@   0x080021bc: 21e4        movs	r1, #228	@ 0xe4
@   0x080021be: 0800        lsrs	r0, r0, #32
@   0x080021c0: 21fc        movs	r1, #252	@ 0xfc
@   0x080021c2: 0800        lsrs	r0, r0, #32
@   0x080021c4: 2230        movs	r2, #48	@ 0x30
@   0x080021c6: 0800        lsrs	r0, r0, #32
@   0x080021c8: 2242        movs	r2, #66	@ 0x42
@   0x080021ca: 0800        lsrs	r0, r0, #32
@   0x080021cc: 2288        movs	r2, #136	@ 0x88
@   0x080021ce: 0800        lsrs	r0, r0, #32
@   0x080021d0: 2330        movs	r3, #48	@ 0x30
@   0x080021d2: 0800        lsrs	r0, r0, #32
@   0x080021d4: 2364        movs	r3, #100	@ 0x64
@   0x080021d6: 0800        lsrs	r0, r0, #32
@   0x080021d8: 2398        movs	r3, #152	@ 0x98
@   0x080021da: 0800        lsrs	r0, r0, #32
@   0x080021dc: 23d8        movs	r3, #216	@ 0xd8
@   0x080021de: 0800        lsrs	r0, r0, #32
@   0x080021e0: 2428        movs	r4, #40	@ 0x28
@   0x080021e2: 0800        lsrs	r0, r0, #32
@   0x080021e4: 4904        ldr	r1, [pc, #16]	@ (0x21f8)
@   0x080021e6: 2400        movs	r4, #0
@   0x080021e8: 2006        movs	r0, #6
@   0x080021ea: 7288        strb	r0, [r1, #10]
@   0x080021ec: f008        f812 	bl	0xa214
@   0x080021f0: 1c07        adds	r7, r0, #0
@   0x080021f2: 2001        movs	r0, #1
@   0x080021f4: 7030        strb	r0, [r6, #0]
@   0x080021f6: e0af        b.n	0x2358
@   0x080021f8: 5330        strh	r0, [r6, r4]
@   0x080021fa: 0300        lsls	r0, r0, #12
@   0x080021fc: ac30        add	r4, sp, #192	@ 0xc0
@   0x080021fe: 4909        ldr	r1, [pc, #36]	@ (0x2224)
@   0x08002200: 1c20        adds	r0, r4, #0
@   0x08002202: f007        ff7f 	bl	0xa104
@   0x08002206: 0600        lsls	r0, r0, #24
@   0x08002208: 2800        cmp	r0, #0
@   0x0800220a: d100        bne.n	0x220e
@   0x0800220c: e102        b.n	0x2414
@   0x0800220e: 2002        movs	r0, #2
@   0x08002210: 7030        strb	r0, [r6, #0]
@   0x08002212: 4805        ldr	r0, [pc, #20]	@ (0x2228)
@   0x08002214: 2100        movs	r1, #0
@   0x08002216: 6141        str	r1, [r0, #20]
@   0x08002218: 7021        strb	r1, [r4, #0]
@   0x0800221a: 4804        ldr	r0, [pc, #16]	@ (0x222c)
@   0x0800221c: 302b        adds	r0, #43	@ 0x2b
@   0x0800221e: 7001        strb	r1, [r0, #0]
@   0x08002220: e0f8        b.n	0x2414
@   0x08002222: 0000        movs	r0, r0
@   0x08002224: 2451        movs	r4, #81	@ 0x51
@   0x08002226: 0800        lsrs	r0, r0, #32
@   0x08002228: 5330        strh	r0, [r6, r4]
@   0x0800222a: 0300        lsls	r0, r0, #12
@   0x0800222c: 6110        str	r0, [r2, #16]
@   0x0800222e: 0300        lsls	r0, r0, #12
@   0x08002230: 2006        movs	r0, #6
@   0x08002232: f019        f96f 	bl	0x1b514
@   0x08002236: 1c38        adds	r0, r7, #0
@   0x08002238: f008        f80e 	bl	0xa258
@   0x0800223c: 2003        movs	r0, #3
@   0x0800223e: 7030        strb	r0, [r6, #0]
@   0x08002240: e0f4        b.n	0x242c
@   0x08002242: a830        add	r0, sp, #192	@ 0xc0
@   0x08002244: f007        fdaa 	bl	0x9d9c
@   0x08002248: 2800        cmp	r0, #0
@   0x0800224a: d100        bne.n	0x224e
@   0x0800224c: e0ee        b.n	0x242c
@   0x0800224e: 2004        movs	r0, #4
@   0x08002250: 7030        strb	r0, [r6, #0]
@   0x08002252: 4c08        ldr	r4, [pc, #32]	@ (0x2274)
@   0x08002254: 2000        movs	r0, #0
@   0x08002256: 6160        str	r0, [r4, #20]
@   0x08002258: 4807        ldr	r0, [pc, #28]	@ (0x2278)
@   0x0800225a: 2108        movs	r1, #8
@   0x0800225c: 2200        movs	r2, #0
@   0x0800225e: f004        f9cf 	bl	0x6600
@   0x08002262: 4806        ldr	r0, [pc, #24]	@ (0x227c)
@   0x08002264: 4a06        ldr	r2, [pc, #24]	@ (0x2280)
@   0x08002266: 1881        adds	r1, r0, r2
@   0x08002268: 6822        ldr	r2, [r4, #0]
@   0x0800226a: 600a        str	r2, [r1, #0]
@   0x0800226c: 4905        ldr	r1, [pc, #20]	@ (0x2284)
@   0x0800226e: 1840        adds	r0, r0, r1
@   0x08002270: 6002        str	r2, [r0, #0]
@   0x08002272: e0db        b.n	0x242c
@   0x08002274: 5330        strh	r0, [r6, r4]
@   0x08002276: 0300        lsls	r0, r0, #12
@   0x08002278: 6110        str	r0, [r2, #16]
@   0x0800227a: 0300        lsls	r0, r0, #12
@   0x0800227c: 3720        adds	r7, #32
@   0x0800227e: 0300        lsls	r0, r0, #12
@   0x08002280: 0b54        lsrs	r4, r2, #13
@   0x08002282: 0000        movs	r0, r0
@   0x08002284: 0b48        lsrs	r0, r1, #13
@   0x08002286: 0000        movs	r0, r0
@   0x08002288: f7fe        f91c 	bl	0x4c4
@   0x0800228c: 4905        ldr	r1, [pc, #20]	@ (0x22a4)
@   0x0800228e: 8008        strh	r0, [r1, #0]
@   0x08002290: 0400        lsls	r0, r0, #16
@   0x08002292: 0c00        lsrs	r0, r0, #16
@   0x08002294: 2840        cmp	r0, #64	@ 0x40
@   0x08002296: d107        bne.n	0x22a8
@   0x08002298: 2006        movs	r0, #6
@   0x0800229a: 7030        strb	r0, [r6, #0]
@   0x0800229c: f00b        fee0 	bl	0xe060
@   0x080022a0: e0c4        b.n	0x242c
@   0x080022a2: 0000        movs	r0, r0
@   0x080022a4: 5398        strh	r0, [r3, r6]
@   0x080022a6: 0300        lsls	r0, r0, #12
@   0x080022a8: 4904        ldr	r1, [pc, #16]	@ (0x22bc)
@   0x080022aa: 2208        movs	r2, #8
@   0x080022ac: 1c10        adds	r0, r2, #0
@   0x080022ae: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x080022b0: 4008        ands	r0, r1
@   0x080022b2: 2800        cmp	r0, #0
@   0x080022b4: d004        beq.n	0x22c0
@   0x080022b6: 2005        movs	r0, #5
@   0x080022b8: 7030        strb	r0, [r6, #0]
@   0x080022ba: e0b7        b.n	0x242c
@   0x080022bc: 3720        adds	r7, #32
@   0x080022be: 0300        lsls	r0, r0, #12
@   0x080022c0: 4904        ldr	r1, [pc, #16]	@ (0x22d4)
@   0x080022c2: 1c10        adds	r0, r2, #0
@   0x080022c4: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x080022c6: 4008        ands	r0, r1
@   0x080022c8: 2800        cmp	r0, #0
@   0x080022ca: d005        beq.n	0x22d8
@   0x080022cc: 2009        movs	r0, #9
@   0x080022ce: 7030        strb	r0, [r6, #0]
@   0x080022d0: e0ac        b.n	0x242c
@   0x080022d2: 0000        movs	r0, r0
@   0x080022d4: 6110        str	r0, [r2, #16]
@   0x080022d6: 0300        lsls	r0, r0, #12
@   0x080022d8: ad31        add	r5, sp, #196	@ 0xc4
@   0x080022da: f008        f921 	bl	0xa520
@   0x080022de: 4911        ldr	r1, [pc, #68]	@ (0x2324)
@   0x080022e0: 4c11        ldr	r4, [pc, #68]	@ (0x2328)
@   0x080022e2: 7aa2        ldrb	r2, [r4, #10]
@   0x080022e4: 0090        lsls	r0, r2, #2
@   0x080022e6: 1840        adds	r0, r0, r1
@   0x080022e8: 6800        ldr	r0, [r0, #0]
@   0x080022ea: f031        fcf5 	bl	0x33cd8
@   0x080022ee: 490f        ldr	r1, [pc, #60]	@ (0x232c)
@   0x080022f0: 7aa2        ldrb	r2, [r4, #10]
@   0x080022f2: 0090        lsls	r0, r2, #2
@   0x080022f4: 1840        adds	r0, r0, r1
@   0x080022f6: 6800        ldr	r0, [r0, #0]
@   0x080022f8: f031        fcee 	bl	0x33cd8
@   0x080022fc: f007        fbac 	bl	0x9a58
@   0x08002300: f006        ff42 	bl	0x9188
@   0x08002304: f7fe        faea 	bl	0x8dc
@   0x08002308: f008        f80e 	bl	0xa328
@   0x0800230c: f007        f8f4 	bl	0x94f8
@   0x08002310: f007        fb38 	bl	0x9984
@   0x08002314: 4668        mov	r0, sp
@   0x08002316: 1c29        adds	r1, r5, #0
@   0x08002318: f7ff        fd84 	bl	0x1e24
@   0x0800231c: 6960        ldr	r0, [r4, #20]
@   0x0800231e: 3001        adds	r0, #1
@   0x08002320: 6160        str	r0, [r4, #20]
@   0x08002322: e083        b.n	0x242c
@   0x08002324: 0cb8        lsrs	r0, r7, #18
@   0x08002326: 080c        lsrs	r4, r1, #32
@   0x08002328: 5330        strh	r0, [r6, r4]
@   0x0800232a: 0300        lsls	r0, r0, #12
@   0x0800232c: 0d40        lsrs	r0, r0, #21
@   0x0800232e: 080c        lsrs	r4, r1, #32
@   0x08002330: 1c30        adds	r0, r6, #0
@   0x08002332: f007        fc6f 	bl	0x9c14
@   0x08002336: 2800        cmp	r0, #0
@   0x08002338: d101        bne.n	0x233e
@   0x0800233a: 2008        movs	r0, #8
@   0x0800233c: 7030        strb	r0, [r6, #0]
@   0x0800233e: 4808        ldr	r0, [pc, #32]	@ (0x2360)
@   0x08002340: 1c02        adds	r2, r0, #0
@   0x08002342: 322a        adds	r2, #42	@ 0x2a
@   0x08002344: 2100        movs	r1, #0
@   0x08002346: 7011        strb	r1, [r2, #0]
@   0x08002348: 2400        movs	r4, #0
@   0x0800234a: 8181        strh	r1, [r0, #12]
@   0x0800234c: 302b        adds	r0, #43	@ 0x2b
@   0x0800234e: 7800        ldrb	r0, [r0, #0]
@   0x08002350: 2801        cmp	r0, #1
@   0x08002352: d101        bne.n	0x2358
@   0x08002354: f028        fc06 	bl	0x2ab64
@   0x08002358: a830        add	r0, sp, #192	@ 0xc0
@   0x0800235a: 7004        strb	r4, [r0, #0]
@   0x0800235c: e066        b.n	0x242c
@   0x0800235e: 0000        movs	r0, r0
@   0x08002360: 6110        str	r0, [r2, #16]
@   0x08002362: 0300        lsls	r0, r0, #12
@   0x08002364: f7fe        f8ae 	bl	0x4c4
@   0x08002368: 4909        ldr	r1, [pc, #36]	@ (0x2390)
@   0x0800236a: 8008        strh	r0, [r1, #0]
@   0x0800236c: f00c        f99c 	bl	0xe6a8
@   0x08002370: 0600        lsls	r0, r0, #24
@   0x08002372: 0e01        lsrs	r1, r0, #24
@   0x08002374: 2900        cmp	r1, #0
@   0x08002376: d103        bne.n	0x2380
@   0x08002378: 2007        movs	r0, #7
@   0x0800237a: 7030        strb	r0, [r6, #0]
@   0x0800237c: a830        add	r0, sp, #192	@ 0xc0
@   0x0800237e: 7001        strb	r1, [r0, #0]
@   0x08002380: 4804        ldr	r0, [pc, #16]	@ (0x2394)
@   0x08002382: 7800        ldrb	r0, [r0, #0]
@   0x08002384: 2800        cmp	r0, #0
@   0x08002386: d151        bne.n	0x242c
@   0x08002388: 2004        movs	r0, #4
@   0x0800238a: 7030        strb	r0, [r6, #0]
@   0x0800238c: e04e        b.n	0x242c
@   0x0800238e: 0000        movs	r0, r0
@   0x08002390: 5398        strh	r0, [r3, r6]
@   0x08002392: 0300        lsls	r0, r0, #12
@   0x08002394: 5328        strh	r0, [r5, r4]
@   0x08002396: 0300        lsls	r0, r0, #12
@   0x08002398: ac30        add	r4, sp, #192	@ 0xc0
@   0x0800239a: 2000        movs	r0, #0
@   0x0800239c: 5620        ldrsb	r0, [r4, r0]
@   0x0800239e: 2800        cmp	r0, #0
@   0x080023a0: d105        bne.n	0x23ae
@   0x080023a2: 20bf        movs	r0, #191	@ 0xbf
@   0x080023a4: f00e        f976 	bl	0x10694
@   0x080023a8: 7820        ldrb	r0, [r4, #0]
@   0x080023aa: 3001        adds	r0, #1
@   0x080023ac: 7020        strb	r0, [r4, #0]
@   0x080023ae: 7824        ldrb	r4, [r4, #0]
@   0x080023b0: 0624        lsls	r4, r4, #24
@   0x080023b2: 1624        asrs	r4, r4, #24
@   0x080023b4: 2c01        cmp	r4, #1
@   0x080023b6: d139        bne.n	0x242c
@   0x080023b8: f00e        f97e 	bl	0x106b8
@   0x080023bc: 0600        lsls	r0, r0, #24
@   0x080023be: 2800        cmp	r0, #0
@   0x080023c0: d134        bne.n	0x242c
@   0x080023c2: 4803        ldr	r0, [pc, #12]	@ (0x23d0)
@   0x080023c4: 2104        movs	r1, #4
@   0x080023c6: 7001        strb	r1, [r0, #0]
@   0x080023c8: 7184        strb	r4, [r0, #6]
@   0x080023ca: 4802        ldr	r0, [pc, #8]	@ (0x23d4)
@   0x080023cc: 7241        strb	r1, [r0, #9]
@   0x080023ce: e02d        b.n	0x242c
@   0x080023d0: 3480        adds	r4, #128	@ 0x80
@   0x080023d2: 0300        lsls	r0, r0, #12
@   0x080023d4: 5330        strh	r0, [r6, r4]
@   0x080023d6: 0300        lsls	r0, r0, #12
@   0x080023d8: ac30        add	r4, sp, #192	@ 0xc0
@   0x080023da: 4910        ldr	r1, [pc, #64]	@ (0x241c)
@   0x080023dc: 1c20        adds	r0, r4, #0
@   0x080023de: f007        fe91 	bl	0xa104
@   0x080023e2: 0600        lsls	r0, r0, #24
@   0x080023e4: 2800        cmp	r0, #0
@   0x080023e6: d015        beq.n	0x2414
@   0x080023e8: 480d        ldr	r0, [pc, #52]	@ (0x2420)
@   0x080023ea: 302b        adds	r0, #43	@ 0x2b
@   0x080023ec: 7800        ldrb	r0, [r0, #0]
@   0x080023ee: 2802        cmp	r0, #2
@   0x080023f0: d106        bne.n	0x2400
@   0x080023f2: a931        add	r1, sp, #196	@ 0xc4
@   0x080023f4: 4668        mov	r0, sp
@   0x080023f6: 221c        movs	r2, #28
@   0x080023f8: f009        f9da 	bl	0xb7b0
@   0x080023fc: f010        fb9c 	bl	0x12b38
@   0x08002400: 2003        movs	r0, #3
@   0x08002402: 7030        strb	r0, [r6, #0]
@   0x08002404: 2000        movs	r0, #0
@   0x08002406: 7020        strb	r0, [r4, #0]
@   0x08002408: 4906        ldr	r1, [pc, #24]	@ (0x2424)
@   0x0800240a: 2000        movs	r0, #0
@   0x0800240c: 6148        str	r0, [r1, #20]
@   0x0800240e: 1c38        adds	r0, r7, #0
@   0x08002410: f007        ff22 	bl	0xa258
@   0x08002414: f7fe        fa62 	bl	0x8dc
@   0x08002418: e008        b.n	0x242c
@   0x0800241a: 0000        movs	r0, r0
@   0x0800241c: a26d        add	r2, pc, #436	@ (adr r2, 0x25d4)
@   0x0800241e: 0800        lsrs	r0, r0, #32
@   0x08002420: 6110        str	r0, [r2, #16]
@   0x08002422: 0300        lsls	r0, r0, #12
@   0x08002424: 5330        strh	r0, [r6, r4]
@   0x08002426: 0300        lsls	r0, r0, #12
@   0x08002428: f00b        fd2a 	bl	0xde80
@   0x0800242c: 4804        ldr	r0, [pc, #16]	@ (0x2440)
@   0x0800242e: 7a40        ldrb	r0, [r0, #9]
@   0x08002430: 280d        cmp	r0, #13
@   0x08002432: d100        bne.n	0x2436
@   0x08002434: e6b2        b.n	0x219c
@   0x08002436: b033        add	sp, #204	@ 0xcc
@   0x08002438: bcf0        pop	{r4, r5, r6, r7}
@   0x0800243a: bc01        pop	{r0}
@   0x0800243c: 4700        bx	r0
@   0x0800243e: 0000        movs	r0, r0
@   0x08002440: 5330        strh	r0, [r6, r4]
@   0x08002442: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002184
sub_08002184: @ 0x08002184
        .incbin "frog_us_baserom.gba", 0x2184, 0x2c0
        thumb_func_end sub_08002184
