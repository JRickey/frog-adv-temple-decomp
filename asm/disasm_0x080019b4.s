@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080019b4, 0x08001d18)  (868 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80019b4 --end 0x8001d18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080019b4: b530        push	{r4, r5, lr}
@   0x080019b6: 4c03        ldr	r4, [pc, #12]	@ (0x19c4)
@   0x080019b8: 44a5        add	sp, r4
@   0x080019ba: 4803        ldr	r0, [pc, #12]	@ (0x19c8)
@   0x080019bc: 4468        add	r0, sp
@   0x080019be: 2100        movs	r1, #0
@   0x080019c0: 7001        strb	r1, [r0, #0]
@   0x080019c2: e181        b.n	0x1cc8
@   0x080019c4: fb2c        ffff 			@ <UNDEFINED> instruction: 0xfb2cffff
@   0x080019c8: 04c9        lsls	r1, r1, #19
@   0x080019ca: 0000        movs	r0, r0
@   0x080019cc: f01f        f8f8 	bl	0x20bc0
@   0x080019d0: 4805        ldr	r0, [pc, #20]	@ (0x19e8)
@   0x080019d2: 4468        add	r0, sp
@   0x080019d4: 7800        ldrb	r0, [r0, #0]
@   0x080019d6: 2808        cmp	r0, #8
@   0x080019d8: d900        bls.n	0x19dc
@   0x080019da: e175        b.n	0x1cc8
@   0x080019dc: 0080        lsls	r0, r0, #2
@   0x080019de: 4903        ldr	r1, [pc, #12]	@ (0x19ec)
@   0x080019e0: 1840        adds	r0, r0, r1
@   0x080019e2: 6800        ldr	r0, [r0, #0]
@   0x080019e4: 4687        mov	pc, r0
@   0x080019e6: 0000        movs	r0, r0
@   0x080019e8: 04c9        lsls	r1, r1, #19
@   0x080019ea: 0000        movs	r0, r0
@   0x080019ec: 19f0        adds	r0, r6, r7
@   0x080019ee: 0800        lsrs	r0, r0, #32
@   0x080019f0: 1a14        subs	r4, r2, r0
@   0x080019f2: 0800        lsrs	r0, r0, #32
@   0x080019f4: 1a54        subs	r4, r2, r1
@   0x080019f6: 0800        lsrs	r0, r0, #32
@   0x080019f8: 1a88        subs	r0, r1, r2
@   0x080019fa: 0800        lsrs	r0, r0, #32
@   0x080019fc: 1ab8        subs	r0, r7, r2
@   0x080019fe: 0800        lsrs	r0, r0, #32
@   0x08001a00: 1b64        subs	r4, r4, r5
@   0x08001a02: 0800        lsrs	r0, r0, #32
@   0x08001a04: 1c00        adds	r0, r0, #0
@   0x08001a06: 0800        lsrs	r0, r0, #32
@   0x08001a08: 1c44        adds	r4, r0, #1
@   0x08001a0a: 0800        lsrs	r0, r0, #32
@   0x08001a0c: 1c88        adds	r0, r1, #2
@   0x08001a0e: 0800        lsrs	r0, r0, #32
@   0x08001a10: 1cc4        adds	r4, r0, #3
@   0x08001a12: 0800        lsrs	r0, r0, #32
@   0x08001a14: 4c0c        ldr	r4, [pc, #48]	@ (0x1a48)
@   0x08001a16: 446c        add	r4, sp
@   0x08001a18: 490c        ldr	r1, [pc, #48]	@ (0x1a4c)
@   0x08001a1a: 2500        movs	r5, #0
@   0x08001a1c: 2005        movs	r0, #5
@   0x08001a1e: 7288        strb	r0, [r1, #10]
@   0x08001a20: 2000        movs	r0, #0
@   0x08001a22: 4669        mov	r1, sp
@   0x08001a24: f005        f8c6 	bl	0x6bb4
@   0x08001a28: 2087        movs	r0, #135	@ 0x87
@   0x08001a2a: 00c0        lsls	r0, r0, #3
@   0x08001a2c: 4468        add	r0, sp
@   0x08001a2e: 1c21        adds	r1, r4, #0
@   0x08001a30: 2205        movs	r2, #5
@   0x08001a32: f009        febd 	bl	0xb7b0
@   0x08001a36: 4906        ldr	r1, [pc, #24]	@ (0x1a50)
@   0x08001a38: 4469        add	r1, sp
@   0x08001a3a: 2001        movs	r0, #1
@   0x08001a3c: 7008        strb	r0, [r1, #0]
@   0x08001a3e: 2099        movs	r0, #153	@ 0x99
@   0x08001a40: 00c0        lsls	r0, r0, #3
@   0x08001a42: 4468        add	r0, sp
@   0x08001a44: 7005        strb	r5, [r0, #0]
@   0x08001a46: e13f        b.n	0x1cc8
@   0x08001a48: 04cc        lsls	r4, r1, #19
@   0x08001a4a: 0000        movs	r0, r0
@   0x08001a4c: 5330        strh	r0, [r6, r4]
@   0x08001a4e: 0300        lsls	r0, r0, #12
@   0x08001a50: 04c9        lsls	r1, r1, #19
@   0x08001a52: 0000        movs	r0, r0
@   0x08001a54: 2499        movs	r4, #153	@ 0x99
@   0x08001a56: 00e4        lsls	r4, r4, #3
@   0x08001a58: 446c        add	r4, sp
@   0x08001a5a: 4908        ldr	r1, [pc, #32]	@ (0x1a7c)
@   0x08001a5c: 1c20        adds	r0, r4, #0
@   0x08001a5e: f008        fb51 	bl	0xa104
@   0x08001a62: 0600        lsls	r0, r0, #24
@   0x08001a64: 2800        cmp	r0, #0
@   0x08001a66: d100        bne.n	0x1a6a
@   0x08001a68: e122        b.n	0x1cb0
@   0x08001a6a: 4905        ldr	r1, [pc, #20]	@ (0x1a80)
@   0x08001a6c: 4469        add	r1, sp
@   0x08001a6e: 2002        movs	r0, #2
@   0x08001a70: 7008        strb	r0, [r1, #0]
@   0x08001a72: 4904        ldr	r1, [pc, #16]	@ (0x1a84)
@   0x08001a74: 2000        movs	r0, #0
@   0x08001a76: 6148        str	r0, [r1, #20]
@   0x08001a78: 7020        strb	r0, [r4, #0]
@   0x08001a7a: e119        b.n	0x1cb0
@   0x08001a7c: 1d19        adds	r1, r3, #4
@   0x08001a7e: 0800        lsrs	r0, r0, #32
@   0x08001a80: 04c9        lsls	r1, r1, #19
@   0x08001a82: 0000        movs	r0, r0
@   0x08001a84: 5330        strh	r0, [r6, r4]
@   0x08001a86: 0300        lsls	r0, r0, #12
@   0x08001a88: 2099        movs	r0, #153	@ 0x99
@   0x08001a8a: 00c0        lsls	r0, r0, #3
@   0x08001a8c: 4468        add	r0, sp
@   0x08001a8e: f008        f985 	bl	0x9d9c
@   0x08001a92: 2800        cmp	r0, #0
@   0x08001a94: d006        beq.n	0x1aa4
@   0x08001a96: 4906        ldr	r1, [pc, #24]	@ (0x1ab0)
@   0x08001a98: 4469        add	r1, sp
@   0x08001a9a: 2003        movs	r0, #3
@   0x08001a9c: 7008        strb	r0, [r1, #0]
@   0x08001a9e: 4905        ldr	r1, [pc, #20]	@ (0x1ab4)
@   0x08001aa0: 2000        movs	r0, #0
@   0x08001aa2: 6148        str	r0, [r1, #20]
@   0x08001aa4: 2000        movs	r0, #0
@   0x08001aa6: 4669        mov	r1, sp
@   0x08001aa8: f005        fdda 	bl	0x7660
@   0x08001aac: e10c        b.n	0x1cc8
@   0x08001aae: 0000        movs	r0, r0
@   0x08001ab0: 04c9        lsls	r1, r1, #19
@   0x08001ab2: 0000        movs	r0, r0
@   0x08001ab4: 5330        strh	r0, [r6, r4]
@   0x08001ab6: 0300        lsls	r0, r0, #12
@   0x08001ab8: f7fe        fd04 	bl	0x4c4
@   0x08001abc: 4906        ldr	r1, [pc, #24]	@ (0x1ad8)
@   0x08001abe: 8008        strh	r0, [r1, #0]
@   0x08001ac0: 0400        lsls	r0, r0, #16
@   0x08001ac2: 0c00        lsrs	r0, r0, #16
@   0x08001ac4: 2840        cmp	r0, #64	@ 0x40
@   0x08001ac6: d10b        bne.n	0x1ae0
@   0x08001ac8: 4904        ldr	r1, [pc, #16]	@ (0x1adc)
@   0x08001aca: 4469        add	r1, sp
@   0x08001acc: 2005        movs	r0, #5
@   0x08001ace: 7008        strb	r0, [r1, #0]
@   0x08001ad0: f00c        fac6 	bl	0xe060
@   0x08001ad4: e0f8        b.n	0x1cc8
@   0x08001ad6: 0000        movs	r0, r0
@   0x08001ad8: 5398        strh	r0, [r3, r6]
@   0x08001ada: 0300        lsls	r0, r0, #12
@   0x08001adc: 04c9        lsls	r1, r1, #19
@   0x08001ade: 0000        movs	r0, r0
@   0x08001ae0: 4907        ldr	r1, [pc, #28]	@ (0x1b00)
@   0x08001ae2: 2308        movs	r3, #8
@   0x08001ae4: 2208        movs	r2, #8
@   0x08001ae6: 1c10        adds	r0, r2, #0
@   0x08001ae8: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08001aea: 4008        ands	r0, r1
@   0x08001aec: 2800        cmp	r0, #0
@   0x08001aee: d00b        beq.n	0x1b08
@   0x08001af0: 4904        ldr	r1, [pc, #16]	@ (0x1b04)
@   0x08001af2: 4469        add	r1, sp
@   0x08001af4: 2004        movs	r0, #4
@   0x08001af6: 7008        strb	r0, [r1, #0]
@   0x08001af8: f00d        fa4a 	bl	0xef90
@   0x08001afc: e0e4        b.n	0x1cc8
@   0x08001afe: 0000        movs	r0, r0
@   0x08001b00: 3720        adds	r7, #32
@   0x08001b02: 0300        lsls	r0, r0, #12
@   0x08001b04: 04c9        lsls	r1, r1, #19
@   0x08001b06: 0000        movs	r0, r0
@   0x08001b08: 4904        ldr	r1, [pc, #16]	@ (0x1b1c)
@   0x08001b0a: 1c10        adds	r0, r2, #0
@   0x08001b0c: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08001b0e: 4008        ands	r0, r1
@   0x08001b10: 2800        cmp	r0, #0
@   0x08001b12: d007        beq.n	0x1b24
@   0x08001b14: 4802        ldr	r0, [pc, #8]	@ (0x1b20)
@   0x08001b16: 4468        add	r0, sp
@   0x08001b18: 7003        strb	r3, [r0, #0]
@   0x08001b1a: e0d5        b.n	0x1cc8
@   0x08001b1c: 6110        str	r0, [r2, #16]
@   0x08001b1e: 0300        lsls	r0, r0, #12
@   0x08001b20: 04c9        lsls	r1, r1, #19
@   0x08001b22: 0000        movs	r0, r0
@   0x08001b24: 4c0d        ldr	r4, [pc, #52]	@ (0x1b5c)
@   0x08001b26: 446c        add	r4, sp
@   0x08001b28: 2000        movs	r0, #0
@   0x08001b2a: 4669        mov	r1, sp
@   0x08001b2c: f005        fd98 	bl	0x7660
@   0x08001b30: f008        fbd2 	bl	0xa2d8
@   0x08001b34: f7fe        fed2 	bl	0x8dc
@   0x08001b38: f008        fbf6 	bl	0xa328
@   0x08001b3c: f007        fcdc 	bl	0x94f8
@   0x08001b40: f007        ff20 	bl	0x9984
@   0x08001b44: 2087        movs	r0, #135	@ 0x87
@   0x08001b46: 00c0        lsls	r0, r0, #3
@   0x08001b48: 4468        add	r0, sp
@   0x08001b4a: 1c21        adds	r1, r4, #0
@   0x08001b4c: f7ff        fed4 	bl	0x18f8
@   0x08001b50: 4903        ldr	r1, [pc, #12]	@ (0x1b60)
@   0x08001b52: 6948        ldr	r0, [r1, #20]
@   0x08001b54: 3001        adds	r0, #1
@   0x08001b56: 6148        str	r0, [r1, #20]
@   0x08001b58: e0b6        b.n	0x1cc8
@   0x08001b5a: 0000        movs	r0, r0
@   0x08001b5c: 04cc        lsls	r4, r1, #19
@   0x08001b5e: 0000        movs	r0, r0
@   0x08001b60: 5330        strh	r0, [r6, r4]
@   0x08001b62: 0300        lsls	r0, r0, #12
@   0x08001b64: 4c22        ldr	r4, [pc, #136]	@ (0x1bf0)
@   0x08001b66: 446c        add	r4, sp
@   0x08001b68: 4d22        ldr	r5, [pc, #136]	@ (0x1bf4)
@   0x08001b6a: 446d        add	r5, sp
@   0x08001b6c: 4820        ldr	r0, [pc, #128]	@ (0x1bf0)
@   0x08001b6e: 4468        add	r0, sp
@   0x08001b70: f008        f850 	bl	0x9c14
@   0x08001b74: 2800        cmp	r0, #0
@   0x08001b76: d101        bne.n	0x1b7c
@   0x08001b78: 2007        movs	r0, #7
@   0x08001b7a: 7020        strb	r0, [r4, #0]
@   0x08001b7c: 2087        movs	r0, #135	@ 0x87
@   0x08001b7e: 00c0        lsls	r0, r0, #3
@   0x08001b80: 4468        add	r0, sp
@   0x08001b82: 1c29        adds	r1, r5, #0
@   0x08001b84: 2205        movs	r2, #5
@   0x08001b86: f009        fe13 	bl	0xb7b0
@   0x08001b8a: 4d1b        ldr	r5, [pc, #108]	@ (0x1bf8)
@   0x08001b8c: 2005        movs	r0, #5
@   0x08001b8e: 5628        ldrsb	r0, [r5, r0]
@   0x08001b90: 2801        cmp	r0, #1
@   0x08001b92: dc0a        bgt.n	0x1baa
@   0x08001b94: 4c19        ldr	r4, [pc, #100]	@ (0x1bfc)
@   0x08001b96: 1c20        adds	r0, r4, #0
@   0x08001b98: 2108        movs	r1, #8
@   0x08001b9a: 2200        movs	r2, #0
@   0x08001b9c: f004        fd92 	bl	0x66c4
@   0x08001ba0: 1c20        adds	r0, r4, #0
@   0x08001ba2: 2109        movs	r1, #9
@   0x08001ba4: 2200        movs	r2, #0
@   0x08001ba6: f004        fd8d 	bl	0x66c4
@   0x08001baa: 7968        ldrb	r0, [r5, #5]
@   0x08001bac: 2802        cmp	r0, #2
@   0x08001bae: d10a        bne.n	0x1bc6
@   0x08001bb0: 4c12        ldr	r4, [pc, #72]	@ (0x1bfc)
@   0x08001bb2: 1c20        adds	r0, r4, #0
@   0x08001bb4: 2108        movs	r1, #8
@   0x08001bb6: 2201        movs	r2, #1
@   0x08001bb8: f004        fd84 	bl	0x66c4
@   0x08001bbc: 1c20        adds	r0, r4, #0
@   0x08001bbe: 2109        movs	r1, #9
@   0x08001bc0: 2201        movs	r2, #1
@   0x08001bc2: f004        fd7f 	bl	0x66c4
@   0x08001bc6: 796d        ldrb	r5, [r5, #5]
@   0x08001bc8: 2d03        cmp	r5, #3
@   0x08001bca: d10a        bne.n	0x1be2
@   0x08001bcc: 4c0b        ldr	r4, [pc, #44]	@ (0x1bfc)
@   0x08001bce: 1c20        adds	r0, r4, #0
@   0x08001bd0: 2108        movs	r1, #8
@   0x08001bd2: 2201        movs	r2, #1
@   0x08001bd4: f004        fd76 	bl	0x66c4
@   0x08001bd8: 1c20        adds	r0, r4, #0
@   0x08001bda: 2109        movs	r1, #9
@   0x08001bdc: 2201        movs	r2, #1
@   0x08001bde: f004        fd71 	bl	0x66c4
@   0x08001be2: 2199        movs	r1, #153	@ 0x99
@   0x08001be4: 00c9        lsls	r1, r1, #3
@   0x08001be6: 4469        add	r1, sp
@   0x08001be8: 2000        movs	r0, #0
@   0x08001bea: 7008        strb	r0, [r1, #0]
@   0x08001bec: e06c        b.n	0x1cc8
@   0x08001bee: 0000        movs	r0, r0
@   0x08001bf0: 04c9        lsls	r1, r1, #19
@   0x08001bf2: 0000        movs	r0, r0
@   0x08001bf4: 04cc        lsls	r4, r1, #19
@   0x08001bf6: 0000        movs	r0, r0
@   0x08001bf8: 35e0        adds	r5, #224	@ 0xe0
@   0x08001bfa: 0300        lsls	r0, r0, #12
@   0x08001bfc: 6110        str	r0, [r2, #16]
@   0x08001bfe: 0300        lsls	r0, r0, #12
@   0x08001c00: f7fe        fc60 	bl	0x4c4
@   0x08001c04: 490c        ldr	r1, [pc, #48]	@ (0x1c38)
@   0x08001c06: 8008        strh	r0, [r1, #0]
@   0x08001c08: f00c        fd4e 	bl	0xe6a8
@   0x08001c0c: 0600        lsls	r0, r0, #24
@   0x08001c0e: 0e02        lsrs	r2, r0, #24
@   0x08001c10: 2a00        cmp	r2, #0
@   0x08001c12: d107        bne.n	0x1c24
@   0x08001c14: 4809        ldr	r0, [pc, #36]	@ (0x1c3c)
@   0x08001c16: 4468        add	r0, sp
@   0x08001c18: 2106        movs	r1, #6
@   0x08001c1a: 7001        strb	r1, [r0, #0]
@   0x08001c1c: 2099        movs	r0, #153	@ 0x99
@   0x08001c1e: 00c0        lsls	r0, r0, #3
@   0x08001c20: 4468        add	r0, sp
@   0x08001c22: 7002        strb	r2, [r0, #0]
@   0x08001c24: 4806        ldr	r0, [pc, #24]	@ (0x1c40)
@   0x08001c26: 7800        ldrb	r0, [r0, #0]
@   0x08001c28: 2800        cmp	r0, #0
@   0x08001c2a: d14d        bne.n	0x1cc8
@   0x08001c2c: 4903        ldr	r1, [pc, #12]	@ (0x1c3c)
@   0x08001c2e: 4469        add	r1, sp
@   0x08001c30: 2003        movs	r0, #3
@   0x08001c32: 7008        strb	r0, [r1, #0]
@   0x08001c34: e048        b.n	0x1cc8
@   0x08001c36: 0000        movs	r0, r0
@   0x08001c38: 5398        strh	r0, [r3, r6]
@   0x08001c3a: 0300        lsls	r0, r0, #12
@   0x08001c3c: 04c9        lsls	r1, r1, #19
@   0x08001c3e: 0000        movs	r0, r0
@   0x08001c40: 5328        strh	r0, [r5, r4]
@   0x08001c42: 0300        lsls	r0, r0, #12
@   0x08001c44: 2499        movs	r4, #153	@ 0x99
@   0x08001c46: 00e4        lsls	r4, r4, #3
@   0x08001c48: 446c        add	r4, sp
@   0x08001c4a: 2000        movs	r0, #0
@   0x08001c4c: 5620        ldrsb	r0, [r4, r0]
@   0x08001c4e: 2800        cmp	r0, #0
@   0x08001c50: d105        bne.n	0x1c5e
@   0x08001c52: 20bf        movs	r0, #191	@ 0xbf
@   0x08001c54: f00e        fd1e 	bl	0x10694
@   0x08001c58: 7820        ldrb	r0, [r4, #0]
@   0x08001c5a: 3001        adds	r0, #1
@   0x08001c5c: 7020        strb	r0, [r4, #0]
@   0x08001c5e: 7824        ldrb	r4, [r4, #0]
@   0x08001c60: 0624        lsls	r4, r4, #24
@   0x08001c62: 1624        asrs	r4, r4, #24
@   0x08001c64: 2c01        cmp	r4, #1
@   0x08001c66: d12f        bne.n	0x1cc8
@   0x08001c68: f00e        fd26 	bl	0x106b8
@   0x08001c6c: 0600        lsls	r0, r0, #24
@   0x08001c6e: 2800        cmp	r0, #0
@   0x08001c70: d12a        bne.n	0x1cc8
@   0x08001c72: 4803        ldr	r0, [pc, #12]	@ (0x1c80)
@   0x08001c74: 2104        movs	r1, #4
@   0x08001c76: 7001        strb	r1, [r0, #0]
@   0x08001c78: 7184        strb	r4, [r0, #6]
@   0x08001c7a: 4802        ldr	r0, [pc, #8]	@ (0x1c84)
@   0x08001c7c: 7241        strb	r1, [r0, #9]
@   0x08001c7e: e023        b.n	0x1cc8
@   0x08001c80: 3480        adds	r4, #128	@ 0x80
@   0x08001c82: 0300        lsls	r0, r0, #12
@   0x08001c84: 5330        strh	r0, [r6, r4]
@   0x08001c86: 0300        lsls	r0, r0, #12
@   0x08001c88: 2499        movs	r4, #153	@ 0x99
@   0x08001c8a: 00e4        lsls	r4, r4, #3
@   0x08001c8c: 446c        add	r4, sp
@   0x08001c8e: 490a        ldr	r1, [pc, #40]	@ (0x1cb8)
@   0x08001c90: 1c20        adds	r0, r4, #0
@   0x08001c92: f008        fa37 	bl	0xa104
@   0x08001c96: 0600        lsls	r0, r0, #24
@   0x08001c98: 2800        cmp	r0, #0
@   0x08001c9a: d009        beq.n	0x1cb0
@   0x08001c9c: 4907        ldr	r1, [pc, #28]	@ (0x1cbc)
@   0x08001c9e: 4469        add	r1, sp
@   0x08001ca0: 2002        movs	r0, #2
@   0x08001ca2: 7008        strb	r0, [r1, #0]
@   0x08001ca4: 4906        ldr	r1, [pc, #24]	@ (0x1cc0)
@   0x08001ca6: 2000        movs	r0, #0
@   0x08001ca8: 6148        str	r0, [r1, #20]
@   0x08001caa: 7020        strb	r0, [r4, #0]
@   0x08001cac: f008        fa8c 	bl	0xa1c8
@   0x08001cb0: f7fe        fe14 	bl	0x8dc
@   0x08001cb4: e008        b.n	0x1cc8
@   0x08001cb6: 0000        movs	r0, r0
@   0x08001cb8: a26d        add	r2, pc, #436	@ (adr r2, 0x1e70)
@   0x08001cba: 0800        lsrs	r0, r0, #32
@   0x08001cbc: 04c9        lsls	r1, r1, #19
@   0x08001cbe: 0000        movs	r0, r0
@   0x08001cc0: 5330        strh	r0, [r6, r4]
@   0x08001cc2: 0300        lsls	r0, r0, #12
@   0x08001cc4: f00c        f8dc 	bl	0xde80
@   0x08001cc8: 4806        ldr	r0, [pc, #24]	@ (0x1ce4)
@   0x08001cca: 7a40        ldrb	r0, [r0, #9]
@   0x08001ccc: 280c        cmp	r0, #12
@   0x08001cce: d100        bne.n	0x1cd2
@   0x08001cd0: e67c        b.n	0x19cc
@   0x08001cd2: 2818        cmp	r0, #24
@   0x08001cd4: d100        bne.n	0x1cd8
@   0x08001cd6: e679        b.n	0x19cc
@   0x08001cd8: 4b03        ldr	r3, [pc, #12]	@ (0x1ce8)
@   0x08001cda: 449d        add	sp, r3
@   0x08001cdc: bc30        pop	{r4, r5}
@   0x08001cde: bc01        pop	{r0}
@   0x08001ce0: 4700        bx	r0
@   0x08001ce2: 0000        movs	r0, r0
@   0x08001ce4: 5330        strh	r0, [r6, r4]
@   0x08001ce6: 0300        lsls	r0, r0, #12
@   0x08001ce8: 04d4        lsls	r4, r2, #19
@   0x08001cea: 0000        movs	r0, r0
@   0x08001cec: b530        push	{r4, r5, lr}
@   0x08001cee: 1c03        adds	r3, r0, #0
@   0x08001cf0: 1c0c        adds	r4, r1, #0
@   0x08001cf2: 1c15        adds	r5, r2, #0
@   0x08001cf4: 4907        ldr	r1, [pc, #28]	@ (0x1d14)
@   0x08001cf6: 2005        movs	r0, #5
@   0x08001cf8: 7288        strb	r0, [r1, #10]
@   0x08001cfa: 2000        movs	r0, #0
@   0x08001cfc: 1c19        adds	r1, r3, #0
@   0x08001cfe: f004        ff59 	bl	0x6bb4
@   0x08001d02: 1c20        adds	r0, r4, #0
@   0x08001d04: 1c29        adds	r1, r5, #0
@   0x08001d06: 2205        movs	r2, #5
@   0x08001d08: f009        fd52 	bl	0xb7b0
@   0x08001d0c: bc30        pop	{r4, r5}
@   0x08001d0e: bc01        pop	{r0}
@   0x08001d10: 4700        bx	r0
@   0x08001d12: 0000        movs	r0, r0
@   0x08001d14: 5330        strh	r0, [r6, r4]
@   0x08001d16: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080019B4
sub_080019B4: @ 0x080019b4
        .incbin "frog_us_baserom.gba", 0x19b4, 0x364
        thumb_func_end sub_080019B4
