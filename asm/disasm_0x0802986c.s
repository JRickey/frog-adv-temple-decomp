@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802986c, 0x0802a284)  (2584 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802986c --end 0x802a284 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802986c: b500        push	{lr}
@   0x0802986e: b084        sub	sp, #16
@   0x08029870: 480b        ldr	r0, [pc, #44]	@ (0x298a0)
@   0x08029872: 2103        movs	r1, #3
@   0x08029874: 2201        movs	r2, #1
@   0x08029876: f7dc        ff91 	bl	0x679c
@   0x0802987a: 0600        lsls	r0, r0, #24
@   0x0802987c: 2800        cmp	r0, #0
@   0x0802987e: d015        beq.n	0x298ac
@   0x08029880: 4808        ldr	r0, [pc, #32]	@ (0x298a4)
@   0x08029882: 6841        ldr	r1, [r0, #4]
@   0x08029884: 4808        ldr	r0, [pc, #32]	@ (0x298a8)
@   0x08029886: 9000        str	r0, [sp, #0]
@   0x08029888: 200b        movs	r0, #11
@   0x0802988a: 9001        str	r0, [sp, #4]
@   0x0802988c: 2003        movs	r0, #3
@   0x0802988e: 9002        str	r0, [sp, #8]
@   0x08029890: 9003        str	r0, [sp, #12]
@   0x08029892: 2059        movs	r0, #89	@ 0x59
@   0x08029894: 2208        movs	r2, #8
@   0x08029896: 2346        movs	r3, #70	@ 0x46
@   0x08029898: f7f7        fc02 	bl	0x210a0
@   0x0802989c: e014        b.n	0x298c8
@   0x0802989e: 0000        movs	r0, r0
@   0x080298a0: 6110        str	r0, [r2, #16]
@   0x080298a2: 0300        lsls	r0, r0, #12
@   0x080298a4: 7af8        ldrb	r0, [r7, #11]
@   0x080298a6: 0831        lsrs	r1, r6, #32
@   0x080298a8: 01f5        lsls	r5, r6, #7
@   0x080298aa: 0000        movs	r0, r0
@   0x080298ac: 4808        ldr	r0, [pc, #32]	@ (0x298d0)
@   0x080298ae: 6801        ldr	r1, [r0, #0]
@   0x080298b0: 4808        ldr	r0, [pc, #32]	@ (0x298d4)
@   0x080298b2: 9000        str	r0, [sp, #0]
@   0x080298b4: 200b        movs	r0, #11
@   0x080298b6: 9001        str	r0, [sp, #4]
@   0x080298b8: 2003        movs	r0, #3
@   0x080298ba: 9002        str	r0, [sp, #8]
@   0x080298bc: 9003        str	r0, [sp, #12]
@   0x080298be: 2059        movs	r0, #89	@ 0x59
@   0x080298c0: 2210        movs	r2, #16
@   0x080298c2: 2346        movs	r3, #70	@ 0x46
@   0x080298c4: f7f7        fbec 	bl	0x210a0
@   0x080298c8: b004        add	sp, #16
@   0x080298ca: bc01        pop	{r0}
@   0x080298cc: 4700        bx	r0
@   0x080298ce: 0000        movs	r0, r0
@   0x080298d0: 7af8        ldrb	r0, [r7, #11]
@   0x080298d2: 0831        lsrs	r1, r6, #32
@   0x080298d4: 01f5        lsls	r5, r6, #7
@   0x080298d6: 0000        movs	r0, r0
@   0x080298d8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080298da: b084        sub	sp, #16
@   0x080298dc: 2600        movs	r6, #0
@   0x080298de: 2703        movs	r7, #3
@   0x080298e0: 1c35        adds	r5, r6, #0
@   0x080298e2: 355b        adds	r5, #91	@ 0x5b
@   0x080298e4: 4910        ldr	r1, [pc, #64]	@ (0x29928)
@   0x080298e6: 00b0        lsls	r0, r6, #2
@   0x080298e8: 1840        adds	r0, r0, r1
@   0x080298ea: 6804        ldr	r4, [r0, #0]
@   0x080298ec: 1c30        adds	r0, r6, #0
@   0x080298ee: 2103        movs	r1, #3
@   0x080298f0: f00a        fb34 	bl	0x33f5c
@   0x080298f4: 0600        lsls	r0, r0, #24
@   0x080298f6: 0900        lsrs	r0, r0, #4
@   0x080298f8: 490c        ldr	r1, [pc, #48]	@ (0x2992c)
@   0x080298fa: 1840        adds	r0, r0, r1
@   0x080298fc: 0c00        lsrs	r0, r0, #16
@   0x080298fe: 9000        str	r0, [sp, #0]
@   0x08029900: 200d        movs	r0, #13
@   0x08029902: 9001        str	r0, [sp, #4]
@   0x08029904: 9702        str	r7, [sp, #8]
@   0x08029906: 9703        str	r7, [sp, #12]
@   0x08029908: 1c28        adds	r0, r5, #0
@   0x0802990a: 1c21        adds	r1, r4, #0
@   0x0802990c: 2210        movs	r2, #16
@   0x0802990e: 233c        movs	r3, #60	@ 0x3c
@   0x08029910: f7f7        fbc6 	bl	0x210a0
@   0x08029914: 1c70        adds	r0, r6, #1
@   0x08029916: 0600        lsls	r0, r0, #24
@   0x08029918: 0e06        lsrs	r6, r0, #24
@   0x0802991a: 2e03        cmp	r6, #3
@   0x0802991c: d9e0        bls.n	0x298e0
@   0x0802991e: b004        add	sp, #16
@   0x08029920: bcf0        pop	{r4, r5, r6, r7}
@   0x08029922: bc01        pop	{r0}
@   0x08029924: 4700        bx	r0
@   0x08029926: 0000        movs	r0, r0
@   0x08029928: 7b00        ldrb	r0, [r0, #12]
@   0x0802992a: 0831        lsrs	r1, r6, #32
@   0x0802992c: 0000        movs	r0, r0
@   0x0802992e: 0275        lsls	r5, r6, #9
@   0x08029930: b530        push	{r4, r5, lr}
@   0x08029932: 2400        movs	r4, #0
@   0x08029934: 4d0b        ldr	r5, [pc, #44]	@ (0x29964)
@   0x08029936: 00a0        lsls	r0, r4, #2
@   0x08029938: 1940        adds	r0, r0, r5
@   0x0802993a: 6800        ldr	r0, [r0, #0]
@   0x0802993c: 1c21        adds	r1, r4, #0
@   0x0802993e: 315b        adds	r1, #91	@ 0x5b
@   0x08029940: f7f8        f83c 	bl	0x219bc
@   0x08029944: 1c60        adds	r0, r4, #1
@   0x08029946: 0600        lsls	r0, r0, #24
@   0x08029948: 0e04        lsrs	r4, r0, #24
@   0x0802994a: 2c03        cmp	r4, #3
@   0x0802994c: d9f3        bls.n	0x29936
@   0x0802994e: 205b        movs	r0, #91	@ 0x5b
@   0x08029950: 215e        movs	r1, #94	@ 0x5e
@   0x08029952: f7f7        fb47 	bl	0x20fe4
@   0x08029956: 205b        movs	r0, #91	@ 0x5b
@   0x08029958: 215e        movs	r1, #94	@ 0x5e
@   0x0802995a: f7dc        f9d9 	bl	0x5d10
@   0x0802995e: bc30        pop	{r4, r5}
@   0x08029960: bc01        pop	{r0}
@   0x08029962: 4700        bx	r0
@   0x08029964: 7b00        ldrb	r0, [r0, #12]
@   0x08029966: 0831        lsrs	r1, r6, #32
@   0x08029968: b500        push	{lr}
@   0x0802996a: b083        sub	sp, #12
@   0x0802996c: 4907        ldr	r1, [pc, #28]	@ (0x2998c)
@   0x0802996e: 4808        ldr	r0, [pc, #32]	@ (0x29990)
@   0x08029970: 9000        str	r0, [sp, #0]
@   0x08029972: 200e        movs	r0, #14
@   0x08029974: 9001        str	r0, [sp, #4]
@   0x08029976: 2000        movs	r0, #0
@   0x08029978: 9002        str	r0, [sp, #8]
@   0x0802997a: 2022        movs	r0, #34	@ 0x22
@   0x0802997c: 2210        movs	r2, #16
@   0x0802997e: 2340        movs	r3, #64	@ 0x40
@   0x08029980: f7f7        fbde 	bl	0x21140
@   0x08029984: b003        add	sp, #12
@   0x08029986: bc01        pop	{r0}
@   0x08029988: 4700        bx	r0
@   0x0802998a: 0000        movs	r0, r0
@   0x0802998c: 7844        ldrb	r4, [r0, #1]
@   0x0802998e: 0831        lsrs	r1, r6, #32
@   0x08029990: 02a5        lsls	r5, r4, #10
@   0x08029992: 0000        movs	r0, r0
@   0x08029994: b500        push	{lr}
@   0x08029996: b084        sub	sp, #16
@   0x08029998: 490c        ldr	r1, [pc, #48]	@ (0x299cc)
@   0x0802999a: 480d        ldr	r0, [pc, #52]	@ (0x299d0)
@   0x0802999c: 9000        str	r0, [sp, #0]
@   0x0802999e: 2006        movs	r0, #6
@   0x080299a0: 9001        str	r0, [sp, #4]
@   0x080299a2: 2002        movs	r0, #2
@   0x080299a4: 9002        str	r0, [sp, #8]
@   0x080299a6: 2003        movs	r0, #3
@   0x080299a8: 9003        str	r0, [sp, #12]
@   0x080299aa: 205f        movs	r0, #95	@ 0x5f
@   0x080299ac: 2210        movs	r2, #16
@   0x080299ae: 2349        movs	r3, #73	@ 0x49
@   0x080299b0: f7f7        fb76 	bl	0x210a0
@   0x080299b4: 4807        ldr	r0, [pc, #28]	@ (0x299d4)
@   0x080299b6: 2105        movs	r1, #5
@   0x080299b8: 2207        movs	r2, #7
@   0x080299ba: f7dc        fe83 	bl	0x66c4
@   0x080299be: 2065        movs	r0, #101	@ 0x65
@   0x080299c0: f7f7        f95a 	bl	0x20c78
@   0x080299c4: b004        add	sp, #16
@   0x080299c6: bc01        pop	{r0}
@   0x080299c8: 4700        bx	r0
@   0x080299ca: 0000        movs	r0, r0
@   0x080299cc: 6f24        ldr	r4, [r4, #112]	@ 0x70
@   0x080299ce: 0831        lsrs	r1, r6, #32
@   0x080299d0: 02f5        lsls	r5, r6, #11
@   0x080299d2: 0000        movs	r0, r0
@   0x080299d4: 6110        str	r0, [r2, #16]
@   0x080299d6: 0300        lsls	r0, r0, #12
@   0x080299d8: b500        push	{lr}
@   0x080299da: b084        sub	sp, #16
@   0x080299dc: 490c        ldr	r1, [pc, #48]	@ (0x29a10)
@   0x080299de: 480d        ldr	r0, [pc, #52]	@ (0x29a14)
@   0x080299e0: 9000        str	r0, [sp, #0]
@   0x080299e2: 2006        movs	r0, #6
@   0x080299e4: 9001        str	r0, [sp, #4]
@   0x080299e6: 2002        movs	r0, #2
@   0x080299e8: 9002        str	r0, [sp, #8]
@   0x080299ea: 2003        movs	r0, #3
@   0x080299ec: 9003        str	r0, [sp, #12]
@   0x080299ee: 2060        movs	r0, #96	@ 0x60
@   0x080299f0: 2210        movs	r2, #16
@   0x080299f2: 2349        movs	r3, #73	@ 0x49
@   0x080299f4: f7f7        fb54 	bl	0x210a0
@   0x080299f8: 4807        ldr	r0, [pc, #28]	@ (0x29a18)
@   0x080299fa: 2105        movs	r1, #5
@   0x080299fc: 2206        movs	r2, #6
@   0x080299fe: f7dc        fe61 	bl	0x66c4
@   0x08029a02: 2065        movs	r0, #101	@ 0x65
@   0x08029a04: f7f7        f938 	bl	0x20c78
@   0x08029a08: b004        add	sp, #16
@   0x08029a0a: bc01        pop	{r0}
@   0x08029a0c: 4700        bx	r0
@   0x08029a0e: 0000        movs	r0, r0
@   0x08029a10: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x08029a12: 0831        lsrs	r1, r6, #32
@   0x08029a14: 02f5        lsls	r5, r6, #11
@   0x08029a16: 0000        movs	r0, r0
@   0x08029a18: 6110        str	r0, [r2, #16]
@   0x08029a1a: 0300        lsls	r0, r0, #12
@   0x08029a1c: b570        push	{r4, r5, r6, lr}
@   0x08029a1e: 464e        mov	r6, r9
@   0x08029a20: 4645        mov	r5, r8
@   0x08029a22: b460        push	{r5, r6}
@   0x08029a24: b083        sub	sp, #12
@   0x08029a26: 491b        ldr	r1, [pc, #108]	@ (0x29a94)
@   0x08029a28: 481b        ldr	r0, [pc, #108]	@ (0x29a98)
@   0x08029a2a: 9000        str	r0, [sp, #0]
@   0x08029a2c: 200c        movs	r0, #12
@   0x08029a2e: 4680        mov	r8, r0
@   0x08029a30: 9001        str	r0, [sp, #4]
@   0x08029a32: 2600        movs	r6, #0
@   0x08029a34: 9602        str	r6, [sp, #8]
@   0x08029a36: 205a        movs	r0, #90	@ 0x5a
@   0x08029a38: 2200        movs	r2, #0
@   0x08029a3a: 2348        movs	r3, #72	@ 0x48
@   0x08029a3c: f7f7        fb80 	bl	0x21140
@   0x08029a40: 4c16        ldr	r4, [pc, #88]	@ (0x29a9c)
@   0x08029a42: 2280        movs	r2, #128	@ 0x80
@   0x08029a44: 0052        lsls	r2, r2, #1
@   0x08029a46: 1c20        adds	r0, r4, #0
@   0x08029a48: 1c11        adds	r1, r2, #0
@   0x08029a4a: 2300        movs	r3, #0
@   0x08029a4c: f7e0        fe9c 	bl	0xa788
@   0x08029a50: 4813        ldr	r0, [pc, #76]	@ (0x29aa0)
@   0x08029a52: 4681        mov	r9, r0
@   0x08029a54: 4d13        ldr	r5, [pc, #76]	@ (0x29aa4)
@   0x08029a56: 9500        str	r5, [sp, #0]
@   0x08029a58: 4640        mov	r0, r8
@   0x08029a5a: 9001        str	r0, [sp, #4]
@   0x08029a5c: 9602        str	r6, [sp, #8]
@   0x08029a5e: 2061        movs	r0, #97	@ 0x61
@   0x08029a60: 4649        mov	r1, r9
@   0x08029a62: 2210        movs	r2, #16
@   0x08029a64: 234a        movs	r3, #74	@ 0x4a
@   0x08029a66: f7f7        fb6b 	bl	0x21140
@   0x08029a6a: 9500        str	r5, [sp, #0]
@   0x08029a6c: 4640        mov	r0, r8
@   0x08029a6e: 9001        str	r0, [sp, #4]
@   0x08029a70: 9602        str	r6, [sp, #8]
@   0x08029a72: 2062        movs	r0, #98	@ 0x62
@   0x08029a74: 4649        mov	r1, r9
@   0x08029a76: 2210        movs	r2, #16
@   0x08029a78: 234a        movs	r3, #74	@ 0x4a
@   0x08029a7a: f7f7        fb61 	bl	0x21140
@   0x08029a7e: 342a        adds	r4, #42	@ 0x2a
@   0x08029a80: 2001        movs	r0, #1
@   0x08029a82: 7020        strb	r0, [r4, #0]
@   0x08029a84: b003        add	sp, #12
@   0x08029a86: bc18        pop	{r3, r4}
@   0x08029a88: 4698        mov	r8, r3
@   0x08029a8a: 46a1        mov	r9, r4
@   0x08029a8c: bc70        pop	{r4, r5, r6}
@   0x08029a8e: bc01        pop	{r0}
@   0x08029a90: 4700        bx	r0
@   0x08029a92: 0000        movs	r0, r0
@   0x08029a94: 7784        strb	r4, [r0, #30]
@   0x08029a96: 0831        lsrs	r1, r6, #32
@   0x08029a98: 0235        lsls	r5, r6, #8
@   0x08029a9a: 0000        movs	r0, r0
@   0x08029a9c: 4ad0        ldr	r2, [pc, #832]	@ (0x29de0)
@   0x08029a9e: 0300        lsls	r0, r0, #12
@   0x08029aa0: 7794        strb	r4, [r2, #30]
@   0x08029aa2: 0831        lsrs	r1, r6, #32
@   0x08029aa4: 02f6        lsls	r6, r6, #11
@   0x08029aa6: 0000        movs	r0, r0
@   0x08029aa8: b570        push	{r4, r5, r6, lr}
@   0x08029aaa: 4646        mov	r6, r8
@   0x08029aac: b440        push	{r6}
@   0x08029aae: b082        sub	sp, #8
@   0x08029ab0: 4e14        ldr	r6, [pc, #80]	@ (0x29b04)
@   0x08029ab2: 4815        ldr	r0, [pc, #84]	@ (0x29b08)
@   0x08029ab4: 4680        mov	r8, r0
@   0x08029ab6: 2500        movs	r5, #0
@   0x08029ab8: 9500        str	r5, [sp, #0]
@   0x08029aba: 4c14        ldr	r4, [pc, #80]	@ (0x29b0c)
@   0x08029abc: 4814        ldr	r0, [pc, #80]	@ (0x29b10)
@   0x08029abe: 1824        adds	r4, r4, r0
@   0x08029ac0: 7820        ldrb	r0, [r4, #0]
@   0x08029ac2: 9001        str	r0, [sp, #4]
@   0x08029ac4: 205a        movs	r0, #90	@ 0x5a
@   0x08029ac6: 1c31        adds	r1, r6, #0
@   0x08029ac8: 4642        mov	r2, r8
@   0x08029aca: 2300        movs	r3, #0
@   0x08029acc: f7f8        f916 	bl	0x21cfc
@   0x08029ad0: 9500        str	r5, [sp, #0]
@   0x08029ad2: 7820        ldrb	r0, [r4, #0]
@   0x08029ad4: 9001        str	r0, [sp, #4]
@   0x08029ad6: 2061        movs	r0, #97	@ 0x61
@   0x08029ad8: 1c31        adds	r1, r6, #0
@   0x08029ada: 4642        mov	r2, r8
@   0x08029adc: 230f        movs	r3, #15
@   0x08029ade: f7f8        f90d 	bl	0x21cfc
@   0x08029ae2: 230f        movs	r3, #15
@   0x08029ae4: 425b        negs	r3, r3
@   0x08029ae6: 9500        str	r5, [sp, #0]
@   0x08029ae8: 7820        ldrb	r0, [r4, #0]
@   0x08029aea: 9001        str	r0, [sp, #4]
@   0x08029aec: 2062        movs	r0, #98	@ 0x62
@   0x08029aee: 1c31        adds	r1, r6, #0
@   0x08029af0: 4642        mov	r2, r8
@   0x08029af2: f7f8        f903 	bl	0x21cfc
@   0x08029af6: b002        add	sp, #8
@   0x08029af8: bc08        pop	{r3}
@   0x08029afa: 4698        mov	r8, r3
@   0x08029afc: bc70        pop	{r4, r5, r6}
@   0x08029afe: bc01        pop	{r0}
@   0x08029b00: 4700        bx	r0
@   0x08029b02: 0000        movs	r0, r0
@   0x08029b04: 014f        lsls	r7, r1, #5
@   0x08029b06: 0000        movs	r0, r0
@   0x08029b08: 0377        lsls	r7, r6, #13
@   0x08029b0a: 0000        movs	r0, r0
@   0x08029b0c: 3720        adds	r7, #32
@   0x08029b0e: 0300        lsls	r0, r0, #12
@   0x08029b10: 13da        asrs	r2, r3, #15
@   0x08029b12: 0000        movs	r0, r0
@   0x08029b14: b500        push	{lr}
@   0x08029b16: b083        sub	sp, #12
@   0x08029b18: 4907        ldr	r1, [pc, #28]	@ (0x29b38)
@   0x08029b1a: 4808        ldr	r0, [pc, #32]	@ (0x29b3c)
@   0x08029b1c: 9000        str	r0, [sp, #0]
@   0x08029b1e: 2005        movs	r0, #5
@   0x08029b20: 9001        str	r0, [sp, #4]
@   0x08029b22: 2000        movs	r0, #0
@   0x08029b24: 9002        str	r0, [sp, #8]
@   0x08029b26: 206f        movs	r0, #111	@ 0x6f
@   0x08029b28: 2200        movs	r2, #0
@   0x08029b2a: 234c        movs	r3, #76	@ 0x4c
@   0x08029b2c: f7f7        fb08 	bl	0x21140
@   0x08029b30: b003        add	sp, #12
@   0x08029b32: bc01        pop	{r0}
@   0x08029b34: 4700        bx	r0
@   0x08029b36: 0000        movs	r0, r0
@   0x08029b38: 6eb4        ldr	r4, [r6, #104]	@ 0x68
@   0x08029b3a: 0831        lsrs	r1, r6, #32
@   0x08029b3c: 0317        lsls	r7, r2, #12
@   0x08029b3e: 0000        movs	r0, r0
@   0x08029b40: b500        push	{lr}
@   0x08029b42: b081        sub	sp, #4
@   0x08029b44: 4905        ldr	r1, [pc, #20]	@ (0x29b5c)
@   0x08029b46: 4b06        ldr	r3, [pc, #24]	@ (0x29b60)
@   0x08029b48: 2000        movs	r0, #0
@   0x08029b4a: 9000        str	r0, [sp, #0]
@   0x08029b4c: 206f        movs	r0, #111	@ 0x6f
@   0x08029b4e: 224c        movs	r2, #76	@ 0x4c
@   0x08029b50: f7f7        fcde 	bl	0x21510
@   0x08029b54: b001        add	sp, #4
@   0x08029b56: bc01        pop	{r0}
@   0x08029b58: 4700        bx	r0
@   0x08029b5a: 0000        movs	r0, r0
@   0x08029b5c: 6eb4        ldr	r4, [r6, #104]	@ 0x68
@   0x08029b5e: 0831        lsrs	r1, r6, #32
@   0x08029b60: 6110        str	r0, [r2, #16]
@   0x08029b62: 0300        lsls	r0, r0, #12
@   0x08029b64: b530        push	{r4, r5, lr}
@   0x08029b66: 2300        movs	r3, #0
@   0x08029b68: 4d18        ldr	r5, [pc, #96]	@ (0x29bcc)
@   0x08029b6a: 4c19        ldr	r4, [pc, #100]	@ (0x29bd0)
@   0x08029b6c: 00d8        lsls	r0, r3, #3
@   0x08029b6e: 1942        adds	r2, r0, r5
@   0x08029b70: 1900        adds	r0, r0, r4
@   0x08029b72: 6841        ldr	r1, [r0, #4]
@   0x08029b74: 6800        ldr	r0, [r0, #0]
@   0x08029b76: 6050        str	r0, [r2, #4]
@   0x08029b78: 6091        str	r1, [r2, #8]
@   0x08029b7a: 1c58        adds	r0, r3, #1
@   0x08029b7c: 0600        lsls	r0, r0, #24
@   0x08029b7e: 0e03        lsrs	r3, r0, #24
@   0x08029b80: 2b0b        cmp	r3, #11
@   0x08029b82: d9f3        bls.n	0x29b6c
@   0x08029b84: f7ff        fd12 	bl	0x295ac
@   0x08029b88: f7ff        fd36 	bl	0x295f8
@   0x08029b8c: f7ff        fd5a 	bl	0x29644
@   0x08029b90: f7fe        fcf4 	bl	0x2857c
@   0x08029b94: f7fe        fd34 	bl	0x28600
@   0x08029b98: f7ff        fdf2 	bl	0x29780
@   0x08029b9c: f7ff        fe66 	bl	0x2986c
@   0x08029ba0: f7ff        fe9a 	bl	0x298d8
@   0x08029ba4: f7ff        fee0 	bl	0x29968
@   0x08029ba8: f7ff        ff38 	bl	0x29a1c
@   0x08029bac: f7fe        ff74 	bl	0x28a98
@   0x08029bb0: f7ff        fdfc 	bl	0x297ac
@   0x08029bb4: f7ff        fb94 	bl	0x292e0
@   0x08029bb8: 4806        ldr	r0, [pc, #24]	@ (0x29bd4)
@   0x08029bba: 210a        movs	r1, #10
@   0x08029bbc: 5e40        ldrsh	r0, [r0, r1]
@   0x08029bbe: 281e        cmp	r0, #30
@   0x08029bc0: dd0a        ble.n	0x29bd8
@   0x08029bc2: f7ff        fd65 	bl	0x29690
@   0x08029bc6: f7ff        fd77 	bl	0x296b8
@   0x08029bca: e009        b.n	0x29be0
@   0x08029bcc: 3570        adds	r5, #112	@ 0x70
@   0x08029bce: 0300        lsls	r0, r0, #12
@   0x08029bd0: 7b4c        ldrb	r4, [r1, #13]
@   0x08029bd2: 0831        lsrs	r1, r6, #32
@   0x08029bd4: 35e0        adds	r5, #224	@ 0xe0
@   0x08029bd6: 0300        lsls	r0, r0, #12
@   0x08029bd8: 281d        cmp	r0, #29
@   0x08029bda: dc01        bgt.n	0x29be0
@   0x08029bdc: f7ff        fe24 	bl	0x29828
@   0x08029be0: f7ff        ff98 	bl	0x29b14
@   0x08029be4: bc30        pop	{r4, r5}
@   0x08029be6: bc01        pop	{r0}
@   0x08029be8: 4700        bx	r0
@   0x08029bea: 0000        movs	r0, r0
@   0x08029bec: b500        push	{lr}
@   0x08029bee: f7ff        ffa7 	bl	0x29b40
@   0x08029bf2: f7ff        fcef 	bl	0x295d4
@   0x08029bf6: f7ff        fd13 	bl	0x29620
@   0x08029bfa: f7ff        fd37 	bl	0x2966c
@   0x08029bfe: f7ff        fd87 	bl	0x29710
@   0x08029c02: f7ff        fda1 	bl	0x29748
@   0x08029c06: f7fe        fd3d 	bl	0x28684
@   0x08029c0a: f7fe        fdb7 	bl	0x2877c
@   0x08029c0e: f7ff        fe8f 	bl	0x29930
@   0x08029c12: f7fe        fe21 	bl	0x28858
@   0x08029c16: f7ff        ff47 	bl	0x29aa8
@   0x08029c1a: f7fe        ffbb 	bl	0x28b94
@   0x08029c1e: f7ff        fde7 	bl	0x297f0
@   0x08029c22: f7ff        fc11 	bl	0x29448
@   0x08029c26: 4804        ldr	r0, [pc, #16]	@ (0x29c38)
@   0x08029c28: 6881        ldr	r1, [r0, #8]
@   0x08029c2a: 4804        ldr	r0, [pc, #16]	@ (0x29c3c)
@   0x08029c2c: 4281        cmp	r1, r0
@   0x08029c2e: d107        bne.n	0x29c40
@   0x08029c30: f7ff        fdfa 	bl	0x29828
@   0x08029c34: e00b        b.n	0x29c4e
@   0x08029c36: 0000        movs	r0, r0
@   0x08029c38: 35e0        adds	r5, #224	@ 0xe0
@   0x08029c3a: 0300        lsls	r0, r0, #12
@   0x08029c3c: 000f        movs	r7, r1
@   0x08029c3e: 001d        movs	r5, r3
@   0x08029c40: 4807        ldr	r0, [pc, #28]	@ (0x29c60)
@   0x08029c42: 4281        cmp	r1, r0
@   0x08029c44: d103        bne.n	0x29c4e
@   0x08029c46: f7ff        fd23 	bl	0x29690
@   0x08029c4a: f7ff        fd35 	bl	0x296b8
@   0x08029c4e: 4805        ldr	r0, [pc, #20]	@ (0x29c64)
@   0x08029c50: 210a        movs	r1, #10
@   0x08029c52: 5e40        ldrsh	r0, [r0, r1]
@   0x08029c54: 2819        cmp	r0, #25
@   0x08029c56: dc07        bgt.n	0x29c68
@   0x08029c58: f7fe        fd62 	bl	0x28720
@   0x08029c5c: e00a        b.n	0x29c74
@   0x08029c5e: 0000        movs	r0, r0
@   0x08029c60: 000e        movs	r6, r1
@   0x08029c62: 001d        movs	r5, r3
@   0x08029c64: 35e0        adds	r5, #224	@ 0xe0
@   0x08029c66: 0300        lsls	r0, r0, #12
@   0x08029c68: 2820        cmp	r0, #32
@   0x08029c6a: dd03        ble.n	0x29c74
@   0x08029c6c: f7fe        fb00 	bl	0x28270
@   0x08029c70: f7fe        fc56 	bl	0x28520
@   0x08029c74: bc01        pop	{r0}
@   0x08029c76: 4700        bx	r0
@   0x08029c78: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08029c7a: 464f        mov	r7, r9
@   0x08029c7c: 4646        mov	r6, r8
@   0x08029c7e: b4c0        push	{r6, r7}
@   0x08029c80: 1c07        adds	r7, r0, #0
@   0x08029c82: 4689        mov	r9, r1
@   0x08029c84: 4821        ldr	r0, [pc, #132]	@ (0x29d0c)
@   0x08029c86: 4680        mov	r8, r0
@   0x08029c88: 7e05        ldrb	r5, [r0, #24]
@   0x08029c8a: 7e46        ldrb	r6, [r0, #25]
@   0x08029c8c: 2102        movs	r1, #2
@   0x08029c8e: 5e78        ldrsh	r0, [r7, r1]
@   0x08029c90: 2118        movs	r1, #24
@   0x08029c92: f00a        f83f 	bl	0x33d14
@   0x08029c96: 1c04        adds	r4, r0, #0
@   0x08029c98: 0424        lsls	r4, r4, #16
@   0x08029c9a: 1424        asrs	r4, r4, #16
@   0x08029c9c: 2104        movs	r1, #4
@   0x08029c9e: 5e78        ldrsh	r0, [r7, r1]
@   0x08029ca0: 2118        movs	r1, #24
@   0x08029ca2: f00a        f837 	bl	0x33d14
@   0x08029ca6: 1c03        adds	r3, r0, #0
@   0x08029ca8: 041b        lsls	r3, r3, #16
@   0x08029caa: 141b        asrs	r3, r3, #16
@   0x08029cac: 1c28        adds	r0, r5, #0
@   0x08029cae: 1c31        adds	r1, r6, #0
@   0x08029cb0: 1c22        adds	r2, r4, #0
@   0x08029cb2: f7e3        f869 	bl	0xcd88
@   0x08029cb6: 0600        lsls	r0, r0, #24
@   0x08029cb8: 0e00        lsrs	r0, r0, #24
@   0x08029cba: 2801        cmp	r0, #1
@   0x08029cbc: d01c        beq.n	0x29cf8
@   0x08029cbe: 4640        mov	r0, r8
@   0x08029cc0: 7e05        ldrb	r5, [r0, #24]
@   0x08029cc2: 7e46        ldrb	r6, [r0, #25]
@   0x08029cc4: 2102        movs	r1, #2
@   0x08029cc6: 5e78        ldrsh	r0, [r7, r1]
@   0x08029cc8: 2118        movs	r1, #24
@   0x08029cca: f00a        f823 	bl	0x33d14
@   0x08029cce: 1c04        adds	r4, r0, #0
@   0x08029cd0: 0424        lsls	r4, r4, #16
@   0x08029cd2: 1424        asrs	r4, r4, #16
@   0x08029cd4: 2104        movs	r1, #4
@   0x08029cd6: 5e78        ldrsh	r0, [r7, r1]
@   0x08029cd8: 2118        movs	r1, #24
@   0x08029cda: f00a        f81b 	bl	0x33d14
@   0x08029cde: 1c03        adds	r3, r0, #0
@   0x08029ce0: 3b01        subs	r3, #1
@   0x08029ce2: 041b        lsls	r3, r3, #16
@   0x08029ce4: 141b        asrs	r3, r3, #16
@   0x08029ce6: 1c28        adds	r0, r5, #0
@   0x08029ce8: 1c31        adds	r1, r6, #0
@   0x08029cea: 1c22        adds	r2, r4, #0
@   0x08029cec: f7e3        f84c 	bl	0xcd88
@   0x08029cf0: 0600        lsls	r0, r0, #24
@   0x08029cf2: 0e00        lsrs	r0, r0, #24
@   0x08029cf4: 2801        cmp	r0, #1
@   0x08029cf6: d103        bne.n	0x29d00
@   0x08029cf8: 2002        movs	r0, #2
@   0x08029cfa: 75f8        strb	r0, [r7, #23]
@   0x08029cfc: 4649        mov	r1, r9
@   0x08029cfe: 75c8        strb	r0, [r1, #23]
@   0x08029d00: bc18        pop	{r3, r4}
@   0x08029d02: 4698        mov	r8, r3
@   0x08029d04: 46a1        mov	r9, r4
@   0x08029d06: bcf0        pop	{r4, r5, r6, r7}
@   0x08029d08: bc01        pop	{r0}
@   0x08029d0a: 4700        bx	r0
@   0x08029d0c: 35e0        adds	r5, #224	@ 0xe0
@   0x08029d0e: 0300        lsls	r0, r0, #12
@   0x08029d10: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08029d12: 4657        mov	r7, sl
@   0x08029d14: 464e        mov	r6, r9
@   0x08029d16: 4645        mov	r5, r8
@   0x08029d18: b4e0        push	{r5, r6, r7}
@   0x08029d1a: 4a3a        ldr	r2, [pc, #232]	@ (0x29e04)
@   0x08029d1c: 20df        movs	r0, #223	@ 0xdf
@   0x08029d1e: 0080        lsls	r0, r0, #2
@   0x08029d20: 1811        adds	r1, r2, r0
@   0x08029d22: 2008        movs	r0, #8
@   0x08029d24: 8809        ldrh	r1, [r1, #0]
@   0x08029d26: 4008        ands	r0, r1
@   0x08029d28: 2800        cmp	r0, #0
@   0x08029d2a: d164        bne.n	0x29df6
@   0x08029d2c: 2600        movs	r6, #0
@   0x08029d2e: 21d2        movs	r1, #210	@ 0xd2
@   0x08029d30: 0089        lsls	r1, r1, #2
@   0x08029d32: 1889        adds	r1, r1, r2
@   0x08029d34: 468a        mov	sl, r1
@   0x08029d36: 4834        ldr	r0, [pc, #208]	@ (0x29e08)
@   0x08029d38: 4681        mov	r9, r0
@   0x08029d3a: 2708        movs	r7, #8
@   0x08029d3c: 21d1        movs	r1, #209	@ 0xd1
@   0x08029d3e: 0089        lsls	r1, r1, #2
@   0x08029d40: 1889        adds	r1, r1, r2
@   0x08029d42: 4688        mov	r8, r1
@   0x08029d44: 00f0        lsls	r0, r6, #3
@   0x08029d46: 1b80        subs	r0, r0, r6
@   0x08029d48: 00c0        lsls	r0, r0, #3
@   0x08029d4a: 4652        mov	r2, sl
@   0x08029d4c: 1884        adds	r4, r0, r2
@   0x08029d4e: 218c        movs	r1, #140	@ 0x8c
@   0x08029d50: 0049        lsls	r1, r1, #1
@   0x08029d52: 4451        add	r1, sl
@   0x08029d54: 1845        adds	r5, r0, r1
@   0x08029d56: 1c20        adds	r0, r4, #0
@   0x08029d58: 1c29        adds	r1, r5, #0
@   0x08029d5a: f7ff        ff8d 	bl	0x29c78
@   0x08029d5e: 4648        mov	r0, r9
@   0x08029d60: 2108        movs	r1, #8
@   0x08029d62: 2201        movs	r2, #1
@   0x08029d64: f7dc        fd1a 	bl	0x679c
@   0x08029d68: 0600        lsls	r0, r0, #24
@   0x08029d6a: 2800        cmp	r0, #0
@   0x08029d6c: d105        bne.n	0x29d7a
@   0x08029d6e: 8ea0        ldrh	r0, [r4, #52]	@ 0x34
@   0x08029d70: 4338        orrs	r0, r7
@   0x08029d72: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08029d74: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x08029d76: 4338        orrs	r0, r7
@   0x08029d78: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08029d7a: 7ee0        ldrb	r0, [r4, #27]
@   0x08029d7c: 2802        cmp	r0, #2
@   0x08029d7e: d110        bne.n	0x29da2
@   0x08029d80: 4a22        ldr	r2, [pc, #136]	@ (0x29e0c)
@   0x08029d82: 4452        add	r2, sl
@   0x08029d84: 1c31        adds	r1, r6, #0
@   0x08029d86: 3119        adds	r1, #25
@   0x08029d88: 00c8        lsls	r0, r1, #3
@   0x08029d8a: 1a40        subs	r0, r0, r1
@   0x08029d8c: 00c0        lsls	r0, r0, #3
@   0x08029d8e: 1880        adds	r0, r0, r2
@   0x08029d90: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08029d92: 4339        orrs	r1, r7
@   0x08029d94: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08029d96: 1c20        adds	r0, r4, #0
@   0x08029d98: 2102        movs	r1, #2
@   0x08029d9a: 220a        movs	r2, #10
@   0x08029d9c: 230a        movs	r3, #10
@   0x08029d9e: f7f7        f839 	bl	0x20e14
@   0x08029da2: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08029da4: 2280        movs	r2, #128	@ 0x80
@   0x08029da6: 0212        lsls	r2, r2, #8
@   0x08029da8: 1c10        adds	r0, r2, #0
@   0x08029daa: 4008        ands	r0, r1
@   0x08029dac: 2800        cmp	r0, #0
@   0x08029dae: d014        beq.n	0x29dda
@   0x08029db0: 1c08        adds	r0, r1, #0
@   0x08029db2: 4338        orrs	r0, r7
@   0x08029db4: 2102        movs	r1, #2
@   0x08029db6: 4308        orrs	r0, r1
@   0x08029db8: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08029dba: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x08029dbc: 4338        orrs	r0, r7
@   0x08029dbe: 4308        orrs	r0, r1
@   0x08029dc0: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08029dc2: 4648        mov	r0, r9
@   0x08029dc4: 2108        movs	r1, #8
@   0x08029dc6: 2200        movs	r2, #0
@   0x08029dc8: f7dc        fc1a 	bl	0x6600
@   0x08029dcc: 4a10        ldr	r2, [pc, #64]	@ (0x29e10)
@   0x08029dce: 1c10        adds	r0, r2, #0
@   0x08029dd0: 4641        mov	r1, r8
@   0x08029dd2: 8809        ldrh	r1, [r1, #0]
@   0x08029dd4: 4008        ands	r0, r1
@   0x08029dd6: 4642        mov	r2, r8
@   0x08029dd8: 8010        strh	r0, [r2, #0]
@   0x08029dda: 1c31        adds	r1, r6, #0
@   0x08029ddc: 310f        adds	r1, #15
@   0x08029dde: 4648        mov	r0, r9
@   0x08029de0: f7dc        fdc4 	bl	0x696c
@   0x08029de4: 1c70        adds	r0, r6, #1
@   0x08029de6: 0600        lsls	r0, r0, #24
@   0x08029de8: 0e06        lsrs	r6, r0, #24
@   0x08029dea: 2e04        cmp	r6, #4
@   0x08029dec: d9aa        bls.n	0x29d44
@   0x08029dee: 200f        movs	r0, #15
@   0x08029df0: 2118        movs	r1, #24
@   0x08029df2: f7db        ff8d 	bl	0x5d10
@   0x08029df6: bc38        pop	{r3, r4, r5}
@   0x08029df8: 4698        mov	r8, r3
@   0x08029dfa: 46a1        mov	r9, r4
@   0x08029dfc: 46aa        mov	sl, r5
@   0x08029dfe: bcf0        pop	{r4, r5, r6, r7}
@   0x08029e00: bc01        pop	{r0}
@   0x08029e02: 4700        bx	r0
@   0x08029e04: 3720        adds	r7, #32
@   0x08029e06: 0300        lsls	r0, r0, #12
@   0x08029e08: 6110        str	r0, [r2, #16]
@   0x08029e0a: 0300        lsls	r0, r0, #12
@   0x08029e0c: fcb8        ffff 			@ <UNDEFINED> instruction: 0xfcb8ffff
@   0x08029e10: 7fff        ldrb	r7, [r7, #31]
@   0x08029e12: 0000        movs	r0, r0
@   0x08029e14: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08029e16: 4657        mov	r7, sl
@   0x08029e18: 464e        mov	r6, r9
@   0x08029e1a: 4645        mov	r5, r8
@   0x08029e1c: b4e0        push	{r5, r6, r7}
@   0x08029e1e: b09d        sub	sp, #116	@ 0x74
@   0x08029e20: 4a44        ldr	r2, [pc, #272]	@ (0x29f34)
@   0x08029e22: 4845        ldr	r0, [pc, #276]	@ (0x29f38)
@   0x08029e24: 1811        adds	r1, r2, r0
@   0x08029e26: 2008        movs	r0, #8
@   0x08029e28: 8809        ldrh	r1, [r1, #0]
@   0x08029e2a: 4008        ands	r0, r1
@   0x08029e2c: 2800        cmp	r0, #0
@   0x08029e2e: d000        beq.n	0x29e32
@   0x08029e30: e0b7        b.n	0x29fa2
@   0x08029e32: 2400        movs	r4, #0
@   0x08029e34: 00e0        lsls	r0, r4, #3
@   0x08029e36: 1b00        subs	r0, r0, r4
@   0x08029e38: 00c0        lsls	r0, r0, #3
@   0x08029e3a: 4940        ldr	r1, [pc, #256]	@ (0x29f3c)
@   0x08029e3c: 1846        adds	r6, r0, r1
@   0x08029e3e: 4840        ldr	r0, [pc, #256]	@ (0x29f40)
@   0x08029e40: 2108        movs	r1, #8
@   0x08029e42: 2201        movs	r2, #1
@   0x08029e44: f7dc        fcaa 	bl	0x679c
@   0x08029e48: 0600        lsls	r0, r0, #24
@   0x08029e4a: 2800        cmp	r0, #0
@   0x08029e4c: d103        bne.n	0x29e56
@   0x08029e4e: 2008        movs	r0, #8
@   0x08029e50: 8eb2        ldrh	r2, [r6, #52]	@ 0x34
@   0x08029e52: 4310        orrs	r0, r2
@   0x08029e54: 86b0        strh	r0, [r6, #52]	@ 0x34
@   0x08029e56: 7eb0        ldrb	r0, [r6, #26]
@   0x08029e58: 2800        cmp	r0, #0
@   0x08029e5a: d177        bne.n	0x29f4c
@   0x08029e5c: 2180        movs	r1, #128	@ 0x80
@   0x08029e5e: 0209        lsls	r1, r1, #8
@   0x08029e60: 1c08        adds	r0, r1, #0
@   0x08029e62: 8eb2        ldrh	r2, [r6, #52]	@ 0x34
@   0x08029e64: 4010        ands	r0, r2
@   0x08029e66: 2119        movs	r1, #25
@   0x08029e68: 1909        adds	r1, r1, r4
@   0x08029e6a: 468a        mov	sl, r1
@   0x08029e6c: 1c62        adds	r2, r4, #1
@   0x08029e6e: 4691        mov	r9, r2
@   0x08029e70: 2800        cmp	r0, #0
@   0x08029e72: d100        bne.n	0x29e76
@   0x08029e74: e087        b.n	0x29f86
@   0x08029e76: 2001        movs	r0, #1
@   0x08029e78: 76b0        strb	r0, [r6, #26]
@   0x08029e7a: 1c27        adds	r7, r4, #0
@   0x08029e7c: 370e        adds	r7, #14
@   0x08029e7e: 2c00        cmp	r4, #0
@   0x08029e80: d14d        bne.n	0x29f1e
@   0x08029e82: a803        add	r0, sp, #12
@   0x08029e84: 2105        movs	r1, #5
@   0x08029e86: 8001        strh	r1, [r0, #0]
@   0x08029e88: 8044        strh	r4, [r0, #2]
@   0x08029e8a: 8084        strh	r4, [r0, #4]
@   0x08029e8c: a80f        add	r0, sp, #60	@ 0x3c
@   0x08029e8e: 8001        strh	r1, [r0, #0]
@   0x08029e90: 8044        strh	r4, [r0, #2]
@   0x08029e92: 8084        strh	r4, [r0, #4]
@   0x08029e94: 2500        movs	r5, #0
@   0x08029e96: 4669        mov	r1, sp
@   0x08029e98: 316c        adds	r1, #108	@ 0x6c
@   0x08029e9a: 911c        str	r1, [sp, #112]	@ 0x70
@   0x08029e9c: 4a29        ldr	r2, [pc, #164]	@ (0x29f44)
@   0x08029e9e: 4690        mov	r8, r2
@   0x08029ea0: 4827        ldr	r0, [pc, #156]	@ (0x29f40)
@   0x08029ea2: 6901        ldr	r1, [r0, #16]
@   0x08029ea4: 062a        lsls	r2, r5, #24
@   0x08029ea6: 1612        asrs	r2, r2, #24
@   0x08029ea8: 981c        ldr	r0, [sp, #112]	@ 0x70
@   0x08029eaa: f7e3        fd3b 	bl	0xd924
@   0x08029eae: 991b        ldr	r1, [sp, #108]	@ 0x6c
@   0x08029eb0: 3501        adds	r5, #1
@   0x08029eb2: 00eb        lsls	r3, r5, #3
@   0x08029eb4: 466c        mov	r4, sp
@   0x08029eb6: 18e4        adds	r4, r4, r3
@   0x08029eb8: 340c        adds	r4, #12
@   0x08029eba: 0408        lsls	r0, r1, #16
@   0x08029ebc: 1400        asrs	r0, r0, #16
@   0x08029ebe: 0042        lsls	r2, r0, #1
@   0x08029ec0: 1812        adds	r2, r2, r0
@   0x08029ec2: 00d2        lsls	r2, r2, #3
@   0x08029ec4: 320b        adds	r2, #11
@   0x08029ec6: 8022        strh	r2, [r4, #0]
@   0x08029ec8: 1409        asrs	r1, r1, #16
@   0x08029eca: 3901        subs	r1, #1
@   0x08029ecc: 0048        lsls	r0, r1, #1
@   0x08029ece: 1840        adds	r0, r0, r1
@   0x08029ed0: 00c0        lsls	r0, r0, #3
@   0x08029ed2: 1c01        adds	r1, r0, #0
@   0x08029ed4: 310b        adds	r1, #11
@   0x08029ed6: 8061        strh	r1, [r4, #2]
@   0x08029ed8: 4641        mov	r1, r8
@   0x08029eda: 80a1        strh	r1, [r4, #4]
@   0x08029edc: 446b        add	r3, sp
@   0x08029ede: 333c        adds	r3, #60	@ 0x3c
@   0x08029ee0: 801a        strh	r2, [r3, #0]
@   0x08029ee2: 3825        subs	r0, #37	@ 0x25
@   0x08029ee4: 8058        strh	r0, [r3, #2]
@   0x08029ee6: 8099        strh	r1, [r3, #4]
@   0x08029ee8: 062d        lsls	r5, r5, #24
@   0x08029eea: 0e2d        lsrs	r5, r5, #24
@   0x08029eec: 2d04        cmp	r5, #4
@   0x08029eee: d9d7        bls.n	0x29ea0
@   0x08029ef0: 2041        movs	r0, #65	@ 0x41
@   0x08029ef2: 9000        str	r0, [sp, #0]
@   0x08029ef4: 2201        movs	r2, #1
@   0x08029ef6: 9201        str	r2, [sp, #4]
@   0x08029ef8: 2400        movs	r4, #0
@   0x08029efa: 9402        str	r4, [sp, #8]
@   0x08029efc: 200f        movs	r0, #15
@   0x08029efe: a903        add	r1, sp, #12
@   0x08029f00: 2220        movs	r2, #32
@   0x08029f02: 234e        movs	r3, #78	@ 0x4e
@   0x08029f04: f7f7        f91c 	bl	0x21140
@   0x08029f08: 2061        movs	r0, #97	@ 0x61
@   0x08029f0a: 9000        str	r0, [sp, #0]
@   0x08029f0c: 2001        movs	r0, #1
@   0x08029f0e: 9001        str	r0, [sp, #4]
@   0x08029f10: 9402        str	r4, [sp, #8]
@   0x08029f12: 2014        movs	r0, #20
@   0x08029f14: a90f        add	r1, sp, #60	@ 0x3c
@   0x08029f16: 2220        movs	r2, #32
@   0x08029f18: 234d        movs	r3, #77	@ 0x4d
@   0x08029f1a: f7f7        f911 	bl	0x21140
@   0x08029f1e: 2002        movs	r0, #2
@   0x08029f20: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x08029f22: 4308        orrs	r0, r1
@   0x08029f24: 86b0        strh	r0, [r6, #52]	@ 0x34
@   0x08029f26: 00f8        lsls	r0, r7, #3
@   0x08029f28: 1bc0        subs	r0, r0, r7
@   0x08029f2a: 00c0        lsls	r0, r0, #3
@   0x08029f2c: 4a01        ldr	r2, [pc, #4]	@ (0x29f34)
@   0x08029f2e: 1880        adds	r0, r0, r2
@   0x08029f30: 4a05        ldr	r2, [pc, #20]	@ (0x29f48)
@   0x08029f32: e024        b.n	0x29f7e
@   0x08029f34: 3720        adds	r7, #32
@   0x08029f36: 0300        lsls	r0, r0, #12
@   0x08029f38: 05ac        lsls	r4, r5, #22
@   0x08029f3a: 0000        movs	r0, r0
@   0x08029f3c: 3c98        subs	r4, #152	@ 0x98
@   0x08029f3e: 0300        lsls	r0, r0, #12
@   0x08029f40: 6110        str	r0, [r2, #16]
@   0x08029f42: 0300        lsls	r0, r0, #12
@   0x08029f44: 0303        lsls	r3, r0, #12
@   0x08029f46: 0000        movs	r0, r0
@   0x08029f48: 7fff        ldrb	r7, [r7, #31]
@   0x08029f4a: 0000        movs	r0, r0
@   0x08029f4c: 2119        movs	r1, #25
@   0x08029f4e: 1909        adds	r1, r1, r4
@   0x08029f50: 468a        mov	sl, r1
@   0x08029f52: 1c62        adds	r2, r4, #1
@   0x08029f54: 4691        mov	r9, r2
@   0x08029f56: 2801        cmp	r0, #1
@   0x08029f58: d115        bne.n	0x29f86
@   0x08029f5a: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x08029f5c: 2280        movs	r2, #128	@ 0x80
@   0x08029f5e: 0212        lsls	r2, r2, #8
@   0x08029f60: 1c10        adds	r0, r2, #0
@   0x08029f62: 4008        ands	r0, r1
@   0x08029f64: 2800        cmp	r0, #0
@   0x08029f66: d00e        beq.n	0x29f86
@   0x08029f68: 2002        movs	r0, #2
@   0x08029f6a: 4308        orrs	r0, r1
@   0x08029f6c: 86b0        strh	r0, [r6, #52]	@ 0x34
@   0x08029f6e: 1c21        adds	r1, r4, #0
@   0x08029f70: 310e        adds	r1, #14
@   0x08029f72: 00c8        lsls	r0, r1, #3
@   0x08029f74: 1a40        subs	r0, r0, r1
@   0x08029f76: 00c0        lsls	r0, r0, #3
@   0x08029f78: 490e        ldr	r1, [pc, #56]	@ (0x29fb4)
@   0x08029f7a: 1840        adds	r0, r0, r1
@   0x08029f7c: 3a01        subs	r2, #1
@   0x08029f7e: 1c11        adds	r1, r2, #0
@   0x08029f80: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x08029f82: 4011        ands	r1, r2
@   0x08029f84: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08029f86: 480c        ldr	r0, [pc, #48]	@ (0x29fb8)
@   0x08029f88: 4651        mov	r1, sl
@   0x08029f8a: f7dc        fcef 	bl	0x696c
@   0x08029f8e: 4649        mov	r1, r9
@   0x08029f90: 0608        lsls	r0, r1, #24
@   0x08029f92: 0e04        lsrs	r4, r0, #24
@   0x08029f94: 2c04        cmp	r4, #4
@   0x08029f96: d800        bhi.n	0x29f9a
@   0x08029f98: e74c        b.n	0x29e34
@   0x08029f9a: 2019        movs	r0, #25
@   0x08029f9c: 211d        movs	r1, #29
@   0x08029f9e: f7db        feb7 	bl	0x5d10
@   0x08029fa2: b01d        add	sp, #116	@ 0x74
@   0x08029fa4: bc38        pop	{r3, r4, r5}
@   0x08029fa6: 4698        mov	r8, r3
@   0x08029fa8: 46a1        mov	r9, r4
@   0x08029faa: 46aa        mov	sl, r5
@   0x08029fac: bcf0        pop	{r4, r5, r6, r7}
@   0x08029fae: bc01        pop	{r0}
@   0x08029fb0: 4700        bx	r0
@   0x08029fb2: 0000        movs	r0, r0
@   0x08029fb4: 3720        adds	r7, #32
@   0x08029fb6: 0300        lsls	r0, r0, #12
@   0x08029fb8: 6110        str	r0, [r2, #16]
@   0x08029fba: 0300        lsls	r0, r0, #12
@   0x08029fbc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08029fbe: b090        sub	sp, #64	@ 0x40
@   0x08029fc0: 4d3a        ldr	r5, [pc, #232]	@ (0x2a0ac)
@   0x08029fc2: 4c3b        ldr	r4, [pc, #236]	@ (0x2a0b0)
@   0x08029fc4: 1c20        adds	r0, r4, #0
@   0x08029fc6: 2108        movs	r1, #8
@   0x08029fc8: 2201        movs	r2, #1
@   0x08029fca: f7dc        fbe7 	bl	0x679c
@   0x08029fce: 0600        lsls	r0, r0, #24
@   0x08029fd0: 2800        cmp	r0, #0
@   0x08029fd2: d018        beq.n	0x2a006
@   0x08029fd4: 1c20        adds	r0, r4, #0
@   0x08029fd6: 2108        movs	r1, #8
@   0x08029fd8: 2200        movs	r2, #0
@   0x08029fda: f7dc        fbdf 	bl	0x679c
@   0x08029fde: 0600        lsls	r0, r0, #24
@   0x08029fe0: 2800        cmp	r0, #0
@   0x08029fe2: d010        beq.n	0x2a006
@   0x08029fe4: 2001        movs	r0, #1
@   0x08029fe6: 76a8        strb	r0, [r5, #26]
@   0x08029fe8: 2002        movs	r0, #2
@   0x08029fea: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08029fec: 4308        orrs	r0, r1
@   0x08029fee: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08029ff0: 1c20        adds	r0, r4, #0
@   0x08029ff2: 2108        movs	r1, #8
@   0x08029ff4: 2200        movs	r2, #0
@   0x08029ff6: f7dc        fb65 	bl	0x66c4
@   0x08029ffa: 1c28        adds	r0, r5, #0
@   0x08029ffc: 210f        movs	r1, #15
@   0x08029ffe: 2204        movs	r2, #4
@   0x0802a000: 2304        movs	r3, #4
@   0x0802a002: f7f6        fe6b 	bl	0x20cdc
@   0x0802a006: 7ea8        ldrb	r0, [r5, #26]
@   0x0802a008: 2801        cmp	r0, #1
@   0x0802a00a: d159        bne.n	0x2a0c0
@   0x0802a00c: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802a00e: 2080        movs	r0, #128	@ 0x80
@   0x0802a010: 0200        lsls	r0, r0, #8
@   0x0802a012: 4008        ands	r0, r1
@   0x0802a014: 2800        cmp	r0, #0
@   0x0802a016: d075        beq.n	0x2a104
@   0x0802a018: 2200        movs	r2, #0
@   0x0802a01a: 76aa        strb	r2, [r5, #26]
@   0x0802a01c: 2002        movs	r0, #2
@   0x0802a01e: 4308        orrs	r0, r1
@   0x0802a020: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802a022: a903        add	r1, sp, #12
@   0x0802a024: 2005        movs	r0, #5
@   0x0802a026: 8008        strh	r0, [r1, #0]
@   0x0802a028: 1c08        adds	r0, r1, #0
@   0x0802a02a: 8042        strh	r2, [r0, #2]
@   0x0802a02c: 8082        strh	r2, [r0, #4]
@   0x0802a02e: f7e3        fccb 	bl	0xd9c8
@   0x0802a032: 491f        ldr	r1, [pc, #124]	@ (0x2a0b0)
@   0x0802a034: 6108        str	r0, [r1, #16]
@   0x0802a036: 2400        movs	r4, #0
@   0x0802a038: ae0f        add	r6, sp, #60	@ 0x3c
@   0x0802a03a: 4f1e        ldr	r7, [pc, #120]	@ (0x2a0b4)
@   0x0802a03c: 481c        ldr	r0, [pc, #112]	@ (0x2a0b0)
@   0x0802a03e: 6901        ldr	r1, [r0, #16]
@   0x0802a040: 0622        lsls	r2, r4, #24
@   0x0802a042: 1612        asrs	r2, r2, #24
@   0x0802a044: 1c30        adds	r0, r6, #0
@   0x0802a046: f7e3        fc6d 	bl	0xd924
@   0x0802a04a: 9a0f        ldr	r2, [sp, #60]	@ 0x3c
@   0x0802a04c: 3401        adds	r4, #1
@   0x0802a04e: 00e0        lsls	r0, r4, #3
@   0x0802a050: 466b        mov	r3, sp
@   0x0802a052: 181b        adds	r3, r3, r0
@   0x0802a054: 330c        adds	r3, #12
@   0x0802a056: 0411        lsls	r1, r2, #16
@   0x0802a058: 1409        asrs	r1, r1, #16
@   0x0802a05a: 0048        lsls	r0, r1, #1
@   0x0802a05c: 1840        adds	r0, r0, r1
@   0x0802a05e: 00c0        lsls	r0, r0, #3
@   0x0802a060: 300b        adds	r0, #11
@   0x0802a062: 8018        strh	r0, [r3, #0]
@   0x0802a064: 1412        asrs	r2, r2, #16
@   0x0802a066: 0050        lsls	r0, r2, #1
@   0x0802a068: 1880        adds	r0, r0, r2
@   0x0802a06a: 00c0        lsls	r0, r0, #3
@   0x0802a06c: 300b        adds	r0, #11
@   0x0802a06e: 8058        strh	r0, [r3, #2]
@   0x0802a070: 809f        strh	r7, [r3, #4]
@   0x0802a072: 0624        lsls	r4, r4, #24
@   0x0802a074: 0e24        lsrs	r4, r4, #24
@   0x0802a076: 2c04        cmp	r4, #4
@   0x0802a078: d9e0        bls.n	0x2a03c
@   0x0802a07a: 2071        movs	r0, #113	@ 0x71
@   0x0802a07c: 9000        str	r0, [sp, #0]
@   0x0802a07e: 2002        movs	r0, #2
@   0x0802a080: 9001        str	r0, [sp, #4]
@   0x0802a082: 2000        movs	r0, #0
@   0x0802a084: 9002        str	r0, [sp, #8]
@   0x0802a086: 2019        movs	r0, #25
@   0x0802a088: a903        add	r1, sp, #12
@   0x0802a08a: 2220        movs	r2, #32
@   0x0802a08c: 234f        movs	r3, #79	@ 0x4f
@   0x0802a08e: f7f7        f857 	bl	0x21140
@   0x0802a092: 4909        ldr	r1, [pc, #36]	@ (0x2a0b8)
@   0x0802a094: 22d1        movs	r2, #209	@ 0xd1
@   0x0802a096: 0092        lsls	r2, r2, #2
@   0x0802a098: 1889        adds	r1, r1, r2
@   0x0802a09a: 4808        ldr	r0, [pc, #32]	@ (0x2a0bc)
@   0x0802a09c: 880a        ldrh	r2, [r1, #0]
@   0x0802a09e: 4010        ands	r0, r2
@   0x0802a0a0: 8008        strh	r0, [r1, #0]
@   0x0802a0a2: 2005        movs	r0, #5
@   0x0802a0a4: f7f6        fde8 	bl	0x20c78
@   0x0802a0a8: e02c        b.n	0x2a104
@   0x0802a0aa: 0000        movs	r0, r0
@   0x0802a0ac: 3a30        subs	r2, #48	@ 0x30
@   0x0802a0ae: 0300        lsls	r0, r0, #12
@   0x0802a0b0: 6110        str	r0, [r2, #16]
@   0x0802a0b2: 0300        lsls	r0, r0, #12
@   0x0802a0b4: 0303        lsls	r3, r0, #12
@   0x0802a0b6: 0000        movs	r0, r0
@   0x0802a0b8: 3720        adds	r7, #32
@   0x0802a0ba: 0300        lsls	r0, r0, #12
@   0x0802a0bc: 7fff        ldrb	r7, [r7, #31]
@   0x0802a0be: 0000        movs	r0, r0
@   0x0802a0c0: 2802        cmp	r0, #2
@   0x0802a0c2: d10e        bne.n	0x2a0e2
@   0x0802a0c4: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802a0c6: 4008        ands	r0, r1
@   0x0802a0c8: 2800        cmp	r0, #0
@   0x0802a0ca: d002        beq.n	0x2a0d2
@   0x0802a0cc: 2003        movs	r0, #3
@   0x0802a0ce: f7f6        fe67 	bl	0x20da0
@   0x0802a0d2: 7eea        ldrb	r2, [r5, #27]
@   0x0802a0d4: 2a0e        cmp	r2, #14
@   0x0802a0d6: d115        bne.n	0x2a104
@   0x0802a0d8: 2008        movs	r0, #8
@   0x0802a0da: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802a0dc: 4308        orrs	r0, r1
@   0x0802a0de: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802a0e0: e010        b.n	0x2a104
@   0x0802a0e2: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802a0e4: 2080        movs	r0, #128	@ 0x80
@   0x0802a0e6: 0200        lsls	r0, r0, #8
@   0x0802a0e8: 4008        ands	r0, r1
@   0x0802a0ea: 2800        cmp	r0, #0
@   0x0802a0ec: d00a        beq.n	0x2a104
@   0x0802a0ee: 2002        movs	r0, #2
@   0x0802a0f0: 4308        orrs	r0, r1
@   0x0802a0f2: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802a0f4: 4909        ldr	r1, [pc, #36]	@ (0x2a11c)
@   0x0802a0f6: 22d1        movs	r2, #209	@ 0xd1
@   0x0802a0f8: 0092        lsls	r2, r2, #2
@   0x0802a0fa: 1889        adds	r1, r1, r2
@   0x0802a0fc: 4808        ldr	r0, [pc, #32]	@ (0x2a120)
@   0x0802a0fe: 880a        ldrh	r2, [r1, #0]
@   0x0802a100: 4010        ands	r0, r2
@   0x0802a102: 8008        strh	r0, [r1, #0]
@   0x0802a104: 1c28        adds	r0, r5, #0
@   0x0802a106: f7db        fc5d 	bl	0x59c4
@   0x0802a10a: 4806        ldr	r0, [pc, #24]	@ (0x2a124)
@   0x0802a10c: 210e        movs	r1, #14
@   0x0802a10e: f7dc        fc2d 	bl	0x696c
@   0x0802a112: b010        add	sp, #64	@ 0x40
@   0x0802a114: bcf0        pop	{r4, r5, r6, r7}
@   0x0802a116: bc01        pop	{r0}
@   0x0802a118: 4700        bx	r0
@   0x0802a11a: 0000        movs	r0, r0
@   0x0802a11c: 3720        adds	r7, #32
@   0x0802a11e: 0300        lsls	r0, r0, #12
@   0x0802a120: 7fff        ldrb	r7, [r7, #31]
@   0x0802a122: 0000        movs	r0, r0
@   0x0802a124: 6110        str	r0, [r2, #16]
@   0x0802a126: 0300        lsls	r0, r0, #12
@   0x0802a128: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802a12a: b081        sub	sp, #4
@   0x0802a12c: 2400        movs	r4, #0
@   0x0802a12e: 4e0a        ldr	r6, [pc, #40]	@ (0x2a158)
@   0x0802a130: 1c35        adds	r5, r6, #0
@   0x0802a132: 3570        adds	r5, #112	@ 0x70
@   0x0802a134: 1ca1        adds	r1, r4, #2
@   0x0802a136: 00c8        lsls	r0, r1, #3
@   0x0802a138: 1a40        subs	r0, r0, r1
@   0x0802a13a: 00c0        lsls	r0, r0, #3
@   0x0802a13c: 1980        adds	r0, r0, r6
@   0x0802a13e: 7ec0        ldrb	r0, [r0, #27]
@   0x0802a140: 2801        cmp	r0, #1
@   0x0802a142: d10b        bne.n	0x2a15c
@   0x0802a144: 00e0        lsls	r0, r4, #3
@   0x0802a146: 1b00        subs	r0, r0, r4
@   0x0802a148: 00c0        lsls	r0, r0, #3
@   0x0802a14a: 1940        adds	r0, r0, r5
@   0x0802a14c: 2106        movs	r1, #6
@   0x0802a14e: 2202        movs	r2, #2
@   0x0802a150: 2302        movs	r3, #2
@   0x0802a152: f7f6        fe5f 	bl	0x20e14
@   0x0802a156: e00c        b.n	0x2a172
@   0x0802a158: 3720        adds	r7, #32
@   0x0802a15a: 0300        lsls	r0, r0, #12
@   0x0802a15c: 2805        cmp	r0, #5
@   0x0802a15e: d108        bne.n	0x2a172
@   0x0802a160: 00e0        lsls	r0, r4, #3
@   0x0802a162: 1b00        subs	r0, r0, r4
@   0x0802a164: 00c0        lsls	r0, r0, #3
@   0x0802a166: 1940        adds	r0, r0, r5
@   0x0802a168: 2107        movs	r1, #7
@   0x0802a16a: 2202        movs	r2, #2
@   0x0802a16c: 2302        movs	r3, #2
@   0x0802a16e: f7f6        fe51 	bl	0x20e14
@   0x0802a172: 1c60        adds	r0, r4, #1
@   0x0802a174: 0600        lsls	r0, r0, #24
@   0x0802a176: 0e04        lsrs	r4, r0, #24
@   0x0802a178: 2c0b        cmp	r4, #11
@   0x0802a17a: d9db        bls.n	0x2a134
@   0x0802a17c: 4912        ldr	r1, [pc, #72]	@ (0x2a1c8)
@   0x0802a17e: 2008        movs	r0, #8
@   0x0802a180: 8dca        ldrh	r2, [r1, #46]	@ 0x2e
@   0x0802a182: 4010        ands	r0, r2
@   0x0802a184: 1c0f        adds	r7, r1, #0
@   0x0802a186: 4b11        ldr	r3, [pc, #68]	@ (0x2a1cc)
@   0x0802a188: 2800        cmp	r0, #0
@   0x0802a18a: d011        beq.n	0x2a1b0
@   0x0802a18c: 2400        movs	r4, #0
@   0x0802a18e: 4e10        ldr	r6, [pc, #64]	@ (0x2a1d0)
@   0x0802a190: 2505        movs	r5, #5
@   0x0802a192: 2202        movs	r2, #2
@   0x0802a194: 1ca1        adds	r1, r4, #2
@   0x0802a196: 00c8        lsls	r0, r1, #3
@   0x0802a198: 1a40        subs	r0, r0, r1
@   0x0802a19a: 00c0        lsls	r0, r0, #3
@   0x0802a19c: 1980        adds	r0, r0, r6
@   0x0802a19e: 7685        strb	r5, [r0, #26]
@   0x0802a1a0: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x0802a1a2: 4311        orrs	r1, r2
@   0x0802a1a4: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802a1a6: 1c60        adds	r0, r4, #1
@   0x0802a1a8: 0600        lsls	r0, r0, #24
@   0x0802a1aa: 0e04        lsrs	r4, r0, #24
@   0x0802a1ac: 2c0b        cmp	r4, #11
@   0x0802a1ae: d9f1        bls.n	0x2a194
@   0x0802a1b0: 2000        movs	r0, #0
@   0x0802a1b2: 9000        str	r0, [sp, #0]
@   0x0802a1b4: 2002        movs	r0, #2
@   0x0802a1b6: 1c19        adds	r1, r3, #0
@   0x0802a1b8: 224b        movs	r2, #75	@ 0x4b
@   0x0802a1ba: 1c3b        adds	r3, r7, #0
@   0x0802a1bc: f7f7        f9a8 	bl	0x21510
@   0x0802a1c0: b001        add	sp, #4
@   0x0802a1c2: bcf0        pop	{r4, r5, r6, r7}
@   0x0802a1c4: bc01        pop	{r0}
@   0x0802a1c6: 4700        bx	r0
@   0x0802a1c8: 6110        str	r0, [r2, #16]
@   0x0802a1ca: 0300        lsls	r0, r0, #12
@   0x0802a1cc: 7c1c        ldrb	r4, [r3, #16]
@   0x0802a1ce: 0831        lsrs	r1, r6, #32
@   0x0802a1d0: 3720        adds	r7, #32
@   0x0802a1d2: 0300        lsls	r0, r0, #12
@   0x0802a1d4: b570        push	{r4, r5, r6, lr}
@   0x0802a1d6: b083        sub	sp, #12
@   0x0802a1d8: 4e0d        ldr	r6, [pc, #52]	@ (0x2a210)
@   0x0802a1da: 2041        movs	r0, #65	@ 0x41
@   0x0802a1dc: 9000        str	r0, [sp, #0]
@   0x0802a1de: 2501        movs	r5, #1
@   0x0802a1e0: 9501        str	r5, [sp, #4]
@   0x0802a1e2: 2400        movs	r4, #0
@   0x0802a1e4: 9402        str	r4, [sp, #8]
@   0x0802a1e6: 200f        movs	r0, #15
@   0x0802a1e8: 1c31        adds	r1, r6, #0
@   0x0802a1ea: 2208        movs	r2, #8
@   0x0802a1ec: 234e        movs	r3, #78	@ 0x4e
@   0x0802a1ee: f7f6        ffa7 	bl	0x21140
@   0x0802a1f2: 2061        movs	r0, #97	@ 0x61
@   0x0802a1f4: 9000        str	r0, [sp, #0]
@   0x0802a1f6: 9501        str	r5, [sp, #4]
@   0x0802a1f8: 9402        str	r4, [sp, #8]
@   0x0802a1fa: 2014        movs	r0, #20
@   0x0802a1fc: 1c31        adds	r1, r6, #0
@   0x0802a1fe: 2208        movs	r2, #8
@   0x0802a200: 234d        movs	r3, #77	@ 0x4d
@   0x0802a202: f7f6        ff9d 	bl	0x21140
@   0x0802a206: b003        add	sp, #12
@   0x0802a208: bc70        pop	{r4, r5, r6}
@   0x0802a20a: bc01        pop	{r0}
@   0x0802a20c: 4700        bx	r0
@   0x0802a20e: 0000        movs	r0, r0
@   0x0802a210: 7bac        ldrb	r4, [r5, #14]
@   0x0802a212: 0831        lsrs	r1, r6, #32
@   0x0802a214: b500        push	{lr}
@   0x0802a216: b083        sub	sp, #12
@   0x0802a218: 4907        ldr	r1, [pc, #28]	@ (0x2a238)
@   0x0802a21a: 2071        movs	r0, #113	@ 0x71
@   0x0802a21c: 9000        str	r0, [sp, #0]
@   0x0802a21e: 2002        movs	r0, #2
@   0x0802a220: 9001        str	r0, [sp, #4]
@   0x0802a222: 2000        movs	r0, #0
@   0x0802a224: 9002        str	r0, [sp, #8]
@   0x0802a226: 2019        movs	r0, #25
@   0x0802a228: 2208        movs	r2, #8
@   0x0802a22a: 234f        movs	r3, #79	@ 0x4f
@   0x0802a22c: f7f6        ff88 	bl	0x21140
@   0x0802a230: b003        add	sp, #12
@   0x0802a232: bc01        pop	{r0}
@   0x0802a234: 4700        bx	r0
@   0x0802a236: 0000        movs	r0, r0
@   0x0802a238: 7bdc        ldrb	r4, [r3, #15]
@   0x0802a23a: 0831        lsrs	r1, r6, #32
@   0x0802a23c: b500        push	{lr}
@   0x0802a23e: b083        sub	sp, #12
@   0x0802a240: 4909        ldr	r1, [pc, #36]	@ (0x2a268)
@   0x0802a242: 20b1        movs	r0, #177	@ 0xb1
@   0x0802a244: 9000        str	r0, [sp, #0]
@   0x0802a246: 2003        movs	r0, #3
@   0x0802a248: 9001        str	r0, [sp, #4]
@   0x0802a24a: 2000        movs	r0, #0
@   0x0802a24c: 9002        str	r0, [sp, #8]
@   0x0802a24e: 200e        movs	r0, #14
@   0x0802a250: 2210        movs	r2, #16
@   0x0802a252: 2350        movs	r3, #80	@ 0x50
@   0x0802a254: f7f6        ff74 	bl	0x21140
@   0x0802a258: 4804        ldr	r0, [pc, #16]	@ (0x2a26c)
@   0x0802a25a: 2108        movs	r1, #8
@   0x0802a25c: 2200        movs	r2, #0
@   0x0802a25e: f7dc        f9cf 	bl	0x6600
@   0x0802a262: b003        add	sp, #12
@   0x0802a264: bc01        pop	{r0}
@   0x0802a266: 4700        bx	r0
@   0x0802a268: 7c0c        ldrb	r4, [r1, #16]
@   0x0802a26a: 0831        lsrs	r1, r6, #32
@   0x0802a26c: 6110        str	r0, [r2, #16]
@   0x0802a26e: 0300        lsls	r0, r0, #12
@   0x0802a270: b500        push	{lr}
@   0x0802a272: b083        sub	sp, #12
@   0x0802a274: 4907        ldr	r1, [pc, #28]	@ (0x2a294)
@   0x0802a276: 20f1        movs	r0, #241	@ 0xf1
@   0x0802a278: 9000        str	r0, [sp, #0]
@   0x0802a27a: 2004        movs	r0, #4
@   0x0802a27c: 9001        str	r0, [sp, #4]
@   0x0802a27e: 2000        movs	r0, #0
@   0x0802a280: 9002        str	r0, [sp, #8]
@   0x0802a282: 2002        movs	r0, #2

        thumb_func_start sub_0802986C
sub_0802986C: @ 0x0802986c
        .incbin "baserom.gba", 0x2986c, 0xa18
        thumb_func_end sub_0802986C
