@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08010dd8, 0x08010f64)  (396 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8010dd8 --end 0x8010f64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08010dd8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08010dda: 1c05        adds	r5, r0, #0
@   0x08010ddc: 1c17        adds	r7, r2, #0
@   0x08010dde: 0609        lsls	r1, r1, #24
@   0x08010de0: 0e0c        lsrs	r4, r1, #24
@   0x08010de2: 4a1a        ldr	r2, [pc, #104]	@ (0x10e4c)
@   0x08010de4: 1c10        adds	r0, r2, #0
@   0x08010de6: 302a        adds	r0, #42	@ 0x2a
@   0x08010de8: 7801        ldrb	r1, [r0, #0]
@   0x08010dea: 4121        asrs	r1, r4
@   0x08010dec: 2301        movs	r3, #1
@   0x08010dee: 4019        ands	r1, r3
@   0x08010df0: 4694        mov	ip, r2
@   0x08010df2: 2900        cmp	r1, #0
@   0x08010df4: d006        beq.n	0x10e04
@   0x08010df6: 4660        mov	r0, ip
@   0x08010df8: 302b        adds	r0, #43	@ 0x2b
@   0x08010dfa: 7800        ldrb	r0, [r0, #0]
@   0x08010dfc: 4120        asrs	r0, r4
@   0x08010dfe: 4018        ands	r0, r3
@   0x08010e00: 4281        cmp	r1, r0
@   0x08010e02: d102        bne.n	0x10e0a
@   0x08010e04: 2f00        cmp	r7, #0
@   0x08010e06: d000        beq.n	0x10e0a
@   0x08010e08: e0a6        b.n	0x10f58
@   0x08010e0a: 4a11        ldr	r2, [pc, #68]	@ (0x10e50)
@   0x08010e0c: 4811        ldr	r0, [pc, #68]	@ (0x10e54)
@   0x08010e0e: 7a81        ldrb	r1, [r0, #10]
@   0x08010e10: 3901        subs	r1, #1
@   0x08010e12: 0088        lsls	r0, r1, #2
@   0x08010e14: 1840        adds	r0, r0, r1
@   0x08010e16: 0080        lsls	r0, r0, #2
@   0x08010e18: 320c        adds	r2, #12
@   0x08010e1a: 1880        adds	r0, r0, r2
@   0x08010e1c: 6801        ldr	r1, [r0, #0]
@   0x08010e1e: 0060        lsls	r0, r4, #1
@   0x08010e20: 1840        adds	r0, r0, r1
@   0x08010e22: 4a0d        ldr	r2, [pc, #52]	@ (0x10e58)
@   0x08010e24: 18a1        adds	r1, r4, r2
@   0x08010e26: 7809        ldrb	r1, [r1, #0]
@   0x08010e28: 7800        ldrb	r0, [r0, #0]
@   0x08010e2a: 1809        adds	r1, r1, r0
@   0x08010e2c: 0048        lsls	r0, r1, #1
@   0x08010e2e: 1840        adds	r0, r0, r1
@   0x08010e30: 00c0        lsls	r0, r0, #3
@   0x08010e32: 182b        adds	r3, r5, r0
@   0x08010e34: 7a18        ldrb	r0, [r3, #8]
@   0x08010e36: 0901        lsrs	r1, r0, #4
@   0x08010e38: 2001        movs	r0, #1
@   0x08010e3a: 4001        ands	r1, r0
@   0x08010e3c: 1c16        adds	r6, r2, #0
@   0x08010e3e: 2900        cmp	r1, #0
@   0x08010e40: d010        beq.n	0x10e64
@   0x08010e42: 4806        ldr	r0, [pc, #24]	@ (0x10e5c)
@   0x08010e44: 2101        movs	r1, #1
@   0x08010e46: 7201        strb	r1, [r0, #8]
@   0x08010e48: 4905        ldr	r1, [pc, #20]	@ (0x10e60)
@   0x08010e4a: e00f        b.n	0x10e6c
@   0x08010e4c: 6110        str	r0, [r2, #16]
@   0x08010e4e: 0300        lsls	r0, r0, #12
@   0x08010e50: 7eac        ldrb	r4, [r5, #26]
@   0x08010e52: 0830        lsrs	r0, r6, #32
@   0x08010e54: 5330        strh	r0, [r6, r4]
@   0x08010e56: 0300        lsls	r0, r0, #12
@   0x08010e58: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x08010e5a: 0300        lsls	r0, r0, #12
@   0x08010e5c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010e5e: 0300        lsls	r0, r0, #12
@   0x08010e60: 0000        movs	r0, r0
@   0x08010e62: 0201        lsls	r1, r0, #8
@   0x08010e64: 4813        ldr	r0, [pc, #76]	@ (0x10eb4)
@   0x08010e66: 7201        strb	r1, [r0, #8]
@   0x08010e68: 2180        movs	r1, #128	@ 0x80
@   0x08010e6a: 0489        lsls	r1, r1, #18
@   0x08010e6c: 6181        str	r1, [r0, #24]
@   0x08010e6e: 1c05        adds	r5, r0, #0
@   0x08010e70: 4811        ldr	r0, [pc, #68]	@ (0x10eb8)
@   0x08010e72: 2101        movs	r1, #1
@   0x08010e74: 8201        strh	r1, [r0, #16]
@   0x08010e76: 1c2a        adds	r2, r5, #0
@   0x08010e78: 19a0        adds	r0, r4, r6
@   0x08010e7a: 7800        ldrb	r0, [r0, #0]
@   0x08010e7c: 3001        adds	r0, #1
@   0x08010e7e: 7010        strb	r0, [r2, #0]
@   0x08010e80: 2f00        cmp	r7, #0
@   0x08010e82: d004        beq.n	0x10e8e
@   0x08010e84: 1c08        adds	r0, r1, #0
@   0x08010e86: 40a0        lsls	r0, r4
@   0x08010e88: 7891        ldrb	r1, [r2, #2]
@   0x08010e8a: 1808        adds	r0, r1, r0
@   0x08010e8c: 7090        strb	r0, [r2, #2]
@   0x08010e8e: 7b18        ldrb	r0, [r3, #12]
@   0x08010e90: 72d0        strb	r0, [r2, #11]
@   0x08010e92: 8899        ldrh	r1, [r3, #4]
@   0x08010e94: 8611        strh	r1, [r2, #48]	@ 0x30
@   0x08010e96: 88d8        ldrh	r0, [r3, #6]
@   0x08010e98: 8650        strh	r0, [r2, #50]	@ 0x32
@   0x08010e9a: 8591        strh	r1, [r2, #44]	@ 0x2c
@   0x08010e9c: 85d0        strh	r0, [r2, #46]	@ 0x2e
@   0x08010e9e: 200f        movs	r0, #15
@   0x08010ea0: 7a1c        ldrb	r4, [r3, #8]
@   0x08010ea2: 4020        ands	r0, r4
@   0x08010ea4: 2802        cmp	r0, #2
@   0x08010ea6: d00e        beq.n	0x10ec6
@   0x08010ea8: 2802        cmp	r0, #2
@   0x08010eaa: dc07        bgt.n	0x10ebc
@   0x08010eac: 2801        cmp	r0, #1
@   0x08010eae: d023        beq.n	0x10ef8
@   0x08010eb0: e04b        b.n	0x10f4a
@   0x08010eb2: 0000        movs	r0, r0
@   0x08010eb4: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010eb6: 0300        lsls	r0, r0, #12
@   0x08010eb8: 35e0        adds	r5, #224	@ 0xe0
@   0x08010eba: 0300        lsls	r0, r0, #12
@   0x08010ebc: 2803        cmp	r0, #3
@   0x08010ebe: d01b        beq.n	0x10ef8
@   0x08010ec0: 2804        cmp	r0, #4
@   0x08010ec2: d02b        beq.n	0x10f1c
@   0x08010ec4: e041        b.n	0x10f4a
@   0x08010ec6: 88d9        ldrh	r1, [r3, #6]
@   0x08010ec8: 885c        ldrh	r4, [r3, #2]
@   0x08010eca: 1908        adds	r0, r1, r4
@   0x08010ecc: 3801        subs	r0, #1
@   0x08010ece: 4909        ldr	r1, [pc, #36]	@ (0x10ef4)
@   0x08010ed0: 8b49        ldrh	r1, [r1, #26]
@   0x08010ed2: 4341        muls	r1, r0
@   0x08010ed4: 8818        ldrh	r0, [r3, #0]
@   0x08010ed6: 1841        adds	r1, r0, r1
@   0x08010ed8: 0049        lsls	r1, r1, #1
@   0x08010eda: 6990        ldr	r0, [r2, #24]
@   0x08010edc: 1840        adds	r0, r0, r1
@   0x08010ede: 6190        str	r0, [r2, #24]
@   0x08010ee0: 6918        ldr	r0, [r3, #16]
@   0x08010ee2: 6801        ldr	r1, [r0, #0]
@   0x08010ee4: 88d8        ldrh	r0, [r3, #6]
@   0x08010ee6: 3801        subs	r0, #1
@   0x08010ee8: 889b        ldrh	r3, [r3, #4]
@   0x08010eea: 4358        muls	r0, r3
@   0x08010eec: 0040        lsls	r0, r0, #1
@   0x08010eee: 1809        adds	r1, r1, r0
@   0x08010ef0: 6111        str	r1, [r2, #16]
@   0x08010ef2: e02a        b.n	0x10f4a
@   0x08010ef4: 60a0        str	r0, [r4, #8]
@   0x08010ef6: 0300        lsls	r0, r0, #12
@   0x08010ef8: 4807        ldr	r0, [pc, #28]	@ (0x10f18)
@   0x08010efa: 8b40        ldrh	r0, [r0, #26]
@   0x08010efc: 885c        ldrh	r4, [r3, #2]
@   0x08010efe: 1c01        adds	r1, r0, #0
@   0x08010f00: 4361        muls	r1, r4
@   0x08010f02: 8818        ldrh	r0, [r3, #0]
@   0x08010f04: 1841        adds	r1, r0, r1
@   0x08010f06: 0049        lsls	r1, r1, #1
@   0x08010f08: 6990        ldr	r0, [r2, #24]
@   0x08010f0a: 1840        adds	r0, r0, r1
@   0x08010f0c: 6190        str	r0, [r2, #24]
@   0x08010f0e: 6918        ldr	r0, [r3, #16]
@   0x08010f10: 6800        ldr	r0, [r0, #0]
@   0x08010f12: 6110        str	r0, [r2, #16]
@   0x08010f14: e019        b.n	0x10f4a
@   0x08010f16: 0000        movs	r0, r0
@   0x08010f18: 60a0        str	r0, [r4, #8]
@   0x08010f1a: 0300        lsls	r0, r0, #12
@   0x08010f1c: 4810        ldr	r0, [pc, #64]	@ (0x10f60)
@   0x08010f1e: 8b40        ldrh	r0, [r0, #26]
@   0x08010f20: 8859        ldrh	r1, [r3, #2]
@   0x08010f22: 4348        muls	r0, r1
@   0x08010f24: 881a        ldrh	r2, [r3, #0]
@   0x08010f26: 1810        adds	r0, r2, r0
@   0x08010f28: 0040        lsls	r0, r0, #1
@   0x08010f2a: 69a9        ldr	r1, [r5, #24]
@   0x08010f2c: 1809        adds	r1, r1, r0
@   0x08010f2e: 61a9        str	r1, [r5, #24]
@   0x08010f30: 889c        ldrh	r4, [r3, #4]
@   0x08010f32: 0060        lsls	r0, r4, #1
@   0x08010f34: 3802        subs	r0, #2
@   0x08010f36: 1809        adds	r1, r1, r0
@   0x08010f38: 61a9        str	r1, [r5, #24]
@   0x08010f3a: 6918        ldr	r0, [r3, #16]
@   0x08010f3c: 6801        ldr	r1, [r0, #0]
@   0x08010f3e: 6129        str	r1, [r5, #16]
@   0x08010f40: 889b        ldrh	r3, [r3, #4]
@   0x08010f42: 0058        lsls	r0, r3, #1
@   0x08010f44: 3802        subs	r0, #2
@   0x08010f46: 1809        adds	r1, r1, r0
@   0x08010f48: 6129        str	r1, [r5, #16]
@   0x08010f4a: 2f00        cmp	r7, #0
@   0x08010f4c: d004        beq.n	0x10f58
@   0x08010f4e: 4660        mov	r0, ip
@   0x08010f50: 302a        adds	r0, #42	@ 0x2a
@   0x08010f52: 7801        ldrb	r1, [r0, #0]
@   0x08010f54: 3001        adds	r0, #1
@   0x08010f56: 7001        strb	r1, [r0, #0]
@   0x08010f58: bcf0        pop	{r4, r5, r6, r7}
@   0x08010f5a: bc01        pop	{r0}
@   0x08010f5c: 4700        bx	r0
@   0x08010f5e: 0000        movs	r0, r0
@   0x08010f60: 60a0        str	r0, [r4, #8]
@   0x08010f62: 0300        lsls	r0, r0, #12

        thumb_func_start Scroll_PrepareBlitWork
Scroll_PrepareBlitWork: @ 0x08010dd8
        .incbin "frog_us_baserom.gba", 0x10dd8, 0x18c
        thumb_func_end Scroll_PrepareBlitWork
