@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033e14, 0x08033ee4)  (208 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033e14 --end 0x8033ee4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033e14: 2301        movs	r3, #1
@   0x08033e16: 2900        cmp	r1, #0
@   0x08033e18: d05e        beq.n	0x33ed8
@   0x08033e1a: d500        bpl.n	0x33e1e
@   0x08033e1c: 4249        negs	r1, r1
@   0x08033e1e: b410        push	{r4}
@   0x08033e20: b401        push	{r0}
@   0x08033e22: 2800        cmp	r0, #0
@   0x08033e24: d500        bpl.n	0x33e28
@   0x08033e26: 4240        negs	r0, r0
@   0x08033e28: 4288        cmp	r0, r1
@   0x08033e2a: d34f        bcc.n	0x33ecc
@   0x08033e2c: 2401        movs	r4, #1
@   0x08033e2e: 0724        lsls	r4, r4, #28
@   0x08033e30: 42a1        cmp	r1, r4
@   0x08033e32: d204        bcs.n	0x33e3e
@   0x08033e34: 4281        cmp	r1, r0
@   0x08033e36: d202        bcs.n	0x33e3e
@   0x08033e38: 0109        lsls	r1, r1, #4
@   0x08033e3a: 011b        lsls	r3, r3, #4
@   0x08033e3c: e7f8        b.n	0x33e30
@   0x08033e3e: 00e4        lsls	r4, r4, #3
@   0x08033e40: 42a1        cmp	r1, r4
@   0x08033e42: d204        bcs.n	0x33e4e
@   0x08033e44: 4281        cmp	r1, r0
@   0x08033e46: d202        bcs.n	0x33e4e
@   0x08033e48: 0049        lsls	r1, r1, #1
@   0x08033e4a: 005b        lsls	r3, r3, #1
@   0x08033e4c: e7f8        b.n	0x33e40
@   0x08033e4e: 2200        movs	r2, #0
@   0x08033e50: 4288        cmp	r0, r1
@   0x08033e52: d300        bcc.n	0x33e56
@   0x08033e54: 1a40        subs	r0, r0, r1
@   0x08033e56: 084c        lsrs	r4, r1, #1
@   0x08033e58: 42a0        cmp	r0, r4
@   0x08033e5a: d305        bcc.n	0x33e68
@   0x08033e5c: 1b00        subs	r0, r0, r4
@   0x08033e5e: 469c        mov	ip, r3
@   0x08033e60: 2401        movs	r4, #1
@   0x08033e62: 41e3        rors	r3, r4
@   0x08033e64: 431a        orrs	r2, r3
@   0x08033e66: 4663        mov	r3, ip
@   0x08033e68: 088c        lsrs	r4, r1, #2
@   0x08033e6a: 42a0        cmp	r0, r4
@   0x08033e6c: d305        bcc.n	0x33e7a
@   0x08033e6e: 1b00        subs	r0, r0, r4
@   0x08033e70: 469c        mov	ip, r3
@   0x08033e72: 2402        movs	r4, #2
@   0x08033e74: 41e3        rors	r3, r4
@   0x08033e76: 431a        orrs	r2, r3
@   0x08033e78: 4663        mov	r3, ip
@   0x08033e7a: 08cc        lsrs	r4, r1, #3
@   0x08033e7c: 42a0        cmp	r0, r4
@   0x08033e7e: d305        bcc.n	0x33e8c
@   0x08033e80: 1b00        subs	r0, r0, r4
@   0x08033e82: 469c        mov	ip, r3
@   0x08033e84: 2403        movs	r4, #3
@   0x08033e86: 41e3        rors	r3, r4
@   0x08033e88: 431a        orrs	r2, r3
@   0x08033e8a: 4663        mov	r3, ip
@   0x08033e8c: 469c        mov	ip, r3
@   0x08033e8e: 2800        cmp	r0, #0
@   0x08033e90: d003        beq.n	0x33e9a
@   0x08033e92: 091b        lsrs	r3, r3, #4
@   0x08033e94: d001        beq.n	0x33e9a
@   0x08033e96: 0909        lsrs	r1, r1, #4
@   0x08033e98: e7d9        b.n	0x33e4e
@   0x08033e9a: 240e        movs	r4, #14
@   0x08033e9c: 0724        lsls	r4, r4, #28
@   0x08033e9e: 4022        ands	r2, r4
@   0x08033ea0: d014        beq.n	0x33ecc
@   0x08033ea2: 4663        mov	r3, ip
@   0x08033ea4: 2403        movs	r4, #3
@   0x08033ea6: 41e3        rors	r3, r4
@   0x08033ea8: 421a        tst	r2, r3
@   0x08033eaa: d001        beq.n	0x33eb0
@   0x08033eac: 08cc        lsrs	r4, r1, #3
@   0x08033eae: 1900        adds	r0, r0, r4
@   0x08033eb0: 4663        mov	r3, ip
@   0x08033eb2: 2402        movs	r4, #2
@   0x08033eb4: 41e3        rors	r3, r4
@   0x08033eb6: 421a        tst	r2, r3
@   0x08033eb8: d001        beq.n	0x33ebe
@   0x08033eba: 088c        lsrs	r4, r1, #2
@   0x08033ebc: 1900        adds	r0, r0, r4
@   0x08033ebe: 4663        mov	r3, ip
@   0x08033ec0: 2401        movs	r4, #1
@   0x08033ec2: 41e3        rors	r3, r4
@   0x08033ec4: 421a        tst	r2, r3
@   0x08033ec6: d001        beq.n	0x33ecc
@   0x08033ec8: 084c        lsrs	r4, r1, #1
@   0x08033eca: 1900        adds	r0, r0, r4
@   0x08033ecc: bc10        pop	{r4}
@   0x08033ece: 2c00        cmp	r4, #0
@   0x08033ed0: d500        bpl.n	0x33ed4
@   0x08033ed2: 4240        negs	r0, r0
@   0x08033ed4: bc10        pop	{r4}
@   0x08033ed6: 46f7        mov	pc, lr
@   0x08033ed8: b500        push	{lr}
@   0x08033eda: f7ff        ff65 	bl	0x33da8
@   0x08033ede: 2000        movs	r0, #0
@   0x08033ee0: bd00        pop	{pc}

        thumb_func_start __modsi3
__modsi3: @ 0x08033e14 — libgcc signed-int modulo helper
        .incbin "frog_us_baserom.gba", 0x33e14, 0xd0
        thumb_func_end __modsi3
