@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800793c, 0x08007dd0)  (1172 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800793c --end 0x8007dd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800793c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800793e: 0600        lsls	r0, r0, #24
@   0x08007940: 0e05        lsrs	r5, r0, #24
@   0x08007942: 0609        lsls	r1, r1, #24
@   0x08007944: 0e0f        lsrs	r7, r1, #24
@   0x08007946: 4817        ldr	r0, [pc, #92]	@ (0x79a4)
@   0x08007948: 8800        ldrh	r0, [r0, #0]
@   0x0800794a: 2800        cmp	r0, #0
@   0x0800794c: d001        beq.n	0x7952
@   0x0800794e: 4916        ldr	r1, [pc, #88]	@ (0x79a8)
@   0x08007950: 8248        strh	r0, [r1, #18]
@   0x08007952: 2201        movs	r2, #1
@   0x08007954: 1c10        adds	r0, r2, #0
@   0x08007956: 4b14        ldr	r3, [pc, #80]	@ (0x79a8)
@   0x08007958: 8a1b        ldrh	r3, [r3, #16]
@   0x0800795a: 4018        ands	r0, r3
@   0x0800795c: 2800        cmp	r0, #0
@   0x0800795e: d000        beq.n	0x7962
@   0x08007960: e230        b.n	0x7dc4
@   0x08007962: 4c11        ldr	r4, [pc, #68]	@ (0x79a8)
@   0x08007964: 8a61        ldrh	r1, [r4, #18]
@   0x08007966: 2900        cmp	r1, #0
@   0x08007968: d100        bne.n	0x796c
@   0x0800796a: e22b        b.n	0x7dc4
@   0x0800796c: 4c0f        ldr	r4, [pc, #60]	@ (0x79ac)
@   0x0800796e: 2004        movs	r0, #4
@   0x08007970: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007972: 4018        ands	r0, r3
@   0x08007974: 2800        cmp	r0, #0
@   0x08007976: d000        beq.n	0x797a
@   0x08007978: e224        b.n	0x7dc4
@   0x0800797a: 1c10        adds	r0, r2, #0
@   0x0800797c: 4008        ands	r0, r1
@   0x0800797e: 2800        cmp	r0, #0
@   0x08007980: d023        beq.n	0x79ca
@   0x08007982: 0629        lsls	r1, r5, #24
@   0x08007984: 1609        asrs	r1, r1, #24
@   0x08007986: 063a        lsls	r2, r7, #24
@   0x08007988: 1612        asrs	r2, r2, #24
@   0x0800798a: 2001        movs	r0, #1
@   0x0800798c: f001        f866 	bl	0x8a5c
@   0x08007990: 0600        lsls	r0, r0, #24
@   0x08007992: 2800        cmp	r0, #0
@   0x08007994: d00c        beq.n	0x79b0
@   0x08007996: 2004        movs	r0, #4
@   0x08007998: 76a0        strb	r0, [r4, #26]
@   0x0800799a: 2002        movs	r0, #2
@   0x0800799c: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0800799e: 4308        orrs	r0, r1
@   0x080079a0: e00b        b.n	0x79ba
@   0x080079a2: 0000        movs	r0, r0
@   0x080079a4: 5398        strh	r0, [r3, r6]
@   0x080079a6: 0300        lsls	r0, r0, #12
@   0x080079a8: 35e0        adds	r5, #224	@ 0xe0
@   0x080079aa: 0300        lsls	r0, r0, #12
@   0x080079ac: 3720        adds	r7, #32
@   0x080079ae: 0300        lsls	r0, r0, #12
@   0x080079b0: 2010        movs	r0, #16
@   0x080079b2: 76a0        strb	r0, [r4, #26]
@   0x080079b4: 2002        movs	r0, #2
@   0x080079b6: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x080079b8: 4310        orrs	r0, r2
@   0x080079ba: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080079bc: 490d        ldr	r1, [pc, #52]	@ (0x79f4)
@   0x080079be: 2001        movs	r0, #1
@   0x080079c0: 2200        movs	r2, #0
@   0x080079c2: 8a0b        ldrh	r3, [r1, #16]
@   0x080079c4: 4318        orrs	r0, r3
@   0x080079c6: 8208        strh	r0, [r1, #16]
@   0x080079c8: 824a        strh	r2, [r1, #18]
@   0x080079ca: 2402        movs	r4, #2
@   0x080079cc: 2002        movs	r0, #2
@   0x080079ce: 4909        ldr	r1, [pc, #36]	@ (0x79f4)
@   0x080079d0: 8a49        ldrh	r1, [r1, #18]
@   0x080079d2: 4008        ands	r0, r1
@   0x080079d4: 2800        cmp	r0, #0
@   0x080079d6: d01e        beq.n	0x7a16
@   0x080079d8: 0629        lsls	r1, r5, #24
@   0x080079da: 1609        asrs	r1, r1, #24
@   0x080079dc: 063a        lsls	r2, r7, #24
@   0x080079de: 1612        asrs	r2, r2, #24
@   0x080079e0: 2002        movs	r0, #2
@   0x080079e2: f001        f83b 	bl	0x8a5c
@   0x080079e6: 0600        lsls	r0, r0, #24
@   0x080079e8: 2800        cmp	r0, #0
@   0x080079ea: d007        beq.n	0x79fc
@   0x080079ec: 4802        ldr	r0, [pc, #8]	@ (0x79f8)
@   0x080079ee: 2105        movs	r1, #5
@   0x080079f0: e006        b.n	0x7a00
@   0x080079f2: 0000        movs	r0, r0
@   0x080079f4: 35e0        adds	r5, #224	@ 0xe0
@   0x080079f6: 0300        lsls	r0, r0, #12
@   0x080079f8: 3720        adds	r7, #32
@   0x080079fa: 0300        lsls	r0, r0, #12
@   0x080079fc: 4811        ldr	r0, [pc, #68]	@ (0x7a44)
@   0x080079fe: 2111        movs	r1, #17
@   0x08007a00: 7681        strb	r1, [r0, #26]
@   0x08007a02: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08007a04: 4321        orrs	r1, r4
@   0x08007a06: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08007a08: 490f        ldr	r1, [pc, #60]	@ (0x7a48)
@   0x08007a0a: 2001        movs	r0, #1
@   0x08007a0c: 2200        movs	r2, #0
@   0x08007a0e: 8a0b        ldrh	r3, [r1, #16]
@   0x08007a10: 4318        orrs	r0, r3
@   0x08007a12: 8208        strh	r0, [r1, #16]
@   0x08007a14: 824a        strh	r2, [r1, #18]
@   0x08007a16: 2004        movs	r0, #4
@   0x08007a18: 4c0b        ldr	r4, [pc, #44]	@ (0x7a48)
@   0x08007a1a: 8a64        ldrh	r4, [r4, #18]
@   0x08007a1c: 4020        ands	r0, r4
@   0x08007a1e: 2800        cmp	r0, #0
@   0x08007a20: d022        beq.n	0x7a68
@   0x08007a22: 0629        lsls	r1, r5, #24
@   0x08007a24: 1609        asrs	r1, r1, #24
@   0x08007a26: 063a        lsls	r2, r7, #24
@   0x08007a28: 1612        asrs	r2, r2, #24
@   0x08007a2a: 2004        movs	r0, #4
@   0x08007a2c: f001        f816 	bl	0x8a5c
@   0x08007a30: 0600        lsls	r0, r0, #24
@   0x08007a32: 2800        cmp	r0, #0
@   0x08007a34: d00a        beq.n	0x7a4c
@   0x08007a36: 4903        ldr	r1, [pc, #12]	@ (0x7a44)
@   0x08007a38: 2006        movs	r0, #6
@   0x08007a3a: 7688        strb	r0, [r1, #26]
@   0x08007a3c: 2002        movs	r0, #2
@   0x08007a3e: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08007a40: 4310        orrs	r0, r2
@   0x08007a42: e009        b.n	0x7a58
@   0x08007a44: 3720        adds	r7, #32
@   0x08007a46: 0300        lsls	r0, r0, #12
@   0x08007a48: 35e0        adds	r5, #224	@ 0xe0
@   0x08007a4a: 0300        lsls	r0, r0, #12
@   0x08007a4c: 4912        ldr	r1, [pc, #72]	@ (0x7a98)
@   0x08007a4e: 2012        movs	r0, #18
@   0x08007a50: 7688        strb	r0, [r1, #26]
@   0x08007a52: 2002        movs	r0, #2
@   0x08007a54: 8e8b        ldrh	r3, [r1, #52]	@ 0x34
@   0x08007a56: 4318        orrs	r0, r3
@   0x08007a58: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08007a5a: 4910        ldr	r1, [pc, #64]	@ (0x7a9c)
@   0x08007a5c: 2001        movs	r0, #1
@   0x08007a5e: 2200        movs	r2, #0
@   0x08007a60: 8a0c        ldrh	r4, [r1, #16]
@   0x08007a62: 4320        orrs	r0, r4
@   0x08007a64: 8208        strh	r0, [r1, #16]
@   0x08007a66: 824a        strh	r2, [r1, #18]
@   0x08007a68: 2008        movs	r0, #8
@   0x08007a6a: 490c        ldr	r1, [pc, #48]	@ (0x7a9c)
@   0x08007a6c: 8a49        ldrh	r1, [r1, #18]
@   0x08007a6e: 4008        ands	r0, r1
@   0x08007a70: 2800        cmp	r0, #0
@   0x08007a72: d023        beq.n	0x7abc
@   0x08007a74: 0629        lsls	r1, r5, #24
@   0x08007a76: 1609        asrs	r1, r1, #24
@   0x08007a78: 063a        lsls	r2, r7, #24
@   0x08007a7a: 1612        asrs	r2, r2, #24
@   0x08007a7c: 2008        movs	r0, #8
@   0x08007a7e: f000        ffed 	bl	0x8a5c
@   0x08007a82: 0600        lsls	r0, r0, #24
@   0x08007a84: 2800        cmp	r0, #0
@   0x08007a86: d00b        beq.n	0x7aa0
@   0x08007a88: 4903        ldr	r1, [pc, #12]	@ (0x7a98)
@   0x08007a8a: 2007        movs	r0, #7
@   0x08007a8c: 7688        strb	r0, [r1, #26]
@   0x08007a8e: 2002        movs	r0, #2
@   0x08007a90: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08007a92: 4310        orrs	r0, r2
@   0x08007a94: e00a        b.n	0x7aac
@   0x08007a96: 0000        movs	r0, r0
@   0x08007a98: 3720        adds	r7, #32
@   0x08007a9a: 0300        lsls	r0, r0, #12
@   0x08007a9c: 35e0        adds	r5, #224	@ 0xe0
@   0x08007a9e: 0300        lsls	r0, r0, #12
@   0x08007aa0: 490e        ldr	r1, [pc, #56]	@ (0x7adc)
@   0x08007aa2: 2013        movs	r0, #19
@   0x08007aa4: 7688        strb	r0, [r1, #26]
@   0x08007aa6: 2002        movs	r0, #2
@   0x08007aa8: 8e8b        ldrh	r3, [r1, #52]	@ 0x34
@   0x08007aaa: 4318        orrs	r0, r3
@   0x08007aac: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08007aae: 490c        ldr	r1, [pc, #48]	@ (0x7ae0)
@   0x08007ab0: 2001        movs	r0, #1
@   0x08007ab2: 2200        movs	r2, #0
@   0x08007ab4: 8a0c        ldrh	r4, [r1, #16]
@   0x08007ab6: 4320        orrs	r0, r4
@   0x08007ab8: 8208        strh	r0, [r1, #16]
@   0x08007aba: 824a        strh	r2, [r1, #18]
@   0x08007abc: 2010        movs	r0, #16
@   0x08007abe: 4908        ldr	r1, [pc, #32]	@ (0x7ae0)
@   0x08007ac0: 8a49        ldrh	r1, [r1, #18]
@   0x08007ac2: 4008        ands	r0, r1
@   0x08007ac4: 2800        cmp	r0, #0
@   0x08007ac6: d100        bne.n	0x7aca
@   0x08007ac8: e0f2        b.n	0x7cb0
@   0x08007aca: 4c04        ldr	r4, [pc, #16]	@ (0x7adc)
@   0x08007acc: 7ea0        ldrb	r0, [r4, #26]
@   0x08007ace: 2801        cmp	r0, #1
@   0x08007ad0: d047        beq.n	0x7b62
@   0x08007ad2: 2801        cmp	r0, #1
@   0x08007ad4: dc06        bgt.n	0x7ae4
@   0x08007ad6: 2800        cmp	r0, #0
@   0x08007ad8: d00a        beq.n	0x7af0
@   0x08007ada: e0e1        b.n	0x7ca0
@   0x08007adc: 3720        adds	r7, #32
@   0x08007ade: 0300        lsls	r0, r0, #12
@   0x08007ae0: 35e0        adds	r5, #224	@ 0xe0
@   0x08007ae2: 0300        lsls	r0, r0, #12
@   0x08007ae4: 2802        cmp	r0, #2
@   0x08007ae6: d06c        beq.n	0x7bc2
@   0x08007ae8: 2803        cmp	r0, #3
@   0x08007aea: d100        bne.n	0x7aee
@   0x08007aec: e0a3        b.n	0x7c36
@   0x08007aee: e0d7        b.n	0x7ca0
@   0x08007af0: 4a08        ldr	r2, [pc, #32]	@ (0x7b14)
@   0x08007af2: 2108        movs	r1, #8
@   0x08007af4: 5651        ldrsb	r1, [r2, r1]
@   0x08007af6: 7a92        ldrb	r2, [r2, #10]
@   0x08007af8: 0612        lsls	r2, r2, #24
@   0x08007afa: 1612        asrs	r2, r2, #24
@   0x08007afc: 2001        movs	r0, #1
@   0x08007afe: f001        f9c1 	bl	0x8e84
@   0x08007b02: 2800        cmp	r0, #0
@   0x08007b04: d008        beq.n	0x7b18
@   0x08007b06: 7ea0        ldrb	r0, [r4, #26]
@   0x08007b08: 3010        adds	r0, #16
@   0x08007b0a: 76a0        strb	r0, [r4, #26]
@   0x08007b0c: 2002        movs	r0, #2
@   0x08007b0e: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007b10: 4318        orrs	r0, r3
@   0x08007b12: e0c4        b.n	0x7c9e
@   0x08007b14: 35e0        adds	r5, #224	@ 0xe0
@   0x08007b16: 0300        lsls	r0, r0, #12
@   0x08007b18: 0628        lsls	r0, r5, #24
@   0x08007b1a: 1606        asrs	r6, r0, #24
@   0x08007b1c: 0638        lsls	r0, r7, #24
@   0x08007b1e: 1605        asrs	r5, r0, #24
@   0x08007b20: 2010        movs	r0, #16
@   0x08007b22: 1c31        adds	r1, r6, #0
@   0x08007b24: 1c2a        adds	r2, r5, #0
@   0x08007b26: f000        ff99 	bl	0x8a5c
@   0x08007b2a: 0600        lsls	r0, r0, #24
@   0x08007b2c: 2800        cmp	r0, #0
@   0x08007b2e: d002        beq.n	0x7b36
@   0x08007b30: 7ea0        ldrb	r0, [r4, #26]
@   0x08007b32: 3008        adds	r0, #8
@   0x08007b34: e0af        b.n	0x7c96
@   0x08007b36: 2001        movs	r0, #1
@   0x08007b38: 1c31        adds	r1, r6, #0
@   0x08007b3a: 1c2a        adds	r2, r5, #0
@   0x08007b3c: f000        ff8e 	bl	0x8a5c
@   0x08007b40: 0600        lsls	r0, r0, #24
@   0x08007b42: 2800        cmp	r0, #0
@   0x08007b44: d006        beq.n	0x7b54
@   0x08007b46: 7ea0        ldrb	r0, [r4, #26]
@   0x08007b48: 3004        adds	r0, #4
@   0x08007b4a: 76a0        strb	r0, [r4, #26]
@   0x08007b4c: 2002        movs	r0, #2
@   0x08007b4e: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08007b50: 4310        orrs	r0, r2
@   0x08007b52: e0a4        b.n	0x7c9e
@   0x08007b54: 7ea0        ldrb	r0, [r4, #26]
@   0x08007b56: 3010        adds	r0, #16
@   0x08007b58: 76a0        strb	r0, [r4, #26]
@   0x08007b5a: 2002        movs	r0, #2
@   0x08007b5c: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007b5e: 4318        orrs	r0, r3
@   0x08007b60: e09d        b.n	0x7c9e
@   0x08007b62: 480f        ldr	r0, [pc, #60]	@ (0x7ba0)
@   0x08007b64: 2108        movs	r1, #8
@   0x08007b66: 5641        ldrsb	r1, [r0, r1]
@   0x08007b68: 220a        movs	r2, #10
@   0x08007b6a: 5682        ldrsb	r2, [r0, r2]
@   0x08007b6c: 2002        movs	r0, #2
@   0x08007b6e: f001        f989 	bl	0x8e84
@   0x08007b72: 2800        cmp	r0, #0
@   0x08007b74: d000        beq.n	0x7b78
@   0x08007b76: e08c        b.n	0x7c92
@   0x08007b78: 0628        lsls	r0, r5, #24
@   0x08007b7a: 1606        asrs	r6, r0, #24
@   0x08007b7c: 0638        lsls	r0, r7, #24
@   0x08007b7e: 1605        asrs	r5, r0, #24
@   0x08007b80: 2010        movs	r0, #16
@   0x08007b82: 1c31        adds	r1, r6, #0
@   0x08007b84: 1c2a        adds	r2, r5, #0
@   0x08007b86: f000        ff69 	bl	0x8a5c
@   0x08007b8a: 0600        lsls	r0, r0, #24
@   0x08007b8c: 2800        cmp	r0, #0
@   0x08007b8e: d009        beq.n	0x7ba4
@   0x08007b90: 7ea0        ldrb	r0, [r4, #26]
@   0x08007b92: 3008        adds	r0, #8
@   0x08007b94: 76a0        strb	r0, [r4, #26]
@   0x08007b96: 2002        movs	r0, #2
@   0x08007b98: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08007b9a: 4310        orrs	r0, r2
@   0x08007b9c: e07f        b.n	0x7c9e
@   0x08007b9e: 0000        movs	r0, r0
@   0x08007ba0: 35e0        adds	r5, #224	@ 0xe0
@   0x08007ba2: 0300        lsls	r0, r0, #12
@   0x08007ba4: 2002        movs	r0, #2
@   0x08007ba6: 1c31        adds	r1, r6, #0
@   0x08007ba8: 1c2a        adds	r2, r5, #0
@   0x08007baa: f000        ff57 	bl	0x8a5c
@   0x08007bae: 0600        lsls	r0, r0, #24
@   0x08007bb0: 2800        cmp	r0, #0
@   0x08007bb2: d06e        beq.n	0x7c92
@   0x08007bb4: 7ea0        ldrb	r0, [r4, #26]
@   0x08007bb6: 3004        adds	r0, #4
@   0x08007bb8: 76a0        strb	r0, [r4, #26]
@   0x08007bba: 2002        movs	r0, #2
@   0x08007bbc: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007bbe: 4318        orrs	r0, r3
@   0x08007bc0: e06d        b.n	0x7c9e
@   0x08007bc2: 4a09        ldr	r2, [pc, #36]	@ (0x7be8)
@   0x08007bc4: 2108        movs	r1, #8
@   0x08007bc6: 5651        ldrsb	r1, [r2, r1]
@   0x08007bc8: 7a92        ldrb	r2, [r2, #10]
@   0x08007bca: 0612        lsls	r2, r2, #24
@   0x08007bcc: 1612        asrs	r2, r2, #24
@   0x08007bce: 2004        movs	r0, #4
@   0x08007bd0: f001        f958 	bl	0x8e84
@   0x08007bd4: 2800        cmp	r0, #0
@   0x08007bd6: d009        beq.n	0x7bec
@   0x08007bd8: 7ea0        ldrb	r0, [r4, #26]
@   0x08007bda: 3010        adds	r0, #16
@   0x08007bdc: 76a0        strb	r0, [r4, #26]
@   0x08007bde: 2002        movs	r0, #2
@   0x08007be0: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007be2: 4318        orrs	r0, r3
@   0x08007be4: e05b        b.n	0x7c9e
@   0x08007be6: 0000        movs	r0, r0
@   0x08007be8: 35e0        adds	r5, #224	@ 0xe0
@   0x08007bea: 0300        lsls	r0, r0, #12
@   0x08007bec: 0628        lsls	r0, r5, #24
@   0x08007bee: 1606        asrs	r6, r0, #24
@   0x08007bf0: 0638        lsls	r0, r7, #24
@   0x08007bf2: 1605        asrs	r5, r0, #24
@   0x08007bf4: 2010        movs	r0, #16
@   0x08007bf6: 1c31        adds	r1, r6, #0
@   0x08007bf8: 1c2a        adds	r2, r5, #0
@   0x08007bfa: f000        ff2f 	bl	0x8a5c
@   0x08007bfe: 0600        lsls	r0, r0, #24
@   0x08007c00: 2800        cmp	r0, #0
@   0x08007c02: d002        beq.n	0x7c0a
@   0x08007c04: 7ea0        ldrb	r0, [r4, #26]
@   0x08007c06: 3008        adds	r0, #8
@   0x08007c08: e045        b.n	0x7c96
@   0x08007c0a: 2004        movs	r0, #4
@   0x08007c0c: 1c31        adds	r1, r6, #0
@   0x08007c0e: 1c2a        adds	r2, r5, #0
@   0x08007c10: f000        ff24 	bl	0x8a5c
@   0x08007c14: 0600        lsls	r0, r0, #24
@   0x08007c16: 2800        cmp	r0, #0
@   0x08007c18: d006        beq.n	0x7c28
@   0x08007c1a: 7ea0        ldrb	r0, [r4, #26]
@   0x08007c1c: 3004        adds	r0, #4
@   0x08007c1e: 76a0        strb	r0, [r4, #26]
@   0x08007c20: 2002        movs	r0, #2
@   0x08007c22: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08007c24: 4310        orrs	r0, r2
@   0x08007c26: e03a        b.n	0x7c9e
@   0x08007c28: 7ea0        ldrb	r0, [r4, #26]
@   0x08007c2a: 3010        adds	r0, #16
@   0x08007c2c: 76a0        strb	r0, [r4, #26]
@   0x08007c2e: 2002        movs	r0, #2
@   0x08007c30: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007c32: 4318        orrs	r0, r3
@   0x08007c34: e033        b.n	0x7c9e
@   0x08007c36: 480e        ldr	r0, [pc, #56]	@ (0x7c70)
@   0x08007c38: 2108        movs	r1, #8
@   0x08007c3a: 5641        ldrsb	r1, [r0, r1]
@   0x08007c3c: 220a        movs	r2, #10
@   0x08007c3e: 5682        ldrsb	r2, [r0, r2]
@   0x08007c40: 2008        movs	r0, #8
@   0x08007c42: f001        f91f 	bl	0x8e84
@   0x08007c46: 2800        cmp	r0, #0
@   0x08007c48: d123        bne.n	0x7c92
@   0x08007c4a: 0628        lsls	r0, r5, #24
@   0x08007c4c: 1606        asrs	r6, r0, #24
@   0x08007c4e: 0638        lsls	r0, r7, #24
@   0x08007c50: 1605        asrs	r5, r0, #24
@   0x08007c52: 2010        movs	r0, #16
@   0x08007c54: 1c31        adds	r1, r6, #0
@   0x08007c56: 1c2a        adds	r2, r5, #0
@   0x08007c58: f000        ff00 	bl	0x8a5c
@   0x08007c5c: 0600        lsls	r0, r0, #24
@   0x08007c5e: 2800        cmp	r0, #0
@   0x08007c60: d008        beq.n	0x7c74
@   0x08007c62: 7ea0        ldrb	r0, [r4, #26]
@   0x08007c64: 3008        adds	r0, #8
@   0x08007c66: 76a0        strb	r0, [r4, #26]
@   0x08007c68: 2002        movs	r0, #2
@   0x08007c6a: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08007c6c: 4310        orrs	r0, r2
@   0x08007c6e: e016        b.n	0x7c9e
@   0x08007c70: 35e0        adds	r5, #224	@ 0xe0
@   0x08007c72: 0300        lsls	r0, r0, #12
@   0x08007c74: 2008        movs	r0, #8
@   0x08007c76: 1c31        adds	r1, r6, #0
@   0x08007c78: 1c2a        adds	r2, r5, #0
@   0x08007c7a: f000        feef 	bl	0x8a5c
@   0x08007c7e: 0600        lsls	r0, r0, #24
@   0x08007c80: 2800        cmp	r0, #0
@   0x08007c82: d006        beq.n	0x7c92
@   0x08007c84: 7ea0        ldrb	r0, [r4, #26]
@   0x08007c86: 3004        adds	r0, #4
@   0x08007c88: 76a0        strb	r0, [r4, #26]
@   0x08007c8a: 2002        movs	r0, #2
@   0x08007c8c: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x08007c8e: 4318        orrs	r0, r3
@   0x08007c90: e005        b.n	0x7c9e
@   0x08007c92: 7ea0        ldrb	r0, [r4, #26]
@   0x08007c94: 3010        adds	r0, #16
@   0x08007c96: 76a0        strb	r0, [r4, #26]
@   0x08007c98: 2002        movs	r0, #2
@   0x08007c9a: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08007c9c: 4308        orrs	r0, r1
@   0x08007c9e: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08007ca0: 2001        movs	r0, #1
@   0x08007ca2: 2100        movs	r1, #0
@   0x08007ca4: 4a19        ldr	r2, [pc, #100]	@ (0x7d0c)
@   0x08007ca6: 8a12        ldrh	r2, [r2, #16]
@   0x08007ca8: 4310        orrs	r0, r2
@   0x08007caa: 4b18        ldr	r3, [pc, #96]	@ (0x7d0c)
@   0x08007cac: 8218        strh	r0, [r3, #16]
@   0x08007cae: 8259        strh	r1, [r3, #18]
@   0x08007cb0: 2020        movs	r0, #32
@   0x08007cb2: 4c16        ldr	r4, [pc, #88]	@ (0x7d0c)
@   0x08007cb4: 8a64        ldrh	r4, [r4, #18]
@   0x08007cb6: 4020        ands	r0, r4
@   0x08007cb8: 2800        cmp	r0, #0
@   0x08007cba: d017        beq.n	0x7cec
@   0x08007cbc: 4814        ldr	r0, [pc, #80]	@ (0x7d10)
@   0x08007cbe: 7a80        ldrb	r0, [r0, #10]
@   0x08007cc0: 2807        cmp	r0, #7
@   0x08007cc2: d013        beq.n	0x7cec
@   0x08007cc4: 2808        cmp	r0, #8
@   0x08007cc6: d011        beq.n	0x7cec
@   0x08007cc8: 2809        cmp	r0, #9
@   0x08007cca: d00f        beq.n	0x7cec
@   0x08007ccc: 4911        ldr	r1, [pc, #68]	@ (0x7d14)
@   0x08007cce: 7e88        ldrb	r0, [r1, #26]
@   0x08007cd0: 300c        adds	r0, #12
@   0x08007cd2: 2200        movs	r2, #0
@   0x08007cd4: 7688        strb	r0, [r1, #26]
@   0x08007cd6: 2002        movs	r0, #2
@   0x08007cd8: 8e8b        ldrh	r3, [r1, #52]	@ 0x34
@   0x08007cda: 4318        orrs	r0, r3
@   0x08007cdc: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08007cde: 2001        movs	r0, #1
@   0x08007ce0: 4c0a        ldr	r4, [pc, #40]	@ (0x7d0c)
@   0x08007ce2: 8a24        ldrh	r4, [r4, #16]
@   0x08007ce4: 4320        orrs	r0, r4
@   0x08007ce6: 4909        ldr	r1, [pc, #36]	@ (0x7d0c)
@   0x08007ce8: 8208        strh	r0, [r1, #16]
@   0x08007cea: 824a        strh	r2, [r1, #18]
@   0x08007cec: 2080        movs	r0, #128	@ 0x80
@   0x08007cee: 0040        lsls	r0, r0, #1
@   0x08007cf0: 4a06        ldr	r2, [pc, #24]	@ (0x7d0c)
@   0x08007cf2: 8a52        ldrh	r2, [r2, #18]
@   0x08007cf4: 4010        ands	r0, r2
@   0x08007cf6: 2800        cmp	r0, #0
@   0x08007cf8: d02e        beq.n	0x7d58
@   0x08007cfa: 4a06        ldr	r2, [pc, #24]	@ (0x7d14)
@   0x08007cfc: 7e91        ldrb	r1, [r2, #26]
@   0x08007cfe: 2901        cmp	r1, #1
@   0x08007d00: d012        beq.n	0x7d28
@   0x08007d02: 2901        cmp	r1, #1
@   0x08007d04: dc08        bgt.n	0x7d18
@   0x08007d06: 2900        cmp	r1, #0
@   0x08007d08: d00b        beq.n	0x7d22
@   0x08007d0a: e025        b.n	0x7d58
@   0x08007d0c: 35e0        adds	r5, #224	@ 0xe0
@   0x08007d0e: 0300        lsls	r0, r0, #12
@   0x08007d10: 5330        strh	r0, [r6, r4]
@   0x08007d12: 0300        lsls	r0, r0, #12
@   0x08007d14: 3720        adds	r7, #32
@   0x08007d16: 0300        lsls	r0, r0, #12
@   0x08007d18: 2902        cmp	r1, #2
@   0x08007d1a: d008        beq.n	0x7d2e
@   0x08007d1c: 2903        cmp	r1, #3
@   0x08007d1e: d013        beq.n	0x7d48
@   0x08007d20: e01a        b.n	0x7d58
@   0x08007d22: 2002        movs	r0, #2
@   0x08007d24: 7690        strb	r0, [r2, #26]
@   0x08007d26: e006        b.n	0x7d36
@   0x08007d28: 2100        movs	r1, #0
@   0x08007d2a: 2003        movs	r0, #3
@   0x08007d2c: e001        b.n	0x7d32
@   0x08007d2e: 2100        movs	r1, #0
@   0x08007d30: 2001        movs	r0, #1
@   0x08007d32: 7690        strb	r0, [r2, #26]
@   0x08007d34: 2002        movs	r0, #2
@   0x08007d36: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x08007d38: 4318        orrs	r0, r3
@   0x08007d3a: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08007d3c: 4c01        ldr	r4, [pc, #4]	@ (0x7d44)
@   0x08007d3e: 8261        strh	r1, [r4, #18]
@   0x08007d40: e00a        b.n	0x7d58
@   0x08007d42: 0000        movs	r0, r0
@   0x08007d44: 35e0        adds	r5, #224	@ 0xe0
@   0x08007d46: 0300        lsls	r0, r0, #12
@   0x08007d48: 2000        movs	r0, #0
@   0x08007d4a: 7690        strb	r0, [r2, #26]
@   0x08007d4c: 2102        movs	r1, #2
@   0x08007d4e: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x08007d50: 4319        orrs	r1, r3
@   0x08007d52: 8691        strh	r1, [r2, #52]	@ 0x34
@   0x08007d54: 4c08        ldr	r4, [pc, #32]	@ (0x7d78)
@   0x08007d56: 8260        strh	r0, [r4, #18]
@   0x08007d58: 4b07        ldr	r3, [pc, #28]	@ (0x7d78)
@   0x08007d5a: 2080        movs	r0, #128	@ 0x80
@   0x08007d5c: 0080        lsls	r0, r0, #2
@   0x08007d5e: 8a59        ldrh	r1, [r3, #18]
@   0x08007d60: 4008        ands	r0, r1
@   0x08007d62: 2800        cmp	r0, #0
@   0x08007d64: d02e        beq.n	0x7dc4
@   0x08007d66: 4a05        ldr	r2, [pc, #20]	@ (0x7d7c)
@   0x08007d68: 7e91        ldrb	r1, [r2, #26]
@   0x08007d6a: 2901        cmp	r1, #1
@   0x08007d6c: d011        beq.n	0x7d92
@   0x08007d6e: 2901        cmp	r1, #1
@   0x08007d70: dc06        bgt.n	0x7d80
@   0x08007d72: 2900        cmp	r1, #0
@   0x08007d74: d009        beq.n	0x7d8a
@   0x08007d76: e025        b.n	0x7dc4
@   0x08007d78: 35e0        adds	r5, #224	@ 0xe0
@   0x08007d7a: 0300        lsls	r0, r0, #12
@   0x08007d7c: 3720        adds	r7, #32
@   0x08007d7e: 0300        lsls	r0, r0, #12
@   0x08007d80: 2902        cmp	r1, #2
@   0x08007d82: d00e        beq.n	0x7da2
@   0x08007d84: 2903        cmp	r1, #3
@   0x08007d86: d014        beq.n	0x7db2
@   0x08007d88: e01c        b.n	0x7dc4
@   0x08007d8a: 2003        movs	r0, #3
@   0x08007d8c: 7690        strb	r0, [r2, #26]
@   0x08007d8e: 2002        movs	r0, #2
@   0x08007d90: e002        b.n	0x7d98
@   0x08007d92: 2100        movs	r1, #0
@   0x08007d94: 2002        movs	r0, #2
@   0x08007d96: 7690        strb	r0, [r2, #26]
@   0x08007d98: 8e94        ldrh	r4, [r2, #52]	@ 0x34
@   0x08007d9a: 4320        orrs	r0, r4
@   0x08007d9c: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08007d9e: 8259        strh	r1, [r3, #18]
@   0x08007da0: e010        b.n	0x7dc4
@   0x08007da2: 2000        movs	r0, #0
@   0x08007da4: 7690        strb	r0, [r2, #26]
@   0x08007da6: 2102        movs	r1, #2
@   0x08007da8: 8e94        ldrh	r4, [r2, #52]	@ 0x34
@   0x08007daa: 4321        orrs	r1, r4
@   0x08007dac: 8691        strh	r1, [r2, #52]	@ 0x34
@   0x08007dae: 8258        strh	r0, [r3, #18]
@   0x08007db0: e008        b.n	0x7dc4
@   0x08007db2: 2100        movs	r1, #0
@   0x08007db4: 2001        movs	r0, #1
@   0x08007db6: 7690        strb	r0, [r2, #26]
@   0x08007db8: 2002        movs	r0, #2
@   0x08007dba: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x08007dbc: 4318        orrs	r0, r3
@   0x08007dbe: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08007dc0: 4c02        ldr	r4, [pc, #8]	@ (0x7dcc)
@   0x08007dc2: 8261        strh	r1, [r4, #18]
@   0x08007dc4: bcf0        pop	{r4, r5, r6, r7}
@   0x08007dc6: bc01        pop	{r0}
@   0x08007dc8: 4700        bx	r0
@   0x08007dca: 0000        movs	r0, r0
@   0x08007dcc: 35e0        adds	r5, #224	@ 0xe0
@   0x08007dce: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800793C
sub_0800793C: @ 0x0800793c
        .incbin "frog_us_baserom.gba", 0x793c, 0x494
        thumb_func_end sub_0800793C
