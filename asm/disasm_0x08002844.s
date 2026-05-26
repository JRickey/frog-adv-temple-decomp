@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002844, 0x08002a5c)  (536 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002844 --end 0x8002a5c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002844: b530        push	{r4, r5, lr}
@   0x08002846: b081        sub	sp, #4
@   0x08002848: 4668        mov	r0, sp
@   0x0800284a: 3001        adds	r0, #1
@   0x0800284c: 2100        movs	r1, #0
@   0x0800284e: 7001        strb	r1, [r0, #0]
@   0x08002850: 4909        ldr	r1, [pc, #36]	@ (0x2878)
@   0x08002852: 7a49        ldrb	r1, [r1, #9]
@   0x08002854: 1c05        adds	r5, r0, #0
@   0x08002856: 290f        cmp	r1, #15
@   0x08002858: d002        beq.n	0x2860
@   0x0800285a: 2918        cmp	r1, #24
@   0x0800285c: d000        beq.n	0x2860
@   0x0800285e: e0f7        b.n	0x2a50
@   0x08002860: f01e        f9ae 	bl	0x20bc0
@   0x08002864: 7828        ldrb	r0, [r5, #0]
@   0x08002866: 2808        cmp	r0, #8
@   0x08002868: d900        bls.n	0x286c
@   0x0800286a: e0e9        b.n	0x2a40
@   0x0800286c: 0080        lsls	r0, r0, #2
@   0x0800286e: 4903        ldr	r1, [pc, #12]	@ (0x287c)
@   0x08002870: 1840        adds	r0, r0, r1
@   0x08002872: 6800        ldr	r0, [r0, #0]
@   0x08002874: 4687        mov	pc, r0
@   0x08002876: 0000        movs	r0, r0
@   0x08002878: 5330        strh	r0, [r6, r4]
@   0x0800287a: 0300        lsls	r0, r0, #12
@   0x0800287c: 2880        cmp	r0, #128	@ 0x80
@   0x0800287e: 0800        lsrs	r0, r0, #32
@   0x08002880: 28a4        cmp	r0, #164	@ 0xa4
@   0x08002882: 0800        lsrs	r0, r0, #32
@   0x08002884: 28bc        cmp	r0, #188	@ 0xbc
@   0x08002886: 0800        lsrs	r0, r0, #32
@   0x08002888: 28e4        cmp	r0, #228	@ 0xe4
@   0x0800288a: 0800        lsrs	r0, r0, #32
@   0x0800288c: 2904        cmp	r1, #4
@   0x0800288e: 0800        lsrs	r0, r0, #32
@   0x08002890: 297c        cmp	r1, #124	@ 0x7c
@   0x08002892: 0800        lsrs	r0, r0, #32
@   0x08002894: 2992        cmp	r1, #146	@ 0x92
@   0x08002896: 0800        lsrs	r0, r0, #32
@   0x08002898: 29c4        cmp	r1, #196	@ 0xc4
@   0x0800289a: 0800        lsrs	r0, r0, #32
@   0x0800289c: 2a0c        cmp	r2, #12
@   0x0800289e: 0800        lsrs	r0, r0, #32
@   0x080028a0: 2a3c        cmp	r2, #60	@ 0x3c
@   0x080028a2: 0800        lsrs	r0, r0, #32
@   0x080028a4: 4904        ldr	r1, [pc, #16]	@ (0x28b8)
@   0x080028a6: 2200        movs	r2, #0
@   0x080028a8: 2008        movs	r0, #8
@   0x080028aa: 7288        strb	r0, [r1, #10]
@   0x080028ac: 2001        movs	r0, #1
@   0x080028ae: 7028        strb	r0, [r5, #0]
@   0x080028b0: 4668        mov	r0, sp
@   0x080028b2: 7002        strb	r2, [r0, #0]
@   0x080028b4: e0c4        b.n	0x2a40
@   0x080028b6: 0000        movs	r0, r0
@   0x080028b8: 5330        strh	r0, [r6, r4]
@   0x080028ba: 0300        lsls	r0, r0, #12
@   0x080028bc: 4907        ldr	r1, [pc, #28]	@ (0x28dc)
@   0x080028be: 4668        mov	r0, sp
@   0x080028c0: f007        fc20 	bl	0xa104
@   0x080028c4: 0600        lsls	r0, r0, #24
@   0x080028c6: 2800        cmp	r0, #0
@   0x080028c8: d100        bne.n	0x28cc
@   0x080028ca: e0af        b.n	0x2a2c
@   0x080028cc: 2002        movs	r0, #2
@   0x080028ce: 7028        strb	r0, [r5, #0]
@   0x080028d0: 4803        ldr	r0, [pc, #12]	@ (0x28e0)
@   0x080028d2: 2100        movs	r1, #0
@   0x080028d4: 6141        str	r1, [r0, #20]
@   0x080028d6: 4668        mov	r0, sp
@   0x080028d8: 7001        strb	r1, [r0, #0]
@   0x080028da: e0a7        b.n	0x2a2c
@   0x080028dc: 2a69        cmp	r2, #105	@ 0x69
@   0x080028de: 0800        lsrs	r0, r0, #32
@   0x080028e0: 5330        strh	r0, [r6, r4]
@   0x080028e2: 0300        lsls	r0, r0, #12
@   0x080028e4: 4668        mov	r0, sp
@   0x080028e6: f007        fa59 	bl	0x9d9c
@   0x080028ea: 2800        cmp	r0, #0
@   0x080028ec: d100        bne.n	0x28f0
@   0x080028ee: e0a7        b.n	0x2a40
@   0x080028f0: 2003        movs	r0, #3
@   0x080028f2: 7028        strb	r0, [r5, #0]
@   0x080028f4: 4802        ldr	r0, [pc, #8]	@ (0x2900)
@   0x080028f6: 2100        movs	r1, #0
@   0x080028f8: 6141        str	r1, [r0, #20]
@   0x080028fa: 4668        mov	r0, sp
@   0x080028fc: 7001        strb	r1, [r0, #0]
@   0x080028fe: e09f        b.n	0x2a40
@   0x08002900: 5330        strh	r0, [r6, r4]
@   0x08002902: 0300        lsls	r0, r0, #12
@   0x08002904: f7fd        fdde 	bl	0x4c4
@   0x08002908: 4905        ldr	r1, [pc, #20]	@ (0x2920)
@   0x0800290a: 8008        strh	r0, [r1, #0]
@   0x0800290c: 0400        lsls	r0, r0, #16
@   0x0800290e: 0c00        lsrs	r0, r0, #16
@   0x08002910: 2840        cmp	r0, #64	@ 0x40
@   0x08002912: d107        bne.n	0x2924
@   0x08002914: 2005        movs	r0, #5
@   0x08002916: 7028        strb	r0, [r5, #0]
@   0x08002918: f00b        fba2 	bl	0xe060
@   0x0800291c: e090        b.n	0x2a40
@   0x0800291e: 0000        movs	r0, r0
@   0x08002920: 5398        strh	r0, [r3, r6]
@   0x08002922: 0300        lsls	r0, r0, #12
@   0x08002924: 4906        ldr	r1, [pc, #24]	@ (0x2940)
@   0x08002926: 2308        movs	r3, #8
@   0x08002928: 2208        movs	r2, #8
@   0x0800292a: 1c10        adds	r0, r2, #0
@   0x0800292c: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800292e: 4008        ands	r0, r1
@   0x08002930: 2800        cmp	r0, #0
@   0x08002932: d007        beq.n	0x2944
@   0x08002934: 2004        movs	r0, #4
@   0x08002936: 7028        strb	r0, [r5, #0]
@   0x08002938: f00c        fb2a 	bl	0xef90
@   0x0800293c: e080        b.n	0x2a40
@   0x0800293e: 0000        movs	r0, r0
@   0x08002940: 3720        adds	r7, #32
@   0x08002942: 0300        lsls	r0, r0, #12
@   0x08002944: 4903        ldr	r1, [pc, #12]	@ (0x2954)
@   0x08002946: 1c10        adds	r0, r2, #0
@   0x08002948: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x0800294a: 4008        ands	r0, r1
@   0x0800294c: 2800        cmp	r0, #0
@   0x0800294e: d003        beq.n	0x2958
@   0x08002950: 702b        strb	r3, [r5, #0]
@   0x08002952: e075        b.n	0x2a40
@   0x08002954: 6110        str	r0, [r2, #16]
@   0x08002956: 0300        lsls	r0, r0, #12
@   0x08002958: f007        fcbe 	bl	0xa2d8
@   0x0800295c: f7fd        ffbe 	bl	0x8dc
@   0x08002960: f007        fce2 	bl	0xa328
@   0x08002964: f006        fdc8 	bl	0x94f8
@   0x08002968: f007        f80c 	bl	0x9984
@   0x0800296c: 4902        ldr	r1, [pc, #8]	@ (0x2978)
@   0x0800296e: 6948        ldr	r0, [r1, #20]
@   0x08002970: 3001        adds	r0, #1
@   0x08002972: 6148        str	r0, [r1, #20]
@   0x08002974: e064        b.n	0x2a40
@   0x08002976: 0000        movs	r0, r0
@   0x08002978: 5330        strh	r0, [r6, r4]
@   0x0800297a: 0300        lsls	r0, r0, #12
@   0x0800297c: 1c28        adds	r0, r5, #0
@   0x0800297e: f007        f949 	bl	0x9c14
@   0x08002982: 2800        cmp	r0, #0
@   0x08002984: d101        bne.n	0x298a
@   0x08002986: 2007        movs	r0, #7
@   0x08002988: 7028        strb	r0, [r5, #0]
@   0x0800298a: 4669        mov	r1, sp
@   0x0800298c: 2000        movs	r0, #0
@   0x0800298e: 7008        strb	r0, [r1, #0]
@   0x08002990: e056        b.n	0x2a40
@   0x08002992: f7fd        fd97 	bl	0x4c4
@   0x08002996: 4909        ldr	r1, [pc, #36]	@ (0x29bc)
@   0x08002998: 8008        strh	r0, [r1, #0]
@   0x0800299a: f00b        fe85 	bl	0xe6a8
@   0x0800299e: 0600        lsls	r0, r0, #24
@   0x080029a0: 0e01        lsrs	r1, r0, #24
@   0x080029a2: 2900        cmp	r1, #0
@   0x080029a4: d103        bne.n	0x29ae
@   0x080029a6: 2006        movs	r0, #6
@   0x080029a8: 7028        strb	r0, [r5, #0]
@   0x080029aa: 4668        mov	r0, sp
@   0x080029ac: 7001        strb	r1, [r0, #0]
@   0x080029ae: 4804        ldr	r0, [pc, #16]	@ (0x29c0)
@   0x080029b0: 7800        ldrb	r0, [r0, #0]
@   0x080029b2: 2800        cmp	r0, #0
@   0x080029b4: d144        bne.n	0x2a40
@   0x080029b6: 2003        movs	r0, #3
@   0x080029b8: 7028        strb	r0, [r5, #0]
@   0x080029ba: e041        b.n	0x2a40
@   0x080029bc: 5398        strh	r0, [r3, r6]
@   0x080029be: 0300        lsls	r0, r0, #12
@   0x080029c0: 5328        strh	r0, [r5, r4]
@   0x080029c2: 0300        lsls	r0, r0, #12
@   0x080029c4: 4668        mov	r0, sp
@   0x080029c6: 7800        ldrb	r0, [r0, #0]
@   0x080029c8: 0600        lsls	r0, r0, #24
@   0x080029ca: 1600        asrs	r0, r0, #24
@   0x080029cc: 2800        cmp	r0, #0
@   0x080029ce: d107        bne.n	0x29e0
@   0x080029d0: 20bf        movs	r0, #191	@ 0xbf
@   0x080029d2: f00d        fe5f 	bl	0x10694
@   0x080029d6: 4668        mov	r0, sp
@   0x080029d8: 4669        mov	r1, sp
@   0x080029da: 7809        ldrb	r1, [r1, #0]
@   0x080029dc: 3101        adds	r1, #1
@   0x080029de: 7001        strb	r1, [r0, #0]
@   0x080029e0: 4668        mov	r0, sp
@   0x080029e2: 2400        movs	r4, #0
@   0x080029e4: 5704        ldrsb	r4, [r0, r4]
@   0x080029e6: 2c01        cmp	r4, #1
@   0x080029e8: d12a        bne.n	0x2a40
@   0x080029ea: f00d        fe65 	bl	0x106b8
@   0x080029ee: 0600        lsls	r0, r0, #24
@   0x080029f0: 2800        cmp	r0, #0
@   0x080029f2: d125        bne.n	0x2a40
@   0x080029f4: 4803        ldr	r0, [pc, #12]	@ (0x2a04)
@   0x080029f6: 2104        movs	r1, #4
@   0x080029f8: 7001        strb	r1, [r0, #0]
@   0x080029fa: 7184        strb	r4, [r0, #6]
@   0x080029fc: 4802        ldr	r0, [pc, #8]	@ (0x2a08)
@   0x080029fe: 7241        strb	r1, [r0, #9]
@   0x08002a00: e01e        b.n	0x2a40
@   0x08002a02: 0000        movs	r0, r0
@   0x08002a04: 3480        adds	r4, #128	@ 0x80
@   0x08002a06: 0300        lsls	r0, r0, #12
@   0x08002a08: 5330        strh	r0, [r6, r4]
@   0x08002a0a: 0300        lsls	r0, r0, #12
@   0x08002a0c: 4909        ldr	r1, [pc, #36]	@ (0x2a34)
@   0x08002a0e: 4668        mov	r0, sp
@   0x08002a10: f007        fb78 	bl	0xa104
@   0x08002a14: 0600        lsls	r0, r0, #24
@   0x08002a16: 2800        cmp	r0, #0
@   0x08002a18: d008        beq.n	0x2a2c
@   0x08002a1a: 2002        movs	r0, #2
@   0x08002a1c: 7028        strb	r0, [r5, #0]
@   0x08002a1e: 4806        ldr	r0, [pc, #24]	@ (0x2a38)
@   0x08002a20: 2100        movs	r1, #0
@   0x08002a22: 6141        str	r1, [r0, #20]
@   0x08002a24: 4668        mov	r0, sp
@   0x08002a26: 7001        strb	r1, [r0, #0]
@   0x08002a28: f007        fbce 	bl	0xa1c8
@   0x08002a2c: f7fd        ff56 	bl	0x8dc
@   0x08002a30: e006        b.n	0x2a40
@   0x08002a32: 0000        movs	r0, r0
@   0x08002a34: a26d        add	r2, pc, #436	@ (adr r2, 0x2bec)
@   0x08002a36: 0800        lsrs	r0, r0, #32
@   0x08002a38: 5330        strh	r0, [r6, r4]
@   0x08002a3a: 0300        lsls	r0, r0, #12
@   0x08002a3c: f00b        fa20 	bl	0xde80
@   0x08002a40: 4805        ldr	r0, [pc, #20]	@ (0x2a58)
@   0x08002a42: 7a40        ldrb	r0, [r0, #9]
@   0x08002a44: 280f        cmp	r0, #15
@   0x08002a46: d100        bne.n	0x2a4a
@   0x08002a48: e70a        b.n	0x2860
@   0x08002a4a: 2818        cmp	r0, #24
@   0x08002a4c: d100        bne.n	0x2a50
@   0x08002a4e: e707        b.n	0x2860
@   0x08002a50: b001        add	sp, #4
@   0x08002a52: bc30        pop	{r4, r5}
@   0x08002a54: bc01        pop	{r0}
@   0x08002a56: 4700        bx	r0
@   0x08002a58: 5330        strh	r0, [r6, r4]
@   0x08002a5a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002844
sub_08002844: @ 0x08002844
        .incbin "frog_us_baserom.gba", 0x2844, 0x218
        thumb_func_end sub_08002844
