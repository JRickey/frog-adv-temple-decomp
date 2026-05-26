@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003864, 0x08003b40)  (732 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003864 --end 0x8003b40 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003864: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08003866: 4647        mov	r7, r8
@   0x08003868: b480        push	{r7}
@   0x0800386a: 4c03        ldr	r4, [pc, #12]	@ (0x3878)
@   0x0800386c: 44a5        add	sp, r4
@   0x0800386e: 4803        ldr	r0, [pc, #12]	@ (0x387c)
@   0x08003870: 4468        add	r0, sp
@   0x08003872: 2100        movs	r1, #0
@   0x08003874: 7001        strb	r1, [r0, #0]
@   0x08003876: e151        b.n	0x3b1c
@   0x08003878: fcd8        ffff 			@ <UNDEFINED> instruction: 0xfcd8ffff
@   0x0800387c: 030d        lsls	r5, r1, #12
@   0x0800387e: 0000        movs	r0, r0
@   0x08003880: f01d        f99e 	bl	0x20bc0
@   0x08003884: 4805        ldr	r0, [pc, #20]	@ (0x389c)
@   0x08003886: 4468        add	r0, sp
@   0x08003888: 7800        ldrb	r0, [r0, #0]
@   0x0800388a: 2808        cmp	r0, #8
@   0x0800388c: d900        bls.n	0x3890
@   0x0800388e: e145        b.n	0x3b1c
@   0x08003890: 0080        lsls	r0, r0, #2
@   0x08003892: 4903        ldr	r1, [pc, #12]	@ (0x38a0)
@   0x08003894: 1840        adds	r0, r0, r1
@   0x08003896: 6800        ldr	r0, [r0, #0]
@   0x08003898: 4687        mov	pc, r0
@   0x0800389a: 0000        movs	r0, r0
@   0x0800389c: 030d        lsls	r5, r1, #12
@   0x0800389e: 0000        movs	r0, r0
@   0x080038a0: 38a4        subs	r0, #164	@ 0xa4
@   0x080038a2: 0800        lsrs	r0, r0, #32
@   0x080038a4: 38c8        subs	r0, #200	@ 0xc8
@   0x080038a6: 0800        lsrs	r0, r0, #32
@   0x080038a8: 3918        subs	r1, #24
@   0x080038aa: 0800        lsrs	r0, r0, #32
@   0x080038ac: 3948        subs	r1, #72	@ 0x48
@   0x080038ae: 0800        lsrs	r0, r0, #32
@   0x080038b0: 396c        subs	r1, #108	@ 0x6c
@   0x080038b2: 0800        lsrs	r0, r0, #32
@   0x080038b4: 3a1c        subs	r2, #28
@   0x080038b6: 0800        lsrs	r0, r0, #32
@   0x080038b8: 3a60        subs	r2, #96	@ 0x60
@   0x080038ba: 0800        lsrs	r0, r0, #32
@   0x080038bc: 3aa0        subs	r2, #160	@ 0xa0
@   0x080038be: 0800        lsrs	r0, r0, #32
@   0x080038c0: 3ae0        subs	r2, #224	@ 0xe0
@   0x080038c2: 0800        lsrs	r0, r0, #32
@   0x080038c4: 3b18        subs	r3, #24
@   0x080038c6: 0800        lsrs	r0, r0, #32
@   0x080038c8: acc4        add	r4, sp, #784	@ 0x310
@   0x080038ca: adc6        add	r5, sp, #792	@ 0x318
@   0x080038cc: aec8        add	r6, sp, #800	@ 0x320
@   0x080038ce: 4910        ldr	r1, [pc, #64]	@ (0x3910)
@   0x080038d0: 2000        movs	r0, #0
@   0x080038d2: 4680        mov	r8, r0
@   0x080038d4: 200b        movs	r0, #11
@   0x080038d6: 7288        strb	r0, [r1, #10]
@   0x080038d8: 2001        movs	r0, #1
@   0x080038da: a9a8        add	r1, sp, #672	@ 0x2a0
@   0x080038dc: f003        f96a 	bl	0x6bb4
@   0x080038e0: a802        add	r0, sp, #8
@   0x080038e2: 1c21        adds	r1, r4, #0
@   0x080038e4: 2206        movs	r2, #6
@   0x080038e6: f007        ff63 	bl	0xb7b0
@   0x080038ea: a856        add	r0, sp, #344	@ 0x158
@   0x080038ec: 1c29        adds	r1, r5, #0
@   0x080038ee: 2207        movs	r2, #7
@   0x080038f0: f007        ff5e 	bl	0xb7b0
@   0x080038f4: a890        add	r0, sp, #576	@ 0x240
@   0x080038f6: 1c31        adds	r1, r6, #0
@   0x080038f8: 2216        movs	r2, #22
@   0x080038fa: f008        fa8d 	bl	0xbe18
@   0x080038fe: 4905        ldr	r1, [pc, #20]	@ (0x3914)
@   0x08003900: 4469        add	r1, sp
@   0x08003902: 2001        movs	r0, #1
@   0x08003904: 7008        strb	r0, [r1, #0]
@   0x08003906: a8c3        add	r0, sp, #780	@ 0x30c
@   0x08003908: 4641        mov	r1, r8
@   0x0800390a: 7001        strb	r1, [r0, #0]
@   0x0800390c: e106        b.n	0x3b1c
@   0x0800390e: 0000        movs	r0, r0
@   0x08003910: 5330        strh	r0, [r6, r4]
@   0x08003912: 0300        lsls	r0, r0, #12
@   0x08003914: 030d        lsls	r5, r1, #12
@   0x08003916: 0000        movs	r0, r0
@   0x08003918: acc3        add	r4, sp, #780	@ 0x30c
@   0x0800391a: 4908        ldr	r1, [pc, #32]	@ (0x393c)
@   0x0800391c: 1c20        adds	r0, r4, #0
@   0x0800391e: f006        fbf1 	bl	0xa104
@   0x08003922: 0600        lsls	r0, r0, #24
@   0x08003924: 2800        cmp	r0, #0
@   0x08003926: d100        bne.n	0x392a
@   0x08003928: e0ec        b.n	0x3b04
@   0x0800392a: 4905        ldr	r1, [pc, #20]	@ (0x3940)
@   0x0800392c: 4469        add	r1, sp
@   0x0800392e: 2002        movs	r0, #2
@   0x08003930: 7008        strb	r0, [r1, #0]
@   0x08003932: 4904        ldr	r1, [pc, #16]	@ (0x3944)
@   0x08003934: 2000        movs	r0, #0
@   0x08003936: 6148        str	r0, [r1, #20]
@   0x08003938: 7020        strb	r0, [r4, #0]
@   0x0800393a: e0e3        b.n	0x3b04
@   0x0800393c: 3b8d        subs	r3, #141	@ 0x8d
@   0x0800393e: 0800        lsrs	r0, r0, #32
@   0x08003940: 030d        lsls	r5, r1, #12
@   0x08003942: 0000        movs	r0, r0
@   0x08003944: 5330        strh	r0, [r6, r4]
@   0x08003946: 0300        lsls	r0, r0, #12
@   0x08003948: a8c3        add	r0, sp, #780	@ 0x30c
@   0x0800394a: f006        fa27 	bl	0x9d9c
@   0x0800394e: 2800        cmp	r0, #0
@   0x08003950: d100        bne.n	0x3954
@   0x08003952: e0e3        b.n	0x3b1c
@   0x08003954: 4903        ldr	r1, [pc, #12]	@ (0x3964)
@   0x08003956: 4469        add	r1, sp
@   0x08003958: 2003        movs	r0, #3
@   0x0800395a: 7008        strb	r0, [r1, #0]
@   0x0800395c: 4902        ldr	r1, [pc, #8]	@ (0x3968)
@   0x0800395e: 2000        movs	r0, #0
@   0x08003960: 6148        str	r0, [r1, #20]
@   0x08003962: e0db        b.n	0x3b1c
@   0x08003964: 030d        lsls	r5, r1, #12
@   0x08003966: 0000        movs	r0, r0
@   0x08003968: 5330        strh	r0, [r6, r4]
@   0x0800396a: 0300        lsls	r0, r0, #12
@   0x0800396c: f7fc        fdaa 	bl	0x4c4
@   0x08003970: 4906        ldr	r1, [pc, #24]	@ (0x398c)
@   0x08003972: 8008        strh	r0, [r1, #0]
@   0x08003974: 0400        lsls	r0, r0, #16
@   0x08003976: 0c00        lsrs	r0, r0, #16
@   0x08003978: 2840        cmp	r0, #64	@ 0x40
@   0x0800397a: d10b        bne.n	0x3994
@   0x0800397c: 4904        ldr	r1, [pc, #16]	@ (0x3990)
@   0x0800397e: 4469        add	r1, sp
@   0x08003980: 2005        movs	r0, #5
@   0x08003982: 7008        strb	r0, [r1, #0]
@   0x08003984: f00a        fb6c 	bl	0xe060
@   0x08003988: e0c8        b.n	0x3b1c
@   0x0800398a: 0000        movs	r0, r0
@   0x0800398c: 5398        strh	r0, [r3, r6]
@   0x0800398e: 0300        lsls	r0, r0, #12
@   0x08003990: 030d        lsls	r5, r1, #12
@   0x08003992: 0000        movs	r0, r0
@   0x08003994: 4906        ldr	r1, [pc, #24]	@ (0x39b0)
@   0x08003996: 2308        movs	r3, #8
@   0x08003998: 2208        movs	r2, #8
@   0x0800399a: 1c10        adds	r0, r2, #0
@   0x0800399c: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800399e: 4008        ands	r0, r1
@   0x080039a0: 2800        cmp	r0, #0
@   0x080039a2: d009        beq.n	0x39b8
@   0x080039a4: 4903        ldr	r1, [pc, #12]	@ (0x39b4)
@   0x080039a6: 4469        add	r1, sp
@   0x080039a8: 2004        movs	r0, #4
@   0x080039aa: 7008        strb	r0, [r1, #0]
@   0x080039ac: e0b6        b.n	0x3b1c
@   0x080039ae: 0000        movs	r0, r0
@   0x080039b0: 3720        adds	r7, #32
@   0x080039b2: 0300        lsls	r0, r0, #12
@   0x080039b4: 030d        lsls	r5, r1, #12
@   0x080039b6: 0000        movs	r0, r0
@   0x080039b8: 4904        ldr	r1, [pc, #16]	@ (0x39cc)
@   0x080039ba: 1c10        adds	r0, r2, #0
@   0x080039bc: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x080039be: 4008        ands	r0, r1
@   0x080039c0: 2800        cmp	r0, #0
@   0x080039c2: d007        beq.n	0x39d4
@   0x080039c4: 4802        ldr	r0, [pc, #8]	@ (0x39d0)
@   0x080039c6: 4468        add	r0, sp
@   0x080039c8: 7003        strb	r3, [r0, #0]
@   0x080039ca: e0a7        b.n	0x3b1c
@   0x080039cc: 6110        str	r0, [r2, #16]
@   0x080039ce: 0300        lsls	r0, r0, #12
@   0x080039d0: 030d        lsls	r5, r1, #12
@   0x080039d2: 0000        movs	r0, r0
@   0x080039d4: aec4        add	r6, sp, #784	@ 0x310
@   0x080039d6: 20c6        movs	r0, #198	@ 0xc6
@   0x080039d8: 0080        lsls	r0, r0, #2
@   0x080039da: 4468        add	r0, sp
@   0x080039dc: 4680        mov	r8, r0
@   0x080039de: ac90        add	r4, sp, #576	@ 0x240
@   0x080039e0: adc8        add	r5, sp, #800	@ 0x320
@   0x080039e2: 2001        movs	r0, #1
@   0x080039e4: a9a8        add	r1, sp, #672	@ 0x2a0
@   0x080039e6: f003        fe3b 	bl	0x7660
@   0x080039ea: f006        fc75 	bl	0xa2d8
@   0x080039ee: f7fc        ff75 	bl	0x8dc
@   0x080039f2: f006        fc99 	bl	0xa328
@   0x080039f6: f005        fd7f 	bl	0x94f8
@   0x080039fa: f005        ffc3 	bl	0x9984
@   0x080039fe: 9400        str	r4, [sp, #0]
@   0x08003a00: 9501        str	r5, [sp, #4]
@   0x08003a02: a802        add	r0, sp, #8
@   0x08003a04: 1c31        adds	r1, r6, #0
@   0x08003a06: aa56        add	r2, sp, #344	@ 0x158
@   0x08003a08: 4643        mov	r3, r8
@   0x08003a0a: f7ff        fe2d 	bl	0x3668
@   0x08003a0e: 4902        ldr	r1, [pc, #8]	@ (0x3a18)
@   0x08003a10: 6948        ldr	r0, [r1, #20]
@   0x08003a12: 3001        adds	r0, #1
@   0x08003a14: 6148        str	r0, [r1, #20]
@   0x08003a16: e081        b.n	0x3b1c
@   0x08003a18: 5330        strh	r0, [r6, r4]
@   0x08003a1a: 0300        lsls	r0, r0, #12
@   0x08003a1c: 4c0f        ldr	r4, [pc, #60]	@ (0x3a5c)
@   0x08003a1e: 446c        add	r4, sp
@   0x08003a20: adc4        add	r5, sp, #784	@ 0x310
@   0x08003a22: aec6        add	r6, sp, #792	@ 0x318
@   0x08003a24: afc8        add	r7, sp, #800	@ 0x320
@   0x08003a26: 480d        ldr	r0, [pc, #52]	@ (0x3a5c)
@   0x08003a28: 4468        add	r0, sp
@   0x08003a2a: f006        f8f3 	bl	0x9c14
@   0x08003a2e: 2800        cmp	r0, #0
@   0x08003a30: d101        bne.n	0x3a36
@   0x08003a32: 2007        movs	r0, #7
@   0x08003a34: 7020        strb	r0, [r4, #0]
@   0x08003a36: a802        add	r0, sp, #8
@   0x08003a38: 1c29        adds	r1, r5, #0
@   0x08003a3a: 2206        movs	r2, #6
@   0x08003a3c: f007        feb8 	bl	0xb7b0
@   0x08003a40: a856        add	r0, sp, #344	@ 0x158
@   0x08003a42: 1c31        adds	r1, r6, #0
@   0x08003a44: 2207        movs	r2, #7
@   0x08003a46: f007        feb3 	bl	0xb7b0
@   0x08003a4a: a890        add	r0, sp, #576	@ 0x240
@   0x08003a4c: 1c39        adds	r1, r7, #0
@   0x08003a4e: 2216        movs	r2, #22
@   0x08003a50: f008        f9e2 	bl	0xbe18
@   0x08003a54: a9c3        add	r1, sp, #780	@ 0x30c
@   0x08003a56: 2000        movs	r0, #0
@   0x08003a58: 7008        strb	r0, [r1, #0]
@   0x08003a5a: e05f        b.n	0x3b1c
@   0x08003a5c: 030d        lsls	r5, r1, #12
@   0x08003a5e: 0000        movs	r0, r0
@   0x08003a60: f7fc        fd30 	bl	0x4c4
@   0x08003a64: 490b        ldr	r1, [pc, #44]	@ (0x3a94)
@   0x08003a66: 8008        strh	r0, [r1, #0]
@   0x08003a68: f00a        fe1e 	bl	0xe6a8
@   0x08003a6c: 0600        lsls	r0, r0, #24
@   0x08003a6e: 0e02        lsrs	r2, r0, #24
@   0x08003a70: 2a00        cmp	r2, #0
@   0x08003a72: d105        bne.n	0x3a80
@   0x08003a74: 4808        ldr	r0, [pc, #32]	@ (0x3a98)
@   0x08003a76: 4468        add	r0, sp
@   0x08003a78: 2106        movs	r1, #6
@   0x08003a7a: 7001        strb	r1, [r0, #0]
@   0x08003a7c: a8c3        add	r0, sp, #780	@ 0x30c
@   0x08003a7e: 7002        strb	r2, [r0, #0]
@   0x08003a80: 4806        ldr	r0, [pc, #24]	@ (0x3a9c)
@   0x08003a82: 7800        ldrb	r0, [r0, #0]
@   0x08003a84: 2800        cmp	r0, #0
@   0x08003a86: d149        bne.n	0x3b1c
@   0x08003a88: 4903        ldr	r1, [pc, #12]	@ (0x3a98)
@   0x08003a8a: 4469        add	r1, sp
@   0x08003a8c: 2003        movs	r0, #3
@   0x08003a8e: 7008        strb	r0, [r1, #0]
@   0x08003a90: e044        b.n	0x3b1c
@   0x08003a92: 0000        movs	r0, r0
@   0x08003a94: 5398        strh	r0, [r3, r6]
@   0x08003a96: 0300        lsls	r0, r0, #12
@   0x08003a98: 030d        lsls	r5, r1, #12
@   0x08003a9a: 0000        movs	r0, r0
@   0x08003a9c: 5328        strh	r0, [r5, r4]
@   0x08003a9e: 0300        lsls	r0, r0, #12
@   0x08003aa0: acc3        add	r4, sp, #780	@ 0x30c
@   0x08003aa2: 2000        movs	r0, #0
@   0x08003aa4: 5620        ldrsb	r0, [r4, r0]
@   0x08003aa6: 2800        cmp	r0, #0
@   0x08003aa8: d105        bne.n	0x3ab6
@   0x08003aaa: 20bf        movs	r0, #191	@ 0xbf
@   0x08003aac: f00c        fdf2 	bl	0x10694
@   0x08003ab0: 7820        ldrb	r0, [r4, #0]
@   0x08003ab2: 3001        adds	r0, #1
@   0x08003ab4: 7020        strb	r0, [r4, #0]
@   0x08003ab6: 7824        ldrb	r4, [r4, #0]
@   0x08003ab8: 0624        lsls	r4, r4, #24
@   0x08003aba: 1624        asrs	r4, r4, #24
@   0x08003abc: 2c01        cmp	r4, #1
@   0x08003abe: d12d        bne.n	0x3b1c
@   0x08003ac0: f00c        fdfa 	bl	0x106b8
@   0x08003ac4: 0600        lsls	r0, r0, #24
@   0x08003ac6: 2800        cmp	r0, #0
@   0x08003ac8: d128        bne.n	0x3b1c
@   0x08003aca: 4803        ldr	r0, [pc, #12]	@ (0x3ad8)
@   0x08003acc: 2104        movs	r1, #4
@   0x08003ace: 7001        strb	r1, [r0, #0]
@   0x08003ad0: 7184        strb	r4, [r0, #6]
@   0x08003ad2: 4802        ldr	r0, [pc, #8]	@ (0x3adc)
@   0x08003ad4: 7241        strb	r1, [r0, #9]
@   0x08003ad6: e021        b.n	0x3b1c
@   0x08003ad8: 3480        adds	r4, #128	@ 0x80
@   0x08003ada: 0300        lsls	r0, r0, #12
@   0x08003adc: 5330        strh	r0, [r6, r4]
@   0x08003ade: 0300        lsls	r0, r0, #12
@   0x08003ae0: acc3        add	r4, sp, #780	@ 0x30c
@   0x08003ae2: 490a        ldr	r1, [pc, #40]	@ (0x3b0c)
@   0x08003ae4: 1c20        adds	r0, r4, #0
@   0x08003ae6: f006        fb0d 	bl	0xa104
@   0x08003aea: 0600        lsls	r0, r0, #24
@   0x08003aec: 2800        cmp	r0, #0
@   0x08003aee: d009        beq.n	0x3b04
@   0x08003af0: 4907        ldr	r1, [pc, #28]	@ (0x3b10)
@   0x08003af2: 4469        add	r1, sp
@   0x08003af4: 2002        movs	r0, #2
@   0x08003af6: 7008        strb	r0, [r1, #0]
@   0x08003af8: 4906        ldr	r1, [pc, #24]	@ (0x3b14)
@   0x08003afa: 2000        movs	r0, #0
@   0x08003afc: 6148        str	r0, [r1, #20]
@   0x08003afe: 7020        strb	r0, [r4, #0]
@   0x08003b00: f006        fb62 	bl	0xa1c8
@   0x08003b04: f7fc        feea 	bl	0x8dc
@   0x08003b08: e008        b.n	0x3b1c
@   0x08003b0a: 0000        movs	r0, r0
@   0x08003b0c: a26d        add	r2, pc, #436	@ (adr r2, 0x3cc4)
@   0x08003b0e: 0800        lsrs	r0, r0, #32
@   0x08003b10: 030d        lsls	r5, r1, #12
@   0x08003b12: 0000        movs	r0, r0
@   0x08003b14: 5330        strh	r0, [r6, r4]
@   0x08003b16: 0300        lsls	r0, r0, #12
@   0x08003b18: f00a        f9b2 	bl	0xde80
@   0x08003b1c: 4807        ldr	r0, [pc, #28]	@ (0x3b3c)
@   0x08003b1e: 7a40        ldrb	r0, [r0, #9]
@   0x08003b20: 2812        cmp	r0, #18
@   0x08003b22: d100        bne.n	0x3b26
@   0x08003b24: e6ac        b.n	0x3880
@   0x08003b26: 2818        cmp	r0, #24
@   0x08003b28: d100        bne.n	0x3b2c
@   0x08003b2a: e6a9        b.n	0x3880
@   0x08003b2c: 23ca        movs	r3, #202	@ 0xca
@   0x08003b2e: 009b        lsls	r3, r3, #2
@   0x08003b30: 449d        add	sp, r3
@   0x08003b32: bc08        pop	{r3}
@   0x08003b34: 4698        mov	r8, r3
@   0x08003b36: bcf0        pop	{r4, r5, r6, r7}
@   0x08003b38: bc01        pop	{r0}
@   0x08003b3a: 4700        bx	r0
@   0x08003b3c: 5330        strh	r0, [r6, r4]
@   0x08003b3e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003864
sub_08003864: @ 0x08003864
        .incbin "frog_us_baserom.gba", 0x3864, 0x2dc
        thumb_func_end sub_08003864
