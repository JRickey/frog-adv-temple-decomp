@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011e40, 0x08012098)  (600 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011e40 --end 0x8012098 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011e40: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08011e42: 4657        mov	r7, sl
@   0x08011e44: 464e        mov	r6, r9
@   0x08011e46: 4645        mov	r5, r8
@   0x08011e48: b4e0        push	{r5, r6, r7}
@   0x08011e4a: b081        sub	sp, #4
@   0x08011e4c: 2000        movs	r0, #0
@   0x08011e4e: 4682        mov	sl, r0
@   0x08011e50: 482f        ldr	r0, [pc, #188]	@ (0x11f10)
@   0x08011e52: 1c01        adds	r1, r0, #0
@   0x08011e54: 312a        adds	r1, #42	@ 0x2a
@   0x08011e56: 1c02        adds	r2, r0, #0
@   0x08011e58: 322b        adds	r2, #43	@ 0x2b
@   0x08011e5a: 7809        ldrb	r1, [r1, #0]
@   0x08011e5c: 7812        ldrb	r2, [r2, #0]
@   0x08011e5e: 4291        cmp	r1, r2
@   0x08011e60: d045        beq.n	0x11eee
@   0x08011e62: 2400        movs	r4, #0
@   0x08011e64: 1c07        adds	r7, r0, #0
@   0x08011e66: 2101        movs	r1, #1
@   0x08011e68: 4688        mov	r8, r1
@   0x08011e6a: 2200        movs	r2, #0
@   0x08011e6c: 4691        mov	r9, r2
@   0x08011e6e: 4d29        ldr	r5, [pc, #164]	@ (0x11f14)
@   0x08011e70: 1c38        adds	r0, r7, #0
@   0x08011e72: 302a        adds	r0, #42	@ 0x2a
@   0x08011e74: 7801        ldrb	r1, [r0, #0]
@   0x08011e76: 4121        asrs	r1, r4
@   0x08011e78: 4640        mov	r0, r8
@   0x08011e7a: 4001        ands	r1, r0
@   0x08011e7c: 2900        cmp	r1, #0
@   0x08011e7e: d031        beq.n	0x11ee4
@   0x08011e80: 1c3e        adds	r6, r7, #0
@   0x08011e82: 362b        adds	r6, #43	@ 0x2b
@   0x08011e84: 7830        ldrb	r0, [r6, #0]
@   0x08011e86: 4120        asrs	r0, r4
@   0x08011e88: 4642        mov	r2, r8
@   0x08011e8a: 4010        ands	r0, r2
@   0x08011e8c: 4281        cmp	r1, r0
@   0x08011e8e: d029        beq.n	0x11ee4
@   0x08011e90: 4668        mov	r0, sp
@   0x08011e92: 4649        mov	r1, r9
@   0x08011e94: 8001        strh	r1, [r0, #0]
@   0x08011e96: 6028        str	r0, [r5, #0]
@   0x08011e98: 481f        ldr	r0, [pc, #124]	@ (0x11f18)
@   0x08011e9a: 6068        str	r0, [r5, #4]
@   0x08011e9c: 481f        ldr	r0, [pc, #124]	@ (0x11f1c)
@   0x08011e9e: 60a8        str	r0, [r5, #8]
@   0x08011ea0: 68a8        ldr	r0, [r5, #8]
@   0x08011ea2: 4668        mov	r0, sp
@   0x08011ea4: 8001        strh	r1, [r0, #0]
@   0x08011ea6: 6028        str	r0, [r5, #0]
@   0x08011ea8: 481d        ldr	r0, [pc, #116]	@ (0x11f20)
@   0x08011eaa: 6068        str	r0, [r5, #4]
@   0x08011eac: 481d        ldr	r0, [pc, #116]	@ (0x11f24)
@   0x08011eae: 60a8        str	r0, [r5, #8]
@   0x08011eb0: 68a8        ldr	r0, [r5, #8]
@   0x08011eb2: 0061        lsls	r1, r4, #1
@   0x08011eb4: 1909        adds	r1, r1, r4
@   0x08011eb6: 0609        lsls	r1, r1, #24
@   0x08011eb8: 0e09        lsrs	r1, r1, #24
@   0x08011eba: 481b        ldr	r0, [pc, #108]	@ (0x11f28)
@   0x08011ebc: f7ff        fd62 	bl	0x11984
@   0x08011ec0: 2002        movs	r0, #2
@   0x08011ec2: f7fc        ffe7 	bl	0xee94
@   0x08011ec6: 4919        ldr	r1, [pc, #100]	@ (0x11f2c)
@   0x08011ec8: 4a19        ldr	r2, [pc, #100]	@ (0x11f30)
@   0x08011eca: 1c10        adds	r0, r2, #0
@   0x08011ecc: 8008        strh	r0, [r1, #0]
@   0x08011ece: 3102        adds	r1, #2
@   0x08011ed0: 4a18        ldr	r2, [pc, #96]	@ (0x11f34)
@   0x08011ed2: 1c10        adds	r0, r2, #0
@   0x08011ed4: 8008        strh	r0, [r1, #0]
@   0x08011ed6: 4640        mov	r0, r8
@   0x08011ed8: 40a0        lsls	r0, r4
@   0x08011eda: 7831        ldrb	r1, [r6, #0]
@   0x08011edc: 4308        orrs	r0, r1
@   0x08011ede: 7030        strb	r0, [r6, #0]
@   0x08011ee0: 4815        ldr	r0, [pc, #84]	@ (0x11f38)
@   0x08011ee2: 7084        strb	r4, [r0, #2]
@   0x08011ee4: 1c60        adds	r0, r4, #1
@   0x08011ee6: 0400        lsls	r0, r0, #16
@   0x08011ee8: 0c04        lsrs	r4, r0, #16
@   0x08011eea: 2c01        cmp	r4, #1
@   0x08011eec: d9c0        bls.n	0x11e70
@   0x08011eee: 480e        ldr	r0, [pc, #56]	@ (0x11f28)
@   0x08011ef0: f7ff        fdd8 	bl	0x11aa4
@   0x08011ef4: 0600        lsls	r0, r0, #24
@   0x08011ef6: 2800        cmp	r0, #0
@   0x08011ef8: d001        beq.n	0x11efe
@   0x08011efa: 2201        movs	r2, #1
@   0x08011efc: 4692        mov	sl, r2
@   0x08011efe: 4650        mov	r0, sl
@   0x08011f00: b001        add	sp, #4
@   0x08011f02: bc38        pop	{r3, r4, r5}
@   0x08011f04: 4698        mov	r8, r3
@   0x08011f06: 46a1        mov	r9, r4
@   0x08011f08: 46aa        mov	sl, r5
@   0x08011f0a: bcf0        pop	{r4, r5, r6, r7}
@   0x08011f0c: bc02        pop	{r1}
@   0x08011f0e: 4708        bx	r1
@   0x08011f10: 6110        str	r0, [r2, #16]
@   0x08011f12: 0300        lsls	r0, r0, #12
@   0x08011f14: 00d4        lsls	r4, r2, #3
@   0x08011f16: 0400        lsls	r0, r0, #16
@   0x08011f18: f000        0600 	and.w	r6, r0, #0
@   0x08011f1c: 0400        lsls	r0, r0, #16
@   0x08011f1e: 8100        strh	r0, [r0, #8]
@   0x08011f20: 0000        movs	r0, r0
@   0x08011f22: 0202        lsls	r2, r0, #8
@   0x08011f24: 8000        strh	r0, [r0, #0]
@   0x08011f26: 8100        strh	r0, [r0, #8]
@   0x08011f28: 6d40        ldr	r0, [r0, #84]	@ 0x54
@   0x08011f2a: 0830        lsrs	r0, r6, #32
@   0x08011f2c: 0050        lsls	r0, r2, #1
@   0x08011f2e: 0400        lsls	r0, r0, #16
@   0x08011f30: 1744        asrs	r4, r0, #29
@   0x08011f32: 0000        movs	r0, r0
@   0x08011f34: 020e        lsls	r6, r1, #8
@   0x08011f36: 0000        movs	r0, r0
@   0x08011f38: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08011f3a: 0300        lsls	r0, r0, #12
@   0x08011f3c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08011f3e: 4657        mov	r7, sl
@   0x08011f40: 464e        mov	r6, r9
@   0x08011f42: 4645        mov	r5, r8
@   0x08011f44: b4e0        push	{r5, r6, r7}
@   0x08011f46: b082        sub	sp, #8
@   0x08011f48: 4682        mov	sl, r0
@   0x08011f4a: 0609        lsls	r1, r1, #24
@   0x08011f4c: 0e09        lsrs	r1, r1, #24
@   0x08011f4e: 4689        mov	r9, r1
@   0x08011f50: 494c        ldr	r1, [pc, #304]	@ (0x12084)
@   0x08011f52: 2000        movs	r0, #0
@   0x08011f54: 7008        strb	r0, [r1, #0]
@   0x08011f56: 494c        ldr	r1, [pc, #304]	@ (0x12088)
@   0x08011f58: 2001        movs	r0, #1
@   0x08011f5a: 7008        strb	r0, [r1, #0]
@   0x08011f5c: 7248        strb	r0, [r1, #9]
@   0x08011f5e: 4648        mov	r0, r9
@   0x08011f60: 00c5        lsls	r5, r0, #3
@   0x08011f62: 1a2a        subs	r2, r5, r0
@   0x08011f64: 0092        lsls	r2, r2, #2
@   0x08011f66: 4452        add	r2, sl
@   0x08011f68: 1c14        adds	r4, r2, #0
@   0x08011f6a: 341c        adds	r4, #28
@   0x08011f6c: 8860        ldrh	r0, [r4, #2]
@   0x08011f6e: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x08011f70: 8b90        ldrh	r0, [r2, #28]
@   0x08011f72: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08011f74: 6920        ldr	r0, [r4, #16]
@   0x08011f76: 6108        str	r0, [r1, #16]
@   0x08011f78: 2002        movs	r0, #2
@   0x08011f7a: 7208        strb	r0, [r1, #8]
@   0x08011f7c: 4843        ldr	r0, [pc, #268]	@ (0x1208c)
@   0x08011f7e: 6188        str	r0, [r1, #24]
@   0x08011f80: 7b20        ldrb	r0, [r4, #12]
@   0x08011f82: 72c8        strb	r0, [r1, #11]
@   0x08011f84: 88a0        ldrh	r0, [r4, #4]
@   0x08011f86: 8608        strh	r0, [r1, #48]	@ 0x30
@   0x08011f88: 88e3        ldrh	r3, [r4, #6]
@   0x08011f8a: 864b        strh	r3, [r1, #50]	@ 0x32
@   0x08011f8c: 8588        strh	r0, [r1, #44]	@ 0x2c
@   0x08011f8e: 85cb        strh	r3, [r1, #46]	@ 0x2e
@   0x08011f90: 493f        ldr	r1, [pc, #252]	@ (0x12090)
@   0x08011f92: 8b4e        ldrh	r6, [r1, #26]
@   0x08011f94: 8864        ldrh	r4, [r4, #2]
@   0x08011f96: 1c30        adds	r0, r6, #0
@   0x08011f98: 4360        muls	r0, r4
@   0x08011f9a: 8b92        ldrh	r2, [r2, #28]
@   0x08011f9c: 1810        adds	r0, r2, r0
@   0x08011f9e: 0040        lsls	r0, r0, #1
@   0x08011fa0: 4f3a        ldr	r7, [pc, #232]	@ (0x1208c)
@   0x08011fa2: 19c0        adds	r0, r0, r7
@   0x08011fa4: 4a38        ldr	r2, [pc, #224]	@ (0x12088)
@   0x08011fa6: 6190        str	r0, [r2, #24]
@   0x08011fa8: 1c04        adds	r4, r0, #0
@   0x08011faa: 041b        lsls	r3, r3, #16
@   0x08011fac: 2200        movs	r2, #0
@   0x08011fae: 9500        str	r5, [sp, #0]
@   0x08011fb0: 4688        mov	r8, r1
@   0x08011fb2: 4e38        ldr	r6, [pc, #224]	@ (0x12094)
@   0x08011fb4: 46b4        mov	ip, r6
@   0x08011fb6: 2b00        cmp	r3, #0
@   0x08011fb8: d02a        beq.n	0x12010
@   0x08011fba: 4f33        ldr	r7, [pc, #204]	@ (0x12088)
@   0x08011fbc: 693b        ldr	r3, [r7, #16]
@   0x08011fbe: 2000        movs	r0, #0
@   0x08011fc0: 3201        adds	r2, #1
@   0x08011fc2: 9201        str	r2, [sp, #4]
@   0x08011fc4: 4661        mov	r1, ip
@   0x08011fc6: 8e49        ldrh	r1, [r1, #50]	@ 0x32
@   0x08011fc8: 4288        cmp	r0, r1
@   0x08011fca: d21a        bcs.n	0x12002
@   0x08011fcc: 4931        ldr	r1, [pc, #196]	@ (0x12094)
@   0x08011fce: 2200        movs	r2, #0
@   0x08011fd0: 1c45        adds	r5, r0, #1
@   0x08011fd2: 8e0e        ldrh	r6, [r1, #48]	@ 0x30
@   0x08011fd4: 42b2        cmp	r2, r6
@   0x08011fd6: d209        bcs.n	0x11fec
@   0x08011fd8: 8818        ldrh	r0, [r3, #0]
@   0x08011fda: 8020        strh	r0, [r4, #0]
@   0x08011fdc: 3302        adds	r3, #2
@   0x08011fde: 3402        adds	r4, #2
@   0x08011fe0: 1c50        adds	r0, r2, #1
@   0x08011fe2: 0400        lsls	r0, r0, #16
@   0x08011fe4: 0c02        lsrs	r2, r0, #16
@   0x08011fe6: 8e0f        ldrh	r7, [r1, #48]	@ 0x30
@   0x08011fe8: 42ba        cmp	r2, r7
@   0x08011fea: d3f5        bcc.n	0x11fd8
@   0x08011fec: 4642        mov	r2, r8
@   0x08011fee: 8b52        ldrh	r2, [r2, #26]
@   0x08011ff0: 8e0e        ldrh	r6, [r1, #48]	@ 0x30
@   0x08011ff2: 1b90        subs	r0, r2, r6
@   0x08011ff4: 0040        lsls	r0, r0, #1
@   0x08011ff6: 1824        adds	r4, r4, r0
@   0x08011ff8: 0428        lsls	r0, r5, #16
@   0x08011ffa: 0c00        lsrs	r0, r0, #16
@   0x08011ffc: 8e4f        ldrh	r7, [r1, #50]	@ 0x32
@   0x08011ffe: 42b8        cmp	r0, r7
@   0x08012000: d3e5        bcc.n	0x11fce
@   0x08012002: 9901        ldr	r1, [sp, #4]
@   0x08012004: 0408        lsls	r0, r1, #16
@   0x08012006: 0c02        lsrs	r2, r0, #16
@   0x08012008: 4b1f        ldr	r3, [pc, #124]	@ (0x12088)
@   0x0801200a: 8e5b        ldrh	r3, [r3, #50]	@ 0x32
@   0x0801200c: 429a        cmp	r2, r3
@   0x0801200e: d3d4        bcc.n	0x11fba
@   0x08012010: 9e00        ldr	r6, [sp, #0]
@   0x08012012: 464f        mov	r7, r9
@   0x08012014: 1bf0        subs	r0, r6, r7
@   0x08012016: 0080        lsls	r0, r0, #2
@   0x08012018: 4450        add	r0, sl
@   0x0801201a: 4661        mov	r1, ip
@   0x0801201c: 8e4e        ldrh	r6, [r1, #50]	@ 0x32
@   0x0801201e: 8e0d        ldrh	r5, [r1, #48]	@ 0x30
@   0x08012020: 6c83        ldr	r3, [r0, #72]	@ 0x48
@   0x08012022: 1c22        adds	r2, r4, #0
@   0x08012024: 2000        movs	r0, #0
@   0x08012026: 42b0        cmp	r0, r6
@   0x08012028: d215        bcs.n	0x12056
@   0x0801202a: 4f19        ldr	r7, [pc, #100]	@ (0x12090)
@   0x0801202c: 2100        movs	r1, #0
@   0x0801202e: 1c44        adds	r4, r0, #1
@   0x08012030: 42a9        cmp	r1, r5
@   0x08012032: d208        bcs.n	0x12046
@   0x08012034: 8818        ldrh	r0, [r3, #0]
@   0x08012036: 8010        strh	r0, [r2, #0]
@   0x08012038: 3302        adds	r3, #2
@   0x0801203a: 3202        adds	r2, #2
@   0x0801203c: 1c48        adds	r0, r1, #1
@   0x0801203e: 0400        lsls	r0, r0, #16
@   0x08012040: 0c01        lsrs	r1, r0, #16
@   0x08012042: 42a9        cmp	r1, r5
@   0x08012044: d3f6        bcc.n	0x12034
@   0x08012046: 8b79        ldrh	r1, [r7, #26]
@   0x08012048: 1b48        subs	r0, r1, r5
@   0x0801204a: 0040        lsls	r0, r0, #1
@   0x0801204c: 1812        adds	r2, r2, r0
@   0x0801204e: 0420        lsls	r0, r4, #16
@   0x08012050: 0c00        lsrs	r0, r0, #16
@   0x08012052: 42b0        cmp	r0, r6
@   0x08012054: d3ea        bcc.n	0x1202c
@   0x08012056: 9a00        ldr	r2, [sp, #0]
@   0x08012058: 464b        mov	r3, r9
@   0x0801205a: 1ad0        subs	r0, r2, r3
@   0x0801205c: 0080        lsls	r0, r0, #2
@   0x0801205e: 4450        add	r0, sl
@   0x08012060: 88c6        ldrh	r6, [r0, #6]
@   0x08012062: 8c47        ldrh	r7, [r0, #34]	@ 0x22
@   0x08012064: 1c31        adds	r1, r6, #0
@   0x08012066: 4379        muls	r1, r7
@   0x08012068: 8bc0        ldrh	r0, [r0, #30]
@   0x0801206a: 1809        adds	r1, r1, r0
@   0x0801206c: 2000        movs	r0, #0
@   0x0801206e: 4a06        ldr	r2, [pc, #24]	@ (0x12088)
@   0x08012070: 86d1        strh	r1, [r2, #54]	@ 0x36
@   0x08012072: 85d0        strh	r0, [r2, #46]	@ 0x2e
@   0x08012074: b002        add	sp, #8
@   0x08012076: bc38        pop	{r3, r4, r5}
@   0x08012078: 4698        mov	r8, r3
@   0x0801207a: 46a1        mov	r9, r4
@   0x0801207c: 46aa        mov	sl, r5
@   0x0801207e: bcf0        pop	{r4, r5, r6, r7}
@   0x08012080: bc01        pop	{r0}
@   0x08012082: 4700        bx	r0
@   0x08012084: 53a0        strh	r0, [r4, r6]
@   0x08012086: 0300        lsls	r0, r0, #12
@   0x08012088: 6480        str	r0, [r0, #72]	@ 0x48
@   0x0801208a: 0300        lsls	r0, r0, #12
@   0x0801208c: 0000        movs	r0, r0
@   0x0801208e: 0202        lsls	r2, r0, #8
@   0x08012090: 60a0        str	r0, [r4, #8]
@   0x08012092: 0300        lsls	r0, r0, #12
@   0x08012094: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08012096: 0300        lsls	r0, r0, #12

        thumb_func_start Selector_TriggerWindowReveal
Selector_TriggerWindowReveal: @ 0x08011e40
        .incbin "frog_us_baserom.gba", 0x11e40, 0x258
        thumb_func_end Selector_TriggerWindowReveal
