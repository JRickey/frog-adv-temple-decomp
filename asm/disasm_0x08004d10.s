@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004d10, 0x08004fac)  (668 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004d10 --end 0x8004fac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004d10: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08004d12: 4657        mov	r7, sl
@   0x08004d14: 464e        mov	r6, r9
@   0x08004d16: 4645        mov	r5, r8
@   0x08004d18: b4e0        push	{r5, r6, r7}
@   0x08004d1a: b082        sub	sp, #8
@   0x08004d1c: 4680        mov	r8, r0
@   0x08004d1e: 4689        mov	r9, r1
@   0x08004d20: 4692        mov	sl, r2
@   0x08004d22: 9301        str	r3, [sp, #4]
@   0x08004d24: 4c3d        ldr	r4, [pc, #244]	@ (0x4e1c)
@   0x08004d26: 1c20        adds	r0, r4, #0
@   0x08004d28: 2103        movs	r1, #3
@   0x08004d2a: 2203        movs	r2, #3
@   0x08004d2c: f001        fd36 	bl	0x679c
@   0x08004d30: 0600        lsls	r0, r0, #24
@   0x08004d32: 2800        cmp	r0, #0
@   0x08004d34: d00e        beq.n	0x4d54
@   0x08004d36: 483a        ldr	r0, [pc, #232]	@ (0x4e20)
@   0x08004d38: 493a        ldr	r1, [pc, #232]	@ (0x4e24)
@   0x08004d3a: 1840        adds	r0, r0, r1
@   0x08004d3c: 2100        movs	r1, #0
@   0x08004d3e: 8001        strh	r1, [r0, #0]
@   0x08004d40: 1c20        adds	r0, r4, #0
@   0x08004d42: 2103        movs	r1, #3
@   0x08004d44: 2204        movs	r2, #4
@   0x08004d46: f001        fc5b 	bl	0x6600
@   0x08004d4a: 1c20        adds	r0, r4, #0
@   0x08004d4c: 2103        movs	r1, #3
@   0x08004d4e: 2203        movs	r2, #3
@   0x08004d50: f001        fcb8 	bl	0x66c4
@   0x08004d54: 1c20        adds	r0, r4, #0
@   0x08004d56: 2103        movs	r1, #3
@   0x08004d58: 2204        movs	r2, #4
@   0x08004d5a: f001        fd1f 	bl	0x679c
@   0x08004d5e: 0600        lsls	r0, r0, #24
@   0x08004d60: 2800        cmp	r0, #0
@   0x08004d62: d02a        beq.n	0x4dba
@   0x08004d64: 1c20        adds	r0, r4, #0
@   0x08004d66: 2103        movs	r1, #3
@   0x08004d68: 2205        movs	r2, #5
@   0x08004d6a: f001        fc49 	bl	0x6600
@   0x08004d6e: 1c20        adds	r0, r4, #0
@   0x08004d70: 2103        movs	r1, #3
@   0x08004d72: 2200        movs	r2, #0
@   0x08004d74: f001        fc44 	bl	0x6600
@   0x08004d78: 1c20        adds	r0, r4, #0
@   0x08004d7a: 2103        movs	r1, #3
@   0x08004d7c: 2206        movs	r2, #6
@   0x08004d7e: f001        fca1 	bl	0x66c4
@   0x08004d82: 1c20        adds	r0, r4, #0
@   0x08004d84: 3033        adds	r0, #51	@ 0x33
@   0x08004d86: 7800        ldrb	r0, [r0, #0]
@   0x08004d88: 2801        cmp	r0, #1
@   0x08004d8a: d10b        bne.n	0x4da4
@   0x08004d8c: f010        fe60 	bl	0x15a50
@   0x08004d90: 4640        mov	r0, r8
@   0x08004d92: 4649        mov	r1, r9
@   0x08004d94: 221d        movs	r2, #29
@   0x08004d96: f007        f83f 	bl	0xbe18
@   0x08004d9a: 4650        mov	r0, sl
@   0x08004d9c: 9901        ldr	r1, [sp, #4]
@   0x08004d9e: 221e        movs	r2, #30
@   0x08004da0: f007        f83a 	bl	0xbe18
@   0x08004da4: 1c21        adds	r1, r4, #0
@   0x08004da6: 312a        adds	r1, #42	@ 0x2a
@   0x08004da8: 2000        movs	r0, #0
@   0x08004daa: 7008        strb	r0, [r1, #0]
@   0x08004dac: 3101        adds	r1, #1
@   0x08004dae: 7008        strb	r0, [r1, #0]
@   0x08004db0: 1c20        adds	r0, r4, #0
@   0x08004db2: 2103        movs	r1, #3
@   0x08004db4: 2204        movs	r2, #4
@   0x08004db6: f001        fc85 	bl	0x66c4
@   0x08004dba: 4e1b        ldr	r6, [pc, #108]	@ (0x4e28)
@   0x08004dbc: 7932        ldrb	r2, [r6, #4]
@   0x08004dbe: 2a05        cmp	r2, #5
@   0x08004dc0: d172        bne.n	0x4ea8
@   0x08004dc2: 4d16        ldr	r5, [pc, #88]	@ (0x4e1c)
@   0x08004dc4: 1c2f        adds	r7, r5, #0
@   0x08004dc6: 3733        adds	r7, #51	@ 0x33
@   0x08004dc8: 7838        ldrb	r0, [r7, #0]
@   0x08004dca: 3001        adds	r0, #1
@   0x08004dcc: 2100        movs	r1, #0
@   0x08004dce: 7038        strb	r0, [r7, #0]
@   0x08004dd0: 2400        movs	r4, #0
@   0x08004dd2: 8029        strh	r1, [r5, #0]
@   0x08004dd4: 7134        strb	r4, [r6, #4]
@   0x08004dd6: 1c29        adds	r1, r5, #0
@   0x08004dd8: 312a        adds	r1, #42	@ 0x2a
@   0x08004dda: 700c        strb	r4, [r1, #0]
@   0x08004ddc: 3101        adds	r1, #1
@   0x08004dde: 700c        strb	r4, [r1, #0]
@   0x08004de0: 0600        lsls	r0, r0, #24
@   0x08004de2: 0e00        lsrs	r0, r0, #24
@   0x08004de4: 2804        cmp	r0, #4
@   0x08004de6: d121        bne.n	0x4e2c
@   0x08004de8: 7e30        ldrb	r0, [r6, #24]
@   0x08004dea: 7e71        ldrb	r1, [r6, #25]
@   0x08004dec: 240f        movs	r4, #15
@   0x08004dee: 9400        str	r4, [sp, #0]
@   0x08004df0: 2207        movs	r2, #7
@   0x08004df2: 2304        movs	r3, #4
@   0x08004df4: f007        fef8 	bl	0xcbe8
@   0x08004df8: 7e30        ldrb	r0, [r6, #24]
@   0x08004dfa: 7e71        ldrb	r1, [r6, #25]
@   0x08004dfc: 9400        str	r4, [sp, #0]
@   0x08004dfe: 2206        movs	r2, #6
@   0x08004e00: 2304        movs	r3, #4
@   0x08004e02: f007        fef1 	bl	0xcbe8
@   0x08004e06: 2008        movs	r0, #8
@   0x08004e08: 8deb        ldrh	r3, [r5, #46]	@ 0x2e
@   0x08004e0a: 4318        orrs	r0, r3
@   0x08004e0c: 85e8        strh	r0, [r5, #46]	@ 0x2e
@   0x08004e0e: 1c28        adds	r0, r5, #0
@   0x08004e10: 2103        movs	r1, #3
@   0x08004e12: 2207        movs	r2, #7
@   0x08004e14: f001        fc56 	bl	0x66c4
@   0x08004e18: e0b5        b.n	0x4f86
@   0x08004e1a: 0000        movs	r0, r0
@   0x08004e1c: 6110        str	r0, [r2, #16]
@   0x08004e1e: 0300        lsls	r0, r0, #12
@   0x08004e20: 3720        adds	r7, #32
@   0x08004e22: 0300        lsls	r0, r0, #12
@   0x08004e24: 0af2        lsrs	r2, r6, #11
@   0x08004e26: 0000        movs	r0, r0
@   0x08004e28: 35e0        adds	r5, #224	@ 0xe0
@   0x08004e2a: 0300        lsls	r0, r0, #12
@   0x08004e2c: 1c28        adds	r0, r5, #0
@   0x08004e2e: 2103        movs	r1, #3
@   0x08004e30: 2207        movs	r2, #7
@   0x08004e32: f001        fc47 	bl	0x66c4
@   0x08004e36: 783d        ldrb	r5, [r7, #0]
@   0x08004e38: 2d01        cmp	r5, #1
@   0x08004e3a: d109        bne.n	0x4e50
@   0x08004e3c: 4640        mov	r0, r8
@   0x08004e3e: 4649        mov	r1, r9
@   0x08004e40: 221d        movs	r2, #29
@   0x08004e42: f006        ffe9 	bl	0xbe18
@   0x08004e46: 4650        mov	r0, sl
@   0x08004e48: 9901        ldr	r1, [sp, #4]
@   0x08004e4a: 221e        movs	r2, #30
@   0x08004e4c: f006        ffe4 	bl	0xbe18
@   0x08004e50: 783f        ldrb	r7, [r7, #0]
@   0x08004e52: 2f02        cmp	r7, #2
@   0x08004e54: d10b        bne.n	0x4e6e
@   0x08004e56: 4640        mov	r0, r8
@   0x08004e58: 4649        mov	r1, r9
@   0x08004e5a: 221d        movs	r2, #29
@   0x08004e5c: f006        ffdc 	bl	0xbe18
@   0x08004e60: 4650        mov	r0, sl
@   0x08004e62: 9901        ldr	r1, [sp, #4]
@   0x08004e64: 221e        movs	r2, #30
@   0x08004e66: f006        ffd7 	bl	0xbe18
@   0x08004e6a: f010        fe09 	bl	0x15a80
@   0x08004e6e: f00d        fb2f 	bl	0x124d0
@   0x08004e72: 201c        movs	r0, #28
@   0x08004e74: f01b        ff00 	bl	0x20c78
@   0x08004e78: 4a47        ldr	r2, [pc, #284]	@ (0x4f98)
@   0x08004e7a: 20b1        movs	r0, #177	@ 0xb1
@   0x08004e7c: 0100        lsls	r0, r0, #4
@   0x08004e7e: 1811        adds	r1, r2, r0
@   0x08004e80: 4846        ldr	r0, [pc, #280]	@ (0x4f9c)
@   0x08004e82: 6800        ldr	r0, [r0, #0]
@   0x08004e84: 6008        str	r0, [r1, #0]
@   0x08004e86: 2308        movs	r3, #8
@   0x08004e88: 32dc        adds	r2, #220	@ 0xdc
@   0x08004e8a: 210f        movs	r1, #15
@   0x08004e8c: 8810        ldrh	r0, [r2, #0]
@   0x08004e8e: 4318        orrs	r0, r3
@   0x08004e90: 8010        strh	r0, [r2, #0]
@   0x08004e92: 3238        adds	r2, #56	@ 0x38
@   0x08004e94: 3901        subs	r1, #1
@   0x08004e96: 2900        cmp	r1, #0
@   0x08004e98: daf8        bge.n	0x4e8c
@   0x08004e9a: f011        fdd1 	bl	0x16a40
@   0x08004e9e: 4840        ldr	r0, [pc, #256]	@ (0x4fa0)
@   0x08004ea0: 2103        movs	r1, #3
@   0x08004ea2: 2208        movs	r2, #8
@   0x08004ea4: f001        fbac 	bl	0x6600
@   0x08004ea8: 4c3d        ldr	r4, [pc, #244]	@ (0x4fa0)
@   0x08004eaa: 1c20        adds	r0, r4, #0
@   0x08004eac: 2103        movs	r1, #3
@   0x08004eae: 2209        movs	r2, #9
@   0x08004eb0: f001        fc74 	bl	0x679c
@   0x08004eb4: 0600        lsls	r0, r0, #24
@   0x08004eb6: 2800        cmp	r0, #0
@   0x08004eb8: d01b        beq.n	0x4ef2
@   0x08004eba: 4938        ldr	r1, [pc, #224]	@ (0x4f9c)
@   0x08004ebc: 4836        ldr	r0, [pc, #216]	@ (0x4f98)
@   0x08004ebe: 4a39        ldr	r2, [pc, #228]	@ (0x4fa4)
@   0x08004ec0: 1880        adds	r0, r0, r2
@   0x08004ec2: 6809        ldr	r1, [r1, #0]
@   0x08004ec4: 6800        ldr	r0, [r0, #0]
@   0x08004ec6: 1a09        subs	r1, r1, r0
@   0x08004ec8: 2978        cmp	r1, #120	@ 0x78
@   0x08004eca: d912        bls.n	0x4ef2
@   0x08004ecc: 1c20        adds	r0, r4, #0
@   0x08004ece: 2103        movs	r1, #3
@   0x08004ed0: 2200        movs	r2, #0
@   0x08004ed2: f001        fb95 	bl	0x6600
@   0x08004ed6: 1c20        adds	r0, r4, #0
@   0x08004ed8: 2103        movs	r1, #3
@   0x08004eda: 2205        movs	r2, #5
@   0x08004edc: f001        fb90 	bl	0x6600
@   0x08004ee0: 1c21        adds	r1, r4, #0
@   0x08004ee2: 312b        adds	r1, #43	@ 0x2b
@   0x08004ee4: 2000        movs	r0, #0
@   0x08004ee6: 7008        strb	r0, [r1, #0]
@   0x08004ee8: 1c20        adds	r0, r4, #0
@   0x08004eea: 2103        movs	r1, #3
@   0x08004eec: 2209        movs	r2, #9
@   0x08004eee: f001        fbe9 	bl	0x66c4
@   0x08004ef2: 4c2b        ldr	r4, [pc, #172]	@ (0x4fa0)
@   0x08004ef4: 1c20        adds	r0, r4, #0
@   0x08004ef6: 3033        adds	r0, #51	@ 0x33
@   0x08004ef8: 7800        ldrb	r0, [r0, #0]
@   0x08004efa: 2801        cmp	r0, #1
@   0x08004efc: d119        bne.n	0x4f32
@   0x08004efe: 1c20        adds	r0, r4, #0
@   0x08004f00: 2103        movs	r1, #3
@   0x08004f02: 2200        movs	r2, #0
@   0x08004f04: f001        fc4a 	bl	0x679c
@   0x08004f08: 0600        lsls	r0, r0, #24
@   0x08004f0a: 2800        cmp	r0, #0
@   0x08004f0c: d107        bne.n	0x4f1e
@   0x08004f0e: 1c20        adds	r0, r4, #0
@   0x08004f10: 2103        movs	r1, #3
@   0x08004f12: 2207        movs	r2, #7
@   0x08004f14: f001        fc42 	bl	0x679c
@   0x08004f18: 0600        lsls	r0, r0, #24
@   0x08004f1a: 2800        cmp	r0, #0
@   0x08004f1c: d009        beq.n	0x4f32
@   0x08004f1e: 4640        mov	r0, r8
@   0x08004f20: 4649        mov	r1, r9
@   0x08004f22: 221d        movs	r2, #29
@   0x08004f24: f006        fffe 	bl	0xbf24
@   0x08004f28: 4650        mov	r0, sl
@   0x08004f2a: 9901        ldr	r1, [sp, #4]
@   0x08004f2c: 221e        movs	r2, #30
@   0x08004f2e: f006        fff9 	bl	0xbf24
@   0x08004f32: 4c1d        ldr	r4, [pc, #116]	@ (0x4fa8)
@   0x08004f34: 2010        movs	r0, #16
@   0x08004f36: 8a23        ldrh	r3, [r4, #16]
@   0x08004f38: 4018        ands	r0, r3
@   0x08004f3a: 2800        cmp	r0, #0
@   0x08004f3c: d023        beq.n	0x4f86
@   0x08004f3e: 4818        ldr	r0, [pc, #96]	@ (0x4fa0)
@   0x08004f40: 1c01        adds	r1, r0, #0
@   0x08004f42: 3133        adds	r1, #51	@ 0x33
@   0x08004f44: 7809        ldrb	r1, [r1, #0]
@   0x08004f46: 2901        cmp	r1, #1
@   0x08004f48: d11d        bne.n	0x4f86
@   0x08004f4a: 2103        movs	r1, #3
@   0x08004f4c: 2200        movs	r2, #0
@   0x08004f4e: f001        fc25 	bl	0x679c
@   0x08004f52: 0600        lsls	r0, r0, #24
@   0x08004f54: 2800        cmp	r0, #0
@   0x08004f56: d016        beq.n	0x4f86
@   0x08004f58: 7e20        ldrb	r0, [r4, #24]
@   0x08004f5a: 7e61        ldrb	r1, [r4, #25]
@   0x08004f5c: 2508        movs	r5, #8
@   0x08004f5e: 5f62        ldrsh	r2, [r4, r5]
@   0x08004f60: 250a        movs	r5, #10
@   0x08004f62: 5f63        ldrsh	r3, [r4, r5]
@   0x08004f64: f007        ff10 	bl	0xcd88
@   0x08004f68: 1c04        adds	r4, r0, #0
@   0x08004f6a: 0624        lsls	r4, r4, #24
@   0x08004f6c: 0e24        lsrs	r4, r4, #24
@   0x08004f6e: 4640        mov	r0, r8
@   0x08004f70: 4649        mov	r1, r9
@   0x08004f72: 221d        movs	r2, #29
@   0x08004f74: 1c23        adds	r3, r4, #0
@   0x08004f76: f006        ffa1 	bl	0xbebc
@   0x08004f7a: 4650        mov	r0, sl
@   0x08004f7c: 9901        ldr	r1, [sp, #4]
@   0x08004f7e: 221e        movs	r2, #30
@   0x08004f80: 1c23        adds	r3, r4, #0
@   0x08004f82: f006        ff9b 	bl	0xbebc
@   0x08004f86: b002        add	sp, #8
@   0x08004f88: bc38        pop	{r3, r4, r5}
@   0x08004f8a: 4698        mov	r8, r3
@   0x08004f8c: 46a1        mov	r9, r4
@   0x08004f8e: 46aa        mov	sl, r5
@   0x08004f90: bcf0        pop	{r4, r5, r6, r7}
@   0x08004f92: bc01        pop	{r0}
@   0x08004f94: 4700        bx	r0
@   0x08004f96: 0000        movs	r0, r0
@   0x08004f98: 3720        adds	r7, #32
@   0x08004f9a: 0300        lsls	r0, r0, #12
@   0x08004f9c: 5330        strh	r0, [r6, r4]
@   0x08004f9e: 0300        lsls	r0, r0, #12
@   0x08004fa0: 6110        str	r0, [r2, #16]
@   0x08004fa2: 0300        lsls	r0, r0, #12
@   0x08004fa4: 0b48        lsrs	r0, r1, #13
@   0x08004fa6: 0000        movs	r0, r0
@   0x08004fa8: 35e0        adds	r5, #224	@ 0xe0
@   0x08004faa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004D10
sub_08004D10: @ 0x08004d10
        .incbin "frog_us_baserom.gba", 0x4d10, 0x29c
        thumb_func_end sub_08004D10
