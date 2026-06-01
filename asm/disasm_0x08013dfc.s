@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013dfc, 0x08013e94)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013dfc --end 0x8013e94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013dfc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08013dfe: 4657        mov	r7, sl
@   0x08013e00: 464e        mov	r6, r9
@   0x08013e02: 4645        mov	r5, r8
@   0x08013e04: b4e0        push	{r5, r6, r7}
@   0x08013e06: 0600        lsls	r0, r0, #24
@   0x08013e08: 0e00        lsrs	r0, r0, #24
@   0x08013e0a: 4680        mov	r8, r0
@   0x08013e0c: 2400        movs	r4, #0
@   0x08013e0e: 4544        cmp	r4, r8
@   0x08013e10: d232        bcs.n	0x13e78
@   0x08013e12: 481d        ldr	r0, [pc, #116]	@ (0x13e88)
@   0x08013e14: 4682        mov	sl, r0
@   0x08013e16: 4657        mov	r7, sl
@   0x08013e18: 37ff        adds	r7, #255	@ 0xff
@   0x08013e1a: 21fe        movs	r1, #254	@ 0xfe
@   0x08013e1c: 4451        add	r1, sl
@   0x08013e1e: 4689        mov	r9, r1
@   0x08013e20: 7838        ldrb	r0, [r7, #0]
@   0x08013e22: f7fd        fd1b 	bl	0x1185c
@   0x08013e26: 0600        lsls	r0, r0, #24
@   0x08013e28: 0e03        lsrs	r3, r0, #24
@   0x08013e2a: 4650        mov	r0, sl
@   0x08013e2c: 1819        adds	r1, r3, r0
@   0x08013e2e: 2001        movs	r0, #1
@   0x08013e30: 7008        strb	r0, [r1, #0]
@   0x08013e32: 4648        mov	r0, r9
@   0x08013e34: 7801        ldrb	r1, [r0, #0]
@   0x08013e36: 3164        adds	r1, #100	@ 0x64
@   0x08013e38: 4451        add	r1, sl
@   0x08013e3a: 4a14        ldr	r2, [pc, #80]	@ (0x13e8c)
@   0x08013e3c: 1898        adds	r0, r3, r2
@   0x08013e3e: 7800        ldrb	r0, [r0, #0]
@   0x08013e40: 7008        strb	r0, [r1, #0]
@   0x08013e42: 4649        mov	r1, r9
@   0x08013e44: 7808        ldrb	r0, [r1, #0]
@   0x08013e46: 3001        adds	r0, #1
@   0x08013e48: 7008        strb	r0, [r1, #0]
@   0x08013e4a: 1c65        adds	r5, r4, #1
@   0x08013e4c: 7838        ldrb	r0, [r7, #0]
@   0x08013e4e: 4283        cmp	r3, r0
@   0x08013e50: d20b        bcs.n	0x13e6a
@   0x08013e52: 1c14        adds	r4, r2, #0
@   0x08013e54: 4e0e        ldr	r6, [pc, #56]	@ (0x13e90)
@   0x08013e56: 191a        adds	r2, r3, r4
@   0x08013e58: 1c59        adds	r1, r3, #1
@   0x08013e5a: 1908        adds	r0, r1, r4
@   0x08013e5c: 7800        ldrb	r0, [r0, #0]
@   0x08013e5e: 7010        strb	r0, [r2, #0]
@   0x08013e60: 0609        lsls	r1, r1, #24
@   0x08013e62: 0e0b        lsrs	r3, r1, #24
@   0x08013e64: 7831        ldrb	r1, [r6, #0]
@   0x08013e66: 428b        cmp	r3, r1
@   0x08013e68: d3f5        bcc.n	0x13e56
@   0x08013e6a: 0628        lsls	r0, r5, #24
@   0x08013e6c: 0e04        lsrs	r4, r0, #24
@   0x08013e6e: 7838        ldrb	r0, [r7, #0]
@   0x08013e70: 3801        subs	r0, #1
@   0x08013e72: 7038        strb	r0, [r7, #0]
@   0x08013e74: 4544        cmp	r4, r8
@   0x08013e76: d3d3        bcc.n	0x13e20
@   0x08013e78: bc38        pop	{r3, r4, r5}
@   0x08013e7a: 4698        mov	r8, r3
@   0x08013e7c: 46a1        mov	r9, r4
@   0x08013e7e: 46aa        mov	sl, r5
@   0x08013e80: bcf0        pop	{r4, r5, r6, r7}
@   0x08013e82: bc01        pop	{r0}
@   0x08013e84: 4700        bx	r0
@   0x08013e86: 0000        movs	r0, r0
@   0x08013e88: 53a0        strh	r0, [r4, r6]
@   0x08013e8a: 0300        lsls	r0, r0, #12
@   0x08013e8c: 3610        adds	r6, #16
@   0x08013e8e: 0300        lsls	r0, r0, #12
@   0x08013e90: 549f        strb	r7, [r3, r2]
@   0x08013e92: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013DFC
sub_08013DFC: @ 0x08013dfc
        .incbin "frog_us_baserom.gba", 0x13dfc, 0x98
        thumb_func_end sub_08013DFC
