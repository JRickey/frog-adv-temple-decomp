@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08033d14, 0x08033da8)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8033d14 --end 0x8033da8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08033d14: 2900        cmp	r1, #0
@   0x08033d16: d041        beq.n	0x33d9c
@   0x08033d18: b410        push	{r4}
@   0x08033d1a: 1c04        adds	r4, r0, #0
@   0x08033d1c: 404c        eors	r4, r1
@   0x08033d1e: 46a4        mov	ip, r4
@   0x08033d20: 2301        movs	r3, #1
@   0x08033d22: 2200        movs	r2, #0
@   0x08033d24: 2900        cmp	r1, #0
@   0x08033d26: d500        bpl.n	0x33d2a
@   0x08033d28: 4249        negs	r1, r1
@   0x08033d2a: 2800        cmp	r0, #0
@   0x08033d2c: d500        bpl.n	0x33d30
@   0x08033d2e: 4240        negs	r0, r0
@   0x08033d30: 4288        cmp	r0, r1
@   0x08033d32: d32c        bcc.n	0x33d8e
@   0x08033d34: 2401        movs	r4, #1
@   0x08033d36: 0724        lsls	r4, r4, #28
@   0x08033d38: 42a1        cmp	r1, r4
@   0x08033d3a: d204        bcs.n	0x33d46
@   0x08033d3c: 4281        cmp	r1, r0
@   0x08033d3e: d202        bcs.n	0x33d46
@   0x08033d40: 0109        lsls	r1, r1, #4
@   0x08033d42: 011b        lsls	r3, r3, #4
@   0x08033d44: e7f8        b.n	0x33d38
@   0x08033d46: 00e4        lsls	r4, r4, #3
@   0x08033d48: 42a1        cmp	r1, r4
@   0x08033d4a: d204        bcs.n	0x33d56
@   0x08033d4c: 4281        cmp	r1, r0
@   0x08033d4e: d202        bcs.n	0x33d56
@   0x08033d50: 0049        lsls	r1, r1, #1
@   0x08033d52: 005b        lsls	r3, r3, #1
@   0x08033d54: e7f8        b.n	0x33d48
@   0x08033d56: 4288        cmp	r0, r1
@   0x08033d58: d301        bcc.n	0x33d5e
@   0x08033d5a: 1a40        subs	r0, r0, r1
@   0x08033d5c: 431a        orrs	r2, r3
@   0x08033d5e: 084c        lsrs	r4, r1, #1
@   0x08033d60: 42a0        cmp	r0, r4
@   0x08033d62: d302        bcc.n	0x33d6a
@   0x08033d64: 1b00        subs	r0, r0, r4
@   0x08033d66: 085c        lsrs	r4, r3, #1
@   0x08033d68: 4322        orrs	r2, r4
@   0x08033d6a: 088c        lsrs	r4, r1, #2
@   0x08033d6c: 42a0        cmp	r0, r4
@   0x08033d6e: d302        bcc.n	0x33d76
@   0x08033d70: 1b00        subs	r0, r0, r4
@   0x08033d72: 089c        lsrs	r4, r3, #2
@   0x08033d74: 4322        orrs	r2, r4
@   0x08033d76: 08cc        lsrs	r4, r1, #3
@   0x08033d78: 42a0        cmp	r0, r4
@   0x08033d7a: d302        bcc.n	0x33d82
@   0x08033d7c: 1b00        subs	r0, r0, r4
@   0x08033d7e: 08dc        lsrs	r4, r3, #3
@   0x08033d80: 4322        orrs	r2, r4
@   0x08033d82: 2800        cmp	r0, #0
@   0x08033d84: d003        beq.n	0x33d8e
@   0x08033d86: 091b        lsrs	r3, r3, #4
@   0x08033d88: d001        beq.n	0x33d8e
@   0x08033d8a: 0909        lsrs	r1, r1, #4
@   0x08033d8c: e7e3        b.n	0x33d56
@   0x08033d8e: 1c10        adds	r0, r2, #0
@   0x08033d90: 4664        mov	r4, ip
@   0x08033d92: 2c00        cmp	r4, #0
@   0x08033d94: d500        bpl.n	0x33d98
@   0x08033d96: 4240        negs	r0, r0
@   0x08033d98: bc10        pop	{r4}
@   0x08033d9a: 46f7        mov	pc, lr
@   0x08033d9c: b500        push	{lr}
@   0x08033d9e: f000        f803 	bl	0x33da8
@   0x08033da2: 2000        movs	r0, #0
@   0x08033da4: bd00        pop	{pc}

        thumb_func_start __divsi3
__divsi3: @ 0x08033d14 — libgcc signed-int division helper
        .incbin "frog_us_baserom.gba", 0x33d14, 0x94
        thumb_func_end __divsi3
