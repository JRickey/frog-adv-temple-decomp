@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009c14, 0x08009cbc)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009c14 --end 0x8009cbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009c14: b570        push	{r4, r5, r6, lr}
@   0x08009c16: 1c06        adds	r6, r0, #0
@   0x08009c18: f005        f9ba 	bl	0xef90
@   0x08009c1c: f000        fa1e 	bl	0xa05c
@   0x08009c20: 4d0a        ldr	r5, [pc, #40]	@ (0x9c4c)
@   0x08009c22: 7828        ldrb	r0, [r5, #0]
@   0x08009c24: 2801        cmp	r0, #1
@   0x08009c26: d11f        bne.n	0x9c68
@   0x08009c28: 4809        ldr	r0, [pc, #36]	@ (0x9c50)
@   0x08009c2a: 2400        movs	r4, #0
@   0x08009c2c: 2100        movs	r1, #0
@   0x08009c2e: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08009c30: f014        fb2c 	bl	0x1e28c
@   0x08009c34: 2800        cmp	r0, #0
@   0x08009c36: d00f        beq.n	0x9c58
@   0x08009c38: 4806        ldr	r0, [pc, #24]	@ (0x9c54)
@   0x08009c3a: 7880        ldrb	r0, [r0, #2]
@   0x08009c3c: 7028        strb	r0, [r5, #0]
@   0x08009c3e: 716c        strb	r4, [r5, #5]
@   0x08009c40: 7034        strb	r4, [r6, #0]
@   0x08009c42: f023        fe59 	bl	0x2d8f8
@   0x08009c46: 2001        movs	r0, #1
@   0x08009c48: e033        b.n	0x9cb2
@   0x08009c4a: 0000        movs	r0, r0
@   0x08009c4c: 35e0        adds	r5, #224	@ 0xe0
@   0x08009c4e: 0300        lsls	r0, r0, #12
@   0x08009c50: 3720        adds	r7, #32
@   0x08009c52: 0300        lsls	r0, r0, #12
@   0x08009c54: 34b4        adds	r4, #180	@ 0xb4
@   0x08009c56: 0300        lsls	r0, r0, #12
@   0x08009c58: f023        fe4e 	bl	0x2d8f8
@   0x08009c5c: 4901        ldr	r1, [pc, #4]	@ (0x9c64)
@   0x08009c5e: 2019        movs	r0, #25
@   0x08009c60: 7248        strb	r0, [r1, #9]
@   0x08009c62: e025        b.n	0x9cb0
@   0x08009c64: 5330        strh	r0, [r6, r4]
@   0x08009c66: 0300        lsls	r0, r0, #12
@   0x08009c68: 4c0c        ldr	r4, [pc, #48]	@ (0x9c9c)
@   0x08009c6a: 2001        movs	r0, #1
@   0x08009c6c: 7c21        ldrb	r1, [r4, #16]
@   0x08009c6e: 4008        ands	r0, r1
@   0x08009c70: 2800        cmp	r0, #0
@   0x08009c72: d102        bne.n	0x9c7a
@   0x08009c74: 1c28        adds	r0, r5, #0
@   0x08009c76: f7fc        ff31 	bl	0x6adc
@   0x08009c7a: 2005        movs	r0, #5
@   0x08009c7c: 5628        ldrsb	r0, [r5, r0]
@   0x08009c7e: f7fd        fdf9 	bl	0x7874
@   0x08009c82: 4907        ldr	r1, [pc, #28]	@ (0x9ca0)
@   0x08009c84: 7aa2        ldrb	r2, [r4, #10]
@   0x08009c86: 0090        lsls	r0, r2, #2
@   0x08009c88: 1840        adds	r0, r0, r1
@   0x08009c8a: 6800        ldr	r0, [r0, #0]
@   0x08009c8c: f02a        f824 	bl	0x33cd8
@   0x08009c90: 7a60        ldrb	r0, [r4, #9]
@   0x08009c92: 2818        cmp	r0, #24
@   0x08009c94: d006        beq.n	0x9ca4
@   0x08009c96: f023        fe2f 	bl	0x2d8f8
@   0x08009c9a: e009        b.n	0x9cb0
@   0x08009c9c: 5330        strh	r0, [r6, r4]
@   0x08009c9e: 0300        lsls	r0, r0, #12
@   0x08009ca0: 0c74        lsrs	r4, r6, #17
@   0x08009ca2: 080c        lsrs	r4, r1, #32
@   0x08009ca4: 2000        movs	r0, #0
@   0x08009ca6: 2104        movs	r1, #4
@   0x08009ca8: 7261        strb	r1, [r4, #9]
@   0x08009caa: 72a0        strb	r0, [r4, #10]
@   0x08009cac: 4802        ldr	r0, [pc, #8]	@ (0x9cb8)
@   0x08009cae: 7001        strb	r1, [r0, #0]
@   0x08009cb0: 2000        movs	r0, #0
@   0x08009cb2: bc70        pop	{r4, r5, r6}
@   0x08009cb4: bc02        pop	{r1}
@   0x08009cb6: 4708        bx	r1
@   0x08009cb8: 3480        adds	r4, #128	@ 0x80
@   0x08009cba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08009C14
sub_08009C14: @ 0x08009c14
        .incbin "frog_us_baserom.gba", 0x9c14, 0xa8
        thumb_func_end sub_08009C14
