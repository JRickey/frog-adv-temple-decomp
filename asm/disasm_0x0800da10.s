@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800da10, 0x0800dab8)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800da10 --end 0x800dab8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800da10: b500        push	{lr}
@   0x0800da12: 2100        movs	r1, #0
@   0x0800da14: 4b11        ldr	r3, [pc, #68]	@ (0xda5c)
@   0x0800da16: 2200        movs	r2, #0
@   0x0800da18: 0608        lsls	r0, r1, #24
@   0x0800da1a: 1600        asrs	r0, r0, #24
@   0x0800da1c: 18c1        adds	r1, r0, r3
@   0x0800da1e: 700a        strb	r2, [r1, #0]
@   0x0800da20: 3001        adds	r0, #1
@   0x0800da22: 0600        lsls	r0, r0, #24
@   0x0800da24: 0e01        lsrs	r1, r0, #24
@   0x0800da26: 1600        asrs	r0, r0, #24
@   0x0800da28: 283f        cmp	r0, #63	@ 0x3f
@   0x0800da2a: ddf5        ble.n	0xda18
@   0x0800da2c: 2014        movs	r0, #20
@   0x0800da2e: 210a        movs	r1, #10
@   0x0800da30: f7ff        fd0e 	bl	0xd450
@   0x0800da34: f7ff        fb60 	bl	0xd0f8
@   0x0800da38: 4909        ldr	r1, [pc, #36]	@ (0xda60)
@   0x0800da3a: 480a        ldr	r0, [pc, #40]	@ (0xda64)
@   0x0800da3c: 180a        adds	r2, r1, r0
@   0x0800da3e: 480a        ldr	r0, [pc, #40]	@ (0xda68)
@   0x0800da40: 6800        ldr	r0, [r0, #0]
@   0x0800da42: 6010        str	r0, [r2, #0]
@   0x0800da44: 4809        ldr	r0, [pc, #36]	@ (0xda6c)
@   0x0800da46: 180a        adds	r2, r1, r0
@   0x0800da48: 2300        movs	r3, #0
@   0x0800da4a: 20f0        movs	r0, #240	@ 0xf0
@   0x0800da4c: 7010        strb	r0, [r2, #0]
@   0x0800da4e: 20b2        movs	r0, #178	@ 0xb2
@   0x0800da50: 0100        lsls	r0, r0, #4
@   0x0800da52: 1809        adds	r1, r1, r0
@   0x0800da54: 700b        strb	r3, [r1, #0]
@   0x0800da56: bc01        pop	{r0}
@   0x0800da58: 4700        bx	r0
@   0x0800da5a: 0000        movs	r0, r0
@   0x0800da5c: 53a0        strh	r0, [r4, r6]
@   0x0800da5e: 0300        lsls	r0, r0, #12
@   0x0800da60: 3720        adds	r7, #32
@   0x0800da62: 0300        lsls	r0, r0, #12
@   0x0800da64: 0b1c        lsrs	r4, r3, #12
@   0x0800da66: 0000        movs	r0, r0
@   0x0800da68: 5330        strh	r0, [r6, r4]
@   0x0800da6a: 0300        lsls	r0, r0, #12
@   0x0800da6c: 0b22        lsrs	r2, r4, #12
@   0x0800da6e: 0000        movs	r0, r0
@   0x0800da70: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800da72: b081        sub	sp, #4
@   0x0800da74: 1c07        adds	r7, r0, #0
@   0x0800da76: 1c3e        adds	r6, r7, #0
@   0x0800da78: 2100        movs	r1, #0
@   0x0800da7a: 2201        movs	r2, #1
@   0x0800da7c: 1c30        adds	r0, r6, #0
@   0x0800da7e: 4010        ands	r0, r2
@   0x0800da80: 060d        lsls	r5, r1, #24
@   0x0800da82: 2800        cmp	r0, #0
@   0x0800da84: d00a        beq.n	0xda9c
@   0x0800da86: 162c        asrs	r4, r5, #24
@   0x0800da88: 1c20        adds	r0, r4, #0
@   0x0800da8a: 9200        str	r2, [sp, #0]
@   0x0800da8c: f000        f814 	bl	0xdab8
@   0x0800da90: 9a00        ldr	r2, [sp, #0]
@   0x0800da92: 2800        cmp	r0, #0
@   0x0800da94: d102        bne.n	0xda9c
@   0x0800da96: 1c10        adds	r0, r2, #0
@   0x0800da98: 40a0        lsls	r0, r4
@   0x0800da9a: 4387        bics	r7, r0
@   0x0800da9c: 0876        lsrs	r6, r6, #1
@   0x0800da9e: 2180        movs	r1, #128	@ 0x80
@   0x0800daa0: 0449        lsls	r1, r1, #17
@   0x0800daa2: 1868        adds	r0, r5, r1
@   0x0800daa4: 0e01        lsrs	r1, r0, #24
@   0x0800daa6: 1600        asrs	r0, r0, #24
@   0x0800daa8: 2818        cmp	r0, #24
@   0x0800daaa: dde7        ble.n	0xda7c
@   0x0800daac: 1c38        adds	r0, r7, #0
@   0x0800daae: b001        add	sp, #4
@   0x0800dab0: bcf0        pop	{r4, r5, r6, r7}
@   0x0800dab2: bc02        pop	{r1}
@   0x0800dab4: 4708        bx	r1

        thumb_func_start sub_0800DA10
sub_0800DA10: @ 0x0800da10
        .incbin "frog_us_baserom.gba", 0xda10, 0xa8
        thumb_func_end sub_0800DA10
