@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013e94, 0x08013f68)  (212 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013e94 --end 0x8013f68 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013e94: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08013e96: 4657        mov	r7, sl
@   0x08013e98: 464e        mov	r6, r9
@   0x08013e9a: 4645        mov	r5, r8
@   0x08013e9c: b4e0        push	{r5, r6, r7}
@   0x08013e9e: 0600        lsls	r0, r0, #24
@   0x08013ea0: 0e00        lsrs	r0, r0, #24
@   0x08013ea2: 4680        mov	r8, r0
@   0x08013ea4: 2400        movs	r4, #0
@   0x08013ea6: 4544        cmp	r4, r8
@   0x08013ea8: d232        bcs.n	0x13f10
@   0x08013eaa: 481d        ldr	r0, [pc, #116]	@ (0x13f20)
@   0x08013eac: 4682        mov	sl, r0
@   0x08013eae: 4657        mov	r7, sl
@   0x08013eb0: 37ff        adds	r7, #255	@ 0xff
@   0x08013eb2: 21fe        movs	r1, #254	@ 0xfe
@   0x08013eb4: 4451        add	r1, sl
@   0x08013eb6: 4689        mov	r9, r1
@   0x08013eb8: 7838        ldrb	r0, [r7, #0]
@   0x08013eba: f7fd        fccf 	bl	0x1185c
@   0x08013ebe: 0600        lsls	r0, r0, #24
@   0x08013ec0: 0e03        lsrs	r3, r0, #24
@   0x08013ec2: 4648        mov	r0, r9
@   0x08013ec4: 7801        ldrb	r1, [r0, #0]
@   0x08013ec6: 3164        adds	r1, #100	@ 0x64
@   0x08013ec8: 4451        add	r1, sl
@   0x08013eca: 4a16        ldr	r2, [pc, #88]	@ (0x13f24)
@   0x08013ecc: 1898        adds	r0, r3, r2
@   0x08013ece: 7800        ldrb	r0, [r0, #0]
@   0x08013ed0: 7008        strb	r0, [r1, #0]
@   0x08013ed2: 4649        mov	r1, r9
@   0x08013ed4: 7808        ldrb	r0, [r1, #0]
@   0x08013ed6: 3001        adds	r0, #1
@   0x08013ed8: 7008        strb	r0, [r1, #0]
@   0x08013eda: 4650        mov	r0, sl
@   0x08013edc: 1819        adds	r1, r3, r0
@   0x08013ede: 2002        movs	r0, #2
@   0x08013ee0: 7008        strb	r0, [r1, #0]
@   0x08013ee2: 1c65        adds	r5, r4, #1
@   0x08013ee4: 7839        ldrb	r1, [r7, #0]
@   0x08013ee6: 428b        cmp	r3, r1
@   0x08013ee8: d20b        bcs.n	0x13f02
@   0x08013eea: 1c14        adds	r4, r2, #0
@   0x08013eec: 4e0e        ldr	r6, [pc, #56]	@ (0x13f28)
@   0x08013eee: 191a        adds	r2, r3, r4
@   0x08013ef0: 1c59        adds	r1, r3, #1
@   0x08013ef2: 1908        adds	r0, r1, r4
@   0x08013ef4: 7800        ldrb	r0, [r0, #0]
@   0x08013ef6: 7010        strb	r0, [r2, #0]
@   0x08013ef8: 0609        lsls	r1, r1, #24
@   0x08013efa: 0e0b        lsrs	r3, r1, #24
@   0x08013efc: 7830        ldrb	r0, [r6, #0]
@   0x08013efe: 4283        cmp	r3, r0
@   0x08013f00: d3f5        bcc.n	0x13eee
@   0x08013f02: 0628        lsls	r0, r5, #24
@   0x08013f04: 0e04        lsrs	r4, r0, #24
@   0x08013f06: 7838        ldrb	r0, [r7, #0]
@   0x08013f08: 3801        subs	r0, #1
@   0x08013f0a: 7038        strb	r0, [r7, #0]
@   0x08013f0c: 4544        cmp	r4, r8
@   0x08013f0e: d3d3        bcc.n	0x13eb8
@   0x08013f10: bc38        pop	{r3, r4, r5}
@   0x08013f12: 4698        mov	r8, r3
@   0x08013f14: 46a1        mov	r9, r4
@   0x08013f16: 46aa        mov	sl, r5
@   0x08013f18: bcf0        pop	{r4, r5, r6, r7}
@   0x08013f1a: bc01        pop	{r0}
@   0x08013f1c: 4700        bx	r0
@   0x08013f1e: 0000        movs	r0, r0
@   0x08013f20: 53a0        strh	r0, [r4, r6]
@   0x08013f22: 0300        lsls	r0, r0, #12
@   0x08013f24: 3610        adds	r6, #16
@   0x08013f26: 0300        lsls	r0, r0, #12
@   0x08013f28: 549f        strb	r7, [r3, r2]
@   0x08013f2a: 0300        lsls	r0, r0, #12
@   0x08013f2c: 2100        movs	r1, #0
@   0x08013f2e: 4b09        ldr	r3, [pc, #36]	@ (0x13f54)
@   0x08013f30: 4a09        ldr	r2, [pc, #36]	@ (0x13f58)
@   0x08013f32: 1888        adds	r0, r1, r2
@   0x08013f34: 7001        strb	r1, [r0, #0]
@   0x08013f36: 1c48        adds	r0, r1, #1
@   0x08013f38: 0600        lsls	r0, r0, #24
@   0x08013f3a: 0e01        lsrs	r1, r0, #24
@   0x08013f3c: 2963        cmp	r1, #99	@ 0x63
@   0x08013f3e: d9f8        bls.n	0x13f32
@   0x08013f40: 1c1a        adds	r2, r3, #0
@   0x08013f42: 32ff        adds	r2, #255	@ 0xff
@   0x08013f44: 2000        movs	r0, #0
@   0x08013f46: 2164        movs	r1, #100	@ 0x64
@   0x08013f48: 7011        strb	r1, [r2, #0]
@   0x08013f4a: 1c19        adds	r1, r3, #0
@   0x08013f4c: 31fe        adds	r1, #254	@ 0xfe
@   0x08013f4e: 7008        strb	r0, [r1, #0]
@   0x08013f50: 4770        bx	lr
@   0x08013f52: 0000        movs	r0, r0
@   0x08013f54: 53a0        strh	r0, [r4, r6]
@   0x08013f56: 0300        lsls	r0, r0, #12
@   0x08013f58: 3610        adds	r6, #16
@   0x08013f5a: 0300        lsls	r0, r0, #12
@   0x08013f5c: 4901        ldr	r1, [pc, #4]	@ (0x13f64)
@   0x08013f5e: 2000        movs	r0, #0
@   0x08013f60: 7008        strb	r0, [r1, #0]
@   0x08013f62: 4770        bx	lr
@   0x08013f64: 3610        adds	r6, #16
@   0x08013f66: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013E94
sub_08013E94: @ 0x08013e94
        .incbin "frog_us_baserom.gba", 0x13e94, 0xd4
        thumb_func_end sub_08013E94
