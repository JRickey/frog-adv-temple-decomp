@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003ca8, 0x08004074)  (972 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003ca8 --end 0x8004074 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003ca8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08003caa: 464f        mov	r7, r9
@   0x08003cac: 4646        mov	r6, r8
@   0x08003cae: b4c0        push	{r6, r7}
@   0x08003cb0: b081        sub	sp, #4
@   0x08003cb2: 4668        mov	r0, sp
@   0x08003cb4: 3001        adds	r0, #1
@   0x08003cb6: 2100        movs	r1, #0
@   0x08003cb8: 7001        strb	r1, [r0, #0]
@   0x08003cba: 4908        ldr	r1, [pc, #32]	@ (0x3cdc)
@   0x08003cbc: 1c06        adds	r6, r0, #0
@   0x08003cbe: 7a49        ldrb	r1, [r1, #9]
@   0x08003cc0: 2913        cmp	r1, #19
@   0x08003cc2: d000        beq.n	0x3cc6
@   0x08003cc4: e1ca        b.n	0x405c
@   0x08003cc6: f01c        ff7b 	bl	0x20bc0
@   0x08003cca: 7830        ldrb	r0, [r6, #0]
@   0x08003ccc: 280c        cmp	r0, #12
@   0x08003cce: d900        bls.n	0x3cd2
@   0x08003cd0: e1bf        b.n	0x4052
@   0x08003cd2: 0080        lsls	r0, r0, #2
@   0x08003cd4: 4902        ldr	r1, [pc, #8]	@ (0x3ce0)
@   0x08003cd6: 1840        adds	r0, r0, r1
@   0x08003cd8: 6800        ldr	r0, [r0, #0]
@   0x08003cda: 4687        mov	pc, r0
@   0x08003cdc: 5330        strh	r0, [r6, r4]
@   0x08003cde: 0300        lsls	r0, r0, #12
@   0x08003ce0: 3ce4        subs	r4, #228	@ 0xe4
@   0x08003ce2: 0800        lsrs	r0, r0, #32
@   0x08003ce4: 3d18        subs	r5, #24
@   0x08003ce6: 0800        lsrs	r0, r0, #32
@   0x08003ce8: 3d34        subs	r5, #52	@ 0x34
@   0x08003cea: 0800        lsrs	r0, r0, #32
@   0x08003cec: 3d5c        subs	r5, #92	@ 0x5c
@   0x08003cee: 0800        lsrs	r0, r0, #32
@   0x08003cf0: 3d72        subs	r5, #114	@ 0x72
@   0x08003cf2: 0800        lsrs	r0, r0, #32
@   0x08003cf4: 3db0        subs	r5, #176	@ 0xb0
@   0x08003cf6: 0800        lsrs	r0, r0, #32
@   0x08003cf8: 3f74        subs	r7, #116	@ 0x74
@   0x08003cfa: 0800        lsrs	r0, r0, #32
@   0x08003cfc: 3f94        subs	r7, #148	@ 0x94
@   0x08003cfe: 0800        lsrs	r0, r0, #32
@   0x08003d00: 3fc8        subs	r7, #200	@ 0xc8
@   0x08003d02: 0800        lsrs	r0, r0, #32
@   0x08003d04: 4010        ands	r0, r2
@   0x08003d06: 0800        lsrs	r0, r0, #32
@   0x08003d08: 3e68        subs	r6, #104	@ 0x68
@   0x08003d0a: 0800        lsrs	r0, r0, #32
@   0x08003d0c: 3ec6        subs	r6, #198	@ 0xc6
@   0x08003d0e: 0800        lsrs	r0, r0, #32
@   0x08003d10: 3f58        subs	r7, #88	@ 0x58
@   0x08003d12: 0800        lsrs	r0, r0, #32
@   0x08003d14: 4044        eors	r4, r0
@   0x08003d16: 0800        lsrs	r0, r0, #32
@   0x08003d18: 4905        ldr	r1, [pc, #20]	@ (0x3d30)
@   0x08003d1a: 2400        movs	r4, #0
@   0x08003d1c: 200c        movs	r0, #12
@   0x08003d1e: 7288        strb	r0, [r1, #10]
@   0x08003d20: f006        fa78 	bl	0xa214
@   0x08003d24: 4681        mov	r9, r0
@   0x08003d26: 2001        movs	r0, #1
@   0x08003d28: 7030        strb	r0, [r6, #0]
@   0x08003d2a: 4668        mov	r0, sp
@   0x08003d2c: 7004        strb	r4, [r0, #0]
@   0x08003d2e: e190        b.n	0x4052
@   0x08003d30: 5330        strh	r0, [r6, r4]
@   0x08003d32: 0300        lsls	r0, r0, #12
@   0x08003d34: 4907        ldr	r1, [pc, #28]	@ (0x3d54)
@   0x08003d36: 4668        mov	r0, sp
@   0x08003d38: f006        f9e4 	bl	0xa104
@   0x08003d3c: 0600        lsls	r0, r0, #24
@   0x08003d3e: 2800        cmp	r0, #0
@   0x08003d40: d100        bne.n	0x3d44
@   0x08003d42: e178        b.n	0x4036
@   0x08003d44: 2002        movs	r0, #2
@   0x08003d46: 7030        strb	r0, [r6, #0]
@   0x08003d48: 4803        ldr	r0, [pc, #12]	@ (0x3d58)
@   0x08003d4a: 2100        movs	r1, #0
@   0x08003d4c: 6141        str	r1, [r0, #20]
@   0x08003d4e: 4668        mov	r0, sp
@   0x08003d50: 7001        strb	r1, [r0, #0]
@   0x08003d52: e170        b.n	0x4036
@   0x08003d54: 4081        lsls	r1, r0
@   0x08003d56: 0800        lsrs	r0, r0, #32
@   0x08003d58: 5330        strh	r0, [r6, r4]
@   0x08003d5a: 0300        lsls	r0, r0, #12
@   0x08003d5c: 200c        movs	r0, #12
@   0x08003d5e: f017        fbd9 	bl	0x1b514
@   0x08003d62: 4648        mov	r0, r9
@   0x08003d64: f006        fa78 	bl	0xa258
@   0x08003d68: f018        fb7c 	bl	0x1c464
@   0x08003d6c: 2003        movs	r0, #3
@   0x08003d6e: 7030        strb	r0, [r6, #0]
@   0x08003d70: e16f        b.n	0x4052
@   0x08003d72: 4c0d        ldr	r4, [pc, #52]	@ (0x3da8)
@   0x08003d74: 1c20        adds	r0, r4, #0
@   0x08003d76: 302a        adds	r0, #42	@ 0x2a
@   0x08003d78: 7801        ldrb	r1, [r0, #0]
@   0x08003d7a: 3101        adds	r1, #1
@   0x08003d7c: 0609        lsls	r1, r1, #24
@   0x08003d7e: 0e09        lsrs	r1, r1, #24
@   0x08003d80: 4668        mov	r0, sp
@   0x08003d82: f006        f8b3 	bl	0x9eec
@   0x08003d86: 2800        cmp	r0, #0
@   0x08003d88: d100        bne.n	0x3d8c
@   0x08003d8a: e162        b.n	0x4052
@   0x08003d8c: 2004        movs	r0, #4
@   0x08003d8e: 7030        strb	r0, [r6, #0]
@   0x08003d90: 4906        ldr	r1, [pc, #24]	@ (0x3dac)
@   0x08003d92: 2000        movs	r0, #0
@   0x08003d94: 6148        str	r0, [r1, #20]
@   0x08003d96: 2714        movs	r7, #20
@   0x08003d98: 6809        ldr	r1, [r1, #0]
@   0x08003d9a: 4688        mov	r8, r1
@   0x08003d9c: 1c20        adds	r0, r4, #0
@   0x08003d9e: 2103        movs	r1, #3
@   0x08003da0: 2200        movs	r2, #0
@   0x08003da2: f002        fc2d 	bl	0x6600
@   0x08003da6: e154        b.n	0x4052
@   0x08003da8: 6110        str	r0, [r2, #16]
@   0x08003daa: 0300        lsls	r0, r0, #12
@   0x08003dac: 5330        strh	r0, [r6, r4]
@   0x08003dae: 0300        lsls	r0, r0, #12
@   0x08003db0: 4812        ldr	r0, [pc, #72]	@ (0x3dfc)
@   0x08003db2: 6801        ldr	r1, [r0, #0]
@   0x08003db4: 4642        mov	r2, r8
@   0x08003db6: 1a88        subs	r0, r1, r2
@   0x08003db8: 283b        cmp	r0, #59	@ 0x3b
@   0x08003dba: d908        bls.n	0x3dce
@   0x08003dbc: 1e78        subs	r0, r7, #1
@   0x08003dbe: 0400        lsls	r0, r0, #16
@   0x08003dc0: 0c07        lsrs	r7, r0, #16
@   0x08003dc2: 4688        mov	r8, r1
@   0x08003dc4: 2f05        cmp	r7, #5
@   0x08003dc6: d802        bhi.n	0x3dce
@   0x08003dc8: 2068        movs	r0, #104	@ 0x68
@   0x08003dca: f01c        ff55 	bl	0x20c78
@   0x08003dce: 4c0c        ldr	r4, [pc, #48]	@ (0x3e00)
@   0x08003dd0: 1c20        adds	r0, r4, #0
@   0x08003dd2: 3080        adds	r0, #128	@ 0x80
@   0x08003dd4: 2100        movs	r1, #0
@   0x08003dd6: 5e40        ldrsh	r0, [r0, r1]
@   0x08003dd8: 2210        movs	r2, #16
@   0x08003dda: 5ea1        ldrsh	r1, [r4, r2]
@   0x08003ddc: 1c3a        adds	r2, r7, #0
@   0x08003dde: f018        fb8b 	bl	0x1c4f8
@   0x08003de2: f7fc        fb6f 	bl	0x4c4
@   0x08003de6: 4907        ldr	r1, [pc, #28]	@ (0x3e04)
@   0x08003de8: 8008        strh	r0, [r1, #0]
@   0x08003dea: 0400        lsls	r0, r0, #16
@   0x08003dec: 0c00        lsrs	r0, r0, #16
@   0x08003dee: 2840        cmp	r0, #64	@ 0x40
@   0x08003df0: d10a        bne.n	0x3e08
@   0x08003df2: 2006        movs	r0, #6
@   0x08003df4: 7030        strb	r0, [r6, #0]
@   0x08003df6: f00a        f933 	bl	0xe060
@   0x08003dfa: e12a        b.n	0x4052
@   0x08003dfc: 5330        strh	r0, [r6, r4]
@   0x08003dfe: 0300        lsls	r0, r0, #12
@   0x08003e00: 3720        adds	r7, #32
@   0x08003e02: 0300        lsls	r0, r0, #12
@   0x08003e04: 5398        strh	r0, [r3, r6]
@   0x08003e06: 0300        lsls	r0, r0, #12
@   0x08003e08: 2508        movs	r5, #8
@   0x08003e0a: 1c28        adds	r0, r5, #0
@   0x08003e0c: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08003e0e: 4008        ands	r0, r1
@   0x08003e10: 2800        cmp	r0, #0
@   0x08003e12: d000        beq.n	0x3e16
@   0x08003e14: e0a9        b.n	0x3f6a
@   0x08003e16: 2f00        cmp	r7, #0
@   0x08003e18: d10b        bne.n	0x3e32
@   0x08003e1a: f7fc        fd71 	bl	0x900
@   0x08003e1e: 4a0f        ldr	r2, [pc, #60]	@ (0x3e5c)
@   0x08003e20: 18a1        adds	r1, r4, r2
@   0x08003e22: 6008        str	r0, [r1, #0]
@   0x08003e24: 480e        ldr	r0, [pc, #56]	@ (0x3e60)
@   0x08003e26: 2103        movs	r1, #3
@   0x08003e28: 2200        movs	r2, #0
@   0x08003e2a: f002        fbe9 	bl	0x6600
@   0x08003e2e: 2009        movs	r0, #9
@   0x08003e30: 7030        strb	r0, [r6, #0]
@   0x08003e32: 490b        ldr	r1, [pc, #44]	@ (0x3e60)
@   0x08003e34: 1c28        adds	r0, r5, #0
@   0x08003e36: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08003e38: 4008        ands	r0, r1
@   0x08003e3a: 2800        cmp	r0, #0
@   0x08003e3c: d165        bne.n	0x3f0a
@   0x08003e3e: f006        fa4b 	bl	0xa2d8
@   0x08003e42: f7fc        fd4b 	bl	0x8dc
@   0x08003e46: f006        fa6f 	bl	0xa328
@   0x08003e4a: f005        fb55 	bl	0x94f8
@   0x08003e4e: f005        fd99 	bl	0x9984
@   0x08003e52: 4904        ldr	r1, [pc, #16]	@ (0x3e64)
@   0x08003e54: 6948        ldr	r0, [r1, #20]
@   0x08003e56: 3001        adds	r0, #1
@   0x08003e58: 6148        str	r0, [r1, #20]
@   0x08003e5a: e0fa        b.n	0x4052
@   0x08003e5c: 0b54        lsrs	r4, r2, #13
@   0x08003e5e: 0000        movs	r0, r0
@   0x08003e60: 6110        str	r0, [r2, #16]
@   0x08003e62: 0300        lsls	r0, r0, #12
@   0x08003e64: 5330        strh	r0, [r6, r4]
@   0x08003e66: 0300        lsls	r0, r0, #12
@   0x08003e68: 480b        ldr	r0, [pc, #44]	@ (0x3e98)
@   0x08003e6a: 2103        movs	r1, #3
@   0x08003e6c: 2200        movs	r2, #0
@   0x08003e6e: f002        fc29 	bl	0x66c4
@   0x08003e72: f7fc        fd45 	bl	0x900
@   0x08003e76: 4c09        ldr	r4, [pc, #36]	@ (0x3e9c)
@   0x08003e78: 4a09        ldr	r2, [pc, #36]	@ (0x3ea0)
@   0x08003e7a: 18a1        adds	r1, r4, r2
@   0x08003e7c: 6809        ldr	r1, [r1, #0]
@   0x08003e7e: 1a40        subs	r0, r0, r1
@   0x08003e80: 283b        cmp	r0, #59	@ 0x3b
@   0x08003e82: d80f        bhi.n	0x3ea4
@   0x08003e84: f006        fa28 	bl	0xa2d8
@   0x08003e88: f7fc        fd28 	bl	0x8dc
@   0x08003e8c: f006        fa4c 	bl	0xa328
@   0x08003e90: 2003        movs	r0, #3
@   0x08003e92: f01c        ff97 	bl	0x20dc4
@   0x08003e96: e0dc        b.n	0x4052
@   0x08003e98: 6110        str	r0, [r2, #16]
@   0x08003e9a: 0300        lsls	r0, r0, #12
@   0x08003e9c: 3720        adds	r7, #32
@   0x08003e9e: 0300        lsls	r0, r0, #12
@   0x08003ea0: 0b54        lsrs	r4, r2, #13
@   0x08003ea2: 0000        movs	r0, r0
@   0x08003ea4: 2003        movs	r0, #3
@   0x08003ea6: f01c        ffe9 	bl	0x20e7c
@   0x08003eaa: 1c20        adds	r0, r4, #0
@   0x08003eac: 3080        adds	r0, #128	@ 0x80
@   0x08003eae: 2210        movs	r2, #16
@   0x08003eb0: 5ea1        ldrsh	r1, [r4, r2]
@   0x08003eb2: 2200        movs	r2, #0
@   0x08003eb4: 5e80        ldrsh	r0, [r0, r2]
@   0x08003eb6: 4281        cmp	r1, r0
@   0x08003eb8: dd02        ble.n	0x3ec0
@   0x08003eba: 200a        movs	r0, #10
@   0x08003ebc: 7030        strb	r0, [r6, #0]
@   0x08003ebe: e0c8        b.n	0x4052
@   0x08003ec0: 200b        movs	r0, #11
@   0x08003ec2: 7030        strb	r0, [r6, #0]
@   0x08003ec4: e0c5        b.n	0x4052
@   0x08003ec6: 4d07        ldr	r5, [pc, #28]	@ (0x3ee4)
@   0x08003ec8: 1c2c        adds	r4, r5, #0
@   0x08003eca: 342a        adds	r4, #42	@ 0x2a
@   0x08003ecc: 7820        ldrb	r0, [r4, #0]
@   0x08003ece: 3001        adds	r0, #1
@   0x08003ed0: 7020        strb	r0, [r4, #0]
@   0x08003ed2: 2078        movs	r0, #120	@ 0x78
@   0x08003ed4: f01c        fed0 	bl	0x20c78
@   0x08003ed8: 7824        ldrb	r4, [r4, #0]
@   0x08003eda: 2c01        cmp	r4, #1
@   0x08003edc: d104        bne.n	0x3ee8
@   0x08003ede: 2007        movs	r0, #7
@   0x08003ee0: 2100        movs	r1, #0
@   0x08003ee2: e003        b.n	0x3eec
@   0x08003ee4: 6110        str	r0, [r2, #16]
@   0x08003ee6: 0300        lsls	r0, r0, #12
@   0x08003ee8: 2008        movs	r0, #8
@   0x08003eea: 2100        movs	r1, #0
@   0x08003eec: 6068        str	r0, [r5, #4]
@   0x08003eee: 60a9        str	r1, [r5, #8]
@   0x08003ef0: 2003        movs	r0, #3
@   0x08003ef2: f017        fe2f 	bl	0x1bb54
@   0x08003ef6: 4806        ldr	r0, [pc, #24]	@ (0x3f10)
@   0x08003ef8: 1c01        adds	r1, r0, #0
@   0x08003efa: 312a        adds	r1, #42	@ 0x2a
@   0x08003efc: 7809        ldrb	r1, [r1, #0]
@   0x08003efe: 2903        cmp	r1, #3
@   0x08003f00: d108        bne.n	0x3f14
@   0x08003f02: 2103        movs	r1, #3
@   0x08003f04: 2200        movs	r2, #0
@   0x08003f06: f002        fbdd 	bl	0x66c4
@   0x08003f0a: 200c        movs	r0, #12
@   0x08003f0c: 7030        strb	r0, [r6, #0]
@   0x08003f0e: e0a0        b.n	0x4052
@   0x08003f10: 6110        str	r0, [r2, #16]
@   0x08003f12: 0300        lsls	r0, r0, #12
@   0x08003f14: 4669        mov	r1, sp
@   0x08003f16: 2000        movs	r0, #0
@   0x08003f18: 7008        strb	r0, [r1, #0]
@   0x08003f1a: f006        f89f 	bl	0xa05c
@   0x08003f1e: 480a        ldr	r0, [pc, #40]	@ (0x3f48)
@   0x08003f20: 7940        ldrb	r0, [r0, #5]
@   0x08003f22: 0600        lsls	r0, r0, #24
@   0x08003f24: 1600        asrs	r0, r0, #24
@   0x08003f26: f003        fca5 	bl	0x7874
@   0x08003f2a: 4908        ldr	r1, [pc, #32]	@ (0x3f4c)
@   0x08003f2c: 4808        ldr	r0, [pc, #32]	@ (0x3f50)
@   0x08003f2e: 7a80        ldrb	r0, [r0, #10]
@   0x08003f30: 0080        lsls	r0, r0, #2
@   0x08003f32: 1840        adds	r0, r0, r1
@   0x08003f34: 6800        ldr	r0, [r0, #0]
@   0x08003f36: f02f        fecf 	bl	0x33cd8
@   0x08003f3a: 4906        ldr	r1, [pc, #24]	@ (0x3f54)
@   0x08003f3c: 2000        movs	r0, #0
@   0x08003f3e: 8208        strh	r0, [r1, #16]
@   0x08003f40: 2008        movs	r0, #8
@   0x08003f42: 7030        strb	r0, [r6, #0]
@   0x08003f44: e085        b.n	0x4052
@   0x08003f46: 0000        movs	r0, r0
@   0x08003f48: 35e0        adds	r5, #224	@ 0xe0
@   0x08003f4a: 0300        lsls	r0, r0, #12
@   0x08003f4c: 0c74        lsrs	r4, r6, #17
@   0x08003f4e: 080c        lsrs	r4, r1, #32
@   0x08003f50: 5330        strh	r0, [r6, r4]
@   0x08003f52: 0300        lsls	r0, r0, #12
@   0x08003f54: 3720        adds	r7, #32
@   0x08003f56: 0300        lsls	r0, r0, #12
@   0x08003f58: 2079        movs	r0, #121	@ 0x79
@   0x08003f5a: f01c        fe8d 	bl	0x20c78
@   0x08003f5e: 2004        movs	r0, #4
@   0x08003f60: f017        fdf8 	bl	0x1bb54
@   0x08003f64: 4802        ldr	r0, [pc, #8]	@ (0x3f70)
@   0x08003f66: 2100        movs	r1, #0
@   0x08003f68: 8201        strh	r1, [r0, #16]
@   0x08003f6a: 2005        movs	r0, #5
@   0x08003f6c: 7030        strb	r0, [r6, #0]
@   0x08003f6e: e070        b.n	0x4052
@   0x08003f70: 3720        adds	r7, #32
@   0x08003f72: 0300        lsls	r0, r0, #12
@   0x08003f74: 1c30        adds	r0, r6, #0
@   0x08003f76: f005        fe4d 	bl	0x9c14
@   0x08003f7a: 2800        cmp	r0, #0
@   0x08003f7c: d101        bne.n	0x3f82
@   0x08003f7e: 2008        movs	r0, #8
@   0x08003f80: 7030        strb	r0, [r6, #0]
@   0x08003f82: 4669        mov	r1, sp
@   0x08003f84: 2000        movs	r0, #0
@   0x08003f86: 7008        strb	r0, [r1, #0]
@   0x08003f88: 4901        ldr	r1, [pc, #4]	@ (0x3f90)
@   0x08003f8a: 2000        movs	r0, #0
@   0x08003f8c: 8208        strh	r0, [r1, #16]
@   0x08003f8e: e060        b.n	0x4052
@   0x08003f90: 3720        adds	r7, #32
@   0x08003f92: 0300        lsls	r0, r0, #12
@   0x08003f94: f7fc        fa96 	bl	0x4c4
@   0x08003f98: 4909        ldr	r1, [pc, #36]	@ (0x3fc0)
@   0x08003f9a: 8008        strh	r0, [r1, #0]
@   0x08003f9c: f00a        fb84 	bl	0xe6a8
@   0x08003fa0: 0600        lsls	r0, r0, #24
@   0x08003fa2: 0e01        lsrs	r1, r0, #24
@   0x08003fa4: 2900        cmp	r1, #0
@   0x08003fa6: d103        bne.n	0x3fb0
@   0x08003fa8: 2007        movs	r0, #7
@   0x08003faa: 7030        strb	r0, [r6, #0]
@   0x08003fac: 4668        mov	r0, sp
@   0x08003fae: 7001        strb	r1, [r0, #0]
@   0x08003fb0: 4804        ldr	r0, [pc, #16]	@ (0x3fc4)
@   0x08003fb2: 7800        ldrb	r0, [r0, #0]
@   0x08003fb4: 2800        cmp	r0, #0
@   0x08003fb6: d14c        bne.n	0x4052
@   0x08003fb8: 2004        movs	r0, #4
@   0x08003fba: 7030        strb	r0, [r6, #0]
@   0x08003fbc: e049        b.n	0x4052
@   0x08003fbe: 0000        movs	r0, r0
@   0x08003fc0: 5398        strh	r0, [r3, r6]
@   0x08003fc2: 0300        lsls	r0, r0, #12
@   0x08003fc4: 5328        strh	r0, [r5, r4]
@   0x08003fc6: 0300        lsls	r0, r0, #12
@   0x08003fc8: 4668        mov	r0, sp
@   0x08003fca: 7800        ldrb	r0, [r0, #0]
@   0x08003fcc: 0600        lsls	r0, r0, #24
@   0x08003fce: 1600        asrs	r0, r0, #24
@   0x08003fd0: 2800        cmp	r0, #0
@   0x08003fd2: d107        bne.n	0x3fe4
@   0x08003fd4: 20bf        movs	r0, #191	@ 0xbf
@   0x08003fd6: f00c        fb5d 	bl	0x10694
@   0x08003fda: 4668        mov	r0, sp
@   0x08003fdc: 4669        mov	r1, sp
@   0x08003fde: 7809        ldrb	r1, [r1, #0]
@   0x08003fe0: 3101        adds	r1, #1
@   0x08003fe2: 7001        strb	r1, [r0, #0]
@   0x08003fe4: 4668        mov	r0, sp
@   0x08003fe6: 2400        movs	r4, #0
@   0x08003fe8: 5704        ldrsb	r4, [r0, r4]
@   0x08003fea: 2c01        cmp	r4, #1
@   0x08003fec: d131        bne.n	0x4052
@   0x08003fee: f00c        fb63 	bl	0x106b8
@   0x08003ff2: 0600        lsls	r0, r0, #24
@   0x08003ff4: 2800        cmp	r0, #0
@   0x08003ff6: d12c        bne.n	0x4052
@   0x08003ff8: 4803        ldr	r0, [pc, #12]	@ (0x4008)
@   0x08003ffa: 2104        movs	r1, #4
@   0x08003ffc: 7001        strb	r1, [r0, #0]
@   0x08003ffe: 7184        strb	r4, [r0, #6]
@   0x08004000: 4802        ldr	r0, [pc, #8]	@ (0x400c)
@   0x08004002: 7241        strb	r1, [r0, #9]
@   0x08004004: e025        b.n	0x4052
@   0x08004006: 0000        movs	r0, r0
@   0x08004008: 3480        adds	r4, #128	@ 0x80
@   0x0800400a: 0300        lsls	r0, r0, #12
@   0x0800400c: 5330        strh	r0, [r6, r4]
@   0x0800400e: 0300        lsls	r0, r0, #12
@   0x08004010: 490a        ldr	r1, [pc, #40]	@ (0x403c)
@   0x08004012: 4668        mov	r0, sp
@   0x08004014: f006        f876 	bl	0xa104
@   0x08004018: 0600        lsls	r0, r0, #24
@   0x0800401a: 2800        cmp	r0, #0
@   0x0800401c: d00b        beq.n	0x4036
@   0x0800401e: 2003        movs	r0, #3
@   0x08004020: 7030        strb	r0, [r6, #0]
@   0x08004022: 4807        ldr	r0, [pc, #28]	@ (0x4040)
@   0x08004024: 2100        movs	r1, #0
@   0x08004026: 6141        str	r1, [r0, #20]
@   0x08004028: 4668        mov	r0, sp
@   0x0800402a: 7001        strb	r1, [r0, #0]
@   0x0800402c: 4648        mov	r0, r9
@   0x0800402e: f006        f913 	bl	0xa258
@   0x08004032: f018        fa17 	bl	0x1c464
@   0x08004036: f7fc        fc51 	bl	0x8dc
@   0x0800403a: e00a        b.n	0x4052
@   0x0800403c: a26d        add	r2, pc, #436	@ (adr r2, 0x41f4)
@   0x0800403e: 0800        lsrs	r0, r0, #32
@   0x08004040: 5330        strh	r0, [r6, r4]
@   0x08004042: 0300        lsls	r0, r0, #12
@   0x08004044: 4909        ldr	r1, [pc, #36]	@ (0x406c)
@   0x08004046: 2002        movs	r0, #2
@   0x08004048: 75c8        strb	r0, [r1, #23]
@   0x0800404a: f00f        ffa9 	bl	0x13fa0
@   0x0800404e: f009        ff17 	bl	0xde80
@   0x08004052: 4807        ldr	r0, [pc, #28]	@ (0x4070)
@   0x08004054: 7a40        ldrb	r0, [r0, #9]
@   0x08004056: 2813        cmp	r0, #19
@   0x08004058: d100        bne.n	0x405c
@   0x0800405a: e634        b.n	0x3cc6
@   0x0800405c: b001        add	sp, #4
@   0x0800405e: bc18        pop	{r3, r4}
@   0x08004060: 4698        mov	r8, r3
@   0x08004062: 46a1        mov	r9, r4
@   0x08004064: bcf0        pop	{r4, r5, r6, r7}
@   0x08004066: bc01        pop	{r0}
@   0x08004068: 4700        bx	r0
@   0x0800406a: 0000        movs	r0, r0
@   0x0800406c: 3720        adds	r7, #32
@   0x0800406e: 0300        lsls	r0, r0, #12
@   0x08004070: 5330        strh	r0, [r6, r4]
@   0x08004072: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003CA8
sub_08003CA8: @ 0x08003ca8
        .incbin "frog_us_baserom.gba", 0x3ca8, 0x3cc
        thumb_func_end sub_08003CA8
