@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08016a40, 0x08017000)  (1472 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8016a40 --end 0x8017000 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08016a40: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08016a42: 4657        mov	r7, sl
@   0x08016a44: 464e        mov	r6, r9
@   0x08016a46: 4645        mov	r5, r8
@   0x08016a48: b4e0        push	{r5, r6, r7}
@   0x08016a4a: b083        sub	sp, #12
@   0x08016a4c: 2001        movs	r0, #1
@   0x08016a4e: 9000        str	r0, [sp, #0]
@   0x08016a50: 2400        movs	r4, #0
@   0x08016a52: 4832        ldr	r0, [pc, #200]	@ (0x16b1c)
@   0x08016a54: 7a80        ldrb	r0, [r0, #10]
@   0x08016a56: 280c        cmp	r0, #12
@   0x08016a58: d101        bne.n	0x16a5e
@   0x08016a5a: f005        fd03 	bl	0x1c464
@   0x08016a5e: f7ff        fdf7 	bl	0x16650
@   0x08016a62: 4e2f        ldr	r6, [pc, #188]	@ (0x16b20)
@   0x08016a64: 482f        ldr	r0, [pc, #188]	@ (0x16b24)
@   0x08016a66: 6887        ldr	r7, [r0, #8]
@   0x08016a68: 2500        movs	r5, #0
@   0x08016a6a: 8840        ldrh	r0, [r0, #2]
@   0x08016a6c: 4284        cmp	r4, r0
@   0x08016a6e: d206        bcs.n	0x16a7e
@   0x08016a70: 1c01        adds	r1, r0, #0
@   0x08016a72: 3640        adds	r6, #64	@ 0x40
@   0x08016a74: 1c68        adds	r0, r5, #1
@   0x08016a76: 0400        lsls	r0, r0, #16
@   0x08016a78: 0c05        lsrs	r5, r0, #16
@   0x08016a7a: 428d        cmp	r5, r1
@   0x08016a7c: d3f9        bcc.n	0x16a72
@   0x08016a7e: 2500        movs	r5, #0
@   0x08016a80: 4828        ldr	r0, [pc, #160]	@ (0x16b24)
@   0x08016a82: 8881        ldrh	r1, [r0, #4]
@   0x08016a84: 4a25        ldr	r2, [pc, #148]	@ (0x16b1c)
@   0x08016a86: 4692        mov	sl, r2
@   0x08016a88: 428d        cmp	r5, r1
@   0x08016a8a: d21e        bcs.n	0x16aca
@   0x08016a8c: 1c02        adds	r2, r0, #0
@   0x08016a8e: 8813        ldrh	r3, [r2, #0]
@   0x08016a90: 005b        lsls	r3, r3, #1
@   0x08016a92: 4699        mov	r9, r3
@   0x08016a94: 88d4        ldrh	r4, [r2, #6]
@   0x08016a96: 46a0        mov	r8, r4
@   0x08016a98: 1c0b        adds	r3, r1, #0
@   0x08016a9a: 444e        add	r6, r9
@   0x08016a9c: 2400        movs	r4, #0
@   0x08016a9e: 3501        adds	r5, #1
@   0x08016aa0: 4544        cmp	r4, r8
@   0x08016aa2: d209        bcs.n	0x16ab8
@   0x08016aa4: 88d1        ldrh	r1, [r2, #6]
@   0x08016aa6: 8838        ldrh	r0, [r7, #0]
@   0x08016aa8: 8030        strh	r0, [r6, #0]
@   0x08016aaa: 3702        adds	r7, #2
@   0x08016aac: 3602        adds	r6, #2
@   0x08016aae: 1c60        adds	r0, r4, #1
@   0x08016ab0: 0400        lsls	r0, r0, #16
@   0x08016ab2: 0c04        lsrs	r4, r0, #16
@   0x08016ab4: 428c        cmp	r4, r1
@   0x08016ab6: d3f6        bcc.n	0x16aa6
@   0x08016ab8: 2020        movs	r0, #32
@   0x08016aba: 88d1        ldrh	r1, [r2, #6]
@   0x08016abc: 1a40        subs	r0, r0, r1
@   0x08016abe: 0040        lsls	r0, r0, #1
@   0x08016ac0: 1836        adds	r6, r6, r0
@   0x08016ac2: 0428        lsls	r0, r5, #16
@   0x08016ac4: 0c05        lsrs	r5, r0, #16
@   0x08016ac6: 429d        cmp	r5, r3
@   0x08016ac8: d3e7        bcc.n	0x16a9a
@   0x08016aca: 2001        movs	r0, #1
@   0x08016acc: 4652        mov	r2, sl
@   0x08016ace: 7c12        ldrb	r2, [r2, #16]
@   0x08016ad0: 4010        ands	r0, r2
@   0x08016ad2: 2800        cmp	r0, #0
@   0x08016ad4: d000        beq.n	0x16ad8
@   0x08016ad6: e0ad        b.n	0x16c34
@   0x08016ad8: 4813        ldr	r0, [pc, #76]	@ (0x16b28)
@   0x08016ada: 2100        movs	r1, #0
@   0x08016adc: 5641        ldrsb	r1, [r0, r1]
@   0x08016ade: 2963        cmp	r1, #99	@ 0x63
@   0x08016ae0: dd02        ble.n	0x16ae8
@   0x08016ae2: 2063        movs	r0, #99	@ 0x63
@   0x08016ae4: 4b10        ldr	r3, [pc, #64]	@ (0x16b28)
@   0x08016ae6: 7018        strb	r0, [r3, #0]
@   0x08016ae8: 4e0d        ldr	r6, [pc, #52]	@ (0x16b20)
@   0x08016aea: 4c0f        ldr	r4, [pc, #60]	@ (0x16b28)
@   0x08016aec: 2000        movs	r0, #0
@   0x08016aee: 5620        ldrsb	r0, [r4, r0]
@   0x08016af0: 3801        subs	r0, #1
@   0x08016af2: 210a        movs	r1, #10
@   0x08016af4: f01d        f90e 	bl	0x33d14
@   0x08016af8: 300e        adds	r0, #14
@   0x08016afa: 0041        lsls	r1, r0, #1
@   0x08016afc: 1809        adds	r1, r1, r0
@   0x08016afe: 0089        lsls	r1, r1, #2
@   0x08016b00: 4808        ldr	r0, [pc, #32]	@ (0x16b24)
@   0x08016b02: 3008        adds	r0, #8
@   0x08016b04: 1809        adds	r1, r1, r0
@   0x08016b06: 680f        ldr	r7, [r1, #0]
@   0x08016b08: 2500        movs	r5, #0
@   0x08016b0a: 3640        adds	r6, #64	@ 0x40
@   0x08016b0c: 1c68        adds	r0, r5, #1
@   0x08016b0e: 0400        lsls	r0, r0, #16
@   0x08016b10: 0c05        lsrs	r5, r0, #16
@   0x08016b12: 2d01        cmp	r5, #1
@   0x08016b14: d9f9        bls.n	0x16b0a
@   0x08016b16: 2500        movs	r5, #0
@   0x08016b18: e029        b.n	0x16b6e
@   0x08016b1a: 0000        movs	r0, r0
@   0x08016b1c: 5330        strh	r0, [r6, r4]
@   0x08016b1e: 0300        lsls	r0, r0, #12
@   0x08016b20: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08016b24: 3628        adds	r6, #40	@ 0x28
@   0x08016b26: 080e        lsrs	r6, r1, #32
@   0x08016b28: 35e0        adds	r5, #224	@ 0xe0
@   0x08016b2a: 0300        lsls	r0, r0, #12
@   0x08016b2c: 3606        adds	r6, #6
@   0x08016b2e: 2400        movs	r4, #0
@   0x08016b30: e006        b.n	0x16b40
@   0x08016b32: 8838        ldrh	r0, [r7, #0]
@   0x08016b34: 8030        strh	r0, [r6, #0]
@   0x08016b36: 3702        adds	r7, #2
@   0x08016b38: 3602        adds	r6, #2
@   0x08016b3a: 1c60        adds	r0, r4, #1
@   0x08016b3c: 0400        lsls	r0, r0, #16
@   0x08016b3e: 0c04        lsrs	r4, r0, #16
@   0x08016b40: 491e        ldr	r1, [pc, #120]	@ (0x16bbc)
@   0x08016b42: 2000        movs	r0, #0
@   0x08016b44: 5608        ldrsb	r0, [r1, r0]
@   0x08016b46: 3801        subs	r0, #1
@   0x08016b48: 210a        movs	r1, #10
@   0x08016b4a: f01d        f8e3 	bl	0x33d14
@   0x08016b4e: 300e        adds	r0, #14
@   0x08016b50: 0041        lsls	r1, r0, #1
@   0x08016b52: 1809        adds	r1, r1, r0
@   0x08016b54: 0089        lsls	r1, r1, #2
@   0x08016b56: 4a1a        ldr	r2, [pc, #104]	@ (0x16bc0)
@   0x08016b58: 1889        adds	r1, r1, r2
@   0x08016b5a: 88cb        ldrh	r3, [r1, #6]
@   0x08016b5c: 429c        cmp	r4, r3
@   0x08016b5e: d3e8        bcc.n	0x16b32
@   0x08016b60: 201d        movs	r0, #29
@   0x08016b62: 1ac0        subs	r0, r0, r3
@   0x08016b64: 0040        lsls	r0, r0, #1
@   0x08016b66: 1836        adds	r6, r6, r0
@   0x08016b68: 1c68        adds	r0, r5, #1
@   0x08016b6a: 0400        lsls	r0, r0, #16
@   0x08016b6c: 0c05        lsrs	r5, r0, #16
@   0x08016b6e: 4c13        ldr	r4, [pc, #76]	@ (0x16bbc)
@   0x08016b70: 2000        movs	r0, #0
@   0x08016b72: 5620        ldrsb	r0, [r4, r0]
@   0x08016b74: 1e44        subs	r4, r0, #1
@   0x08016b76: 1c20        adds	r0, r4, #0
@   0x08016b78: 210a        movs	r1, #10
@   0x08016b7a: f01d        f8cb 	bl	0x33d14
@   0x08016b7e: 300e        adds	r0, #14
@   0x08016b80: 0041        lsls	r1, r0, #1
@   0x08016b82: 1809        adds	r1, r1, r0
@   0x08016b84: 0089        lsls	r1, r1, #2
@   0x08016b86: 480e        ldr	r0, [pc, #56]	@ (0x16bc0)
@   0x08016b88: 1809        adds	r1, r1, r0
@   0x08016b8a: 8889        ldrh	r1, [r1, #4]
@   0x08016b8c: 428d        cmp	r5, r1
@   0x08016b8e: d3cd        bcc.n	0x16b2c
@   0x08016b90: 4e0c        ldr	r6, [pc, #48]	@ (0x16bc4)
@   0x08016b92: 1c20        adds	r0, r4, #0
@   0x08016b94: 210a        movs	r1, #10
@   0x08016b96: f01d        f93d 	bl	0x33e14
@   0x08016b9a: 300e        adds	r0, #14
@   0x08016b9c: 0041        lsls	r1, r0, #1
@   0x08016b9e: 1809        adds	r1, r1, r0
@   0x08016ba0: 0089        lsls	r1, r1, #2
@   0x08016ba2: 4807        ldr	r0, [pc, #28]	@ (0x16bc0)
@   0x08016ba4: 3008        adds	r0, #8
@   0x08016ba6: 1809        adds	r1, r1, r0
@   0x08016ba8: 680f        ldr	r7, [r1, #0]
@   0x08016baa: 2500        movs	r5, #0
@   0x08016bac: 3640        adds	r6, #64	@ 0x40
@   0x08016bae: 1c68        adds	r0, r5, #1
@   0x08016bb0: 0400        lsls	r0, r0, #16
@   0x08016bb2: 0c05        lsrs	r5, r0, #16
@   0x08016bb4: 2d01        cmp	r5, #1
@   0x08016bb6: d9f9        bls.n	0x16bac
@   0x08016bb8: 2500        movs	r5, #0
@   0x08016bba: e026        b.n	0x16c0a
@   0x08016bbc: 35e0        adds	r5, #224	@ 0xe0
@   0x08016bbe: 0300        lsls	r0, r0, #12
@   0x08016bc0: 3628        adds	r6, #40	@ 0x28
@   0x08016bc2: 080e        lsrs	r6, r1, #32
@   0x08016bc4: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08016bc8: 3608        adds	r6, #8
@   0x08016bca: 2400        movs	r4, #0
@   0x08016bcc: 3501        adds	r5, #1
@   0x08016bce: e006        b.n	0x16bde
@   0x08016bd0: 8838        ldrh	r0, [r7, #0]
@   0x08016bd2: 8030        strh	r0, [r6, #0]
@   0x08016bd4: 3702        adds	r7, #2
@   0x08016bd6: 3602        adds	r6, #2
@   0x08016bd8: 1c60        adds	r0, r4, #1
@   0x08016bda: 0400        lsls	r0, r0, #16
@   0x08016bdc: 0c04        lsrs	r4, r0, #16
@   0x08016bde: 4913        ldr	r1, [pc, #76]	@ (0x16c2c)
@   0x08016be0: 2000        movs	r0, #0
@   0x08016be2: 5608        ldrsb	r0, [r1, r0]
@   0x08016be4: 3801        subs	r0, #1
@   0x08016be6: 210a        movs	r1, #10
@   0x08016be8: f01d        f914 	bl	0x33e14
@   0x08016bec: 300e        adds	r0, #14
@   0x08016bee: 0041        lsls	r1, r0, #1
@   0x08016bf0: 1809        adds	r1, r1, r0
@   0x08016bf2: 0089        lsls	r1, r1, #2
@   0x08016bf4: 4a0e        ldr	r2, [pc, #56]	@ (0x16c30)
@   0x08016bf6: 1889        adds	r1, r1, r2
@   0x08016bf8: 88cb        ldrh	r3, [r1, #6]
@   0x08016bfa: 429c        cmp	r4, r3
@   0x08016bfc: d3e8        bcc.n	0x16bd0
@   0x08016bfe: 201c        movs	r0, #28
@   0x08016c00: 1ac0        subs	r0, r0, r3
@   0x08016c02: 0040        lsls	r0, r0, #1
@   0x08016c04: 1836        adds	r6, r6, r0
@   0x08016c06: 0428        lsls	r0, r5, #16
@   0x08016c08: 0c05        lsrs	r5, r0, #16
@   0x08016c0a: 4c08        ldr	r4, [pc, #32]	@ (0x16c2c)
@   0x08016c0c: 2000        movs	r0, #0
@   0x08016c0e: 5620        ldrsb	r0, [r4, r0]
@   0x08016c10: 3801        subs	r0, #1
@   0x08016c12: 210a        movs	r1, #10
@   0x08016c14: f01d        f8fe 	bl	0x33e14
@   0x08016c18: 300e        adds	r0, #14
@   0x08016c1a: 0041        lsls	r1, r0, #1
@   0x08016c1c: 1809        adds	r1, r1, r0
@   0x08016c1e: 0089        lsls	r1, r1, #2
@   0x08016c20: 4803        ldr	r0, [pc, #12]	@ (0x16c30)
@   0x08016c22: 1809        adds	r1, r1, r0
@   0x08016c24: 8889        ldrh	r1, [r1, #4]
@   0x08016c26: 428d        cmp	r5, r1
@   0x08016c28: d3ce        bcc.n	0x16bc8
@   0x08016c2a: e005        b.n	0x16c38
@   0x08016c2c: 35e0        adds	r5, #224	@ 0xe0
@   0x08016c2e: 0300        lsls	r0, r0, #12
@   0x08016c30: 3628        adds	r6, #40	@ 0x28
@   0x08016c32: 080e        lsrs	r6, r1, #32
@   0x08016c34: f7ff        fec2 	bl	0x169bc
@   0x08016c38: 482c        ldr	r0, [pc, #176]	@ (0x16cec)
@   0x08016c3a: 4682        mov	sl, r0
@   0x08016c3c: 7a81        ldrb	r1, [r0, #10]
@   0x08016c3e: 2903        cmp	r1, #3
@   0x08016c40: d100        bne.n	0x16c44
@   0x08016c42: e1c8        b.n	0x16fd6
@   0x08016c44: 4e2a        ldr	r6, [pc, #168]	@ (0x16cf0)
@   0x08016c46: 482b        ldr	r0, [pc, #172]	@ (0x16cf4)
@   0x08016c48: 6947        ldr	r7, [r0, #20]
@   0x08016c4a: 2500        movs	r5, #0
@   0x08016c4c: 89c1        ldrh	r1, [r0, #14]
@   0x08016c4e: 428d        cmp	r5, r1
@   0x08016c50: d205        bcs.n	0x16c5e
@   0x08016c52: 3640        adds	r6, #64	@ 0x40
@   0x08016c54: 1c68        adds	r0, r5, #1
@   0x08016c56: 0400        lsls	r0, r0, #16
@   0x08016c58: 0c05        lsrs	r5, r0, #16
@   0x08016c5a: 428d        cmp	r5, r1
@   0x08016c5c: d3f9        bcc.n	0x16c52
@   0x08016c5e: 2500        movs	r5, #0
@   0x08016c60: 4a24        ldr	r2, [pc, #144]	@ (0x16cf4)
@   0x08016c62: 8a10        ldrh	r0, [r2, #16]
@   0x08016c64: 4285        cmp	r5, r0
@   0x08016c66: d21f        bcs.n	0x16ca8
@   0x08016c68: 8993        ldrh	r3, [r2, #12]
@   0x08016c6a: 005b        lsls	r3, r3, #1
@   0x08016c6c: 4699        mov	r9, r3
@   0x08016c6e: 8a54        ldrh	r4, [r2, #18]
@   0x08016c70: 46a0        mov	r8, r4
@   0x08016c72: 1c03        adds	r3, r0, #0
@   0x08016c74: 444e        add	r6, r9
@   0x08016c76: 2400        movs	r4, #0
@   0x08016c78: 4544        cmp	r4, r8
@   0x08016c7a: d209        bcs.n	0x16c90
@   0x08016c7c: 8a51        ldrh	r1, [r2, #18]
@   0x08016c7e: 8838        ldrh	r0, [r7, #0]
@   0x08016c80: 8030        strh	r0, [r6, #0]
@   0x08016c82: 3702        adds	r7, #2
@   0x08016c84: 3602        adds	r6, #2
@   0x08016c86: 1c60        adds	r0, r4, #1
@   0x08016c88: 0400        lsls	r0, r0, #16
@   0x08016c8a: 0c04        lsrs	r4, r0, #16
@   0x08016c8c: 428c        cmp	r4, r1
@   0x08016c8e: d3f6        bcc.n	0x16c7e
@   0x08016c90: 2020        movs	r0, #32
@   0x08016c92: 8991        ldrh	r1, [r2, #12]
@   0x08016c94: 1a40        subs	r0, r0, r1
@   0x08016c96: 8a54        ldrh	r4, [r2, #18]
@   0x08016c98: 1b00        subs	r0, r0, r4
@   0x08016c9a: 0040        lsls	r0, r0, #1
@   0x08016c9c: 1836        adds	r6, r6, r0
@   0x08016c9e: 1c68        adds	r0, r5, #1
@   0x08016ca0: 0400        lsls	r0, r0, #16
@   0x08016ca2: 0c05        lsrs	r5, r0, #16
@   0x08016ca4: 429d        cmp	r5, r3
@   0x08016ca6: d3e5        bcc.n	0x16c74
@   0x08016ca8: 4913        ldr	r1, [pc, #76]	@ (0x16cf8)
@   0x08016caa: 2202        movs	r2, #2
@   0x08016cac: 5e88        ldrsh	r0, [r1, r2]
@   0x08016cae: 4913        ldr	r1, [pc, #76]	@ (0x16cfc)
@   0x08016cb0: 4288        cmp	r0, r1
@   0x08016cb2: dd01        ble.n	0x16cb8
@   0x08016cb4: 4b10        ldr	r3, [pc, #64]	@ (0x16cf8)
@   0x08016cb6: 8059        strh	r1, [r3, #2]
@   0x08016cb8: 4e0d        ldr	r6, [pc, #52]	@ (0x16cf0)
@   0x08016cba: 4c0f        ldr	r4, [pc, #60]	@ (0x16cf8)
@   0x08016cbc: 2102        movs	r1, #2
@   0x08016cbe: 5e60        ldrsh	r0, [r4, r1]
@   0x08016cc0: 2164        movs	r1, #100	@ 0x64
@   0x08016cc2: f01d        f827 	bl	0x33d14
@   0x08016cc6: 0400        lsls	r0, r0, #16
@   0x08016cc8: 1400        asrs	r0, r0, #16
@   0x08016cca: 300e        adds	r0, #14
@   0x08016ccc: 0041        lsls	r1, r0, #1
@   0x08016cce: 1809        adds	r1, r1, r0
@   0x08016cd0: 0089        lsls	r1, r1, #2
@   0x08016cd2: 4808        ldr	r0, [pc, #32]	@ (0x16cf4)
@   0x08016cd4: 3008        adds	r0, #8
@   0x08016cd6: 1809        adds	r1, r1, r0
@   0x08016cd8: 680f        ldr	r7, [r1, #0]
@   0x08016cda: 2500        movs	r5, #0
@   0x08016cdc: 3640        adds	r6, #64	@ 0x40
@   0x08016cde: 1c68        adds	r0, r5, #1
@   0x08016ce0: 0400        lsls	r0, r0, #16
@   0x08016ce2: 0c05        lsrs	r5, r0, #16
@   0x08016ce4: 2d01        cmp	r5, #1
@   0x08016ce6: d9f9        bls.n	0x16cdc
@   0x08016ce8: 2500        movs	r5, #0
@   0x08016cea: e02b        b.n	0x16d44
@   0x08016cec: 5330        strh	r0, [r6, r4]
@   0x08016cee: 0300        lsls	r0, r0, #12
@   0x08016cf0: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08016cf4: 3628        adds	r6, #40	@ 0x28
@   0x08016cf6: 080e        lsrs	r6, r1, #32
@   0x08016cf8: 35e0        adds	r5, #224	@ 0xe0
@   0x08016cfa: 0300        lsls	r0, r0, #12
@   0x08016cfc: 03e7        lsls	r7, r4, #15
@   0x08016cfe: 0000        movs	r0, r0
@   0x08016d00: 3636        adds	r6, #54	@ 0x36
@   0x08016d02: 2400        movs	r4, #0
@   0x08016d04: e006        b.n	0x16d14
@   0x08016d06: 8838        ldrh	r0, [r7, #0]
@   0x08016d08: 8030        strh	r0, [r6, #0]
@   0x08016d0a: 3702        adds	r7, #2
@   0x08016d0c: 3602        adds	r6, #2
@   0x08016d0e: 1c60        adds	r0, r4, #1
@   0x08016d10: 0400        lsls	r0, r0, #16
@   0x08016d12: 0c04        lsrs	r4, r0, #16
@   0x08016d14: 4a23        ldr	r2, [pc, #140]	@ (0x16da4)
@   0x08016d16: 2302        movs	r3, #2
@   0x08016d18: 5ed0        ldrsh	r0, [r2, r3]
@   0x08016d1a: 2164        movs	r1, #100	@ 0x64
@   0x08016d1c: f01c        fffa 	bl	0x33d14
@   0x08016d20: 0400        lsls	r0, r0, #16
@   0x08016d22: 1400        asrs	r0, r0, #16
@   0x08016d24: 300e        adds	r0, #14
@   0x08016d26: 0041        lsls	r1, r0, #1
@   0x08016d28: 1809        adds	r1, r1, r0
@   0x08016d2a: 0089        lsls	r1, r1, #2
@   0x08016d2c: 481e        ldr	r0, [pc, #120]	@ (0x16da8)
@   0x08016d2e: 1809        adds	r1, r1, r0
@   0x08016d30: 88ca        ldrh	r2, [r1, #6]
@   0x08016d32: 4294        cmp	r4, r2
@   0x08016d34: d3e7        bcc.n	0x16d06
@   0x08016d36: 2005        movs	r0, #5
@   0x08016d38: 1a80        subs	r0, r0, r2
@   0x08016d3a: 0040        lsls	r0, r0, #1
@   0x08016d3c: 1836        adds	r6, r6, r0
@   0x08016d3e: 1c68        adds	r0, r5, #1
@   0x08016d40: 0400        lsls	r0, r0, #16
@   0x08016d42: 0c05        lsrs	r5, r0, #16
@   0x08016d44: 4b17        ldr	r3, [pc, #92]	@ (0x16da4)
@   0x08016d46: 2002        movs	r0, #2
@   0x08016d48: 5e1c        ldrsh	r4, [r3, r0]
@   0x08016d4a: 1c20        adds	r0, r4, #0
@   0x08016d4c: 2164        movs	r1, #100	@ 0x64
@   0x08016d4e: f01c        ffe1 	bl	0x33d14
@   0x08016d52: 0400        lsls	r0, r0, #16
@   0x08016d54: 1400        asrs	r0, r0, #16
@   0x08016d56: 300e        adds	r0, #14
@   0x08016d58: 0041        lsls	r1, r0, #1
@   0x08016d5a: 1809        adds	r1, r1, r0
@   0x08016d5c: 0089        lsls	r1, r1, #2
@   0x08016d5e: 4a12        ldr	r2, [pc, #72]	@ (0x16da8)
@   0x08016d60: 1889        adds	r1, r1, r2
@   0x08016d62: 8889        ldrh	r1, [r1, #4]
@   0x08016d64: 428d        cmp	r5, r1
@   0x08016d66: d3cb        bcc.n	0x16d00
@   0x08016d68: 4e10        ldr	r6, [pc, #64]	@ (0x16dac)
@   0x08016d6a: 1c20        adds	r0, r4, #0
@   0x08016d6c: 210a        movs	r1, #10
@   0x08016d6e: f01c        ffd1 	bl	0x33d14
@   0x08016d72: 0400        lsls	r0, r0, #16
@   0x08016d74: 1400        asrs	r0, r0, #16
@   0x08016d76: 210a        movs	r1, #10
@   0x08016d78: f01d        f84c 	bl	0x33e14
@   0x08016d7c: 0400        lsls	r0, r0, #16
@   0x08016d7e: 1400        asrs	r0, r0, #16
@   0x08016d80: 300e        adds	r0, #14
@   0x08016d82: 0041        lsls	r1, r0, #1
@   0x08016d84: 1809        adds	r1, r1, r0
@   0x08016d86: 0089        lsls	r1, r1, #2
@   0x08016d88: 4807        ldr	r0, [pc, #28]	@ (0x16da8)
@   0x08016d8a: 3008        adds	r0, #8
@   0x08016d8c: 1809        adds	r1, r1, r0
@   0x08016d8e: 680f        ldr	r7, [r1, #0]
@   0x08016d90: 2500        movs	r5, #0
@   0x08016d92: 3640        adds	r6, #64	@ 0x40
@   0x08016d94: 1c68        adds	r0, r5, #1
@   0x08016d96: 0400        lsls	r0, r0, #16
@   0x08016d98: 0c05        lsrs	r5, r0, #16
@   0x08016d9a: 2d01        cmp	r5, #1
@   0x08016d9c: d9f9        bls.n	0x16d92
@   0x08016d9e: 2500        movs	r5, #0
@   0x08016da0: e02d        b.n	0x16dfe
@   0x08016da2: 0000        movs	r0, r0
@   0x08016da4: 35e0        adds	r5, #224	@ 0xe0
@   0x08016da6: 0300        lsls	r0, r0, #12
@   0x08016da8: 3628        adds	r6, #40	@ 0x28
@   0x08016daa: 080e        lsrs	r6, r1, #32
@   0x08016dac: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08016db0: 3638        adds	r6, #56	@ 0x38
@   0x08016db2: 2400        movs	r4, #0
@   0x08016db4: e006        b.n	0x16dc4
@   0x08016db6: 8838        ldrh	r0, [r7, #0]
@   0x08016db8: 8030        strh	r0, [r6, #0]
@   0x08016dba: 3702        adds	r7, #2
@   0x08016dbc: 3602        adds	r6, #2
@   0x08016dbe: 1c60        adds	r0, r4, #1
@   0x08016dc0: 0400        lsls	r0, r0, #16
@   0x08016dc2: 0c04        lsrs	r4, r0, #16
@   0x08016dc4: 4b25        ldr	r3, [pc, #148]	@ (0x16e5c)
@   0x08016dc6: 2102        movs	r1, #2
@   0x08016dc8: 5e58        ldrsh	r0, [r3, r1]
@   0x08016dca: 210a        movs	r1, #10
@   0x08016dcc: f01c        ffa2 	bl	0x33d14
@   0x08016dd0: 0400        lsls	r0, r0, #16
@   0x08016dd2: 1400        asrs	r0, r0, #16
@   0x08016dd4: 210a        movs	r1, #10
@   0x08016dd6: f01d        f81d 	bl	0x33e14
@   0x08016dda: 0400        lsls	r0, r0, #16
@   0x08016ddc: 1400        asrs	r0, r0, #16
@   0x08016dde: 300e        adds	r0, #14
@   0x08016de0: 0041        lsls	r1, r0, #1
@   0x08016de2: 1809        adds	r1, r1, r0
@   0x08016de4: 0089        lsls	r1, r1, #2
@   0x08016de6: 4a1e        ldr	r2, [pc, #120]	@ (0x16e60)
@   0x08016de8: 1889        adds	r1, r1, r2
@   0x08016dea: 88cb        ldrh	r3, [r1, #6]
@   0x08016dec: 429c        cmp	r4, r3
@   0x08016dee: d3e2        bcc.n	0x16db6
@   0x08016df0: 2004        movs	r0, #4
@   0x08016df2: 1ac0        subs	r0, r0, r3
@   0x08016df4: 0040        lsls	r0, r0, #1
@   0x08016df6: 1836        adds	r6, r6, r0
@   0x08016df8: 1c68        adds	r0, r5, #1
@   0x08016dfa: 0400        lsls	r0, r0, #16
@   0x08016dfc: 0c05        lsrs	r5, r0, #16
@   0x08016dfe: 4817        ldr	r0, [pc, #92]	@ (0x16e5c)
@   0x08016e00: 2102        movs	r1, #2
@   0x08016e02: 5e44        ldrsh	r4, [r0, r1]
@   0x08016e04: 1c20        adds	r0, r4, #0
@   0x08016e06: 210a        movs	r1, #10
@   0x08016e08: f01c        ff84 	bl	0x33d14
@   0x08016e0c: 0400        lsls	r0, r0, #16
@   0x08016e0e: 1400        asrs	r0, r0, #16
@   0x08016e10: 210a        movs	r1, #10
@   0x08016e12: f01c        ffff 	bl	0x33e14
@   0x08016e16: 0400        lsls	r0, r0, #16
@   0x08016e18: 1400        asrs	r0, r0, #16
@   0x08016e1a: 300e        adds	r0, #14
@   0x08016e1c: 0041        lsls	r1, r0, #1
@   0x08016e1e: 1809        adds	r1, r1, r0
@   0x08016e20: 0089        lsls	r1, r1, #2
@   0x08016e22: 4a0f        ldr	r2, [pc, #60]	@ (0x16e60)
@   0x08016e24: 1889        adds	r1, r1, r2
@   0x08016e26: 8889        ldrh	r1, [r1, #4]
@   0x08016e28: 428d        cmp	r5, r1
@   0x08016e2a: d3c1        bcc.n	0x16db0
@   0x08016e2c: 4e0d        ldr	r6, [pc, #52]	@ (0x16e64)
@   0x08016e2e: 1c20        adds	r0, r4, #0
@   0x08016e30: 210a        movs	r1, #10
@   0x08016e32: f01c        ffef 	bl	0x33e14
@   0x08016e36: 0400        lsls	r0, r0, #16
@   0x08016e38: 1400        asrs	r0, r0, #16
@   0x08016e3a: 300e        adds	r0, #14
@   0x08016e3c: 0041        lsls	r1, r0, #1
@   0x08016e3e: 1809        adds	r1, r1, r0
@   0x08016e40: 0089        lsls	r1, r1, #2
@   0x08016e42: 4807        ldr	r0, [pc, #28]	@ (0x16e60)
@   0x08016e44: 3008        adds	r0, #8
@   0x08016e46: 1809        adds	r1, r1, r0
@   0x08016e48: 680f        ldr	r7, [r1, #0]
@   0x08016e4a: 2500        movs	r5, #0
@   0x08016e4c: 3640        adds	r6, #64	@ 0x40
@   0x08016e4e: 1c68        adds	r0, r5, #1
@   0x08016e50: 0400        lsls	r0, r0, #16
@   0x08016e52: 0c05        lsrs	r5, r0, #16
@   0x08016e54: 2d01        cmp	r5, #1
@   0x08016e56: d9f9        bls.n	0x16e4c
@   0x08016e58: 2500        movs	r5, #0
@   0x08016e5a: e027        b.n	0x16eac
@   0x08016e5c: 35e0        adds	r5, #224	@ 0xe0
@   0x08016e5e: 0300        lsls	r0, r0, #12
@   0x08016e60: 3628        adds	r6, #40	@ 0x28
@   0x08016e62: 080e        lsrs	r6, r1, #32
@   0x08016e64: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08016e68: 363a        adds	r6, #58	@ 0x3a
@   0x08016e6a: 2400        movs	r4, #0
@   0x08016e6c: 3501        adds	r5, #1
@   0x08016e6e: e006        b.n	0x16e7e
@   0x08016e70: 8838        ldrh	r0, [r7, #0]
@   0x08016e72: 8030        strh	r0, [r6, #0]
@   0x08016e74: 3702        adds	r7, #2
@   0x08016e76: 3602        adds	r6, #2
@   0x08016e78: 1c60        adds	r0, r4, #1
@   0x08016e7a: 0400        lsls	r0, r0, #16
@   0x08016e7c: 0c04        lsrs	r4, r0, #16
@   0x08016e7e: 4b1a        ldr	r3, [pc, #104]	@ (0x16ee8)
@   0x08016e80: 2102        movs	r1, #2
@   0x08016e82: 5e58        ldrsh	r0, [r3, r1]
@   0x08016e84: 210a        movs	r1, #10
@   0x08016e86: f01c        ffc5 	bl	0x33e14
@   0x08016e8a: 0400        lsls	r0, r0, #16
@   0x08016e8c: 1400        asrs	r0, r0, #16
@   0x08016e8e: 300e        adds	r0, #14
@   0x08016e90: 0041        lsls	r1, r0, #1
@   0x08016e92: 1809        adds	r1, r1, r0
@   0x08016e94: 0089        lsls	r1, r1, #2
@   0x08016e96: 4a15        ldr	r2, [pc, #84]	@ (0x16eec)
@   0x08016e98: 1889        adds	r1, r1, r2
@   0x08016e9a: 88cb        ldrh	r3, [r1, #6]
@   0x08016e9c: 429c        cmp	r4, r3
@   0x08016e9e: d3e7        bcc.n	0x16e70
@   0x08016ea0: 2003        movs	r0, #3
@   0x08016ea2: 1ac0        subs	r0, r0, r3
@   0x08016ea4: 0040        lsls	r0, r0, #1
@   0x08016ea6: 1836        adds	r6, r6, r0
@   0x08016ea8: 0428        lsls	r0, r5, #16
@   0x08016eaa: 0c05        lsrs	r5, r0, #16
@   0x08016eac: 4c0e        ldr	r4, [pc, #56]	@ (0x16ee8)
@   0x08016eae: 2102        movs	r1, #2
@   0x08016eb0: 5e60        ldrsh	r0, [r4, r1]
@   0x08016eb2: 210a        movs	r1, #10
@   0x08016eb4: f01c        ffae 	bl	0x33e14
@   0x08016eb8: 0400        lsls	r0, r0, #16
@   0x08016eba: 1400        asrs	r0, r0, #16
@   0x08016ebc: 300e        adds	r0, #14
@   0x08016ebe: 0041        lsls	r1, r0, #1
@   0x08016ec0: 1809        adds	r1, r1, r0
@   0x08016ec2: 0089        lsls	r1, r1, #2
@   0x08016ec4: 4a09        ldr	r2, [pc, #36]	@ (0x16eec)
@   0x08016ec6: 1889        adds	r1, r1, r2
@   0x08016ec8: 8889        ldrh	r1, [r1, #4]
@   0x08016eca: 428d        cmp	r5, r1
@   0x08016ecc: d3cc        bcc.n	0x16e68
@   0x08016ece: 2004        movs	r0, #4
@   0x08016ed0: 5620        ldrsb	r0, [r4, r0]
@   0x08016ed2: 4b07        ldr	r3, [pc, #28]	@ (0x16ef0)
@   0x08016ed4: 789b        ldrb	r3, [r3, #2]
@   0x08016ed6: 4298        cmp	r0, r3
@   0x08016ed8: db0c        blt.n	0x16ef4
@   0x08016eda: 4654        mov	r4, sl
@   0x08016edc: 7aa4        ldrb	r4, [r4, #10]
@   0x08016ede: 2c0f        cmp	r4, #15
@   0x08016ee0: d008        beq.n	0x16ef4
@   0x08016ee2: f7ff        fcdd 	bl	0x168a0
@   0x08016ee6: e076        b.n	0x16fd6
@   0x08016ee8: 35e0        adds	r5, #224	@ 0xe0
@   0x08016eea: 0300        lsls	r0, r0, #12
@   0x08016eec: 3628        adds	r6, #40	@ 0x28
@   0x08016eee: 080e        lsrs	r6, r1, #32
@   0x08016ef0: 6110        str	r0, [r2, #16]
@   0x08016ef2: 0300        lsls	r0, r0, #12
@   0x08016ef4: 2400        movs	r4, #0
@   0x08016ef6: 480d        ldr	r0, [pc, #52]	@ (0x16f2c)
@   0x08016ef8: 7880        ldrb	r0, [r0, #2]
@   0x08016efa: 4284        cmp	r4, r0
@   0x08016efc: d26b        bcs.n	0x16fd6
@   0x08016efe: 480c        ldr	r0, [pc, #48]	@ (0x16f30)
@   0x08016f00: 7802        ldrb	r2, [r0, #0]
@   0x08016f02: 4669        mov	r1, sp
@   0x08016f04: 710a        strb	r2, [r1, #4]
@   0x08016f06: 9900        ldr	r1, [sp, #0]
@   0x08016f08: 466b        mov	r3, sp
@   0x08016f0a: 791b        ldrb	r3, [r3, #4]
@   0x08016f0c: 18c8        adds	r0, r1, r3
@   0x08016f0e: 0600        lsls	r0, r0, #24
@   0x08016f10: 0e00        lsrs	r0, r0, #24
@   0x08016f12: 9000        str	r0, [sp, #0]
@   0x08016f14: 4e07        ldr	r6, [pc, #28]	@ (0x16f34)
@   0x08016f16: 0040        lsls	r0, r0, #1
@   0x08016f18: 1986        adds	r6, r0, r6
@   0x08016f1a: 4907        ldr	r1, [pc, #28]	@ (0x16f38)
@   0x08016f1c: 2004        movs	r0, #4
@   0x08016f1e: 5608        ldrsb	r0, [r1, r0]
@   0x08016f20: 4284        cmp	r4, r0
@   0x08016f22: da0d        bge.n	0x16f40
@   0x08016f24: 4a05        ldr	r2, [pc, #20]	@ (0x16f3c)
@   0x08016f26: 6f57        ldr	r7, [r2, #116]	@ 0x74
@   0x08016f28: e00c        b.n	0x16f44
@   0x08016f2a: 0000        movs	r0, r0
@   0x08016f2c: 6110        str	r0, [r2, #16]
@   0x08016f2e: 0300        lsls	r0, r0, #12
@   0x08016f30: 3688        adds	r6, #136	@ 0x88
@   0x08016f32: 080e        lsrs	r6, r1, #32
@   0x08016f34: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08016f38: 35e0        adds	r5, #224	@ 0xe0
@   0x08016f3a: 0300        lsls	r0, r0, #12
@   0x08016f3c: 3628        adds	r6, #40	@ 0x28
@   0x08016f3e: 080e        lsrs	r6, r1, #32
@   0x08016f40: 4b29        ldr	r3, [pc, #164]	@ (0x16fe8)
@   0x08016f42: 6e9f        ldr	r7, [r3, #104]	@ 0x68
@   0x08016f44: 2500        movs	r5, #0
@   0x08016f46: 3401        adds	r4, #1
@   0x08016f48: 9402        str	r4, [sp, #8]
@   0x08016f4a: 4c28        ldr	r4, [pc, #160]	@ (0x16fec)
@   0x08016f4c: 8824        ldrh	r4, [r4, #0]
@   0x08016f4e: 42a5        cmp	r5, r4
@   0x08016f50: d207        bcs.n	0x16f62
@   0x08016f52: 4826        ldr	r0, [pc, #152]	@ (0x16fec)
@   0x08016f54: 8801        ldrh	r1, [r0, #0]
@   0x08016f56: 3640        adds	r6, #64	@ 0x40
@   0x08016f58: 1c68        adds	r0, r5, #1
@   0x08016f5a: 0400        lsls	r0, r0, #16
@   0x08016f5c: 0c05        lsrs	r5, r0, #16
@   0x08016f5e: 428d        cmp	r5, r1
@   0x08016f60: d3f9        bcc.n	0x16f56
@   0x08016f62: 2500        movs	r5, #0
@   0x08016f64: 4922        ldr	r1, [pc, #136]	@ (0x16ff0)
@   0x08016f66: 8809        ldrh	r1, [r1, #0]
@   0x08016f68: 428d        cmp	r5, r1
@   0x08016f6a: d226        bcs.n	0x16fba
@   0x08016f6c: 4a21        ldr	r2, [pc, #132]	@ (0x16ff4)
@   0x08016f6e: 4691        mov	r9, r2
@   0x08016f70: 8813        ldrh	r3, [r2, #0]
@   0x08016f72: 005b        lsls	r3, r3, #1
@   0x08016f74: 4698        mov	r8, r3
@   0x08016f76: 4a20        ldr	r2, [pc, #128]	@ (0x16ff8)
@   0x08016f78: 8814        ldrh	r4, [r2, #0]
@   0x08016f7a: 46a4        mov	ip, r4
@   0x08016f7c: 481c        ldr	r0, [pc, #112]	@ (0x16ff0)
@   0x08016f7e: 8803        ldrh	r3, [r0, #0]
@   0x08016f80: 4692        mov	sl, r2
@   0x08016f82: 4446        add	r6, r8
@   0x08016f84: 2400        movs	r4, #0
@   0x08016f86: 3501        adds	r5, #1
@   0x08016f88: 4564        cmp	r4, ip
@   0x08016f8a: d20a        bcs.n	0x16fa2
@   0x08016f8c: 4650        mov	r0, sl
@   0x08016f8e: 8801        ldrh	r1, [r0, #0]
@   0x08016f90: 8838        ldrh	r0, [r7, #0]
@   0x08016f92: 8030        strh	r0, [r6, #0]
@   0x08016f94: 3702        adds	r7, #2
@   0x08016f96: 3602        adds	r6, #2
@   0x08016f98: 1c60        adds	r0, r4, #1
@   0x08016f9a: 0400        lsls	r0, r0, #16
@   0x08016f9c: 0c04        lsrs	r4, r0, #16
@   0x08016f9e: 428c        cmp	r4, r1
@   0x08016fa0: d3f6        bcc.n	0x16f90
@   0x08016fa2: 2020        movs	r0, #32
@   0x08016fa4: 4649        mov	r1, r9
@   0x08016fa6: 8809        ldrh	r1, [r1, #0]
@   0x08016fa8: 1a40        subs	r0, r0, r1
@   0x08016faa: 8814        ldrh	r4, [r2, #0]
@   0x08016fac: 1b00        subs	r0, r0, r4
@   0x08016fae: 0040        lsls	r0, r0, #1
@   0x08016fb0: 1836        adds	r6, r6, r0
@   0x08016fb2: 0428        lsls	r0, r5, #16
@   0x08016fb4: 0c05        lsrs	r5, r0, #16
@   0x08016fb6: 429d        cmp	r5, r3
@   0x08016fb8: d3e3        bcc.n	0x16f82
@   0x08016fba: 490f        ldr	r1, [pc, #60]	@ (0x16ff8)
@   0x08016fbc: 7809        ldrb	r1, [r1, #0]
@   0x08016fbe: 9a00        ldr	r2, [sp, #0]
@   0x08016fc0: 1888        adds	r0, r1, r2
@   0x08016fc2: 0600        lsls	r0, r0, #24
@   0x08016fc4: 0e00        lsrs	r0, r0, #24
@   0x08016fc6: 9000        str	r0, [sp, #0]
@   0x08016fc8: 9b02        ldr	r3, [sp, #8]
@   0x08016fca: 0618        lsls	r0, r3, #24
@   0x08016fcc: 0e04        lsrs	r4, r0, #24
@   0x08016fce: 480b        ldr	r0, [pc, #44]	@ (0x16ffc)
@   0x08016fd0: 7880        ldrb	r0, [r0, #2]
@   0x08016fd2: 4284        cmp	r4, r0
@   0x08016fd4: d397        bcc.n	0x16f06
@   0x08016fd6: b003        add	sp, #12
@   0x08016fd8: bc38        pop	{r3, r4, r5}
@   0x08016fda: 4698        mov	r8, r3
@   0x08016fdc: 46a1        mov	r9, r4
@   0x08016fde: 46aa        mov	sl, r5
@   0x08016fe0: bcf0        pop	{r4, r5, r6, r7}
@   0x08016fe2: bc01        pop	{r0}
@   0x08016fe4: 4700        bx	r0
@   0x08016fe6: 0000        movs	r0, r0
@   0x08016fe8: 3628        adds	r6, #40	@ 0x28
@   0x08016fea: 080e        lsrs	r6, r1, #32
@   0x08016fec: 368a        adds	r6, #138	@ 0x8a
@   0x08016fee: 080e        lsrs	r6, r1, #32
@   0x08016ff0: 368c        adds	r6, #140	@ 0x8c
@   0x08016ff2: 080e        lsrs	r6, r1, #32
@   0x08016ff4: 3688        adds	r6, #136	@ 0x88
@   0x08016ff6: 080e        lsrs	r6, r1, #32
@   0x08016ff8: 368e        adds	r6, #142	@ 0x8e
@   0x08016ffa: 080e        lsrs	r6, r1, #32
@   0x08016ffc: 6110        str	r0, [r2, #16]
@   0x08016ffe: 0300        lsls	r0, r0, #12

        thumb_func_start StatusBar_Update
StatusBar_Update: @ 0x08016a40
        .incbin "frog_us_baserom.gba", 0x16a40, 0x5c0
        thumb_func_end StatusBar_Update
