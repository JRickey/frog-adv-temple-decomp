@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009d9c, 0x08009eec)  (336 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009d9c --end 0x8009eec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009d9c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08009d9e: 1c06        adds	r6, r0, #0
@   0x08009da0: f7f6        fb90 	bl	0x4c4
@   0x08009da4: 490a        ldr	r1, [pc, #40]	@ (0x9dd0)
@   0x08009da6: 8008        strh	r0, [r1, #0]
@   0x08009da8: 7833        ldrb	r3, [r6, #0]
@   0x08009daa: 2000        movs	r0, #0
@   0x08009dac: 5630        ldrsb	r0, [r6, r0]
@   0x08009dae: 2800        cmp	r0, #0
@   0x08009db0: d114        bne.n	0x9ddc
@   0x08009db2: 4908        ldr	r1, [pc, #32]	@ (0x9dd4)
@   0x08009db4: 6808        ldr	r0, [r1, #0]
@   0x08009db6: 6148        str	r0, [r1, #20]
@   0x08009db8: 2001        movs	r0, #1
@   0x08009dba: 7030        strb	r0, [r6, #0]
@   0x08009dbc: 4806        ldr	r0, [pc, #24]	@ (0x9dd8)
@   0x08009dbe: 7e81        ldrb	r1, [r0, #26]
@   0x08009dc0: 311d        adds	r1, #29
@   0x08009dc2: 7681        strb	r1, [r0, #26]
@   0x08009dc4: 2102        movs	r1, #2
@   0x08009dc6: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x08009dc8: 4311        orrs	r1, r2
@   0x08009dca: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08009dcc: 1c07        adds	r7, r0, #0
@   0x08009dce: e014        b.n	0x9dfa
@   0x08009dd0: 5398        strh	r0, [r3, r6]
@   0x08009dd2: 0300        lsls	r0, r0, #12
@   0x08009dd4: 5330        strh	r0, [r6, r4]
@   0x08009dd6: 0300        lsls	r0, r0, #12
@   0x08009dd8: 3720        adds	r7, #32
@   0x08009dda: 0300        lsls	r0, r0, #12
@   0x08009ddc: 4934        ldr	r1, [pc, #208]	@ (0x9eb0)
@   0x08009dde: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08009de0: 2080        movs	r0, #128	@ 0x80
@   0x08009de2: 0200        lsls	r0, r0, #8
@   0x08009de4: 4010        ands	r0, r2
@   0x08009de6: 1c0f        adds	r7, r1, #0
@   0x08009de8: 2800        cmp	r0, #0
@   0x08009dea: d006        beq.n	0x9dfa
@   0x08009dec: 2002        movs	r0, #2
@   0x08009dee: 4310        orrs	r0, r2
@   0x08009df0: 4930        ldr	r1, [pc, #192]	@ (0x9eb4)
@   0x08009df2: 4008        ands	r0, r1
@   0x08009df4: 86b8        strh	r0, [r7, #52]	@ 0x34
@   0x08009df6: 1c58        adds	r0, r3, #1
@   0x08009df8: 7030        strb	r0, [r6, #0]
@   0x08009dfa: 1c38        adds	r0, r7, #0
@   0x08009dfc: f7fb        fde2 	bl	0x59c4
@   0x08009e00: 492d        ldr	r1, [pc, #180]	@ (0x9eb8)
@   0x08009e02: 4c2e        ldr	r4, [pc, #184]	@ (0x9ebc)
@   0x08009e04: 7aa2        ldrb	r2, [r4, #10]
@   0x08009e06: 0090        lsls	r0, r2, #2
@   0x08009e08: 1840        adds	r0, r0, r1
@   0x08009e0a: 6800        ldr	r0, [r0, #0]
@   0x08009e0c: f029        ff64 	bl	0x33cd8
@   0x08009e10: 492b        ldr	r1, [pc, #172]	@ (0x9ec0)
@   0x08009e12: 7aa2        ldrb	r2, [r4, #10]
@   0x08009e14: 0090        lsls	r0, r2, #2
@   0x08009e16: 1840        adds	r0, r0, r1
@   0x08009e18: 6800        ldr	r0, [r0, #0]
@   0x08009e1a: f029        ff5d 	bl	0x33cd8
@   0x08009e1e: f7ff        fe1b 	bl	0x9a58
@   0x08009e22: f7ff        f9b1 	bl	0x9188
@   0x08009e26: f7f6        fd59 	bl	0x8dc
@   0x08009e2a: 4d26        ldr	r5, [pc, #152]	@ (0x9ec4)
@   0x08009e2c: 8829        ldrh	r1, [r5, #0]
@   0x08009e2e: 4826        ldr	r0, [pc, #152]	@ (0x9ec8)
@   0x08009e30: 4008        ands	r0, r1
@   0x08009e32: 8028        strh	r0, [r5, #0]
@   0x08009e34: 4825        ldr	r0, [pc, #148]	@ (0x9ecc)
@   0x08009e36: 7aa4        ldrb	r4, [r4, #10]
@   0x08009e38: 1820        adds	r0, r4, r0
@   0x08009e3a: 7800        ldrb	r0, [r0, #0]
@   0x08009e3c: f005        ff44 	bl	0xfcc8
@   0x08009e40: f7fc        f8c2 	bl	0x5fc8
@   0x08009e44: 4822        ldr	r0, [pc, #136]	@ (0x9ed0)
@   0x08009e46: 21e0        movs	r1, #224	@ 0xe0
@   0x08009e48: 04c9        lsls	r1, r1, #19
@   0x08009e4a: 2280        movs	r2, #128	@ 0x80
@   0x08009e4c: 0052        lsls	r2, r2, #1
@   0x08009e4e: f023        fb83 	bl	0x2d558
@   0x08009e52: 4920        ldr	r1, [pc, #128]	@ (0x9ed4)
@   0x08009e54: 4a20        ldr	r2, [pc, #128]	@ (0x9ed8)
@   0x08009e56: 8810        ldrh	r0, [r2, #0]
@   0x08009e58: 8008        strh	r0, [r1, #0]
@   0x08009e5a: 3102        adds	r1, #2
@   0x08009e5c: 8850        ldrh	r0, [r2, #2]
@   0x08009e5e: 8008        strh	r0, [r1, #0]
@   0x08009e60: 3102        adds	r1, #2
@   0x08009e62: 8890        ldrh	r0, [r2, #4]
@   0x08009e64: 8008        strh	r0, [r1, #0]
@   0x08009e66: 3102        adds	r1, #2
@   0x08009e68: 88d0        ldrh	r0, [r2, #6]
@   0x08009e6a: 8008        strh	r0, [r1, #0]
@   0x08009e6c: 3102        adds	r1, #2
@   0x08009e6e: 8910        ldrh	r0, [r2, #8]
@   0x08009e70: 8008        strh	r0, [r1, #0]
@   0x08009e72: 3102        adds	r1, #2
@   0x08009e74: 8950        ldrh	r0, [r2, #10]
@   0x08009e76: 8008        strh	r0, [r1, #0]
@   0x08009e78: 8828        ldrh	r0, [r5, #0]
@   0x08009e7a: 2101        movs	r1, #1
@   0x08009e7c: 4308        orrs	r0, r1
@   0x08009e7e: 8028        strh	r0, [r5, #0]
@   0x08009e80: 7836        ldrb	r6, [r6, #0]
@   0x08009e82: 2e08        cmp	r6, #8
@   0x08009e84: d003        beq.n	0x9e8e
@   0x08009e86: 4815        ldr	r0, [pc, #84]	@ (0x9edc)
@   0x08009e88: 8800        ldrh	r0, [r0, #0]
@   0x08009e8a: 2800        cmp	r0, #0
@   0x08009e8c: d02a        beq.n	0x9ee4
@   0x08009e8e: 7eb8        ldrb	r0, [r7, #26]
@   0x08009e90: 281c        cmp	r0, #28
@   0x08009e92: d905        bls.n	0x9ea0
@   0x08009e94: 381d        subs	r0, #29
@   0x08009e96: 76b8        strb	r0, [r7, #26]
@   0x08009e98: 2002        movs	r0, #2
@   0x08009e9a: 8eb9        ldrh	r1, [r7, #52]	@ 0x34
@   0x08009e9c: 4308        orrs	r0, r1
@   0x08009e9e: 86b8        strh	r0, [r7, #52]	@ 0x34
@   0x08009ea0: 480e        ldr	r0, [pc, #56]	@ (0x9edc)
@   0x08009ea2: 8801        ldrh	r1, [r0, #0]
@   0x08009ea4: 2900        cmp	r1, #0
@   0x08009ea6: d001        beq.n	0x9eac
@   0x08009ea8: 480d        ldr	r0, [pc, #52]	@ (0x9ee0)
@   0x08009eaa: 8241        strh	r1, [r0, #18]
@   0x08009eac: 2001        movs	r0, #1
@   0x08009eae: e01a        b.n	0x9ee6
@   0x08009eb0: 3720        adds	r7, #32
@   0x08009eb2: 0300        lsls	r0, r0, #12
@   0x08009eb4: 7fff        ldrb	r7, [r7, #31]
@   0x08009eb6: 0000        movs	r0, r0
@   0x08009eb8: 0cb8        lsrs	r0, r7, #18
@   0x08009eba: 080c        lsrs	r4, r1, #32
@   0x08009ebc: 5330        strh	r0, [r6, r4]
@   0x08009ebe: 0300        lsls	r0, r0, #12
@   0x08009ec0: 0d40        lsrs	r0, r0, #21
@   0x08009ec2: 080c        lsrs	r4, r1, #32
@   0x08009ec4: 0200        lsls	r0, r0, #8
@   0x08009ec6: 0400        lsls	r0, r0, #16
@   0x08009ec8: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08009ecc: 0d84        lsrs	r4, r0, #22
@   0x08009ece: 080c        lsrs	r4, r1, #32
@   0x08009ed0: 54a0        strb	r0, [r4, r2]
@   0x08009ed2: 0300        lsls	r0, r0, #12
@   0x08009ed4: 0010        movs	r0, r2
@   0x08009ed6: 0400        lsls	r0, r0, #16
@   0x08009ed8: 3550        adds	r5, #80	@ 0x50
@   0x08009eda: 0300        lsls	r0, r0, #12
@   0x08009edc: 5398        strh	r0, [r3, r6]
@   0x08009ede: 0300        lsls	r0, r0, #12
@   0x08009ee0: 35e0        adds	r5, #224	@ 0xe0
@   0x08009ee2: 0300        lsls	r0, r0, #12
@   0x08009ee4: 2000        movs	r0, #0
@   0x08009ee6: bcf0        pop	{r4, r5, r6, r7}
@   0x08009ee8: bc02        pop	{r1}
@   0x08009eea: 4708        bx	r1

        thumb_func_start sub_08009D9C
sub_08009D9C: @ 0x08009d9c
        .incbin "frog_us_baserom.gba", 0x9d9c, 0x150
        thumb_func_end sub_08009D9C
