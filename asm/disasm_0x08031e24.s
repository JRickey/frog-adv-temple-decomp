@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031e24, 0x08031fdc)  (440 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031e24 --end 0x8031fdc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031e24: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08031e26: 4657        mov	r7, sl
@   0x08031e28: 464e        mov	r6, r9
@   0x08031e2a: 4645        mov	r5, r8
@   0x08031e2c: b4e0        push	{r5, r6, r7}
@   0x08031e2e: 1c05        adds	r5, r0, #0
@   0x08031e30: 4a39        ldr	r2, [pc, #228]	@ (0x31f18)
@   0x08031e32: 6813        ldr	r3, [r2, #0]
@   0x08031e34: 2188        movs	r1, #136	@ 0x88
@   0x08031e36: 0049        lsls	r1, r1, #1
@   0x08031e38: 1858        adds	r0, r3, r1
@   0x08031e3a: 6800        ldr	r0, [r0, #0]
@   0x08031e3c: 6981        ldr	r1, [r0, #24]
@   0x08031e3e: 1840        adds	r0, r0, r1
@   0x08031e40: 6800        ldr	r0, [r0, #0]
@   0x08031e42: 42a8        cmp	r0, r5
@   0x08031e44: d800        bhi.n	0x31e48
@   0x08031e46: e0c1        b.n	0x31fcc
@   0x08031e48: 248c        movs	r4, #140	@ 0x8c
@   0x08031e4a: 0064        lsls	r4, r4, #1
@   0x08031e4c: 1918        adds	r0, r3, r4
@   0x08031e4e: 6807        ldr	r7, [r0, #0]
@   0x08031e50: 4a32        ldr	r2, [pc, #200]	@ (0x31f1c)
@   0x08031e52: 18b9        adds	r1, r7, r2
@   0x08031e54: 2000        movs	r0, #0
@   0x08031e56: 7008        strb	r0, [r1, #0]
@   0x08031e58: 208a        movs	r0, #138	@ 0x8a
@   0x08031e5a: 0040        lsls	r0, r0, #1
@   0x08031e5c: 183b        adds	r3, r7, r0
@   0x08031e5e: 492e        ldr	r1, [pc, #184]	@ (0x31f18)
@   0x08031e60: 6808        ldr	r0, [r1, #0]
@   0x08031e62: 3a41        subs	r2, #65	@ 0x41
@   0x08031e64: 1880        adds	r0, r0, r2
@   0x08031e66: 6802        ldr	r2, [r0, #0]
@   0x08031e68: 6990        ldr	r0, [r2, #24]
@   0x08031e6a: 00a9        lsls	r1, r5, #2
@   0x08031e6c: 1810        adds	r0, r2, r0
@   0x08031e6e: 1809        adds	r1, r1, r0
@   0x08031e70: 6848        ldr	r0, [r1, #4]
@   0x08031e72: 1812        adds	r2, r2, r0
@   0x08031e74: 4690        mov	r8, r2
@   0x08031e76: 601a        str	r2, [r3, #0]
@   0x08031e78: 1939        adds	r1, r7, r4
@   0x08031e7a: 2403        movs	r4, #3
@   0x08031e7c: ca01        ldmia	r2!, {r0}
@   0x08031e7e: c101        stmia	r1!, {r0}
@   0x08031e80: 3c01        subs	r4, #1
@   0x08031e82: 2c00        cmp	r4, #0
@   0x08031e84: dafa        bge.n	0x31e7c
@   0x08031e86: 23a4        movs	r3, #164	@ 0xa4
@   0x08031e88: 005b        lsls	r3, r3, #1
@   0x08031e8a: 18f9        adds	r1, r7, r3
@   0x08031e8c: 2080        movs	r0, #128	@ 0x80
@   0x08031e8e: 0140        lsls	r0, r0, #5
@   0x08031e90: 8008        strh	r0, [r1, #0]
@   0x08031e92: 2483        movs	r4, #131	@ 0x83
@   0x08031e94: 00e4        lsls	r4, r4, #3
@   0x08031e96: 4444        add	r4, r8
@   0x08031e98: 8820        ldrh	r0, [r4, #0]
@   0x08031e9a: 22a5        movs	r2, #165	@ 0xa5
@   0x08031e9c: 0052        lsls	r2, r2, #1
@   0x08031e9e: 18b9        adds	r1, r7, r2
@   0x08031ea0: 8008        strh	r0, [r1, #0]
@   0x08031ea2: 8820        ldrh	r0, [r4, #0]
@   0x08031ea4: 0201        lsls	r1, r0, #8
@   0x08031ea6: 0240        lsls	r0, r0, #9
@   0x08031ea8: 1840        adds	r0, r0, r1
@   0x08031eaa: 0140        lsls	r0, r0, #5
@   0x08031eac: 21e1        movs	r1, #225	@ 0xe1
@   0x08031eae: 0109        lsls	r1, r1, #4
@   0x08031eb0: f002        f818 	bl	0x33ee4
@   0x08031eb4: 23a6        movs	r3, #166	@ 0xa6
@   0x08031eb6: 005b        lsls	r3, r3, #1
@   0x08031eb8: 18f9        adds	r1, r7, r3
@   0x08031eba: 8008        strh	r0, [r1, #0]
@   0x08031ebc: 8821        ldrh	r1, [r4, #0]
@   0x08031ebe: 0048        lsls	r0, r1, #1
@   0x08031ec0: 1840        adds	r0, r0, r1
@   0x08031ec2: 0440        lsls	r0, r0, #17
@   0x08031ec4: 4b14        ldr	r3, [pc, #80]	@ (0x31f18)
@   0x08031ec6: 681a        ldr	r2, [r3, #0]
@   0x08031ec8: 8854        ldrh	r4, [r2, #2]
@   0x08031eca: 00a1        lsls	r1, r4, #2
@   0x08031ecc: 1909        adds	r1, r1, r4
@   0x08031ece: f002        f809 	bl	0x33ee4
@   0x08031ed2: 22a7        movs	r2, #167	@ 0xa7
@   0x08031ed4: 0052        lsls	r2, r2, #1
@   0x08031ed6: 18b9        adds	r1, r7, r2
@   0x08031ed8: 8008        strh	r0, [r1, #0]
@   0x08031eda: 2182        movs	r1, #130	@ 0x82
@   0x08031edc: 00c9        lsls	r1, r1, #3
@   0x08031ede: 4643        mov	r3, r8
@   0x08031ee0: 1858        adds	r0, r3, r1
@   0x08031ee2: 6800        ldr	r0, [r0, #0]
@   0x08031ee4: 1840        adds	r0, r0, r1
@   0x08031ee6: 2488        movs	r4, #136	@ 0x88
@   0x08031ee8: 19e4        adds	r4, r4, r7
@   0x08031eea: 46a2        mov	sl, r4
@   0x08031eec: 228c        movs	r2, #140	@ 0x8c
@   0x08031eee: 19d2        adds	r2, r2, r7
@   0x08031ef0: 4691        mov	r9, r2
@   0x08031ef2: 2300        movs	r3, #0
@   0x08031ef4: 469c        mov	ip, r3
@   0x08031ef6: 2600        movs	r6, #0
@   0x08031ef8: 1d3b        adds	r3, r7, #4
@   0x08031efa: 1c3a        adds	r2, r7, #0
@   0x08031efc: 4644        mov	r4, r8
@   0x08031efe: 1825        adds	r5, r4, r0
@   0x08031f00: 2410        movs	r4, #16
@   0x08031f02: 6828        ldr	r0, [r5, #0]
@   0x08031f04: 2800        cmp	r0, #0
@   0x08031f06: d00b        beq.n	0x31f20
@   0x08031f08: 2182        movs	r1, #130	@ 0x82
@   0x08031f0a: 00c9        lsls	r1, r1, #3
@   0x08031f0c: 1840        adds	r0, r0, r1
@   0x08031f0e: 4440        add	r0, r8
@   0x08031f10: 6010        str	r0, [r2, #0]
@   0x08031f12: 6800        ldr	r0, [r0, #0]
@   0x08031f14: 0200        lsls	r0, r0, #8
@   0x08031f16: e004        b.n	0x31f22
@   0x08031f18: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031f1a: 0300        lsls	r0, r0, #12
@   0x08031f1c: 0151        lsls	r1, r2, #5
@   0x08031f1e: 0000        movs	r0, r0
@   0x08031f20: 6010        str	r0, [r2, #0]
@   0x08031f22: 6018        str	r0, [r3, #0]
@   0x08031f24: 4651        mov	r1, sl
@   0x08031f26: 1988        adds	r0, r1, r6
@   0x08031f28: 4661        mov	r1, ip
@   0x08031f2a: 6001        str	r1, [r0, #0]
@   0x08031f2c: 4649        mov	r1, r9
@   0x08031f2e: 1988        adds	r0, r1, r6
@   0x08031f30: 4661        mov	r1, ip
@   0x08031f32: 6001        str	r1, [r0, #0]
@   0x08031f34: 3608        adds	r6, #8
@   0x08031f36: 3308        adds	r3, #8
@   0x08031f38: 3208        adds	r2, #8
@   0x08031f3a: 3504        adds	r5, #4
@   0x08031f3c: 3c01        subs	r4, #1
@   0x08031f3e: 2c00        cmp	r4, #0
@   0x08031f40: dadf        bge.n	0x31f02
@   0x08031f42: 22ff        movs	r2, #255	@ 0xff
@   0x08031f44: 2394        movs	r3, #148	@ 0x94
@   0x08031f46: 005b        lsls	r3, r3, #1
@   0x08031f48: 18f9        adds	r1, r7, r3
@   0x08031f4a: 240f        movs	r4, #15
@   0x08031f4c: 7c08        ldrb	r0, [r1, #16]
@   0x08031f4e: 4310        orrs	r0, r2
@   0x08031f50: 7408        strb	r0, [r1, #16]
@   0x08031f52: 7808        ldrb	r0, [r1, #0]
@   0x08031f54: 4310        orrs	r0, r2
@   0x08031f56: 7008        strb	r0, [r1, #0]
@   0x08031f58: 3101        adds	r1, #1
@   0x08031f5a: 3c01        subs	r4, #1
@   0x08031f5c: 2c00        cmp	r4, #0
@   0x08031f5e: daf5        bge.n	0x31f4c
@   0x08031f60: 2400        movs	r4, #0
@   0x08031f62: 4e18        ldr	r6, [pc, #96]	@ (0x31fc4)
@   0x08031f64: 6830        ldr	r0, [r6, #0]
@   0x08031f66: 7800        ldrb	r0, [r0, #0]
@   0x08031f68: 4284        cmp	r4, r0
@   0x08031f6a: da1d        bge.n	0x31fa8
@   0x08031f6c: 2088        movs	r0, #136	@ 0x88
@   0x08031f6e: 0040        lsls	r0, r0, #1
@   0x08031f70: 183a        adds	r2, r7, r0
@   0x08031f72: 2500        movs	r5, #0
@   0x08031f74: 2300        movs	r3, #0
@   0x08031f76: 6810        ldr	r0, [r2, #0]
@   0x08031f78: 1818        adds	r0, r3, r0
@   0x08031f7a: 7105        strb	r5, [r0, #4]
@   0x08031f7c: 6810        ldr	r0, [r2, #0]
@   0x08031f7e: 1818        adds	r0, r3, r0
@   0x08031f80: 7185        strb	r5, [r0, #6]
@   0x08031f82: 6810        ldr	r0, [r2, #0]
@   0x08031f84: 1818        adds	r0, r3, r0
@   0x08031f86: 7205        strb	r5, [r0, #8]
@   0x08031f88: 6810        ldr	r0, [r2, #0]
@   0x08031f8a: 1818        adds	r0, r3, r0
@   0x08031f8c: 6005        str	r5, [r0, #0]
@   0x08031f8e: 6810        ldr	r0, [r2, #0]
@   0x08031f90: 1818        adds	r0, r3, r0
@   0x08031f92: 71c5        strb	r5, [r0, #7]
@   0x08031f94: 6810        ldr	r0, [r2, #0]
@   0x08031f96: 1818        adds	r0, r3, r0
@   0x08031f98: 21ff        movs	r1, #255	@ 0xff
@   0x08031f9a: 7141        strb	r1, [r0, #5]
@   0x08031f9c: 330c        adds	r3, #12
@   0x08031f9e: 3401        adds	r4, #1
@   0x08031fa0: 6830        ldr	r0, [r6, #0]
@   0x08031fa2: 7800        ldrb	r0, [r0, #0]
@   0x08031fa4: 4284        cmp	r4, r0
@   0x08031fa6: dbe6        blt.n	0x31f76
@   0x08031fa8: 21a8        movs	r1, #168	@ 0xa8
@   0x08031faa: 0049        lsls	r1, r1, #1
@   0x08031fac: 1878        adds	r0, r7, r1
@   0x08031fae: 2100        movs	r1, #0
@   0x08031fb0: 7001        strb	r1, [r0, #0]
@   0x08031fb2: 4a04        ldr	r2, [pc, #16]	@ (0x31fc4)
@   0x08031fb4: 6810        ldr	r0, [r2, #0]
@   0x08031fb6: 7041        strb	r1, [r0, #1]
@   0x08031fb8: 4b03        ldr	r3, [pc, #12]	@ (0x31fc8)
@   0x08031fba: 18f9        adds	r1, r7, r3
@   0x08031fbc: 2001        movs	r0, #1
@   0x08031fbe: 7008        strb	r0, [r1, #0]
@   0x08031fc0: e005        b.n	0x31fce
@   0x08031fc2: 0000        movs	r0, r0
@   0x08031fc4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031fc6: 0300        lsls	r0, r0, #12
@   0x08031fc8: 0151        lsls	r1, r2, #5
@   0x08031fca: 0000        movs	r0, r0
@   0x08031fcc: 2000        movs	r0, #0
@   0x08031fce: bc38        pop	{r3, r4, r5}
@   0x08031fd0: 4698        mov	r8, r3
@   0x08031fd2: 46a1        mov	r9, r4
@   0x08031fd4: 46aa        mov	sl, r5
@   0x08031fd6: bcf0        pop	{r4, r5, r6, r7}
@   0x08031fd8: bc02        pop	{r1}
@   0x08031fda: 4708        bx	r1

        thumb_func_start SoundSlot_Load
SoundSlot_Load: @ 0x08031e24
        .incbin "frog_us_baserom.gba", 0x31e24, 0x1b8
        thumb_func_end SoundSlot_Load
