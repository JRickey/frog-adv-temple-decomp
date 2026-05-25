@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033f5c, 0x0803401c)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033f5c --end 0x803401c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033f5c: 2900        cmp	r1, #0
@   0x08033f5e: d058        beq.n	0x34012
@   0x08033f60: 2301        movs	r3, #1
@   0x08033f62: 4288        cmp	r0, r1
@   0x08033f64: d200        bcs.n	0x33f68
@   0x08033f66: 46f7        mov	pc, lr
@   0x08033f68: b410        push	{r4}
@   0x08033f6a: 2401        movs	r4, #1
@   0x08033f6c: 0724        lsls	r4, r4, #28
@   0x08033f6e: 42a1        cmp	r1, r4
@   0x08033f70: d204        bcs.n	0x33f7c
@   0x08033f72: 4281        cmp	r1, r0
@   0x08033f74: d202        bcs.n	0x33f7c
@   0x08033f76: 0109        lsls	r1, r1, #4
@   0x08033f78: 011b        lsls	r3, r3, #4
@   0x08033f7a: e7f8        b.n	0x33f6e
@   0x08033f7c: 00e4        lsls	r4, r4, #3
@   0x08033f7e: 42a1        cmp	r1, r4
@   0x08033f80: d204        bcs.n	0x33f8c
@   0x08033f82: 4281        cmp	r1, r0
@   0x08033f84: d202        bcs.n	0x33f8c
@   0x08033f86: 0049        lsls	r1, r1, #1
@   0x08033f88: 005b        lsls	r3, r3, #1
@   0x08033f8a: e7f8        b.n	0x33f7e
@   0x08033f8c: 2200        movs	r2, #0
@   0x08033f8e: 4288        cmp	r0, r1
@   0x08033f90: d300        bcc.n	0x33f94
@   0x08033f92: 1a40        subs	r0, r0, r1
@   0x08033f94: 084c        lsrs	r4, r1, #1
@   0x08033f96: 42a0        cmp	r0, r4
@   0x08033f98: d305        bcc.n	0x33fa6
@   0x08033f9a: 1b00        subs	r0, r0, r4
@   0x08033f9c: 469c        mov	ip, r3
@   0x08033f9e: 2401        movs	r4, #1
@   0x08033fa0: 41e3        rors	r3, r4
@   0x08033fa2: 431a        orrs	r2, r3
@   0x08033fa4: 4663        mov	r3, ip
@   0x08033fa6: 088c        lsrs	r4, r1, #2
@   0x08033fa8: 42a0        cmp	r0, r4
@   0x08033faa: d305        bcc.n	0x33fb8
@   0x08033fac: 1b00        subs	r0, r0, r4
@   0x08033fae: 469c        mov	ip, r3
@   0x08033fb0: 2402        movs	r4, #2
@   0x08033fb2: 41e3        rors	r3, r4
@   0x08033fb4: 431a        orrs	r2, r3
@   0x08033fb6: 4663        mov	r3, ip
@   0x08033fb8: 08cc        lsrs	r4, r1, #3
@   0x08033fba: 42a0        cmp	r0, r4
@   0x08033fbc: d305        bcc.n	0x33fca
@   0x08033fbe: 1b00        subs	r0, r0, r4
@   0x08033fc0: 469c        mov	ip, r3
@   0x08033fc2: 2403        movs	r4, #3
@   0x08033fc4: 41e3        rors	r3, r4
@   0x08033fc6: 431a        orrs	r2, r3
@   0x08033fc8: 4663        mov	r3, ip
@   0x08033fca: 469c        mov	ip, r3
@   0x08033fcc: 2800        cmp	r0, #0
@   0x08033fce: d003        beq.n	0x33fd8
@   0x08033fd0: 091b        lsrs	r3, r3, #4
@   0x08033fd2: d001        beq.n	0x33fd8
@   0x08033fd4: 0909        lsrs	r1, r1, #4
@   0x08033fd6: e7d9        b.n	0x33f8c
@   0x08033fd8: 240e        movs	r4, #14
@   0x08033fda: 0724        lsls	r4, r4, #28
@   0x08033fdc: 4022        ands	r2, r4
@   0x08033fde: d101        bne.n	0x33fe4
@   0x08033fe0: bc10        pop	{r4}
@   0x08033fe2: 46f7        mov	pc, lr
@   0x08033fe4: 4663        mov	r3, ip
@   0x08033fe6: 2403        movs	r4, #3
@   0x08033fe8: 41e3        rors	r3, r4
@   0x08033fea: 421a        tst	r2, r3
@   0x08033fec: d001        beq.n	0x33ff2
@   0x08033fee: 08cc        lsrs	r4, r1, #3
@   0x08033ff0: 1900        adds	r0, r0, r4
@   0x08033ff2: 4663        mov	r3, ip
@   0x08033ff4: 2402        movs	r4, #2
@   0x08033ff6: 41e3        rors	r3, r4
@   0x08033ff8: 421a        tst	r2, r3
@   0x08033ffa: d001        beq.n	0x34000
@   0x08033ffc: 088c        lsrs	r4, r1, #2
@   0x08033ffe: 1900        adds	r0, r0, r4
@   0x08034000: 4663        mov	r3, ip
@   0x08034002: 2401        movs	r4, #1
@   0x08034004: 41e3        rors	r3, r4
@   0x08034006: 421a        tst	r2, r3
@   0x08034008: d001        beq.n	0x3400e
@   0x0803400a: 084c        lsrs	r4, r1, #1
@   0x0803400c: 1900        adds	r0, r0, r4
@   0x0803400e: bc10        pop	{r4}
@   0x08034010: 46f7        mov	pc, lr
@   0x08034012: b500        push	{lr}
@   0x08034014: f7ff        fec8 	bl	0x33da8
@   0x08034018: 2000        movs	r0, #0
@   0x0803401a: bd00        pop	{pc}

        thumb_func_start __umodsi3
__umodsi3: @ 0x08033f5c
        .incbin "frog_us_baserom.gba", 0x33f5c, 0xc0
        thumb_func_end __umodsi3
