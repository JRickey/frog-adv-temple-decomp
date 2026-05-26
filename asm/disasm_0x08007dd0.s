@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08007dd0, 0x08007f88)  (440 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8007dd0 --end 0x8007f88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08007dd0: b530        push	{r4, r5, lr}
@   0x08007dd2: 4c6a        ldr	r4, [pc, #424]	@ (0x7f7c)
@   0x08007dd4: 2580        movs	r5, #128	@ 0x80
@   0x08007dd6: 006d        lsls	r5, r5, #1
@   0x08007dd8: 1c20        adds	r0, r4, #0
@   0x08007dda: 1c29        adds	r1, r5, #0
@   0x08007ddc: f7fe        fee2 	bl	0x6ba4
@   0x08007de0: 0600        lsls	r0, r0, #24
@   0x08007de2: 2800        cmp	r0, #0
@   0x08007de4: d010        beq.n	0x7e08
@   0x08007de6: 4866        ldr	r0, [pc, #408]	@ (0x7f80)
@   0x08007de8: 2108        movs	r1, #8
@   0x08007dea: 8dc2        ldrh	r2, [r0, #46]	@ 0x2e
@   0x08007dec: 4311        orrs	r1, r2
@   0x08007dee: 85c1        strh	r1, [r0, #46]	@ 0x2e
@   0x08007df0: 1c20        adds	r0, r4, #0
@   0x08007df2: 2101        movs	r1, #1
@   0x08007df4: f7fe        fec8 	bl	0x6b88
@   0x08007df8: 1c20        adds	r0, r4, #0
@   0x08007dfa: 1c29        adds	r1, r5, #0
@   0x08007dfc: f7fe        feca 	bl	0x6b94
@   0x08007e00: 1c20        adds	r0, r4, #0
@   0x08007e02: 2110        movs	r1, #16
@   0x08007e04: f7fe        fec6 	bl	0x6b94
@   0x08007e08: 1c20        adds	r0, r4, #0
@   0x08007e0a: 2180        movs	r1, #128	@ 0x80
@   0x08007e0c: f7fe        feca 	bl	0x6ba4
@   0x08007e10: 0600        lsls	r0, r0, #24
@   0x08007e12: 2800        cmp	r0, #0
@   0x08007e14: d00b        beq.n	0x7e2e
@   0x08007e16: 485b        ldr	r0, [pc, #364]	@ (0x7f84)
@   0x08007e18: 7e81        ldrb	r1, [r0, #26]
@   0x08007e1a: 3124        adds	r1, #36	@ 0x24
@   0x08007e1c: 7681        strb	r1, [r0, #26]
@   0x08007e1e: 2102        movs	r1, #2
@   0x08007e20: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x08007e22: 4311        orrs	r1, r2
@   0x08007e24: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08007e26: 1c20        adds	r0, r4, #0
@   0x08007e28: 2180        movs	r1, #128	@ 0x80
@   0x08007e2a: f7fe        feb3 	bl	0x6b94
@   0x08007e2e: 2580        movs	r5, #128	@ 0x80
@   0x08007e30: 012d        lsls	r5, r5, #4
@   0x08007e32: 1c20        adds	r0, r4, #0
@   0x08007e34: 1c29        adds	r1, r5, #0
@   0x08007e36: f7fe        feb5 	bl	0x6ba4
@   0x08007e3a: 0600        lsls	r0, r0, #24
@   0x08007e3c: 2800        cmp	r0, #0
@   0x08007e3e: d00e        beq.n	0x7e5e
@   0x08007e40: f018        fd64 	bl	0x2090c
@   0x08007e44: 484f        ldr	r0, [pc, #316]	@ (0x7f84)
@   0x08007e46: 2116        movs	r1, #22
@   0x08007e48: 7681        strb	r1, [r0, #26]
@   0x08007e4a: 2106        movs	r1, #6
@   0x08007e4c: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08007e4e: 1c20        adds	r0, r4, #0
@   0x08007e50: 1c29        adds	r1, r5, #0
@   0x08007e52: f7fe        fe9f 	bl	0x6b94
@   0x08007e56: 1c20        adds	r0, r4, #0
@   0x08007e58: 2102        movs	r1, #2
@   0x08007e5a: f7fe        fe9b 	bl	0x6b94
@   0x08007e5e: 2580        movs	r5, #128	@ 0x80
@   0x08007e60: 00ed        lsls	r5, r5, #3
@   0x08007e62: 1c20        adds	r0, r4, #0
@   0x08007e64: 1c29        adds	r1, r5, #0
@   0x08007e66: f7fe        fe9d 	bl	0x6ba4
@   0x08007e6a: 0600        lsls	r0, r0, #24
@   0x08007e6c: 2800        cmp	r0, #0
@   0x08007e6e: d00e        beq.n	0x7e8e
@   0x08007e70: f018        fd4c 	bl	0x2090c
@   0x08007e74: 4843        ldr	r0, [pc, #268]	@ (0x7f84)
@   0x08007e76: 2114        movs	r1, #20
@   0x08007e78: 7681        strb	r1, [r0, #26]
@   0x08007e7a: 2116        movs	r1, #22
@   0x08007e7c: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08007e7e: 1c20        adds	r0, r4, #0
@   0x08007e80: 1c29        adds	r1, r5, #0
@   0x08007e82: f7fe        fe87 	bl	0x6b94
@   0x08007e86: 1c20        adds	r0, r4, #0
@   0x08007e88: 2102        movs	r1, #2
@   0x08007e8a: f7fe        fe83 	bl	0x6b94
@   0x08007e8e: 2580        movs	r5, #128	@ 0x80
@   0x08007e90: 00ad        lsls	r5, r5, #2
@   0x08007e92: 1c20        adds	r0, r4, #0
@   0x08007e94: 1c29        adds	r1, r5, #0
@   0x08007e96: f7fe        fe85 	bl	0x6ba4
@   0x08007e9a: 0600        lsls	r0, r0, #24
@   0x08007e9c: 2800        cmp	r0, #0
@   0x08007e9e: d00e        beq.n	0x7ebe
@   0x08007ea0: f018        fd34 	bl	0x2090c
@   0x08007ea4: 4837        ldr	r0, [pc, #220]	@ (0x7f84)
@   0x08007ea6: 2114        movs	r1, #20
@   0x08007ea8: 7681        strb	r1, [r0, #26]
@   0x08007eaa: 2106        movs	r1, #6
@   0x08007eac: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08007eae: 1c20        adds	r0, r4, #0
@   0x08007eb0: 1c29        adds	r1, r5, #0
@   0x08007eb2: f7fe        fe6f 	bl	0x6b94
@   0x08007eb6: 1c20        adds	r0, r4, #0
@   0x08007eb8: 2102        movs	r1, #2
@   0x08007eba: f7fe        fe6b 	bl	0x6b94
@   0x08007ebe: 2580        movs	r5, #128	@ 0x80
@   0x08007ec0: 01ad        lsls	r5, r5, #6
@   0x08007ec2: 1c20        adds	r0, r4, #0
@   0x08007ec4: 1c29        adds	r1, r5, #0
@   0x08007ec6: f7fe        fe6d 	bl	0x6ba4
@   0x08007eca: 0600        lsls	r0, r0, #24
@   0x08007ecc: 2800        cmp	r0, #0
@   0x08007ece: d00e        beq.n	0x7eee
@   0x08007ed0: f018        fd1c 	bl	0x2090c
@   0x08007ed4: 482b        ldr	r0, [pc, #172]	@ (0x7f84)
@   0x08007ed6: 2117        movs	r1, #23
@   0x08007ed8: 7681        strb	r1, [r0, #26]
@   0x08007eda: 2136        movs	r1, #54	@ 0x36
@   0x08007edc: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08007ede: 1c20        adds	r0, r4, #0
@   0x08007ee0: 1c29        adds	r1, r5, #0
@   0x08007ee2: f7fe        fe57 	bl	0x6b94
@   0x08007ee6: 1c20        adds	r0, r4, #0
@   0x08007ee8: 2102        movs	r1, #2
@   0x08007eea: f7fe        fe53 	bl	0x6b94
@   0x08007eee: 2580        movs	r5, #128	@ 0x80
@   0x08007ef0: 01ed        lsls	r5, r5, #7
@   0x08007ef2: 1c20        adds	r0, r4, #0
@   0x08007ef4: 1c29        adds	r1, r5, #0
@   0x08007ef6: f7fe        fe55 	bl	0x6ba4
@   0x08007efa: 0600        lsls	r0, r0, #24
@   0x08007efc: 2800        cmp	r0, #0
@   0x08007efe: d012        beq.n	0x7f26
@   0x08007f00: f018        fd04 	bl	0x2090c
@   0x08007f04: 4a1f        ldr	r2, [pc, #124]	@ (0x7f84)
@   0x08007f06: 2021        movs	r0, #33	@ 0x21
@   0x08007f08: 7690        strb	r0, [r2, #26]
@   0x08007f0a: 2002        movs	r0, #2
@   0x08007f0c: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08007f0e: 4308        orrs	r0, r1
@   0x08007f10: 2104        movs	r1, #4
@   0x08007f12: 4308        orrs	r0, r1
@   0x08007f14: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08007f16: 1c20        adds	r0, r4, #0
@   0x08007f18: 1c29        adds	r1, r5, #0
@   0x08007f1a: f7fe        fe3b 	bl	0x6b94
@   0x08007f1e: 1c20        adds	r0, r4, #0
@   0x08007f20: 2102        movs	r1, #2
@   0x08007f22: f7fe        fe37 	bl	0x6b94
@   0x08007f26: 2580        movs	r5, #128	@ 0x80
@   0x08007f28: 022d        lsls	r5, r5, #8
@   0x08007f2a: 1c20        adds	r0, r4, #0
@   0x08007f2c: 1c29        adds	r1, r5, #0
@   0x08007f2e: f7fe        fe39 	bl	0x6ba4
@   0x08007f32: 0600        lsls	r0, r0, #24
@   0x08007f34: 2800        cmp	r0, #0
@   0x08007f36: d012        beq.n	0x7f5e
@   0x08007f38: f018        fce8 	bl	0x2090c
@   0x08007f3c: 4a11        ldr	r2, [pc, #68]	@ (0x7f84)
@   0x08007f3e: 2022        movs	r0, #34	@ 0x22
@   0x08007f40: 7690        strb	r0, [r2, #26]
@   0x08007f42: 2002        movs	r0, #2
@   0x08007f44: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08007f46: 4308        orrs	r0, r1
@   0x08007f48: 2104        movs	r1, #4
@   0x08007f4a: 4308        orrs	r0, r1
@   0x08007f4c: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08007f4e: 1c20        adds	r0, r4, #0
@   0x08007f50: 1c29        adds	r1, r5, #0
@   0x08007f52: f7fe        fe1f 	bl	0x6b94
@   0x08007f56: 1c20        adds	r0, r4, #0
@   0x08007f58: 2102        movs	r1, #2
@   0x08007f5a: f7fe        fe1b 	bl	0x6b94
@   0x08007f5e: 1c20        adds	r0, r4, #0
@   0x08007f60: 2120        movs	r1, #32
@   0x08007f62: f7fe        fe17 	bl	0x6b94
@   0x08007f66: 1c20        adds	r0, r4, #0
@   0x08007f68: 2110        movs	r1, #16
@   0x08007f6a: f7fe        fe13 	bl	0x6b94
@   0x08007f6e: 1c20        adds	r0, r4, #0
@   0x08007f70: 2140        movs	r1, #64	@ 0x40
@   0x08007f72: f7fe        fe0f 	bl	0x6b94
@   0x08007f76: bc30        pop	{r4, r5}
@   0x08007f78: bc01        pop	{r0}
@   0x08007f7a: 4700        bx	r0
@   0x08007f7c: 35e0        adds	r5, #224	@ 0xe0
@   0x08007f7e: 0300        lsls	r0, r0, #12
@   0x08007f80: 6110        str	r0, [r2, #16]
@   0x08007f82: 0300        lsls	r0, r0, #12
@   0x08007f84: 3720        adds	r7, #32
@   0x08007f86: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08007DD0
sub_08007DD0: @ 0x08007dd0
        .incbin "frog_us_baserom.gba", 0x7dd0, 0x1b8
        thumb_func_end sub_08007DD0
