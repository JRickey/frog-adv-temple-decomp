@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006e8c, 0x08006fec)  (352 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006e8c --end 0x8006fec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006e8c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08006e8e: 4657        mov	r7, sl
@   0x08006e90: 464e        mov	r6, r9
@   0x08006e92: 4645        mov	r5, r8
@   0x08006e94: b4e0        push	{r5, r6, r7}
@   0x08006e96: b082        sub	sp, #8
@   0x08006e98: 4682        mov	sl, r0
@   0x08006e9a: 0612        lsls	r2, r2, #24
@   0x08006e9c: 4850        ldr	r0, [pc, #320]	@ (0x6fe0)
@   0x08006e9e: 6800        ldr	r0, [r0, #0]
@   0x08006ea0: 9001        str	r0, [sp, #4]
@   0x08006ea2: 0609        lsls	r1, r1, #24
@   0x08006ea4: 0e09        lsrs	r1, r1, #24
@   0x08006ea6: 4689        mov	r9, r1
@   0x08006ea8: 0609        lsls	r1, r1, #24
@   0x08006eaa: 0e10        lsrs	r0, r2, #24
@   0x08006eac: 9000        str	r0, [sp, #0]
@   0x08006eae: 4291        cmp	r1, r2
@   0x08006eb0: dd00        ble.n	0x6eb4
@   0x08006eb2: e08c        b.n	0x6fce
@   0x08006eb4: 1608        asrs	r0, r1, #24
@   0x08006eb6: 00c1        lsls	r1, r0, #3
@   0x08006eb8: 1809        adds	r1, r1, r0
@   0x08006eba: 0089        lsls	r1, r1, #2
@   0x08006ebc: 4652        mov	r2, sl
@   0x08006ebe: 188d        adds	r5, r1, r2
@   0x08006ec0: 68e8        ldr	r0, [r5, #12]
@   0x08006ec2: 9b01        ldr	r3, [sp, #4]
@   0x08006ec4: 1a18        subs	r0, r3, r0
@   0x08006ec6: 464c        mov	r4, r9
@   0x08006ec8: 0624        lsls	r4, r4, #24
@   0x08006eca: 46a0        mov	r8, r4
@   0x08006ecc: 7ca9        ldrb	r1, [r5, #18]
@   0x08006ece: 4288        cmp	r0, r1
@   0x08006ed0: d972        bls.n	0x6fb8
@   0x08006ed2: 4f44        ldr	r7, [pc, #272]	@ (0x6fe4)
@   0x08006ed4: 2102        movs	r1, #2
@   0x08006ed6: 1c08        adds	r0, r1, #0
@   0x08006ed8: 8a3a        ldrh	r2, [r7, #16]
@   0x08006eda: 4010        ands	r0, r2
@   0x08006edc: 2800        cmp	r0, #0
@   0x08006ede: d063        beq.n	0x6fa8
@   0x08006ee0: 1c08        adds	r0, r1, #0
@   0x08006ee2: 7eab        ldrb	r3, [r5, #26]
@   0x08006ee4: 4018        ands	r0, r3
@   0x08006ee6: 2800        cmp	r0, #0
@   0x08006ee8: d05e        beq.n	0x6fa8
@   0x08006eea: 4e3f        ldr	r6, [pc, #252]	@ (0x6fe8)
@   0x08006eec: 2402        movs	r4, #2
@   0x08006eee: 5f30        ldrsh	r0, [r6, r4]
@   0x08006ef0: 2110        movs	r1, #16
@   0x08006ef2: 5669        ldrsb	r1, [r5, r1]
@   0x08006ef4: 0089        lsls	r1, r1, #2
@   0x08006ef6: 1840        adds	r0, r0, r1
@   0x08006ef8: 2118        movs	r1, #24
@   0x08006efa: f02c        ff0b 	bl	0x33d14
@   0x08006efe: 1c04        adds	r4, r0, #0
@   0x08006f00: 0424        lsls	r4, r4, #16
@   0x08006f02: 0c24        lsrs	r4, r4, #16
@   0x08006f04: 2104        movs	r1, #4
@   0x08006f06: 5e70        ldrsh	r0, [r6, r1]
@   0x08006f08: 2111        movs	r1, #17
@   0x08006f0a: 5669        ldrsb	r1, [r5, r1]
@   0x08006f0c: 0089        lsls	r1, r1, #2
@   0x08006f0e: 1840        adds	r0, r0, r1
@   0x08006f10: 2118        movs	r1, #24
@   0x08006f12: f02c        feff 	bl	0x33d14
@   0x08006f16: 1c03        adds	r3, r0, #0
@   0x08006f18: 7e38        ldrb	r0, [r7, #24]
@   0x08006f1a: 7e79        ldrb	r1, [r7, #25]
@   0x08006f1c: 0424        lsls	r4, r4, #16
@   0x08006f1e: 1424        asrs	r4, r4, #16
@   0x08006f20: 041b        lsls	r3, r3, #16
@   0x08006f22: 141b        asrs	r3, r3, #16
@   0x08006f24: 1c22        adds	r2, r4, #0
@   0x08006f26: f005        ff2f 	bl	0xcd88
@   0x08006f2a: 0600        lsls	r0, r0, #24
@   0x08006f2c: 0e00        lsrs	r0, r0, #24
@   0x08006f2e: 2802        cmp	r0, #2
@   0x08006f30: d03a        beq.n	0x6fa8
@   0x08006f32: 2010        movs	r0, #16
@   0x08006f34: 5628        ldrsb	r0, [r5, r0]
@   0x08006f36: 8872        ldrh	r2, [r6, #2]
@   0x08006f38: 1810        adds	r0, r2, r0
@   0x08006f3a: 8070        strh	r0, [r6, #2]
@   0x08006f3c: 2011        movs	r0, #17
@   0x08006f3e: 5628        ldrsb	r0, [r5, r0]
@   0x08006f40: 88b3        ldrh	r3, [r6, #4]
@   0x08006f42: 181a        adds	r2, r3, r0
@   0x08006f44: 80b2        strh	r2, [r6, #4]
@   0x08006f46: 2010        movs	r0, #16
@   0x08006f48: 5628        ldrsb	r0, [r5, r0]
@   0x08006f4a: 2800        cmp	r0, #0
@   0x08006f4c: d00e        beq.n	0x6f6c
@   0x08006f4e: 0410        lsls	r0, r2, #16
@   0x08006f50: 1400        asrs	r0, r0, #16
@   0x08006f52: 2402        movs	r4, #2
@   0x08006f54: 5f29        ldrsh	r1, [r5, r4]
@   0x08006f56: 4288        cmp	r0, r1
@   0x08006f58: dd01        ble.n	0x6f5e
@   0x08006f5a: 1e50        subs	r0, r2, #1
@   0x08006f5c: 80b0        strh	r0, [r6, #4]
@   0x08006f5e: 88b2        ldrh	r2, [r6, #4]
@   0x08006f60: 2304        movs	r3, #4
@   0x08006f62: 5ef0        ldrsh	r0, [r6, r3]
@   0x08006f64: 4288        cmp	r0, r1
@   0x08006f66: da01        bge.n	0x6f6c
@   0x08006f68: 1c50        adds	r0, r2, #1
@   0x08006f6a: 80b0        strh	r0, [r6, #4]
@   0x08006f6c: 464c        mov	r4, r9
@   0x08006f6e: 0622        lsls	r2, r4, #24
@   0x08006f70: 1611        asrs	r1, r2, #24
@   0x08006f72: 00c8        lsls	r0, r1, #3
@   0x08006f74: 1840        adds	r0, r0, r1
@   0x08006f76: 0080        lsls	r0, r0, #2
@   0x08006f78: 4653        mov	r3, sl
@   0x08006f7a: 18c1        adds	r1, r0, r3
@   0x08006f7c: 2011        movs	r0, #17
@   0x08006f7e: 5608        ldrsb	r0, [r1, r0]
@   0x08006f80: 4690        mov	r8, r2
@   0x08006f82: 2800        cmp	r0, #0
@   0x08006f84: d010        beq.n	0x6fa8
@   0x08006f86: 4b18        ldr	r3, [pc, #96]	@ (0x6fe8)
@   0x08006f88: 885a        ldrh	r2, [r3, #2]
@   0x08006f8a: 2402        movs	r4, #2
@   0x08006f8c: 5f18        ldrsh	r0, [r3, r4]
@   0x08006f8e: 2400        movs	r4, #0
@   0x08006f90: 5f09        ldrsh	r1, [r1, r4]
@   0x08006f92: 4288        cmp	r0, r1
@   0x08006f94: dd01        ble.n	0x6f9a
@   0x08006f96: 1e50        subs	r0, r2, #1
@   0x08006f98: 8058        strh	r0, [r3, #2]
@   0x08006f9a: 885a        ldrh	r2, [r3, #2]
@   0x08006f9c: 2402        movs	r4, #2
@   0x08006f9e: 5f18        ldrsh	r0, [r3, r4]
@   0x08006fa0: 4288        cmp	r0, r1
@   0x08006fa2: da01        bge.n	0x6fa8
@   0x08006fa4: 1c50        adds	r0, r2, #1
@   0x08006fa6: 8058        strh	r0, [r3, #2]
@   0x08006fa8: 4640        mov	r0, r8
@   0x08006faa: 1601        asrs	r1, r0, #24
@   0x08006fac: 00c8        lsls	r0, r1, #3
@   0x08006fae: 1840        adds	r0, r0, r1
@   0x08006fb0: 0080        lsls	r0, r0, #2
@   0x08006fb2: 4450        add	r0, sl
@   0x08006fb4: 9901        ldr	r1, [sp, #4]
@   0x08006fb6: 60c1        str	r1, [r0, #12]
@   0x08006fb8: 2080        movs	r0, #128	@ 0x80
@   0x08006fba: 0440        lsls	r0, r0, #17
@   0x08006fbc: 4440        add	r0, r8
@   0x08006fbe: 0e00        lsrs	r0, r0, #24
@   0x08006fc0: 4681        mov	r9, r0
@   0x08006fc2: 0601        lsls	r1, r0, #24
@   0x08006fc4: 9a00        ldr	r2, [sp, #0]
@   0x08006fc6: 0610        lsls	r0, r2, #24
@   0x08006fc8: 4281        cmp	r1, r0
@   0x08006fca: dc00        bgt.n	0x6fce
@   0x08006fcc: e772        b.n	0x6eb4
@   0x08006fce: b002        add	sp, #8
@   0x08006fd0: bc38        pop	{r3, r4, r5}
@   0x08006fd2: 4698        mov	r8, r3
@   0x08006fd4: 46a1        mov	r9, r4
@   0x08006fd6: 46aa        mov	sl, r5
@   0x08006fd8: bcf0        pop	{r4, r5, r6, r7}
@   0x08006fda: bc01        pop	{r0}
@   0x08006fdc: 4700        bx	r0
@   0x08006fde: 0000        movs	r0, r0
@   0x08006fe0: 5330        strh	r0, [r6, r4]
@   0x08006fe2: 0300        lsls	r0, r0, #12
@   0x08006fe4: 35e0        adds	r5, #224	@ 0xe0
@   0x08006fe6: 0300        lsls	r0, r0, #12
@   0x08006fe8: 3720        adds	r7, #32
@   0x08006fea: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08006E8C
sub_08006E8C: @ 0x08006e8c
        .incbin "frog_us_baserom.gba", 0x6e8c, 0x160
        thumb_func_end sub_08006E8C
