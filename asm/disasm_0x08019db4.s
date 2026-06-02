@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019db4, 0x08019e6c)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019db4 --end 0x8019e6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019db4: b530        push	{r4, r5, lr}
@   0x08019db6: 2180        movs	r1, #128	@ 0x80
@   0x08019db8: 04c9        lsls	r1, r1, #19
@   0x08019dba: 4c12        ldr	r4, [pc, #72]	@ (0x19e04)
@   0x08019dbc: 88a0        ldrh	r0, [r4, #4]
@   0x08019dbe: 8008        strh	r0, [r1, #0]
@   0x08019dc0: 4911        ldr	r1, [pc, #68]	@ (0x19e08)
@   0x08019dc2: 1c20        adds	r0, r4, #0
@   0x08019dc4: 3008        adds	r0, #8
@   0x08019dc6: c82c        ldmia	r0!, {r2, r3, r5}
@   0x08019dc8: c12c        stmia	r1!, {r2, r3, r5}
@   0x08019dca: 6800        ldr	r0, [r0, #0]
@   0x08019dcc: 6008        str	r0, [r1, #0]
@   0x08019dce: 2180        movs	r1, #128	@ 0x80
@   0x08019dd0: 0489        lsls	r1, r1, #18
@   0x08019dd2: 4a0e        ldr	r2, [pc, #56]	@ (0x19e0c)
@   0x08019dd4: 2000        movs	r0, #0
@   0x08019dd6: f7f6        f985 	bl	0x100e4
@   0x08019dda: 490d        ldr	r1, [pc, #52]	@ (0x19e10)
@   0x08019ddc: 4a0d        ldr	r2, [pc, #52]	@ (0x19e14)
@   0x08019dde: 2001        movs	r0, #1
@   0x08019de0: f7f6        f980 	bl	0x100e4
@   0x08019de4: 490c        ldr	r1, [pc, #48]	@ (0x19e18)
@   0x08019de6: 4a0d        ldr	r2, [pc, #52]	@ (0x19e1c)
@   0x08019de8: 2002        movs	r0, #2
@   0x08019dea: f7f6        f97b 	bl	0x100e4
@   0x08019dee: 490c        ldr	r1, [pc, #48]	@ (0x19e20)
@   0x08019df0: 4a0c        ldr	r2, [pc, #48]	@ (0x19e24)
@   0x08019df2: 2003        movs	r0, #3
@   0x08019df4: f7f6        f976 	bl	0x100e4
@   0x08019df8: 2000        movs	r0, #0
@   0x08019dfa: 6020        str	r0, [r4, #0]
@   0x08019dfc: bc30        pop	{r4, r5}
@   0x08019dfe: bc01        pop	{r0}
@   0x08019e00: 4700        bx	r0
@   0x08019e02: 0000        movs	r0, r0
@   0x08019e04: 6420        str	r0, [r4, #64]	@ 0x40
@   0x08019e06: 0300        lsls	r0, r0, #12
@   0x08019e08: 3550        adds	r5, #80	@ 0x50
@   0x08019e0a: 0300        lsls	r0, r0, #12
@   0x08019e0c: e000        b.n	0x19e10
@   0x08019e0e: 0600        lsls	r0, r0, #24
@   0x08019e10: 0000        movs	r0, r0
@   0x08019e12: 0201        lsls	r1, r0, #8
@   0x08019e14: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08019e18: 0000        movs	r0, r0
@   0x08019e1a: 0202        lsls	r2, r0, #8
@   0x08019e1c: f000        0600 	and.w	r6, r0, #0
@   0x08019e20: 0000        movs	r0, r0
@   0x08019e22: 0203        lsls	r3, r0, #8
@   0x08019e24: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08019e28: 2801        cmp	r0, #1
@   0x08019e2a: d00e        beq.n	0x19e4a
@   0x08019e2c: 2801        cmp	r0, #1
@   0x08019e2e: dc02        bgt.n	0x19e36
@   0x08019e30: 2800        cmp	r0, #0
@   0x08019e32: d005        beq.n	0x19e40
@   0x08019e34: e019        b.n	0x19e6a
@   0x08019e36: 2802        cmp	r0, #2
@   0x08019e38: d00c        beq.n	0x19e54
@   0x08019e3a: 2803        cmp	r0, #3
@   0x08019e3c: d00f        beq.n	0x19e5e
@   0x08019e3e: e014        b.n	0x19e6a
@   0x08019e40: 2180        movs	r1, #128	@ 0x80
@   0x08019e42: 04c9        lsls	r1, r1, #19
@   0x08019e44: 2280        movs	r2, #128	@ 0x80
@   0x08019e46: 0052        lsls	r2, r2, #1
@   0x08019e48: e00d        b.n	0x19e66
@   0x08019e4a: 2180        movs	r1, #128	@ 0x80
@   0x08019e4c: 04c9        lsls	r1, r1, #19
@   0x08019e4e: 2280        movs	r2, #128	@ 0x80
@   0x08019e50: 0092        lsls	r2, r2, #2
@   0x08019e52: e008        b.n	0x19e66
@   0x08019e54: 2180        movs	r1, #128	@ 0x80
@   0x08019e56: 04c9        lsls	r1, r1, #19
@   0x08019e58: 2280        movs	r2, #128	@ 0x80
@   0x08019e5a: 00d2        lsls	r2, r2, #3
@   0x08019e5c: e003        b.n	0x19e66
@   0x08019e5e: 2180        movs	r1, #128	@ 0x80
@   0x08019e60: 04c9        lsls	r1, r1, #19
@   0x08019e62: 2280        movs	r2, #128	@ 0x80
@   0x08019e64: 0112        lsls	r2, r2, #4
@   0x08019e66: 1c10        adds	r0, r2, #0
@   0x08019e68: 8008        strh	r0, [r1, #0]
@   0x08019e6a: 4770        bx	lr

        thumb_func_start sub_08019DB4
sub_08019DB4: @ 0x08019db4
        .incbin "frog_us_baserom.gba", 0x19db4, 0xb8
        thumb_func_end sub_08019DB4
