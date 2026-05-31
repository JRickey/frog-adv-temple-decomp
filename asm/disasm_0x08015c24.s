@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015c24, 0x08015cbc)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015c24 --end 0x8015cbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015c24: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08015c26: 9c05        ldr	r4, [sp, #20]
@   0x08015c28: 9e06        ldr	r6, [sp, #24]
@   0x08015c2a: 0600        lsls	r0, r0, #24
@   0x08015c2c: 0e00        lsrs	r0, r0, #24
@   0x08015c2e: 1c07        adds	r7, r0, #0
@   0x08015c30: 0409        lsls	r1, r1, #16
@   0x08015c32: 0c09        lsrs	r1, r1, #16
@   0x08015c34: 0412        lsls	r2, r2, #16
@   0x08015c36: 0c12        lsrs	r2, r2, #16
@   0x08015c38: 061b        lsls	r3, r3, #24
@   0x08015c3a: 0e1b        lsrs	r3, r3, #24
@   0x08015c3c: 0624        lsls	r4, r4, #24
@   0x08015c3e: 0e24        lsrs	r4, r4, #24
@   0x08015c40: 2801        cmp	r0, #1
@   0x08015c42: d00a        beq.n	0x15c5a
@   0x08015c44: 2801        cmp	r0, #1
@   0x08015c46: dc02        bgt.n	0x15c4e
@   0x08015c48: 2800        cmp	r0, #0
@   0x08015c4a: d003        beq.n	0x15c54
@   0x08015c4c: e00b        b.n	0x15c66
@   0x08015c4e: 2f02        cmp	r7, #2
@   0x08015c50: d008        beq.n	0x15c64
@   0x08015c52: e008        b.n	0x15c66
@   0x08015c54: 2580        movs	r5, #128	@ 0x80
@   0x08015c56: 04ad        lsls	r5, r5, #18
@   0x08015c58: e005        b.n	0x15c66
@   0x08015c5a: 4d01        ldr	r5, [pc, #4]	@ (0x15c60)
@   0x08015c5c: e003        b.n	0x15c66
@   0x08015c5e: 0000        movs	r0, r0
@   0x08015c60: 0000        movs	r0, r0
@   0x08015c62: 0201        lsls	r1, r0, #8
@   0x08015c64: 4d13        ldr	r5, [pc, #76]	@ (0x15cb4)
@   0x08015c66: 0408        lsls	r0, r1, #16
@   0x08015c68: 1401        asrs	r1, r0, #16
@   0x08015c6a: 0410        lsls	r0, r2, #16
@   0x08015c6c: 1400        asrs	r0, r0, #16
@   0x08015c6e: 4a12        ldr	r2, [pc, #72]	@ (0x15cb8)
@   0x08015c70: 8b57        ldrh	r7, [r2, #26]
@   0x08015c72: 4378        muls	r0, r7
@   0x08015c74: 1808        adds	r0, r1, r0
@   0x08015c76: 0040        lsls	r0, r0, #1
@   0x08015c78: 182d        adds	r5, r5, r0
@   0x08015c7a: 2000        movs	r0, #0
@   0x08015c7c: 42a0        cmp	r0, r4
@   0x08015c7e: d215        bcs.n	0x15cac
@   0x08015c80: 1c17        adds	r7, r2, #0
@   0x08015c82: 2200        movs	r2, #0
@   0x08015c84: 1c41        adds	r1, r0, #1
@   0x08015c86: 429a        cmp	r2, r3
@   0x08015c88: d208        bcs.n	0x15c9c
@   0x08015c8a: 8830        ldrh	r0, [r6, #0]
@   0x08015c8c: 8028        strh	r0, [r5, #0]
@   0x08015c8e: 3602        adds	r6, #2
@   0x08015c90: 3502        adds	r5, #2
@   0x08015c92: 1c50        adds	r0, r2, #1
@   0x08015c94: 0600        lsls	r0, r0, #24
@   0x08015c96: 0e02        lsrs	r2, r0, #24
@   0x08015c98: 429a        cmp	r2, r3
@   0x08015c9a: d3f6        bcc.n	0x15c8a
@   0x08015c9c: 8b7a        ldrh	r2, [r7, #26]
@   0x08015c9e: 1ad0        subs	r0, r2, r3
@   0x08015ca0: 0040        lsls	r0, r0, #1
@   0x08015ca2: 182d        adds	r5, r5, r0
@   0x08015ca4: 0608        lsls	r0, r1, #24
@   0x08015ca6: 0e00        lsrs	r0, r0, #24
@   0x08015ca8: 42a0        cmp	r0, r4
@   0x08015caa: d3ea        bcc.n	0x15c82
@   0x08015cac: bcf0        pop	{r4, r5, r6, r7}
@   0x08015cae: bc01        pop	{r0}
@   0x08015cb0: 4700        bx	r0
@   0x08015cb2: 0000        movs	r0, r0
@   0x08015cb4: 0000        movs	r0, r0
@   0x08015cb6: 0202        lsls	r2, r0, #8
@   0x08015cb8: 60a0        str	r0, [r4, #8]
@   0x08015cba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08015C24
sub_08015C24: @ 0x08015c24
        .incbin "frog_us_baserom.gba", 0x15c24, 0x98
        thumb_func_end sub_08015C24
