@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080063ec, 0x0800658c)  (416 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80063ec --end 0x800658c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_080063EC
sub_080063EC: @ 0x080063ec
        .incbin "frog_us_baserom.gba", 0x63ec, 0x1a0
        thumb_func_end sub_080063EC
