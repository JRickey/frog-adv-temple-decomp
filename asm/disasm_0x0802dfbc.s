@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802dfbc, 0x0802e00c)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802dfbc --end 0x802e00c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802dfbc: b510        push	{r4, lr}
@   0x0802dfbe: 1c0c        adds	r4, r1, #0
@   0x0802dfc0: 2800        cmp	r0, #0
@   0x0802dfc2: d01e        beq.n	0x2e002
@   0x0802dfc4: 0c02        lsrs	r2, r0, #16
@   0x0802dfc6: 20ff        movs	r0, #255	@ 0xff
@   0x0802dfc8: 4002        ands	r2, r0
@   0x0802dfca: 4b0f        ldr	r3, [pc, #60]	@ (0x2e008)
@   0x0802dfcc: 6818        ldr	r0, [r3, #0]
@   0x0802dfce: 30c8        adds	r0, #200	@ 0xc8
@   0x0802dfd0: 6801        ldr	r1, [r0, #0]
@   0x0802dfd2: 0192        lsls	r2, r2, #6
@   0x0802dfd4: 1851        adds	r1, r2, r1
@   0x0802dfd6: 0060        lsls	r0, r4, #1
@   0x0802dfd8: 312b        adds	r1, #43	@ 0x2b
@   0x0802dfda: 7008        strb	r0, [r1, #0]
@   0x0802dfdc: 0600        lsls	r0, r0, #24
@   0x0802dfde: 2800        cmp	r0, #0
@   0x0802dfe0: d007        beq.n	0x2dff2
@   0x0802dfe2: 6818        ldr	r0, [r3, #0]
@   0x0802dfe4: 30c8        adds	r0, #200	@ 0xc8
@   0x0802dfe6: 6800        ldr	r0, [r0, #0]
@   0x0802dfe8: 1810        adds	r0, r2, r0
@   0x0802dfea: 302b        adds	r0, #43	@ 0x2b
@   0x0802dfec: 7801        ldrb	r1, [r0, #0]
@   0x0802dfee: 3101        adds	r1, #1
@   0x0802dff0: 7001        strb	r1, [r0, #0]
@   0x0802dff2: 6818        ldr	r0, [r3, #0]
@   0x0802dff4: 30c8        adds	r0, #200	@ 0xc8
@   0x0802dff6: 6801        ldr	r1, [r0, #0]
@   0x0802dff8: 1851        adds	r1, r2, r1
@   0x0802dffa: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0802dffc: 2280        movs	r2, #128	@ 0x80
@   0x0802dffe: 4310        orrs	r0, r2
@   0x0802e000: 6388        str	r0, [r1, #56]	@ 0x38
@   0x0802e002: bc10        pop	{r4}
@   0x0802e004: bc01        pop	{r0}
@   0x0802e006: 4700        bx	r0
@   0x0802e008: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e00a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802DFBC
sub_0802DFBC: @ 0x0802dfbc
        .incbin "frog_us_baserom.gba", 0x2dfbc, 0x50
        thumb_func_end sub_0802DFBC
