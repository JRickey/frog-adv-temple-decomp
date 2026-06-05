@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034bf8, 0x08034e94)  (668 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034bf8 --end 0x8034e94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034bf8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08034bfa: 4657        mov	r7, sl
@   0x08034bfc: 464e        mov	r6, r9
@   0x08034bfe: 4645        mov	r5, r8
@   0x08034c00: b4e0        push	{r5, r6, r7}
@   0x08034c02: b083        sub	sp, #12
@   0x08034c04: 1c03        adds	r3, r0, #0
@   0x08034c06: 1c0c        adds	r4, r1, #0
@   0x08034c08: 4692        mov	sl, r2
@   0x08034c0a: 2000        movs	r0, #0
@   0x08034c0c: 681a        ldr	r2, [r3, #0]
@   0x08034c0e: 2a01        cmp	r2, #1
@   0x08034c10: d800        bhi.n	0x34c14
@   0x08034c12: 2001        movs	r0, #1
@   0x08034c14: 2800        cmp	r0, #0
@   0x08034c16: d001        beq.n	0x34c1c
@   0x08034c18: 1c18        adds	r0, r3, #0
@   0x08034c1a: e11b        b.n	0x34e54
@   0x08034c1c: 2100        movs	r1, #0
@   0x08034c1e: 6820        ldr	r0, [r4, #0]
@   0x08034c20: 2801        cmp	r0, #1
@   0x08034c22: d800        bhi.n	0x34c26
@   0x08034c24: 2101        movs	r1, #1
@   0x08034c26: 2900        cmp	r1, #0
@   0x08034c28: d139        bne.n	0x34c9e
@   0x08034c2a: 2100        movs	r1, #0
@   0x08034c2c: 2a04        cmp	r2, #4
@   0x08034c2e: d100        bne.n	0x34c32
@   0x08034c30: 2101        movs	r1, #1
@   0x08034c32: 2900        cmp	r1, #0
@   0x08034c34: d00e        beq.n	0x34c54
@   0x08034c36: 2100        movs	r1, #0
@   0x08034c38: 2804        cmp	r0, #4
@   0x08034c3a: d100        bne.n	0x34c3e
@   0x08034c3c: 2101        movs	r1, #1
@   0x08034c3e: 2900        cmp	r1, #0
@   0x08034c40: d0ea        beq.n	0x34c18
@   0x08034c42: 6859        ldr	r1, [r3, #4]
@   0x08034c44: 6860        ldr	r0, [r4, #4]
@   0x08034c46: 4281        cmp	r1, r0
@   0x08034c48: d0e6        beq.n	0x34c18
@   0x08034c4a: 4801        ldr	r0, [pc, #4]	@ (0x34c50)
@   0x08034c4c: e102        b.n	0x34e54
@   0x08034c4e: 0000        movs	r0, r0
@   0x08034c50: 3450        adds	r4, #80	@ 0x50
@   0x08034c52: 0300        lsls	r0, r0, #12
@   0x08034c54: 2100        movs	r1, #0
@   0x08034c56: 2804        cmp	r0, #4
@   0x08034c58: d100        bne.n	0x34c5c
@   0x08034c5a: 2101        movs	r1, #1
@   0x08034c5c: 2900        cmp	r1, #0
@   0x08034c5e: d11e        bne.n	0x34c9e
@   0x08034c60: 2100        movs	r1, #0
@   0x08034c62: 2802        cmp	r0, #2
@   0x08034c64: d100        bne.n	0x34c68
@   0x08034c66: 2101        movs	r1, #1
@   0x08034c68: 2900        cmp	r1, #0
@   0x08034c6a: d011        beq.n	0x34c90
@   0x08034c6c: 2000        movs	r0, #0
@   0x08034c6e: 2a02        cmp	r2, #2
@   0x08034c70: d100        bne.n	0x34c74
@   0x08034c72: 2001        movs	r0, #1
@   0x08034c74: 2800        cmp	r0, #0
@   0x08034c76: d0cf        beq.n	0x34c18
@   0x08034c78: 4651        mov	r1, sl
@   0x08034c7a: 1c18        adds	r0, r3, #0
@   0x08034c7c: c864        ldmia	r0!, {r2, r5, r6}
@   0x08034c7e: c164        stmia	r1!, {r2, r5, r6}
@   0x08034c80: c824        ldmia	r0!, {r2, r5}
@   0x08034c82: c124        stmia	r1!, {r2, r5}
@   0x08034c84: 6858        ldr	r0, [r3, #4]
@   0x08034c86: 6861        ldr	r1, [r4, #4]
@   0x08034c88: 4008        ands	r0, r1
@   0x08034c8a: 4656        mov	r6, sl
@   0x08034c8c: 6070        str	r0, [r6, #4]
@   0x08034c8e: e0e0        b.n	0x34e52
@   0x08034c90: 2100        movs	r1, #0
@   0x08034c92: 6818        ldr	r0, [r3, #0]
@   0x08034c94: 2802        cmp	r0, #2
@   0x08034c96: d100        bne.n	0x34c9a
@   0x08034c98: 2101        movs	r1, #1
@   0x08034c9a: 2900        cmp	r1, #0
@   0x08034c9c: d001        beq.n	0x34ca2
@   0x08034c9e: 1c20        adds	r0, r4, #0
@   0x08034ca0: e0d8        b.n	0x34e54
@   0x08034ca2: 6898        ldr	r0, [r3, #8]
@   0x08034ca4: 4681        mov	r9, r0
@   0x08034ca6: 68a1        ldr	r1, [r4, #8]
@   0x08034ca8: 4688        mov	r8, r1
@   0x08034caa: 68de        ldr	r6, [r3, #12]
@   0x08034cac: 691f        ldr	r7, [r3, #16]
@   0x08034cae: 68e0        ldr	r0, [r4, #12]
@   0x08034cb0: 6921        ldr	r1, [r4, #16]
@   0x08034cb2: 9000        str	r0, [sp, #0]
@   0x08034cb4: 9101        str	r1, [sp, #4]
@   0x08034cb6: 4649        mov	r1, r9
@   0x08034cb8: 4642        mov	r2, r8
@   0x08034cba: 1a88        subs	r0, r1, r2
@   0x08034cbc: 2800        cmp	r0, #0
@   0x08034cbe: da00        bge.n	0x34cc2
@   0x08034cc0: 4240        negs	r0, r0
@   0x08034cc2: 283f        cmp	r0, #63	@ 0x3f
@   0x08034cc4: dc3c        bgt.n	0x34d40
@   0x08034cc6: 685b        ldr	r3, [r3, #4]
@   0x08034cc8: 469c        mov	ip, r3
@   0x08034cca: 6864        ldr	r4, [r4, #4]
@   0x08034ccc: 9402        str	r4, [sp, #8]
@   0x08034cce: 45c1        cmp	r9, r8
@   0x08034cd0: dd1c        ble.n	0x34d0c
@   0x08034cd2: 464b        mov	r3, r9
@   0x08034cd4: 4644        mov	r4, r8
@   0x08034cd6: 1b1b        subs	r3, r3, r4
@   0x08034cd8: 4698        mov	r8, r3
@   0x08034cda: 2501        movs	r5, #1
@   0x08034cdc: 426d        negs	r5, r5
@   0x08034cde: 44a8        add	r8, r5
@   0x08034ce0: 9a00        ldr	r2, [sp, #0]
@   0x08034ce2: 2001        movs	r0, #1
@   0x08034ce4: 4002        ands	r2, r0
@   0x08034ce6: 2300        movs	r3, #0
@   0x08034ce8: 9901        ldr	r1, [sp, #4]
@   0x08034cea: 07cd        lsls	r5, r1, #31
@   0x08034cec: 9800        ldr	r0, [sp, #0]
@   0x08034cee: 0844        lsrs	r4, r0, #1
@   0x08034cf0: 1c28        adds	r0, r5, #0
@   0x08034cf2: 4320        orrs	r0, r4
@   0x08034cf4: 1c0c        adds	r4, r1, #0
@   0x08034cf6: 0861        lsrs	r1, r4, #1
@   0x08034cf8: 1c15        adds	r5, r2, #0
@   0x08034cfa: 4305        orrs	r5, r0
@   0x08034cfc: 9500        str	r5, [sp, #0]
@   0x08034cfe: 1c1c        adds	r4, r3, #0
@   0x08034d00: 430c        orrs	r4, r1
@   0x08034d02: 9401        str	r4, [sp, #4]
@   0x08034d04: 4645        mov	r5, r8
@   0x08034d06: 2d00        cmp	r5, #0
@   0x08034d08: d1e7        bne.n	0x34cda
@   0x08034d0a: 46c8        mov	r8, r9
@   0x08034d0c: 45c8        cmp	r8, r9
@   0x08034d0e: dd25        ble.n	0x34d5c
@   0x08034d10: 4640        mov	r0, r8
@   0x08034d12: 4649        mov	r1, r9
@   0x08034d14: 1a40        subs	r0, r0, r1
@   0x08034d16: 4681        mov	r9, r0
@   0x08034d18: 2201        movs	r2, #1
@   0x08034d1a: 4252        negs	r2, r2
@   0x08034d1c: 4491        add	r9, r2
@   0x08034d1e: 2201        movs	r2, #1
@   0x08034d20: 4032        ands	r2, r6
@   0x08034d22: 2300        movs	r3, #0
@   0x08034d24: 07fd        lsls	r5, r7, #31
@   0x08034d26: 0874        lsrs	r4, r6, #1
@   0x08034d28: 1c28        adds	r0, r5, #0
@   0x08034d2a: 4320        orrs	r0, r4
@   0x08034d2c: 0879        lsrs	r1, r7, #1
@   0x08034d2e: 1c16        adds	r6, r2, #0
@   0x08034d30: 4306        orrs	r6, r0
@   0x08034d32: 1c1f        adds	r7, r3, #0
@   0x08034d34: 430f        orrs	r7, r1
@   0x08034d36: 464b        mov	r3, r9
@   0x08034d38: 2b00        cmp	r3, #0
@   0x08034d3a: d1ed        bne.n	0x34d18
@   0x08034d3c: 46c1        mov	r9, r8
@   0x08034d3e: e00d        b.n	0x34d5c
@   0x08034d40: 45c1        cmp	r9, r8
@   0x08034d42: dd04        ble.n	0x34d4e
@   0x08034d44: 2000        movs	r0, #0
@   0x08034d46: 2100        movs	r1, #0
@   0x08034d48: 9000        str	r0, [sp, #0]
@   0x08034d4a: 9101        str	r1, [sp, #4]
@   0x08034d4c: e002        b.n	0x34d54
@   0x08034d4e: 46c1        mov	r9, r8
@   0x08034d50: 2600        movs	r6, #0
@   0x08034d52: 2700        movs	r7, #0
@   0x08034d54: 685b        ldr	r3, [r3, #4]
@   0x08034d56: 469c        mov	ip, r3
@   0x08034d58: 6864        ldr	r4, [r4, #4]
@   0x08034d5a: 9402        str	r4, [sp, #8]
@   0x08034d5c: 9902        ldr	r1, [sp, #8]
@   0x08034d5e: 458c        cmp	ip, r1
@   0x08034d60: d050        beq.n	0x34e04
@   0x08034d62: 4662        mov	r2, ip
@   0x08034d64: 2a00        cmp	r2, #0
@   0x08034d66: d00a        beq.n	0x34d7e
@   0x08034d68: 1c39        adds	r1, r7, #0
@   0x08034d6a: 1c30        adds	r0, r6, #0
@   0x08034d6c: f000        fd02 	bl	0x35774
@   0x08034d70: 1c0b        adds	r3, r1, #0
@   0x08034d72: 1c02        adds	r2, r0, #0
@   0x08034d74: 9c00        ldr	r4, [sp, #0]
@   0x08034d76: 9d01        ldr	r5, [sp, #4]
@   0x08034d78: 1912        adds	r2, r2, r4
@   0x08034d7a: 416b        adcs	r3, r5
@   0x08034d7c: e005        b.n	0x34d8a
@   0x08034d7e: 1c3b        adds	r3, r7, #0
@   0x08034d80: 1c32        adds	r2, r6, #0
@   0x08034d82: 9800        ldr	r0, [sp, #0]
@   0x08034d84: 9901        ldr	r1, [sp, #4]
@   0x08034d86: 1a12        subs	r2, r2, r0
@   0x08034d88: 418b        sbcs	r3, r1
@   0x08034d8a: 2b00        cmp	r3, #0
@   0x08034d8c: db08        blt.n	0x34da0
@   0x08034d8e: 2000        movs	r0, #0
@   0x08034d90: 4651        mov	r1, sl
@   0x08034d92: 6048        str	r0, [r1, #4]
@   0x08034d94: 464c        mov	r4, r9
@   0x08034d96: 608c        str	r4, [r1, #8]
@   0x08034d98: 4655        mov	r5, sl
@   0x08034d9a: 60ea        str	r2, [r5, #12]
@   0x08034d9c: 612b        str	r3, [r5, #16]
@   0x08034d9e: e00b        b.n	0x34db8
@   0x08034da0: 2001        movs	r0, #1
@   0x08034da2: 4656        mov	r6, sl
@   0x08034da4: 6070        str	r0, [r6, #4]
@   0x08034da6: 4648        mov	r0, r9
@   0x08034da8: 60b0        str	r0, [r6, #8]
@   0x08034daa: 1c19        adds	r1, r3, #0
@   0x08034dac: 1c10        adds	r0, r2, #0
@   0x08034dae: f000        fce1 	bl	0x35774
@   0x08034db2: 4652        mov	r2, sl
@   0x08034db4: 60d0        str	r0, [r2, #12]
@   0x08034db6: 6111        str	r1, [r2, #16]
@   0x08034db8: 4654        mov	r4, sl
@   0x08034dba: 68e2        ldr	r2, [r4, #12]
@   0x08034dbc: 6923        ldr	r3, [r4, #16]
@   0x08034dbe: 2001        movs	r0, #1
@   0x08034dc0: 4240        negs	r0, r0
@   0x08034dc2: 17c1        asrs	r1, r0, #31
@   0x08034dc4: 1812        adds	r2, r2, r0
@   0x08034dc6: 414b        adcs	r3, r1
@   0x08034dc8: 480d        ldr	r0, [pc, #52]	@ (0x34e00)
@   0x08034dca: 4283        cmp	r3, r0
@   0x08034dcc: d826        bhi.n	0x34e1c
@   0x08034dce: 4283        cmp	r3, r0
@   0x08034dd0: d103        bne.n	0x34dda
@   0x08034dd2: 2002        movs	r0, #2
@   0x08034dd4: 4240        negs	r0, r0
@   0x08034dd6: 4282        cmp	r2, r0
@   0x08034dd8: d820        bhi.n	0x34e1c
@   0x08034dda: 4655        mov	r5, sl
@   0x08034ddc: 68e8        ldr	r0, [r5, #12]
@   0x08034dde: 6929        ldr	r1, [r5, #16]
@   0x08034de0: 0fc3        lsrs	r3, r0, #31
@   0x08034de2: 004a        lsls	r2, r1, #1
@   0x08034de4: 1c19        adds	r1, r3, #0
@   0x08034de6: 4311        orrs	r1, r2
@   0x08034de8: 0040        lsls	r0, r0, #1
@   0x08034dea: 4656        mov	r6, sl
@   0x08034dec: 60f0        str	r0, [r6, #12]
@   0x08034dee: 6131        str	r1, [r6, #16]
@   0x08034df0: 68b2        ldr	r2, [r6, #8]
@   0x08034df2: 3a01        subs	r2, #1
@   0x08034df4: 60b2        str	r2, [r6, #8]
@   0x08034df6: 2201        movs	r2, #1
@   0x08034df8: 4252        negs	r2, r2
@   0x08034dfa: 17d3        asrs	r3, r2, #31
@   0x08034dfc: e7e2        b.n	0x34dc4
@   0x08034dfe: 0000        movs	r0, r0
@   0x08034e00: ffff        0fff 			@ <UNDEFINED> instruction: 0xffff0fff
@   0x08034e04: 4660        mov	r0, ip
@   0x08034e06: 4651        mov	r1, sl
@   0x08034e08: 6048        str	r0, [r1, #4]
@   0x08034e0a: 464a        mov	r2, r9
@   0x08034e0c: 608a        str	r2, [r1, #8]
@   0x08034e0e: 9b00        ldr	r3, [sp, #0]
@   0x08034e10: 9c01        ldr	r4, [sp, #4]
@   0x08034e12: 18f6        adds	r6, r6, r3
@   0x08034e14: 4167        adcs	r7, r4
@   0x08034e16: 4654        mov	r4, sl
@   0x08034e18: 60e6        str	r6, [r4, #12]
@   0x08034e1a: 6127        str	r7, [r4, #16]
@   0x08034e1c: 2003        movs	r0, #3
@   0x08034e1e: 4655        mov	r5, sl
@   0x08034e20: 6028        str	r0, [r5, #0]
@   0x08034e22: 6929        ldr	r1, [r5, #16]
@   0x08034e24: 480e        ldr	r0, [pc, #56]	@ (0x34e60)
@   0x08034e26: 4281        cmp	r1, r0
@   0x08034e28: d913        bls.n	0x34e52
@   0x08034e2a: 68ec        ldr	r4, [r5, #12]
@   0x08034e2c: 692d        ldr	r5, [r5, #16]
@   0x08034e2e: 2201        movs	r2, #1
@   0x08034e30: 1c20        adds	r0, r4, #0
@   0x08034e32: 4010        ands	r0, r2
@   0x08034e34: 2100        movs	r1, #0
@   0x08034e36: 07ee        lsls	r6, r5, #31
@   0x08034e38: 46b0        mov	r8, r6
@   0x08034e3a: 0866        lsrs	r6, r4, #1
@   0x08034e3c: 4642        mov	r2, r8
@   0x08034e3e: 4332        orrs	r2, r6
@   0x08034e40: 086b        lsrs	r3, r5, #1
@   0x08034e42: 4310        orrs	r0, r2
@   0x08034e44: 4319        orrs	r1, r3
@   0x08034e46: 4652        mov	r2, sl
@   0x08034e48: 60d0        str	r0, [r2, #12]
@   0x08034e4a: 6111        str	r1, [r2, #16]
@   0x08034e4c: 6890        ldr	r0, [r2, #8]
@   0x08034e4e: 3001        adds	r0, #1
@   0x08034e50: 6090        str	r0, [r2, #8]
@   0x08034e52: 4650        mov	r0, sl
@   0x08034e54: b003        add	sp, #12
@   0x08034e56: bc38        pop	{r3, r4, r5}
@   0x08034e58: 4698        mov	r8, r3
@   0x08034e5a: 46a1        mov	r9, r4
@   0x08034e5c: 46aa        mov	sl, r5
@   0x08034e5e: bdf0        pop	{r4, r5, r6, r7, pc}
@   0x08034e60: ffff        1fff 			@ <UNDEFINED> instruction: 0xffff1fff
@   0x08034e64: b510        push	{r4, lr}
@   0x08034e66: b093        sub	sp, #76	@ 0x4c
@   0x08034e68: 900f        str	r0, [sp, #60]	@ 0x3c
@   0x08034e6a: 9110        str	r1, [sp, #64]	@ 0x40
@   0x08034e6c: 9211        str	r2, [sp, #68]	@ 0x44
@   0x08034e6e: 9312        str	r3, [sp, #72]	@ 0x48
@   0x08034e70: a80f        add	r0, sp, #60	@ 0x3c
@   0x08034e72: 4669        mov	r1, sp
@   0x08034e74: f7ff        fe54 	bl	0x34b20
@   0x08034e78: a811        add	r0, sp, #68	@ 0x44
@   0x08034e7a: ac05        add	r4, sp, #20
@   0x08034e7c: 1c21        adds	r1, r4, #0
@   0x08034e7e: f7ff        fe4f 	bl	0x34b20
@   0x08034e82: aa0a        add	r2, sp, #40	@ 0x28
@   0x08034e84: 4668        mov	r0, sp
@   0x08034e86: 1c21        adds	r1, r4, #0
@   0x08034e88: f7ff        feb6 	bl	0x34bf8
@   0x08034e8c: f7ff        fda4 	bl	0x349d8
@   0x08034e90: b013        add	sp, #76	@ 0x4c
@   0x08034e92: bd10        pop	{r4, pc}

        thumb_func_start sub_08034BF8
sub_08034BF8: @ 0x08034bf8
        .incbin "frog_us_baserom.gba", 0x34bf8, 0x29c
        thumb_func_end sub_08034BF8
