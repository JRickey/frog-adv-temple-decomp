@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023bc0, 0x08023f68)  (936 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023bc0 --end 0x8023f68 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023bc0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08023bc2: 4657        mov	r7, sl
@   0x08023bc4: 464e        mov	r6, r9
@   0x08023bc6: 4645        mov	r5, r8
@   0x08023bc8: b4e0        push	{r5, r6, r7}
@   0x08023bca: b083        sub	sp, #12
@   0x08023bcc: 4802        ldr	r0, [pc, #8]	@ (0x23bd8)
@   0x08023bce: 7800        ldrb	r0, [r0, #0]
@   0x08023bd0: 9000        str	r0, [sp, #0]
@   0x08023bd2: 2071        movs	r0, #113	@ 0x71
@   0x08023bd4: e1af        b.n	0x23f36
@   0x08023bd6: 0000        movs	r0, r0
@   0x08023bd8: 21f0        movs	r1, #240	@ 0xf0
@   0x08023bda: 0831        lsrs	r1, r6, #32
@   0x08023bdc: 490e        ldr	r1, [pc, #56]	@ (0x23c18)
@   0x08023bde: 2002        movs	r0, #2
@   0x08023be0: 8a0a        ldrh	r2, [r1, #16]
@   0x08023be2: 4010        ands	r0, r2
@   0x08023be4: 4f0d        ldr	r7, [pc, #52]	@ (0x23c1c)
@   0x08023be6: 464b        mov	r3, r9
@   0x08023be8: 00db        lsls	r3, r3, #3
@   0x08023bea: 9301        str	r3, [sp, #4]
@   0x08023bec: 464e        mov	r6, r9
@   0x08023bee: 3e71        subs	r6, #113	@ 0x71
@   0x08023bf0: 2800        cmp	r0, #0
@   0x08023bf2: d039        beq.n	0x23c68
@   0x08023bf4: 7b49        ldrb	r1, [r1, #13]
@   0x08023bf6: 4589        cmp	r9, r1
@   0x08023bf8: d136        bne.n	0x23c68
@   0x08023bfa: 464c        mov	r4, r9
@   0x08023bfc: 1b18        subs	r0, r3, r4
@   0x08023bfe: 00c0        lsls	r0, r0, #3
@   0x08023c00: 19c0        adds	r0, r0, r7
@   0x08023c02: 7e80        ldrb	r0, [r0, #26]
@   0x08023c04: 2803        cmp	r0, #3
@   0x08023c06: d119        bne.n	0x23c3c
@   0x08023c08: 2e01        cmp	r6, #1
@   0x08023c0a: d00f        beq.n	0x23c2c
@   0x08023c0c: 2e01        cmp	r6, #1
@   0x08023c0e: dc07        bgt.n	0x23c20
@   0x08023c10: 2e00        cmp	r6, #0
@   0x08023c12: d00f        beq.n	0x23c34
@   0x08023c14: e028        b.n	0x23c68
@   0x08023c16: 0000        movs	r0, r0
@   0x08023c18: 35e0        adds	r5, #224	@ 0xe0
@   0x08023c1a: 0300        lsls	r0, r0, #12
@   0x08023c1c: 3720        adds	r7, #32
@   0x08023c1e: 0300        lsls	r0, r0, #12
@   0x08023c20: 2e02        cmp	r6, #2
@   0x08023c22: d121        bne.n	0x23c68
@   0x08023c24: 4800        ldr	r0, [pc, #0]	@ (0x23c28)
@   0x08023c26: e01e        b.n	0x23c66
@   0x08023c28: 03b3        lsls	r3, r6, #14
@   0x08023c2a: 0000        movs	r0, r0
@   0x08023c2c: 4800        ldr	r0, [pc, #0]	@ (0x23c30)
@   0x08023c2e: e01a        b.n	0x23c66
@   0x08023c30: 0353        lsls	r3, r2, #13
@   0x08023c32: 0000        movs	r0, r0
@   0x08023c34: 4800        ldr	r0, [pc, #0]	@ (0x23c38)
@   0x08023c36: e016        b.n	0x23c66
@   0x08023c38: 02f3        lsls	r3, r6, #11
@   0x08023c3a: 0000        movs	r0, r0
@   0x08023c3c: 2800        cmp	r0, #0
@   0x08023c3e: d113        bne.n	0x23c68
@   0x08023c40: 2e01        cmp	r6, #1
@   0x08023c42: d00b        beq.n	0x23c5c
@   0x08023c44: 2e01        cmp	r6, #1
@   0x08023c46: dc02        bgt.n	0x23c4e
@   0x08023c48: 2e00        cmp	r6, #0
@   0x08023c4a: d00b        beq.n	0x23c64
@   0x08023c4c: e00c        b.n	0x23c68
@   0x08023c4e: 2e02        cmp	r6, #2
@   0x08023c50: d10a        bne.n	0x23c68
@   0x08023c52: 4801        ldr	r0, [pc, #4]	@ (0x23c58)
@   0x08023c54: e007        b.n	0x23c66
@   0x08023c56: 0000        movs	r0, r0
@   0x08023c58: 03cb        lsls	r3, r1, #15
@   0x08023c5a: 0000        movs	r0, r0
@   0x08023c5c: 4800        ldr	r0, [pc, #0]	@ (0x23c60)
@   0x08023c5e: e002        b.n	0x23c66
@   0x08023c60: 036b        lsls	r3, r5, #13
@   0x08023c62: 0000        movs	r0, r0
@   0x08023c64: 4811        ldr	r0, [pc, #68]	@ (0x23cac)
@   0x08023c66: 80b8        strh	r0, [r7, #4]
@   0x08023c68: 9901        ldr	r1, [sp, #4]
@   0x08023c6a: 464a        mov	r2, r9
@   0x08023c6c: 1a88        subs	r0, r1, r2
@   0x08023c6e: 00c4        lsls	r4, r0, #3
@   0x08023c70: 19e5        adds	r5, r4, r7
@   0x08023c72: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08023c74: 2280        movs	r2, #128	@ 0x80
@   0x08023c76: 0092        lsls	r2, r2, #2
@   0x08023c78: 1c10        adds	r0, r2, #0
@   0x08023c7a: 4008        ands	r0, r1
@   0x08023c7c: 2800        cmp	r0, #0
@   0x08023c7e: d051        beq.n	0x23d24
@   0x08023c80: 4b0b        ldr	r3, [pc, #44]	@ (0x23cb0)
@   0x08023c82: 7b5b        ldrb	r3, [r3, #13]
@   0x08023c84: 4599        cmp	r9, r3
@   0x08023c86: d019        beq.n	0x23cbc
@   0x08023c88: 7ea8        ldrb	r0, [r5, #26]
@   0x08023c8a: 2803        cmp	r0, #3
@   0x08023c8c: d001        beq.n	0x23c92
@   0x08023c8e: 2800        cmp	r0, #0
@   0x08023c90: d114        bne.n	0x23cbc
@   0x08023c92: 4c08        ldr	r4, [pc, #32]	@ (0x23cb4)
@   0x08023c94: 1c20        adds	r0, r4, #0
@   0x08023c96: 4008        ands	r0, r1
@   0x08023c98: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08023c9a: 464a        mov	r2, r9
@   0x08023c9c: 3292        adds	r2, #146	@ 0x92
@   0x08023c9e: 0612        lsls	r2, r2, #24
@   0x08023ca0: 0e12        lsrs	r2, r2, #24
@   0x08023ca2: 4805        ldr	r0, [pc, #20]	@ (0x23cb8)
@   0x08023ca4: 2105        movs	r1, #5
@   0x08023ca6: f7e2        fd0d 	bl	0x66c4
@   0x08023caa: e055        b.n	0x23d58
@   0x08023cac: 030b        lsls	r3, r1, #12
@   0x08023cae: 0000        movs	r0, r0
@   0x08023cb0: 35e0        adds	r5, #224	@ 0xe0
@   0x08023cb2: 0300        lsls	r0, r0, #12
@   0x08023cb4: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08023cb8: 6110        str	r0, [r2, #16]
@   0x08023cba: 0300        lsls	r0, r0, #12
@   0x08023cbc: f7dc        fe20 	bl	0x900
@   0x08023cc0: 4a14        ldr	r2, [pc, #80]	@ (0x23d14)
@   0x08023cc2: 9b01        ldr	r3, [sp, #4]
@   0x08023cc4: 464c        mov	r4, r9
@   0x08023cc6: 1b19        subs	r1, r3, r4
@   0x08023cc8: 00c9        lsls	r1, r1, #3
@   0x08023cca: 322c        adds	r2, #44	@ 0x2c
@   0x08023ccc: 1889        adds	r1, r1, r2
@   0x08023cce: 6809        ldr	r1, [r1, #0]
@   0x08023cd0: 1a40        subs	r0, r0, r1
@   0x08023cd2: 283b        cmp	r0, #59	@ 0x3b
@   0x08023cd4: d940        bls.n	0x23d58
@   0x08023cd6: 4a10        ldr	r2, [pc, #64]	@ (0x23d18)
@   0x08023cd8: 8a11        ldrh	r1, [r2, #16]
@   0x08023cda: 2002        movs	r0, #2
@   0x08023cdc: 4008        ands	r0, r1
@   0x08023cde: 2800        cmp	r0, #0
@   0x08023ce0: d005        beq.n	0x23cee
@   0x08023ce2: 7b50        ldrb	r0, [r2, #13]
@   0x08023ce4: 4581        cmp	r9, r0
@   0x08023ce6: d102        bne.n	0x23cee
@   0x08023ce8: 2001        movs	r0, #1
@   0x08023cea: 4308        orrs	r0, r1
@   0x08023cec: 8210        strh	r0, [r2, #16]
@   0x08023cee: 4809        ldr	r0, [pc, #36]	@ (0x23d14)
@   0x08023cf0: 9a01        ldr	r2, [sp, #4]
@   0x08023cf2: 464b        mov	r3, r9
@   0x08023cf4: 1ad1        subs	r1, r2, r3
@   0x08023cf6: 00c9        lsls	r1, r1, #3
@   0x08023cf8: 1809        adds	r1, r1, r0
@   0x08023cfa: 4c08        ldr	r4, [pc, #32]	@ (0x23d1c)
@   0x08023cfc: 1c20        adds	r0, r4, #0
@   0x08023cfe: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08023d00: 4010        ands	r0, r2
@   0x08023d02: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08023d04: 0632        lsls	r2, r6, #24
@   0x08023d06: 0e12        lsrs	r2, r2, #24
@   0x08023d08: 4805        ldr	r0, [pc, #20]	@ (0x23d20)
@   0x08023d0a: 2105        movs	r1, #5
@   0x08023d0c: f7e2        fc78 	bl	0x6600
@   0x08023d10: e022        b.n	0x23d58
@   0x08023d12: 0000        movs	r0, r0
@   0x08023d14: 3720        adds	r7, #32
@   0x08023d16: 0300        lsls	r0, r0, #12
@   0x08023d18: 35e0        adds	r5, #224	@ 0xe0
@   0x08023d1a: 0300        lsls	r0, r0, #12
@   0x08023d1c: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08023d20: 6110        str	r0, [r2, #16]
@   0x08023d22: 0300        lsls	r0, r0, #12
@   0x08023d24: 9202        str	r2, [sp, #8]
@   0x08023d26: f7dc        fdeb 	bl	0x900
@   0x08023d2a: 1c39        adds	r1, r7, #0
@   0x08023d2c: 312c        adds	r1, #44	@ 0x2c
@   0x08023d2e: 1861        adds	r1, r4, r1
@   0x08023d30: 6008        str	r0, [r1, #0]
@   0x08023d32: 491d        ldr	r1, [pc, #116]	@ (0x23da8)
@   0x08023d34: 2002        movs	r0, #2
@   0x08023d36: 8a0b        ldrh	r3, [r1, #16]
@   0x08023d38: 4018        ands	r0, r3
@   0x08023d3a: 9a02        ldr	r2, [sp, #8]
@   0x08023d3c: 2800        cmp	r0, #0
@   0x08023d3e: d00b        beq.n	0x23d58
@   0x08023d40: 7b49        ldrb	r1, [r1, #13]
@   0x08023d42: 4589        cmp	r9, r1
@   0x08023d44: d108        bne.n	0x23d58
@   0x08023d46: 7ea8        ldrb	r0, [r5, #26]
@   0x08023d48: 2803        cmp	r0, #3
@   0x08023d4a: d001        beq.n	0x23d50
@   0x08023d4c: 2800        cmp	r0, #0
@   0x08023d4e: d103        bne.n	0x23d58
@   0x08023d50: 1c10        adds	r0, r2, #0
@   0x08023d52: 8eac        ldrh	r4, [r5, #52]	@ 0x34
@   0x08023d54: 4320        orrs	r0, r4
@   0x08023d56: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08023d58: 4814        ldr	r0, [pc, #80]	@ (0x23dac)
@   0x08023d5a: 4680        mov	r8, r0
@   0x08023d5c: 0630        lsls	r0, r6, #24
@   0x08023d5e: 0e07        lsrs	r7, r0, #24
@   0x08023d60: 4640        mov	r0, r8
@   0x08023d62: 2105        movs	r1, #5
@   0x08023d64: 1c3a        adds	r2, r7, #0
@   0x08023d66: f7e2        fd19 	bl	0x679c
@   0x08023d6a: 0600        lsls	r0, r0, #24
@   0x08023d6c: 2800        cmp	r0, #0
@   0x08023d6e: d100        bne.n	0x23d72
@   0x08023d70: e0dd        b.n	0x23f2e
@   0x08023d72: 4e0d        ldr	r6, [pc, #52]	@ (0x23da8)
@   0x08023d74: 8a32        ldrh	r2, [r6, #16]
@   0x08023d76: 2102        movs	r1, #2
@   0x08023d78: 468a        mov	sl, r1
@   0x08023d7a: 2002        movs	r0, #2
@   0x08023d7c: 4010        ands	r0, r2
@   0x08023d7e: 2800        cmp	r0, #0
@   0x08023d80: d100        bne.n	0x23d84
@   0x08023d82: e0d4        b.n	0x23f2e
@   0x08023d84: 7b73        ldrb	r3, [r6, #13]
@   0x08023d86: 4599        cmp	r9, r3
@   0x08023d88: d000        beq.n	0x23d8c
@   0x08023d8a: e0d0        b.n	0x23f2e
@   0x08023d8c: 4908        ldr	r1, [pc, #32]	@ (0x23db0)
@   0x08023d8e: 9c01        ldr	r4, [sp, #4]
@   0x08023d90: 464b        mov	r3, r9
@   0x08023d92: 1ae0        subs	r0, r4, r3
@   0x08023d94: 00c0        lsls	r0, r0, #3
@   0x08023d96: 1845        adds	r5, r0, r1
@   0x08023d98: 7eac        ldrb	r4, [r5, #26]
@   0x08023d9a: 2c01        cmp	r4, #1
@   0x08023d9c: d033        beq.n	0x23e06
@   0x08023d9e: 2c01        cmp	r4, #1
@   0x08023da0: dc08        bgt.n	0x23db4
@   0x08023da2: 2c00        cmp	r4, #0
@   0x08023da4: d00b        beq.n	0x23dbe
@   0x08023da6: e093        b.n	0x23ed0
@   0x08023da8: 35e0        adds	r5, #224	@ 0xe0
@   0x08023daa: 0300        lsls	r0, r0, #12
@   0x08023dac: 6110        str	r0, [r2, #16]
@   0x08023dae: 0300        lsls	r0, r0, #12
@   0x08023db0: 3720        adds	r7, #32
@   0x08023db2: 0300        lsls	r0, r0, #12
@   0x08023db4: 2c02        cmp	r4, #2
@   0x08023db6: d05b        beq.n	0x23e70
@   0x08023db8: 2c03        cmp	r4, #3
@   0x08023dba: d012        beq.n	0x23de2
@   0x08023dbc: e088        b.n	0x23ed0
@   0x08023dbe: 2001        movs	r0, #1
@   0x08023dc0: 76a8        strb	r0, [r5, #26]
@   0x08023dc2: 4640        mov	r0, r8
@   0x08023dc4: 2105        movs	r1, #5
@   0x08023dc6: 1c3a        adds	r2, r7, #0
@   0x08023dc8: f7e2        fc1a 	bl	0x6600
@   0x08023dcc: 464a        mov	r2, r9
@   0x08023dce: 3292        adds	r2, #146	@ 0x92
@   0x08023dd0: 0612        lsls	r2, r2, #24
@   0x08023dd2: 0e12        lsrs	r2, r2, #24
@   0x08023dd4: 4640        mov	r0, r8
@   0x08023dd6: 2105        movs	r1, #5
@   0x08023dd8: f7e2        fc74 	bl	0x66c4
@   0x08023ddc: 2402        movs	r4, #2
@   0x08023dde: 86ac        strh	r4, [r5, #52]	@ 0x34
@   0x08023de0: e076        b.n	0x23ed0
@   0x08023de2: 4650        mov	r0, sl
@   0x08023de4: 76a8        strb	r0, [r5, #26]
@   0x08023de6: 4640        mov	r0, r8
@   0x08023de8: 2105        movs	r1, #5
@   0x08023dea: 1c3a        adds	r2, r7, #0
@   0x08023dec: f7e2        fc08 	bl	0x6600
@   0x08023df0: 464a        mov	r2, r9
@   0x08023df2: 3292        adds	r2, #146	@ 0x92
@   0x08023df4: 0612        lsls	r2, r2, #24
@   0x08023df6: 0e12        lsrs	r2, r2, #24
@   0x08023df8: 4640        mov	r0, r8
@   0x08023dfa: 2105        movs	r1, #5
@   0x08023dfc: f7e2        fc00 	bl	0x6600
@   0x08023e00: 2102        movs	r1, #2
@   0x08023e02: 86a9        strh	r1, [r5, #52]	@ 0x34
@   0x08023e04: e064        b.n	0x23ed0
@   0x08023e06: 2001        movs	r0, #1
@   0x08023e08: 2400        movs	r4, #0
@   0x08023e0a: 4310        orrs	r0, r2
@   0x08023e0c: 8230        strh	r0, [r6, #16]
@   0x08023e0e: 7eea        ldrb	r2, [r5, #27]
@   0x08023e10: 2a01        cmp	r2, #1
@   0x08023e12: d105        bne.n	0x23e20
@   0x08023e14: 1c28        adds	r0, r5, #0
@   0x08023e16: 210a        movs	r1, #10
@   0x08023e18: 2202        movs	r2, #2
@   0x08023e1a: 2302        movs	r3, #2
@   0x08023e1c: f7fc        fffa 	bl	0x20e14
@   0x08023e20: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08023e22: 2380        movs	r3, #128	@ 0x80
@   0x08023e24: 021b        lsls	r3, r3, #8
@   0x08023e26: 1c18        adds	r0, r3, #0
@   0x08023e28: 4008        ands	r0, r1
@   0x08023e2a: 2800        cmp	r0, #0
@   0x08023e2c: d050        beq.n	0x23ed0
@   0x08023e2e: 2003        movs	r0, #3
@   0x08023e30: 76a8        strb	r0, [r5, #26]
@   0x08023e32: 4654        mov	r4, sl
@   0x08023e34: 4321        orrs	r1, r4
@   0x08023e36: 4a0d        ldr	r2, [pc, #52]	@ (0x23e6c)
@   0x08023e38: 1c10        adds	r0, r2, #0
@   0x08023e3a: 4001        ands	r1, r0
@   0x08023e3c: 2380        movs	r3, #128	@ 0x80
@   0x08023e3e: 009b        lsls	r3, r3, #2
@   0x08023e40: 1c18        adds	r0, r3, #0
@   0x08023e42: 4301        orrs	r1, r0
@   0x08023e44: 86a9        strh	r1, [r5, #52]	@ 0x34
@   0x08023e46: 4640        mov	r0, r8
@   0x08023e48: 2105        movs	r1, #5
@   0x08023e4a: 1c3a        adds	r2, r7, #0
@   0x08023e4c: f7e2        fc3a 	bl	0x66c4
@   0x08023e50: 464a        mov	r2, r9
@   0x08023e52: 3292        adds	r2, #146	@ 0x92
@   0x08023e54: 0612        lsls	r2, r2, #24
@   0x08023e56: 0e12        lsrs	r2, r2, #24
@   0x08023e58: 4640        mov	r0, r8
@   0x08023e5a: 2105        movs	r1, #5
@   0x08023e5c: f7e2        fbd0 	bl	0x6600
@   0x08023e60: 8a31        ldrh	r1, [r6, #16]
@   0x08023e62: 2002        movs	r0, #2
@   0x08023e64: 4008        ands	r0, r1
@   0x08023e66: 2800        cmp	r0, #0
@   0x08023e68: d061        beq.n	0x23f2e
@   0x08023e6a: e028        b.n	0x23ebe
@   0x08023e6c: 7fff        ldrb	r7, [r7, #31]
@   0x08023e6e: 0000        movs	r0, r0
@   0x08023e70: 2001        movs	r0, #1
@   0x08023e72: 2300        movs	r3, #0
@   0x08023e74: 4310        orrs	r0, r2
@   0x08023e76: 8230        strh	r0, [r6, #16]
@   0x08023e78: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08023e7a: 2280        movs	r2, #128	@ 0x80
@   0x08023e7c: 0212        lsls	r2, r2, #8
@   0x08023e7e: 1c10        adds	r0, r2, #0
@   0x08023e80: 4008        ands	r0, r1
@   0x08023e82: 2800        cmp	r0, #0
@   0x08023e84: d024        beq.n	0x23ed0
@   0x08023e86: 76ab        strb	r3, [r5, #26]
@   0x08023e88: 4653        mov	r3, sl
@   0x08023e8a: 4319        orrs	r1, r3
@   0x08023e8c: 3a01        subs	r2, #1
@   0x08023e8e: 1c10        adds	r0, r2, #0
@   0x08023e90: 4001        ands	r1, r0
@   0x08023e92: 2380        movs	r3, #128	@ 0x80
@   0x08023e94: 009b        lsls	r3, r3, #2
@   0x08023e96: 1c18        adds	r0, r3, #0
@   0x08023e98: 4301        orrs	r1, r0
@   0x08023e9a: 86a9        strh	r1, [r5, #52]	@ 0x34
@   0x08023e9c: 4640        mov	r0, r8
@   0x08023e9e: 2105        movs	r1, #5
@   0x08023ea0: 1c3a        adds	r2, r7, #0
@   0x08023ea2: f7e2        fc0f 	bl	0x66c4
@   0x08023ea6: 464a        mov	r2, r9
@   0x08023ea8: 3292        adds	r2, #146	@ 0x92
@   0x08023eaa: 0612        lsls	r2, r2, #24
@   0x08023eac: 0e12        lsrs	r2, r2, #24
@   0x08023eae: 4640        mov	r0, r8
@   0x08023eb0: 2105        movs	r1, #5
@   0x08023eb2: f7e2        fc07 	bl	0x66c4
@   0x08023eb6: 8a31        ldrh	r1, [r6, #16]
@   0x08023eb8: 400c        ands	r4, r1
@   0x08023eba: 2c00        cmp	r4, #0
@   0x08023ebc: d037        beq.n	0x23f2e
@   0x08023ebe: 7b74        ldrb	r4, [r6, #13]
@   0x08023ec0: 45a1        cmp	r9, r4
@   0x08023ec2: d105        bne.n	0x23ed0
@   0x08023ec4: 2000        movs	r0, #0
@   0x08023ec6: 8270        strh	r0, [r6, #18]
@   0x08023ec8: 4a24        ldr	r2, [pc, #144]	@ (0x23f5c)
@   0x08023eca: 1c10        adds	r0, r2, #0
@   0x08023ecc: 4008        ands	r0, r1
@   0x08023ece: 8230        strh	r0, [r6, #16]
@   0x08023ed0: 4923        ldr	r1, [pc, #140]	@ (0x23f60)
@   0x08023ed2: 2002        movs	r0, #2
@   0x08023ed4: 8a0b        ldrh	r3, [r1, #16]
@   0x08023ed6: 4018        ands	r0, r3
@   0x08023ed8: 2800        cmp	r0, #0
@   0x08023eda: d028        beq.n	0x23f2e
@   0x08023edc: 7b49        ldrb	r1, [r1, #13]
@   0x08023ede: 4589        cmp	r9, r1
@   0x08023ee0: d125        bne.n	0x23f2e
@   0x08023ee2: f7dc        fd0d 	bl	0x900
@   0x08023ee6: 4b1f        ldr	r3, [pc, #124]	@ (0x23f64)
@   0x08023ee8: 9c01        ldr	r4, [sp, #4]
@   0x08023eea: 4649        mov	r1, r9
@   0x08023eec: 1a62        subs	r2, r4, r1
@   0x08023eee: 00d2        lsls	r2, r2, #3
@   0x08023ef0: 1c19        adds	r1, r3, #0
@   0x08023ef2: 3120        adds	r1, #32
@   0x08023ef4: 1851        adds	r1, r2, r1
@   0x08023ef6: 6809        ldr	r1, [r1, #0]
@   0x08023ef8: 1a40        subs	r0, r0, r1
@   0x08023efa: 18d1        adds	r1, r2, r3
@   0x08023efc: 7f4a        ldrb	r2, [r1, #29]
@   0x08023efe: 4290        cmp	r0, r2
@   0x08023f00: d315        bcc.n	0x23f2e
@   0x08023f02: 2402        movs	r4, #2
@   0x08023f04: 5f1a        ldrsh	r2, [r3, r4]
@   0x08023f06: 2402        movs	r4, #2
@   0x08023f08: 5f08        ldrsh	r0, [r1, r4]
@   0x08023f0a: 4282        cmp	r2, r0
@   0x08023f0c: d10f        bne.n	0x23f2e
@   0x08023f0e: 7e88        ldrb	r0, [r1, #26]
@   0x08023f10: 2801        cmp	r0, #1
@   0x08023f12: d102        bne.n	0x23f1a
@   0x08023f14: 8898        ldrh	r0, [r3, #4]
@   0x08023f16: 3802        subs	r0, #2
@   0x08023f18: 8098        strh	r0, [r3, #4]
@   0x08023f1a: 2402        movs	r4, #2
@   0x08023f1c: 5f08        ldrsh	r0, [r1, r4]
@   0x08023f1e: 4282        cmp	r2, r0
@   0x08023f20: d105        bne.n	0x23f2e
@   0x08023f22: 7e89        ldrb	r1, [r1, #26]
@   0x08023f24: 2902        cmp	r1, #2
@   0x08023f26: d102        bne.n	0x23f2e
@   0x08023f28: 8898        ldrh	r0, [r3, #4]
@   0x08023f2a: 3002        adds	r0, #2
@   0x08023f2c: 8098        strh	r0, [r3, #4]
@   0x08023f2e: 4648        mov	r0, r9
@   0x08023f30: 3001        adds	r0, #1
@   0x08023f32: 0600        lsls	r0, r0, #24
@   0x08023f34: 0e00        lsrs	r0, r0, #24
@   0x08023f36: 4681        mov	r9, r0
@   0x08023f38: 9800        ldr	r0, [sp, #0]
@   0x08023f3a: 3071        adds	r0, #113	@ 0x71
@   0x08023f3c: 4581        cmp	r9, r0
@   0x08023f3e: da00        bge.n	0x23f42
@   0x08023f40: e64c        b.n	0x23bdc
@   0x08023f42: 9900        ldr	r1, [sp, #0]
@   0x08023f44: 3170        adds	r1, #112	@ 0x70
@   0x08023f46: 2071        movs	r0, #113	@ 0x71
@   0x08023f48: f7e1        fee2 	bl	0x5d10
@   0x08023f4c: b003        add	sp, #12
@   0x08023f4e: bc38        pop	{r3, r4, r5}
@   0x08023f50: 4698        mov	r8, r3
@   0x08023f52: 46a1        mov	r9, r4
@   0x08023f54: 46aa        mov	sl, r5
@   0x08023f56: bcf0        pop	{r4, r5, r6, r7}
@   0x08023f58: bc01        pop	{r0}
@   0x08023f5a: 4700        bx	r0
@   0x08023f5c: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08023f60: 35e0        adds	r5, #224	@ 0xe0
@   0x08023f62: 0300        lsls	r0, r0, #12
@   0x08023f64: 3720        adds	r7, #32
@   0x08023f66: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08023BC0
sub_08023BC0: @ 0x08023bc0
        .incbin "frog_us_baserom.gba", 0x23bc0, 0x3a8
        thumb_func_end sub_08023BC0
