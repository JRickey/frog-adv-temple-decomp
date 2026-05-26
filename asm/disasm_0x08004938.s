@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004938, 0x08004c04)  (716 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004938 --end 0x8004c04 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004938: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800493a: 4c03        ldr	r4, [pc, #12]	@ (0x4948)
@   0x0800493c: 44a5        add	sp, r4
@   0x0800493e: 4803        ldr	r0, [pc, #12]	@ (0x494c)
@   0x08004940: 4468        add	r0, sp
@   0x08004942: 2100        movs	r1, #0
@   0x08004944: 7001        strb	r1, [r0, #0]
@   0x08004946: e14d        b.n	0x4be4
@   0x08004948: fc78        ffff 			@ <UNDEFINED> instruction: 0xfc78ffff
@   0x0800494c: 037d        lsls	r5, r7, #13
@   0x0800494e: 0000        movs	r0, r0
@   0x08004950: f01c        f936 	bl	0x20bc0
@   0x08004954: 4805        ldr	r0, [pc, #20]	@ (0x496c)
@   0x08004956: 4468        add	r0, sp
@   0x08004958: 7800        ldrb	r0, [r0, #0]
@   0x0800495a: 2808        cmp	r0, #8
@   0x0800495c: d900        bls.n	0x4960
@   0x0800495e: e141        b.n	0x4be4
@   0x08004960: 0080        lsls	r0, r0, #2
@   0x08004962: 4903        ldr	r1, [pc, #12]	@ (0x4970)
@   0x08004964: 1840        adds	r0, r0, r1
@   0x08004966: 6800        ldr	r0, [r0, #0]
@   0x08004968: 4687        mov	pc, r0
@   0x0800496a: 0000        movs	r0, r0
@   0x0800496c: 037d        lsls	r5, r7, #13
@   0x0800496e: 0000        movs	r0, r0
@   0x08004970: 4974        ldr	r1, [pc, #464]	@ (0x4b44)
@   0x08004972: 0800        lsrs	r0, r0, #32
@   0x08004974: 4998        ldr	r1, [pc, #608]	@ (0x4bd8)
@   0x08004976: 0800        lsrs	r0, r0, #32
@   0x08004978: 49cc        ldr	r1, [pc, #816]	@ (0x4cac)
@   0x0800497a: 0800        lsrs	r0, r0, #32
@   0x0800497c: 49fc        ldr	r1, [pc, #1008]	@ (0x4d70)
@   0x0800497e: 0800        lsrs	r0, r0, #32
@   0x08004980: 4a20        ldr	r2, [pc, #128]	@ (0x4a04)
@   0x08004982: 0800        lsrs	r0, r0, #32
@   0x08004984: 4abc        ldr	r2, [pc, #752]	@ (0x4c78)
@   0x08004986: 0800        lsrs	r0, r0, #32
@   0x08004988: 4b28        ldr	r3, [pc, #160]	@ (0x4a2c)
@   0x0800498a: 0800        lsrs	r0, r0, #32
@   0x0800498c: 4b68        ldr	r3, [pc, #416]	@ (0x4b30)
@   0x0800498e: 0800        lsrs	r0, r0, #32
@   0x08004990: 4ba8        ldr	r3, [pc, #672]	@ (0x4c34)
@   0x08004992: 0800        lsrs	r0, r0, #32
@   0x08004994: 4be0        ldr	r3, [pc, #896]	@ (0x4d18)
@   0x08004996: 0800        lsrs	r0, r0, #32
@   0x08004998: ace0        add	r4, sp, #896	@ 0x380
@   0x0800499a: 490a        ldr	r1, [pc, #40]	@ (0x49c4)
@   0x0800499c: 2500        movs	r5, #0
@   0x0800499e: 200e        movs	r0, #14
@   0x080049a0: 7288        strb	r0, [r1, #10]
@   0x080049a2: 2005        movs	r0, #5
@   0x080049a4: a946        add	r1, sp, #280	@ 0x118
@   0x080049a6: f002        f905 	bl	0x6bb4
@   0x080049aa: 4668        mov	r0, sp
@   0x080049ac: 1c21        adds	r1, r4, #0
@   0x080049ae: 2211        movs	r2, #17
@   0x080049b0: f006        fefe 	bl	0xb7b0
@   0x080049b4: 4904        ldr	r1, [pc, #16]	@ (0x49c8)
@   0x080049b6: 4469        add	r1, sp
@   0x080049b8: 2001        movs	r0, #1
@   0x080049ba: 7008        strb	r0, [r1, #0]
@   0x080049bc: a8df        add	r0, sp, #892	@ 0x37c
@   0x080049be: 7005        strb	r5, [r0, #0]
@   0x080049c0: e110        b.n	0x4be4
@   0x080049c2: 0000        movs	r0, r0
@   0x080049c4: 5330        strh	r0, [r6, r4]
@   0x080049c6: 0300        lsls	r0, r0, #12
@   0x080049c8: 037d        lsls	r5, r7, #13
@   0x080049ca: 0000        movs	r0, r0
@   0x080049cc: acdf        add	r4, sp, #892	@ 0x37c
@   0x080049ce: 4908        ldr	r1, [pc, #32]	@ (0x49f0)
@   0x080049d0: 1c20        adds	r0, r4, #0
@   0x080049d2: f005        fb97 	bl	0xa104
@   0x080049d6: 0600        lsls	r0, r0, #24
@   0x080049d8: 2800        cmp	r0, #0
@   0x080049da: d100        bne.n	0x49de
@   0x080049dc: e0f6        b.n	0x4bcc
@   0x080049de: 4905        ldr	r1, [pc, #20]	@ (0x49f4)
@   0x080049e0: 4469        add	r1, sp
@   0x080049e2: 2002        movs	r0, #2
@   0x080049e4: 7008        strb	r0, [r1, #0]
@   0x080049e6: 4904        ldr	r1, [pc, #16]	@ (0x49f8)
@   0x080049e8: 2000        movs	r0, #0
@   0x080049ea: 6148        str	r0, [r1, #20]
@   0x080049ec: 7020        strb	r0, [r4, #0]
@   0x080049ee: e0ed        b.n	0x4bcc
@   0x080049f0: 4c31        ldr	r4, [pc, #196]	@ (0x4ab8)
@   0x080049f2: 0800        lsrs	r0, r0, #32
@   0x080049f4: 037d        lsls	r5, r7, #13
@   0x080049f6: 0000        movs	r0, r0
@   0x080049f8: 5330        strh	r0, [r6, r4]
@   0x080049fa: 0300        lsls	r0, r0, #12
@   0x080049fc: a8df        add	r0, sp, #892	@ 0x37c
@   0x080049fe: f005        f9cd 	bl	0x9d9c
@   0x08004a02: 2800        cmp	r0, #0
@   0x08004a04: d100        bne.n	0x4a08
@   0x08004a06: e0ed        b.n	0x4be4
@   0x08004a08: 4903        ldr	r1, [pc, #12]	@ (0x4a18)
@   0x08004a0a: 4469        add	r1, sp
@   0x08004a0c: 2003        movs	r0, #3
@   0x08004a0e: 7008        strb	r0, [r1, #0]
@   0x08004a10: 4902        ldr	r1, [pc, #8]	@ (0x4a1c)
@   0x08004a12: 2000        movs	r0, #0
@   0x08004a14: 6148        str	r0, [r1, #20]
@   0x08004a16: e0e5        b.n	0x4be4
@   0x08004a18: 037d        lsls	r5, r7, #13
@   0x08004a1a: 0000        movs	r0, r0
@   0x08004a1c: 5330        strh	r0, [r6, r4]
@   0x08004a1e: 0300        lsls	r0, r0, #12
@   0x08004a20: f7fb        fd50 	bl	0x4c4
@   0x08004a24: 4906        ldr	r1, [pc, #24]	@ (0x4a40)
@   0x08004a26: 8008        strh	r0, [r1, #0]
@   0x08004a28: 0400        lsls	r0, r0, #16
@   0x08004a2a: 0c00        lsrs	r0, r0, #16
@   0x08004a2c: 2840        cmp	r0, #64	@ 0x40
@   0x08004a2e: d10b        bne.n	0x4a48
@   0x08004a30: 4904        ldr	r1, [pc, #16]	@ (0x4a44)
@   0x08004a32: 4469        add	r1, sp
@   0x08004a34: 2005        movs	r0, #5
@   0x08004a36: 7008        strb	r0, [r1, #0]
@   0x08004a38: f009        fb12 	bl	0xe060
@   0x08004a3c: e0d2        b.n	0x4be4
@   0x08004a3e: 0000        movs	r0, r0
@   0x08004a40: 5398        strh	r0, [r3, r6]
@   0x08004a42: 0300        lsls	r0, r0, #12
@   0x08004a44: 037d        lsls	r5, r7, #13
@   0x08004a46: 0000        movs	r0, r0
@   0x08004a48: 4906        ldr	r1, [pc, #24]	@ (0x4a64)
@   0x08004a4a: 2308        movs	r3, #8
@   0x08004a4c: 2208        movs	r2, #8
@   0x08004a4e: 1c10        adds	r0, r2, #0
@   0x08004a50: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08004a52: 4008        ands	r0, r1
@   0x08004a54: 2800        cmp	r0, #0
@   0x08004a56: d009        beq.n	0x4a6c
@   0x08004a58: 4903        ldr	r1, [pc, #12]	@ (0x4a68)
@   0x08004a5a: 4469        add	r1, sp
@   0x08004a5c: 2004        movs	r0, #4
@   0x08004a5e: 7008        strb	r0, [r1, #0]
@   0x08004a60: e0c0        b.n	0x4be4
@   0x08004a62: 0000        movs	r0, r0
@   0x08004a64: 3720        adds	r7, #32
@   0x08004a66: 0300        lsls	r0, r0, #12
@   0x08004a68: 037d        lsls	r5, r7, #13
@   0x08004a6a: 0000        movs	r0, r0
@   0x08004a6c: 4904        ldr	r1, [pc, #16]	@ (0x4a80)
@   0x08004a6e: 1c10        adds	r0, r2, #0
@   0x08004a70: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08004a72: 4008        ands	r0, r1
@   0x08004a74: 2800        cmp	r0, #0
@   0x08004a76: d007        beq.n	0x4a88
@   0x08004a78: 4802        ldr	r0, [pc, #8]	@ (0x4a84)
@   0x08004a7a: 4468        add	r0, sp
@   0x08004a7c: 7003        strb	r3, [r0, #0]
@   0x08004a7e: e0b1        b.n	0x4be4
@   0x08004a80: 6110        str	r0, [r2, #16]
@   0x08004a82: 0300        lsls	r0, r0, #12
@   0x08004a84: 037d        lsls	r5, r7, #13
@   0x08004a86: 0000        movs	r0, r0
@   0x08004a88: ace0        add	r4, sp, #896	@ 0x380
@   0x08004a8a: 2005        movs	r0, #5
@   0x08004a8c: a946        add	r1, sp, #280	@ 0x118
@   0x08004a8e: f002        fde7 	bl	0x7660
@   0x08004a92: f005        fc21 	bl	0xa2d8
@   0x08004a96: f7fb        ff21 	bl	0x8dc
@   0x08004a9a: f005        fc45 	bl	0xa328
@   0x08004a9e: f004        fd2b 	bl	0x94f8
@   0x08004aa2: f004        ff6f 	bl	0x9984
@   0x08004aa6: 4668        mov	r0, sp
@   0x08004aa8: 1c21        adds	r1, r4, #0
@   0x08004aaa: f7ff        fd9f 	bl	0x45ec
@   0x08004aae: 4902        ldr	r1, [pc, #8]	@ (0x4ab8)
@   0x08004ab0: 6948        ldr	r0, [r1, #20]
@   0x08004ab2: 3001        adds	r0, #1
@   0x08004ab4: 6148        str	r0, [r1, #20]
@   0x08004ab6: e095        b.n	0x4be4
@   0x08004ab8: 5330        strh	r0, [r6, r4]
@   0x08004aba: 0300        lsls	r0, r0, #12
@   0x08004abc: 4d0a        ldr	r5, [pc, #40]	@ (0x4ae8)
@   0x08004abe: 446d        add	r5, sp
@   0x08004ac0: 466e        mov	r6, sp
@   0x08004ac2: afe0        add	r7, sp, #896	@ 0x380
@   0x08004ac4: 4809        ldr	r0, [pc, #36]	@ (0x4aec)
@   0x08004ac6: 7940        ldrb	r0, [r0, #5]
@   0x08004ac8: 0600        lsls	r0, r0, #24
@   0x08004aca: 1600        asrs	r0, r0, #24
@   0x08004acc: 2802        cmp	r0, #2
@   0x08004ace: dc11        bgt.n	0x4af4
@   0x08004ad0: 4c07        ldr	r4, [pc, #28]	@ (0x4af0)
@   0x08004ad2: 1c20        adds	r0, r4, #0
@   0x08004ad4: 2103        movs	r1, #3
@   0x08004ad6: 2200        movs	r2, #0
@   0x08004ad8: f001        fdf4 	bl	0x66c4
@   0x08004adc: 1c20        adds	r0, r4, #0
@   0x08004ade: 2103        movs	r1, #3
@   0x08004ae0: 2201        movs	r2, #1
@   0x08004ae2: f001        fdef 	bl	0x66c4
@   0x08004ae6: e00a        b.n	0x4afe
@   0x08004ae8: 037d        lsls	r5, r7, #13
@   0x08004aea: 0000        movs	r0, r0
@   0x08004aec: 35e0        adds	r5, #224	@ 0xe0
@   0x08004aee: 0300        lsls	r0, r0, #12
@   0x08004af0: 6110        str	r0, [r2, #16]
@   0x08004af2: 0300        lsls	r0, r0, #12
@   0x08004af4: 480a        ldr	r0, [pc, #40]	@ (0x4b20)
@   0x08004af6: 2103        movs	r1, #3
@   0x08004af8: 2201        movs	r2, #1
@   0x08004afa: f001        fd81 	bl	0x6600
@   0x08004afe: 4809        ldr	r0, [pc, #36]	@ (0x4b24)
@   0x08004b00: 4468        add	r0, sp
@   0x08004b02: f005        f887 	bl	0x9c14
@   0x08004b06: 2800        cmp	r0, #0
@   0x08004b08: d101        bne.n	0x4b0e
@   0x08004b0a: 2007        movs	r0, #7
@   0x08004b0c: 7028        strb	r0, [r5, #0]
@   0x08004b0e: 1c30        adds	r0, r6, #0
@   0x08004b10: 1c39        adds	r1, r7, #0
@   0x08004b12: 2211        movs	r2, #17
@   0x08004b14: f006        fe4c 	bl	0xb7b0
@   0x08004b18: a9df        add	r1, sp, #892	@ 0x37c
@   0x08004b1a: 2000        movs	r0, #0
@   0x08004b1c: 7008        strb	r0, [r1, #0]
@   0x08004b1e: e061        b.n	0x4be4
@   0x08004b20: 6110        str	r0, [r2, #16]
@   0x08004b22: 0300        lsls	r0, r0, #12
@   0x08004b24: 037d        lsls	r5, r7, #13
@   0x08004b26: 0000        movs	r0, r0
@   0x08004b28: f7fb        fccc 	bl	0x4c4
@   0x08004b2c: 490b        ldr	r1, [pc, #44]	@ (0x4b5c)
@   0x08004b2e: 8008        strh	r0, [r1, #0]
@   0x08004b30: f009        fdba 	bl	0xe6a8
@   0x08004b34: 0600        lsls	r0, r0, #24
@   0x08004b36: 0e02        lsrs	r2, r0, #24
@   0x08004b38: 2a00        cmp	r2, #0
@   0x08004b3a: d105        bne.n	0x4b48
@   0x08004b3c: 4808        ldr	r0, [pc, #32]	@ (0x4b60)
@   0x08004b3e: 4468        add	r0, sp
@   0x08004b40: 2106        movs	r1, #6
@   0x08004b42: 7001        strb	r1, [r0, #0]
@   0x08004b44: a8df        add	r0, sp, #892	@ 0x37c
@   0x08004b46: 7002        strb	r2, [r0, #0]
@   0x08004b48: 4806        ldr	r0, [pc, #24]	@ (0x4b64)
@   0x08004b4a: 7800        ldrb	r0, [r0, #0]
@   0x08004b4c: 2800        cmp	r0, #0
@   0x08004b4e: d149        bne.n	0x4be4
@   0x08004b50: 4903        ldr	r1, [pc, #12]	@ (0x4b60)
@   0x08004b52: 4469        add	r1, sp
@   0x08004b54: 2003        movs	r0, #3
@   0x08004b56: 7008        strb	r0, [r1, #0]
@   0x08004b58: e044        b.n	0x4be4
@   0x08004b5a: 0000        movs	r0, r0
@   0x08004b5c: 5398        strh	r0, [r3, r6]
@   0x08004b5e: 0300        lsls	r0, r0, #12
@   0x08004b60: 037d        lsls	r5, r7, #13
@   0x08004b62: 0000        movs	r0, r0
@   0x08004b64: 5328        strh	r0, [r5, r4]
@   0x08004b66: 0300        lsls	r0, r0, #12
@   0x08004b68: acdf        add	r4, sp, #892	@ 0x37c
@   0x08004b6a: 2000        movs	r0, #0
@   0x08004b6c: 5620        ldrsb	r0, [r4, r0]
@   0x08004b6e: 2800        cmp	r0, #0
@   0x08004b70: d105        bne.n	0x4b7e
@   0x08004b72: 20bf        movs	r0, #191	@ 0xbf
@   0x08004b74: f00b        fd8e 	bl	0x10694
@   0x08004b78: 7820        ldrb	r0, [r4, #0]
@   0x08004b7a: 3001        adds	r0, #1
@   0x08004b7c: 7020        strb	r0, [r4, #0]
@   0x08004b7e: 7824        ldrb	r4, [r4, #0]
@   0x08004b80: 0624        lsls	r4, r4, #24
@   0x08004b82: 1624        asrs	r4, r4, #24
@   0x08004b84: 2c01        cmp	r4, #1
@   0x08004b86: d12d        bne.n	0x4be4
@   0x08004b88: f00b        fd96 	bl	0x106b8
@   0x08004b8c: 0600        lsls	r0, r0, #24
@   0x08004b8e: 2800        cmp	r0, #0
@   0x08004b90: d128        bne.n	0x4be4
@   0x08004b92: 4803        ldr	r0, [pc, #12]	@ (0x4ba0)
@   0x08004b94: 2104        movs	r1, #4
@   0x08004b96: 7001        strb	r1, [r0, #0]
@   0x08004b98: 7184        strb	r4, [r0, #6]
@   0x08004b9a: 4802        ldr	r0, [pc, #8]	@ (0x4ba4)
@   0x08004b9c: 7241        strb	r1, [r0, #9]
@   0x08004b9e: e021        b.n	0x4be4
@   0x08004ba0: 3480        adds	r4, #128	@ 0x80
@   0x08004ba2: 0300        lsls	r0, r0, #12
@   0x08004ba4: 5330        strh	r0, [r6, r4]
@   0x08004ba6: 0300        lsls	r0, r0, #12
@   0x08004ba8: acdf        add	r4, sp, #892	@ 0x37c
@   0x08004baa: 490a        ldr	r1, [pc, #40]	@ (0x4bd4)
@   0x08004bac: 1c20        adds	r0, r4, #0
@   0x08004bae: f005        faa9 	bl	0xa104
@   0x08004bb2: 0600        lsls	r0, r0, #24
@   0x08004bb4: 2800        cmp	r0, #0
@   0x08004bb6: d009        beq.n	0x4bcc
@   0x08004bb8: 4907        ldr	r1, [pc, #28]	@ (0x4bd8)
@   0x08004bba: 4469        add	r1, sp
@   0x08004bbc: 2002        movs	r0, #2
@   0x08004bbe: 7008        strb	r0, [r1, #0]
@   0x08004bc0: 4906        ldr	r1, [pc, #24]	@ (0x4bdc)
@   0x08004bc2: 2000        movs	r0, #0
@   0x08004bc4: 6148        str	r0, [r1, #20]
@   0x08004bc6: 7020        strb	r0, [r4, #0]
@   0x08004bc8: f005        fafe 	bl	0xa1c8
@   0x08004bcc: f7fb        fe86 	bl	0x8dc
@   0x08004bd0: e008        b.n	0x4be4
@   0x08004bd2: 0000        movs	r0, r0
@   0x08004bd4: a26d        add	r2, pc, #436	@ (adr r2, 0x4d8c)
@   0x08004bd6: 0800        lsrs	r0, r0, #32
@   0x08004bd8: 037d        lsls	r5, r7, #13
@   0x08004bda: 0000        movs	r0, r0
@   0x08004bdc: 5330        strh	r0, [r6, r4]
@   0x08004bde: 0300        lsls	r0, r0, #12
@   0x08004be0: f009        f94e 	bl	0xde80
@   0x08004be4: 4806        ldr	r0, [pc, #24]	@ (0x4c00)
@   0x08004be6: 7a40        ldrb	r0, [r0, #9]
@   0x08004be8: 2815        cmp	r0, #21
@   0x08004bea: d100        bne.n	0x4bee
@   0x08004bec: e6b0        b.n	0x4950
@   0x08004bee: 2818        cmp	r0, #24
@   0x08004bf0: d100        bne.n	0x4bf4
@   0x08004bf2: e6ad        b.n	0x4950
@   0x08004bf4: 23e2        movs	r3, #226	@ 0xe2
@   0x08004bf6: 009b        lsls	r3, r3, #2
@   0x08004bf8: 449d        add	sp, r3
@   0x08004bfa: bcf0        pop	{r4, r5, r6, r7}
@   0x08004bfc: bc01        pop	{r0}
@   0x08004bfe: 4700        bx	r0
@   0x08004c00: 5330        strh	r0, [r6, r4]
@   0x08004c02: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004938
sub_08004938: @ 0x08004938
        .incbin "frog_us_baserom.gba", 0x4938, 0x2cc
        thumb_func_end sub_08004938
