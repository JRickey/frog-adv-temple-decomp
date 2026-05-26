@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006d24, 0x08006e8c)  (360 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006d24 --end 0x8006e8c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006d24: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08006d26: 4657        mov	r7, sl
@   0x08006d28: 464e        mov	r6, r9
@   0x08006d2a: 4645        mov	r5, r8
@   0x08006d2c: b4e0        push	{r5, r6, r7}
@   0x08006d2e: b08b        sub	sp, #44	@ 0x2c
@   0x08006d30: 4682        mov	sl, r0
@   0x08006d32: 9203        str	r2, [sp, #12]
@   0x08006d34: 061b        lsls	r3, r3, #24
@   0x08006d36: 0e1b        lsrs	r3, r3, #24
@   0x08006d38: 481c        ldr	r0, [pc, #112]	@ (0x6dac)
@   0x08006d3a: 6800        ldr	r0, [r0, #0]
@   0x08006d3c: 9005        str	r0, [sp, #20]
@   0x08006d3e: 4689        mov	r9, r1
@   0x08006d40: 4591        cmp	r9, r2
@   0x08006d42: dd00        ble.n	0x6d46
@   0x08006d44: e09a        b.n	0x6e7c
@   0x08006d46: 9307        str	r3, [sp, #28]
@   0x08006d48: 4649        mov	r1, r9
@   0x08006d4a: 00c8        lsls	r0, r1, #3
@   0x08006d4c: 1841        adds	r1, r0, r1
@   0x08006d4e: 008b        lsls	r3, r1, #2
@   0x08006d50: 4654        mov	r4, sl
@   0x08006d52: 191a        adds	r2, r3, r4
@   0x08006d54: 6951        ldr	r1, [r2, #20]
@   0x08006d56: 9c05        ldr	r4, [sp, #20]
@   0x08006d58: 1a61        subs	r1, r4, r1
@   0x08006d5a: 9009        str	r0, [sp, #36]	@ 0x24
@   0x08006d5c: 4648        mov	r0, r9
@   0x08006d5e: 3001        adds	r0, #1
@   0x08006d60: 9008        str	r0, [sp, #32]
@   0x08006d62: 7e14        ldrb	r4, [r2, #24]
@   0x08006d64: 42a1        cmp	r1, r4
@   0x08006d66: d800        bhi.n	0x6d6a
@   0x08006d68: e082        b.n	0x6e70
@   0x08006d6a: 7e50        ldrb	r0, [r2, #25]
@   0x08006d6c: 9004        str	r0, [sp, #16]
@   0x08006d6e: 3001        adds	r0, #1
@   0x08006d70: 7650        strb	r0, [r2, #25]
@   0x08006d72: 7e51        ldrb	r1, [r2, #25]
@   0x08006d74: 2003        movs	r0, #3
@   0x08006d76: 4008        ands	r0, r1
@   0x08006d78: 2800        cmp	r0, #0
@   0x08006d7a: d101        bne.n	0x6d80
@   0x08006d7c: 1f08        subs	r0, r1, #4
@   0x08006d7e: 7650        strb	r0, [r2, #25]
@   0x08006d80: 2700        movs	r7, #0
@   0x08006d82: 201c        movs	r0, #28
@   0x08006d84: 5610        ldrsb	r0, [r2, r0]
@   0x08006d86: 4287        cmp	r7, r0
@   0x08006d88: da6c        bge.n	0x6e64
@   0x08006d8a: 9306        str	r3, [sp, #24]
@   0x08006d8c: 1c16        adds	r6, r2, #0
@   0x08006d8e: 2100        movs	r1, #0
@   0x08006d90: 4688        mov	r8, r1
@   0x08006d92: 9d04        ldr	r5, [sp, #16]
@   0x08006d94: 201c        movs	r0, #28
@   0x08006d96: 5630        ldrsb	r0, [r6, r0]
@   0x08006d98: 2801        cmp	r0, #1
@   0x08006d9a: dd10        ble.n	0x6dbe
@   0x08006d9c: 3801        subs	r0, #1
@   0x08006d9e: 4287        cmp	r7, r0
@   0x08006da0: d106        bne.n	0x6db0
@   0x08006da2: 0628        lsls	r0, r5, #24
@   0x08006da4: 2280        movs	r2, #128	@ 0x80
@   0x08006da6: 0512        lsls	r2, r2, #20
@   0x08006da8: 1880        adds	r0, r0, r2
@   0x08006daa: e007        b.n	0x6dbc
@   0x08006dac: 5330        strh	r0, [r6, r4]
@   0x08006dae: 0300        lsls	r0, r0, #12
@   0x08006db0: 2f00        cmp	r7, #0
@   0x08006db2: dd04        ble.n	0x6dbe
@   0x08006db4: 0628        lsls	r0, r5, #24
@   0x08006db6: 2480        movs	r4, #128	@ 0x80
@   0x08006db8: 04e4        lsls	r4, r4, #19
@   0x08006dba: 1900        adds	r0, r0, r4
@   0x08006dbc: 0e05        lsrs	r5, r0, #24
@   0x08006dbe: 4919        ldr	r1, [pc, #100]	@ (0x6e24)
@   0x08006dc0: 7e08        ldrb	r0, [r1, #24]
@   0x08006dc2: 7e49        ldrb	r1, [r1, #25]
@   0x08006dc4: 910a        str	r1, [sp, #40]	@ 0x28
@   0x08006dc6: 9c06        ldr	r4, [sp, #24]
@   0x08006dc8: 4454        add	r4, sl
@   0x08006dca: 6a23        ldr	r3, [r4, #32]
@   0x08006dcc: 4443        add	r3, r8
@   0x08006dce: 2200        movs	r2, #0
@   0x08006dd0: 5e99        ldrsh	r1, [r3, r2]
@   0x08006dd2: 468c        mov	ip, r1
@   0x08006dd4: 885b        ldrh	r3, [r3, #2]
@   0x08006dd6: 3301        adds	r3, #1
@   0x08006dd8: 041b        lsls	r3, r3, #16
@   0x08006dda: 141b        asrs	r3, r3, #16
@   0x08006ddc: 990a        ldr	r1, [sp, #40]	@ 0x28
@   0x08006dde: 4662        mov	r2, ip
@   0x08006de0: f005        ffd2 	bl	0xcd88
@   0x08006de4: 0600        lsls	r0, r0, #24
@   0x08006de6: 0e00        lsrs	r0, r0, #24
@   0x08006de8: 2808        cmp	r0, #8
@   0x08006dea: d11d        bne.n	0x6e28
@   0x08006dec: 2011        movs	r0, #17
@   0x08006dee: 5620        ldrsb	r0, [r4, r0]
@   0x08006df0: 2800        cmp	r0, #0
@   0x08006df2: d119        bne.n	0x6e28
@   0x08006df4: 6a21        ldr	r1, [r4, #32]
@   0x08006df6: 4441        add	r1, r8
@   0x08006df8: 2400        movs	r4, #0
@   0x08006dfa: 5f08        ldrsh	r0, [r1, r4]
@   0x08006dfc: 0043        lsls	r3, r0, #1
@   0x08006dfe: 181b        adds	r3, r3, r0
@   0x08006e00: 041b        lsls	r3, r3, #16
@   0x08006e02: 0c1b        lsrs	r3, r3, #16
@   0x08006e04: 2002        movs	r0, #2
@   0x08006e06: 5e09        ldrsh	r1, [r1, r0]
@   0x08006e08: 0048        lsls	r0, r1, #1
@   0x08006e0a: 1840        adds	r0, r0, r1
@   0x08006e0c: 0400        lsls	r0, r0, #16
@   0x08006e0e: 0c00        lsrs	r0, r0, #16
@   0x08006e10: 9000        str	r0, [sp, #0]
@   0x08006e12: 9907        ldr	r1, [sp, #28]
@   0x08006e14: 9101        str	r1, [sp, #4]
@   0x08006e16: 9502        str	r5, [sp, #8]
@   0x08006e18: 2001        movs	r0, #1
@   0x08006e1a: 2104        movs	r1, #4
@   0x08006e1c: 2203        movs	r2, #3
@   0x08006e1e: f00a        fa4f 	bl	0x112c0
@   0x08006e22: e018        b.n	0x6e56
@   0x08006e24: 35e0        adds	r5, #224	@ 0xe0
@   0x08006e26: 0300        lsls	r0, r0, #12
@   0x08006e28: 6a31        ldr	r1, [r6, #32]
@   0x08006e2a: 4441        add	r1, r8
@   0x08006e2c: 2200        movs	r2, #0
@   0x08006e2e: 5e88        ldrsh	r0, [r1, r2]
@   0x08006e30: 0043        lsls	r3, r0, #1
@   0x08006e32: 181b        adds	r3, r3, r0
@   0x08006e34: 041b        lsls	r3, r3, #16
@   0x08006e36: 0c1b        lsrs	r3, r3, #16
@   0x08006e38: 2402        movs	r4, #2
@   0x08006e3a: 5f09        ldrsh	r1, [r1, r4]
@   0x08006e3c: 0048        lsls	r0, r1, #1
@   0x08006e3e: 1840        adds	r0, r0, r1
@   0x08006e40: 0400        lsls	r0, r0, #16
@   0x08006e42: 0c00        lsrs	r0, r0, #16
@   0x08006e44: 9000        str	r0, [sp, #0]
@   0x08006e46: 9807        ldr	r0, [sp, #28]
@   0x08006e48: 9001        str	r0, [sp, #4]
@   0x08006e4a: 9502        str	r5, [sp, #8]
@   0x08006e4c: 2001        movs	r0, #1
@   0x08006e4e: 2103        movs	r1, #3
@   0x08006e50: 2203        movs	r2, #3
@   0x08006e52: f00a        fa35 	bl	0x112c0
@   0x08006e56: 2104        movs	r1, #4
@   0x08006e58: 4488        add	r8, r1
@   0x08006e5a: 3701        adds	r7, #1
@   0x08006e5c: 201c        movs	r0, #28
@   0x08006e5e: 5630        ldrsb	r0, [r6, r0]
@   0x08006e60: 4287        cmp	r7, r0
@   0x08006e62: db96        blt.n	0x6d92
@   0x08006e64: 9809        ldr	r0, [sp, #36]	@ 0x24
@   0x08006e66: 4448        add	r0, r9
@   0x08006e68: 0080        lsls	r0, r0, #2
@   0x08006e6a: 4450        add	r0, sl
@   0x08006e6c: 9a05        ldr	r2, [sp, #20]
@   0x08006e6e: 6142        str	r2, [r0, #20]
@   0x08006e70: 9c08        ldr	r4, [sp, #32]
@   0x08006e72: 46a1        mov	r9, r4
@   0x08006e74: 9803        ldr	r0, [sp, #12]
@   0x08006e76: 4581        cmp	r9, r0
@   0x08006e78: dc00        bgt.n	0x6e7c
@   0x08006e7a: e765        b.n	0x6d48
@   0x08006e7c: b00b        add	sp, #44	@ 0x2c
@   0x08006e7e: bc38        pop	{r3, r4, r5}
@   0x08006e80: 4698        mov	r8, r3
@   0x08006e82: 46a1        mov	r9, r4
@   0x08006e84: 46aa        mov	sl, r5
@   0x08006e86: bcf0        pop	{r4, r5, r6, r7}
@   0x08006e88: bc01        pop	{r0}
@   0x08006e8a: 4700        bx	r0

        thumb_func_start sub_08006D24
sub_08006D24: @ 0x08006d24
        .incbin "frog_us_baserom.gba", 0x6d24, 0x168
        thumb_func_end sub_08006D24
