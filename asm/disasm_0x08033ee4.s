@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033ee4, 0x08033f5c)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033ee4 --end 0x8033f5c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033ee4: 2900        cmp	r1, #0
@   0x08033ee6: d034        beq.n	0x33f52
@   0x08033ee8: 2301        movs	r3, #1
@   0x08033eea: 2200        movs	r2, #0
@   0x08033eec: b410        push	{r4}
@   0x08033eee: 4288        cmp	r0, r1
@   0x08033ef0: d32c        bcc.n	0x33f4c
@   0x08033ef2: 2401        movs	r4, #1
@   0x08033ef4: 0724        lsls	r4, r4, #28
@   0x08033ef6: 42a1        cmp	r1, r4
@   0x08033ef8: d204        bcs.n	0x33f04
@   0x08033efa: 4281        cmp	r1, r0
@   0x08033efc: d202        bcs.n	0x33f04
@   0x08033efe: 0109        lsls	r1, r1, #4
@   0x08033f00: 011b        lsls	r3, r3, #4
@   0x08033f02: e7f8        b.n	0x33ef6
@   0x08033f04: 00e4        lsls	r4, r4, #3
@   0x08033f06: 42a1        cmp	r1, r4
@   0x08033f08: d204        bcs.n	0x33f14
@   0x08033f0a: 4281        cmp	r1, r0
@   0x08033f0c: d202        bcs.n	0x33f14
@   0x08033f0e: 0049        lsls	r1, r1, #1
@   0x08033f10: 005b        lsls	r3, r3, #1
@   0x08033f12: e7f8        b.n	0x33f06
@   0x08033f14: 4288        cmp	r0, r1
@   0x08033f16: d301        bcc.n	0x33f1c
@   0x08033f18: 1a40        subs	r0, r0, r1
@   0x08033f1a: 431a        orrs	r2, r3
@   0x08033f1c: 084c        lsrs	r4, r1, #1
@   0x08033f1e: 42a0        cmp	r0, r4
@   0x08033f20: d302        bcc.n	0x33f28
@   0x08033f22: 1b00        subs	r0, r0, r4
@   0x08033f24: 085c        lsrs	r4, r3, #1
@   0x08033f26: 4322        orrs	r2, r4
@   0x08033f28: 088c        lsrs	r4, r1, #2
@   0x08033f2a: 42a0        cmp	r0, r4
@   0x08033f2c: d302        bcc.n	0x33f34
@   0x08033f2e: 1b00        subs	r0, r0, r4
@   0x08033f30: 089c        lsrs	r4, r3, #2
@   0x08033f32: 4322        orrs	r2, r4
@   0x08033f34: 08cc        lsrs	r4, r1, #3
@   0x08033f36: 42a0        cmp	r0, r4
@   0x08033f38: d302        bcc.n	0x33f40
@   0x08033f3a: 1b00        subs	r0, r0, r4
@   0x08033f3c: 08dc        lsrs	r4, r3, #3
@   0x08033f3e: 4322        orrs	r2, r4
@   0x08033f40: 2800        cmp	r0, #0
@   0x08033f42: d003        beq.n	0x33f4c
@   0x08033f44: 091b        lsrs	r3, r3, #4
@   0x08033f46: d001        beq.n	0x33f4c
@   0x08033f48: 0909        lsrs	r1, r1, #4
@   0x08033f4a: e7e3        b.n	0x33f14
@   0x08033f4c: 1c10        adds	r0, r2, #0
@   0x08033f4e: bc10        pop	{r4}
@   0x08033f50: 46f7        mov	pc, lr
@   0x08033f52: b500        push	{lr}
@   0x08033f54: f7ff        ff28 	bl	0x33da8
@   0x08033f58: 2000        movs	r0, #0
@   0x08033f5a: bd00        pop	{pc}

        thumb_func_start __udivsi3
__udivsi3: @ 0x08033ee4 — libgcc unsigned-int division helper
        .incbin "frog_us_baserom.gba", 0x33ee4, 0x78
        thumb_func_end __udivsi3
