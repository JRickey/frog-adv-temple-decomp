@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017bfc, 0x08017db8)  (444 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017bfc --end 0x8017db8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017bfc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08017bfe: 4647        mov	r7, r8
@   0x08017c00: b480        push	{r7}
@   0x08017c02: 4938        ldr	r1, [pc, #224]	@ (0x17ce4)
@   0x08017c04: 2000        movs	r0, #0
@   0x08017c06: 8008        strh	r0, [r1, #0]
@   0x08017c08: 4f37        ldr	r7, [pc, #220]	@ (0x17ce8)
@   0x08017c0a: 70f8        strb	r0, [r7, #3]
@   0x08017c0c: 7078        strb	r0, [r7, #1]
@   0x08017c0e: 70b8        strb	r0, [r7, #2]
@   0x08017c10: 71f8        strb	r0, [r7, #7]
@   0x08017c12: 7178        strb	r0, [r7, #5]
@   0x08017c14: 7238        strb	r0, [r7, #8]
@   0x08017c16: f001        fee5 	bl	0x199e4
@   0x08017c1a: f001        fbdd 	bl	0x193d8
@   0x08017c1e: f015        fe6b 	bl	0x2d8f8
@   0x08017c22: 2014        movs	r0, #20
@   0x08017c24: f008        ffb0 	bl	0x20b88
@   0x08017c28: f7f8        fd46 	bl	0x106b8
@   0x08017c2c: 1c01        adds	r1, r0, #0
@   0x08017c2e: 2900        cmp	r1, #0
@   0x08017c30: d153        bne.n	0x17cda
@   0x08017c32: 482e        ldr	r0, [pc, #184]	@ (0x17cec)
@   0x08017c34: 8001        strh	r1, [r0, #0]
@   0x08017c36: 8041        strh	r1, [r0, #2]
@   0x08017c38: 482d        ldr	r0, [pc, #180]	@ (0x17cf0)
@   0x08017c3a: 8001        strh	r1, [r0, #0]
@   0x08017c3c: 380c        subs	r0, #12
@   0x08017c3e: 4680        mov	r8, r0
@   0x08017c40: 492c        ldr	r1, [pc, #176]	@ (0x17cf4)
@   0x08017c42: 1c08        adds	r0, r1, #0
@   0x08017c44: 4641        mov	r1, r8
@   0x08017c46: 8008        strh	r0, [r1, #0]
@   0x08017c48: 492b        ldr	r1, [pc, #172]	@ (0x17cf8)
@   0x08017c4a: 4e2c        ldr	r6, [pc, #176]	@ (0x17cfc)
@   0x08017c4c: 1c30        adds	r0, r6, #0
@   0x08017c4e: 3088        adds	r0, #136	@ 0x88
@   0x08017c50: 6800        ldr	r0, [r0, #0]
@   0x08017c52: 6008        str	r0, [r1, #0]
@   0x08017c54: 20a0        movs	r0, #160	@ 0xa0
@   0x08017c56: 04c0        lsls	r0, r0, #19
@   0x08017c58: 6048        str	r0, [r1, #4]
@   0x08017c5a: 4829        ldr	r0, [pc, #164]	@ (0x17d00)
@   0x08017c5c: 6088        str	r0, [r1, #8]
@   0x08017c5e: 6888        ldr	r0, [r1, #8]
@   0x08017c60: 1c30        adds	r0, r6, #0
@   0x08017c62: 3084        adds	r0, #132	@ 0x84
@   0x08017c64: 6804        ldr	r4, [r0, #0]
@   0x08017c66: 4d27        ldr	r5, [pc, #156]	@ (0x17d04)
@   0x08017c68: 2000        movs	r0, #0
@   0x08017c6a: 2100        movs	r1, #0
@   0x08017c6c: 1c22        adds	r2, r4, #0
@   0x08017c6e: 1c2b        adds	r3, r5, #0
@   0x08017c70: f7fe        fb14 	bl	0x1629c
@   0x08017c74: 2000        movs	r0, #0
@   0x08017c76: 2100        movs	r1, #0
@   0x08017c78: 1c22        adds	r2, r4, #0
@   0x08017c7a: 1c2b        adds	r3, r5, #0
@   0x08017c7c: f7fe        fb3e 	bl	0x162fc
@   0x08017c80: 1c30        adds	r0, r6, #0
@   0x08017c82: 3090        adds	r0, #144	@ 0x90
@   0x08017c84: 6804        ldr	r4, [r0, #0]
@   0x08017c86: 4d20        ldr	r5, [pc, #128]	@ (0x17d08)
@   0x08017c88: 2028        movs	r0, #40	@ 0x28
@   0x08017c8a: 2121        movs	r1, #33	@ 0x21
@   0x08017c8c: 1c22        adds	r2, r4, #0
@   0x08017c8e: 1c2b        adds	r3, r5, #0
@   0x08017c90: f7fe        f984 	bl	0x15f9c
@   0x08017c94: 79b8        ldrb	r0, [r7, #6]
@   0x08017c96: 2800        cmp	r0, #0
@   0x08017c98: d00d        beq.n	0x17cb6
@   0x08017c9a: 2028        movs	r0, #40	@ 0x28
@   0x08017c9c: 2121        movs	r1, #33	@ 0x21
@   0x08017c9e: 1c22        adds	r2, r4, #0
@   0x08017ca0: 1c2b        adds	r3, r5, #0
@   0x08017ca2: f7fe        f90f 	bl	0x15ec4
@   0x08017ca6: 1c30        adds	r0, r6, #0
@   0x08017ca8: 309c        adds	r0, #156	@ 0x9c
@   0x08017caa: 6802        ldr	r2, [r0, #0]
@   0x08017cac: 4b17        ldr	r3, [pc, #92]	@ (0x17d0c)
@   0x08017cae: 2050        movs	r0, #80	@ 0x50
@   0x08017cb0: 216e        movs	r1, #110	@ 0x6e
@   0x08017cb2: f7fe        f907 	bl	0x15ec4
@   0x08017cb6: 4640        mov	r0, r8
@   0x08017cb8: 8801        ldrh	r1, [r0, #0]
@   0x08017cba: 2010        movs	r0, #16
@   0x08017cbc: 4008        ands	r0, r1
@   0x08017cbe: 2800        cmp	r0, #0
@   0x08017cc0: d005        beq.n	0x17cce
@   0x08017cc2: 4641        mov	r1, r8
@   0x08017cc4: 8808        ldrh	r0, [r1, #0]
@   0x08017cc6: 2110        movs	r1, #16
@   0x08017cc8: 4048        eors	r0, r1
@   0x08017cca: 4641        mov	r1, r8
@   0x08017ccc: 8008        strh	r0, [r1, #0]
@   0x08017cce: 20bf        movs	r0, #191	@ 0xbf
@   0x08017cd0: f7f8        fd0c 	bl	0x106ec
@   0x08017cd4: 7838        ldrb	r0, [r7, #0]
@   0x08017cd6: 3001        adds	r0, #1
@   0x08017cd8: 7038        strb	r0, [r7, #0]
@   0x08017cda: bc08        pop	{r3}
@   0x08017cdc: 4698        mov	r8, r3
@   0x08017cde: bcf0        pop	{r4, r5, r6, r7}
@   0x08017ce0: bc01        pop	{r0}
@   0x08017ce2: 4700        bx	r0
@   0x08017ce4: 5398        strh	r0, [r3, r6]
@   0x08017ce6: 0300        lsls	r0, r0, #12
@   0x08017ce8: 3480        adds	r4, #128	@ 0x80
@   0x08017cea: 0300        lsls	r0, r0, #12
@   0x08017cec: 3550        adds	r5, #80	@ 0x50
@   0x08017cee: 0300        lsls	r0, r0, #12
@   0x08017cf0: 000c        movs	r4, r1
@   0x08017cf2: 0400        lsls	r0, r0, #16
@   0x08017cf4: 1f04        subs	r4, r0, #4
@   0x08017cf6: 0000        movs	r0, r0
@   0x08017cf8: 00d4        lsls	r4, r2, #3
@   0x08017cfa: 0400        lsls	r0, r0, #16
@   0x08017cfc: 3550        adds	r5, #80	@ 0x50
@   0x08017cfe: 080e        lsrs	r6, r1, #32
@   0x08017d00: 0100        lsls	r0, r0, #4
@   0x08017d02: 8000        strh	r0, [r0, #0]
@   0x08017d04: 3470        adds	r4, #112	@ 0x70
@   0x08017d06: 0300        lsls	r0, r0, #12
@   0x08017d08: 3474        adds	r4, #116	@ 0x74
@   0x08017d0a: 0300        lsls	r0, r0, #12
@   0x08017d0c: 3478        adds	r4, #120	@ 0x78
@   0x08017d0e: 0300        lsls	r0, r0, #12
@   0x08017d10: b530        push	{r4, r5, lr}
@   0x08017d12: 4c1c        ldr	r4, [pc, #112]	@ (0x17d84)
@   0x08017d14: 2000        movs	r0, #0
@   0x08017d16: 7160        strb	r0, [r4, #5]
@   0x08017d18: f7f8        fcfa 	bl	0x10710
@   0x08017d1c: 1c05        adds	r5, r0, #0
@   0x08017d1e: 2d00        cmp	r5, #0
@   0x08017d20: d145        bne.n	0x17dae
@   0x08017d22: 79a0        ldrb	r0, [r4, #6]
@   0x08017d24: 2800        cmp	r0, #0
@   0x08017d26: d137        bne.n	0x17d98
@   0x08017d28: f7e8        fdea 	bl	0x900
@   0x08017d2c: 68e1        ldr	r1, [r4, #12]
@   0x08017d2e: 1a40        subs	r0, r0, r1
@   0x08017d30: 283b        cmp	r0, #59	@ 0x3b
@   0x08017d32: d93c        bls.n	0x17dae
@   0x08017d34: 7820        ldrb	r0, [r4, #0]
@   0x08017d36: 3001        adds	r0, #1
@   0x08017d38: 7020        strb	r0, [r4, #0]
@   0x08017d3a: f7e8        fde1 	bl	0x900
@   0x08017d3e: 60e0        str	r0, [r4, #12]
@   0x08017d40: f7e8        fdde 	bl	0x900
@   0x08017d44: 6120        str	r0, [r4, #16]
@   0x08017d46: 4810        ldr	r0, [pc, #64]	@ (0x17d88)
@   0x08017d48: 8005        strh	r5, [r0, #0]
@   0x08017d4a: 2280        movs	r2, #128	@ 0x80
@   0x08017d4c: 04d2        lsls	r2, r2, #19
@   0x08017d4e: 8811        ldrh	r1, [r2, #0]
@   0x08017d50: 2010        movs	r0, #16
@   0x08017d52: 4008        ands	r0, r1
@   0x08017d54: 2800        cmp	r0, #0
@   0x08017d56: d103        bne.n	0x17d60
@   0x08017d58: 8810        ldrh	r0, [r2, #0]
@   0x08017d5a: 2110        movs	r1, #16
@   0x08017d5c: 4048        eors	r0, r1
@   0x08017d5e: 8010        strh	r0, [r2, #0]
@   0x08017d60: 4c0a        ldr	r4, [pc, #40]	@ (0x17d8c)
@   0x08017d62: 1c20        adds	r0, r4, #0
@   0x08017d64: 3090        adds	r0, #144	@ 0x90
@   0x08017d66: 6802        ldr	r2, [r0, #0]
@   0x08017d68: 4b09        ldr	r3, [pc, #36]	@ (0x17d90)
@   0x08017d6a: 2028        movs	r0, #40	@ 0x28
@   0x08017d6c: 2121        movs	r1, #33	@ 0x21
@   0x08017d6e: f7fe        f8a9 	bl	0x15ec4
@   0x08017d72: 349c        adds	r4, #156	@ 0x9c
@   0x08017d74: 6822        ldr	r2, [r4, #0]
@   0x08017d76: 4b07        ldr	r3, [pc, #28]	@ (0x17d94)
@   0x08017d78: 2050        movs	r0, #80	@ 0x50
@   0x08017d7a: 216e        movs	r1, #110	@ 0x6e
@   0x08017d7c: f7fe        f8a2 	bl	0x15ec4
@   0x08017d80: e015        b.n	0x17dae
@   0x08017d82: 0000        movs	r0, r0
@   0x08017d84: 3480        adds	r4, #128	@ 0x80
@   0x08017d86: 0300        lsls	r0, r0, #12
@   0x08017d88: 5398        strh	r0, [r3, r6]
@   0x08017d8a: 0300        lsls	r0, r0, #12
@   0x08017d8c: 3550        adds	r5, #80	@ 0x50
@   0x08017d8e: 080e        lsrs	r6, r1, #32
@   0x08017d90: 3474        adds	r4, #116	@ 0x74
@   0x08017d92: 0300        lsls	r0, r0, #12
@   0x08017d94: 3478        adds	r4, #120	@ 0x78
@   0x08017d96: 0300        lsls	r0, r0, #12
@   0x08017d98: 7820        ldrb	r0, [r4, #0]
@   0x08017d9a: 3001        adds	r0, #1
@   0x08017d9c: 7020        strb	r0, [r4, #0]
@   0x08017d9e: f7e8        fdaf 	bl	0x900
@   0x08017da2: 60e0        str	r0, [r4, #12]
@   0x08017da4: f7e8        fdac 	bl	0x900
@   0x08017da8: 6120        str	r0, [r4, #16]
@   0x08017daa: 4802        ldr	r0, [pc, #8]	@ (0x17db4)
@   0x08017dac: 8005        strh	r5, [r0, #0]
@   0x08017dae: bc30        pop	{r4, r5}
@   0x08017db0: bc01        pop	{r0}
@   0x08017db2: 4700        bx	r0
@   0x08017db4: 5398        strh	r0, [r3, r6]
@   0x08017db6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08017BFC
sub_08017BFC: @ 0x08017bfc
        .incbin "frog_us_baserom.gba", 0x17bfc, 0x1bc
        thumb_func_end sub_08017BFC
