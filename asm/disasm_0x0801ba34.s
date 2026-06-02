@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801ba34, 0x0801bac8)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801ba34 --end 0x801bac8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801ba34: b570        push	{r4, r5, r6, lr}
@   0x0801ba36: b081        sub	sp, #4
@   0x0801ba38: 2200        movs	r2, #0
@   0x0801ba3a: 481e        ldr	r0, [pc, #120]	@ (0x1bab4)
@   0x0801ba3c: 210f        movs	r1, #15
@   0x0801ba3e: 8002        strh	r2, [r0, #0]
@   0x0801ba40: 3002        adds	r0, #2
@   0x0801ba42: 3901        subs	r1, #1
@   0x0801ba44: 2900        cmp	r1, #0
@   0x0801ba46: dafa        bge.n	0x1ba3e
@   0x0801ba48: 2400        movs	r4, #0
@   0x0801ba4a: 4a1b        ldr	r2, [pc, #108]	@ (0x1bab8)
@   0x0801ba4c: 20fe        movs	r0, #254	@ 0xfe
@   0x0801ba4e: 0080        lsls	r0, r0, #2
@   0x0801ba50: 1816        adds	r6, r2, r0
@   0x0801ba52: 25f0        movs	r5, #240	@ 0xf0
@   0x0801ba54: 1c13        adds	r3, r2, #0
@   0x0801ba56: 8015        strh	r5, [r2, #0]
@   0x0801ba58: 1c98        adds	r0, r3, #2
@   0x0801ba5a: 2102        movs	r1, #2
@   0x0801ba5c: 8004        strh	r4, [r0, #0]
@   0x0801ba5e: 3002        adds	r0, #2
@   0x0801ba60: 3901        subs	r1, #1
@   0x0801ba62: 2900        cmp	r1, #0
@   0x0801ba64: dafa        bge.n	0x1ba5c
@   0x0801ba66: 3208        adds	r2, #8
@   0x0801ba68: 3308        adds	r3, #8
@   0x0801ba6a: 42b2        cmp	r2, r6
@   0x0801ba6c: ddf3        ble.n	0x1ba56
@   0x0801ba6e: 2100        movs	r1, #0
@   0x0801ba70: 2200        movs	r2, #0
@   0x0801ba72: 4812        ldr	r0, [pc, #72]	@ (0x1babc)
@   0x0801ba74: 8042        strh	r2, [r0, #2]
@   0x0801ba76: 7001        strb	r1, [r0, #0]
@   0x0801ba78: 3008        adds	r0, #8
@   0x0801ba7a: 3101        adds	r1, #1
@   0x0801ba7c: 293f        cmp	r1, #63	@ 0x3f
@   0x0801ba7e: ddf9        ble.n	0x1ba74
@   0x0801ba80: 2000        movs	r0, #0
@   0x0801ba82: 9000        str	r0, [sp, #0]
@   0x0801ba84: 4c0e        ldr	r4, [pc, #56]	@ (0x1bac0)
@   0x0801ba86: 4a0f        ldr	r2, [pc, #60]	@ (0x1bac4)
@   0x0801ba88: 4668        mov	r0, sp
@   0x0801ba8a: 1c21        adds	r1, r4, #0
@   0x0801ba8c: f011        fd64 	bl	0x2d558
@   0x0801ba90: 2208        movs	r2, #8
@   0x0801ba92: 3434        adds	r4, #52	@ 0x34
@   0x0801ba94: 217f        movs	r1, #127	@ 0x7f
@   0x0801ba96: 8820        ldrh	r0, [r4, #0]
@   0x0801ba98: 4310        orrs	r0, r2
@   0x0801ba9a: 8020        strh	r0, [r4, #0]
@   0x0801ba9c: 3438        adds	r4, #56	@ 0x38
@   0x0801ba9e: 3901        subs	r1, #1
@   0x0801baa0: 2900        cmp	r1, #0
@   0x0801baa2: daf8        bge.n	0x1ba96
@   0x0801baa4: f000        f818 	bl	0x1bad8
@   0x0801baa8: f000        f818 	bl	0x1badc
@   0x0801baac: b001        add	sp, #4
@   0x0801baae: bc70        pop	{r4, r5, r6}
@   0x0801bab0: bc01        pop	{r0}
@   0x0801bab2: 4700        bx	r0
@   0x0801bab4: 0000        movs	r0, r0
@   0x0801bab6: 0601        lsls	r1, r0, #24
@   0x0801bab8: 54a0        strb	r0, [r4, r2]
@   0x0801baba: 0300        lsls	r0, r0, #12
@   0x0801babc: 6160        str	r0, [r4, #20]
@   0x0801babe: 0300        lsls	r0, r0, #12
@   0x0801bac0: 3720        adds	r7, #32
@   0x0801bac2: 0300        lsls	r0, r0, #12
@   0x0801bac4: 0700        lsls	r0, r0, #28
@   0x0801bac6: 0100        lsls	r0, r0, #4

        thumb_func_start sub_0801BA34
sub_0801BA34: @ 0x0801ba34
        .incbin "frog_us_baserom.gba", 0x1ba34, 0x94
        thumb_func_end sub_0801BA34
