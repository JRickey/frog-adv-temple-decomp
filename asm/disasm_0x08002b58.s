@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002b58, 0x08002e04)  (684 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002b58 --end 0x8002e04 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002b58: b570        push	{r4, r5, r6, lr}
@   0x08002b5a: b081        sub	sp, #4
@   0x08002b5c: 4668        mov	r0, sp
@   0x08002b5e: 3001        adds	r0, #1
@   0x08002b60: 2100        movs	r1, #0
@   0x08002b62: 7001        strb	r1, [r0, #0]
@   0x08002b64: 4908        ldr	r1, [pc, #32]	@ (0x2b88)
@   0x08002b66: 1c05        adds	r5, r0, #0
@   0x08002b68: 7a49        ldrb	r1, [r1, #9]
@   0x08002b6a: 2910        cmp	r1, #16
@   0x08002b6c: d000        beq.n	0x2b70
@   0x08002b6e: e143        b.n	0x2df8
@   0x08002b70: f01e        f826 	bl	0x20bc0
@   0x08002b74: 7828        ldrb	r0, [r5, #0]
@   0x08002b76: 280b        cmp	r0, #11
@   0x08002b78: d900        bls.n	0x2b7c
@   0x08002b7a: e138        b.n	0x2dee
@   0x08002b7c: 0080        lsls	r0, r0, #2
@   0x08002b7e: 4903        ldr	r1, [pc, #12]	@ (0x2b8c)
@   0x08002b80: 1840        adds	r0, r0, r1
@   0x08002b82: 6800        ldr	r0, [r0, #0]
@   0x08002b84: 4687        mov	pc, r0
@   0x08002b86: 0000        movs	r0, r0
@   0x08002b88: 5330        strh	r0, [r6, r4]
@   0x08002b8a: 0300        lsls	r0, r0, #12
@   0x08002b8c: 2b90        cmp	r3, #144	@ 0x90
@   0x08002b8e: 0800        lsrs	r0, r0, #32
@   0x08002b90: 2bc0        cmp	r3, #192	@ 0xc0
@   0x08002b92: 0800        lsrs	r0, r0, #32
@   0x08002b94: 2bdc        cmp	r3, #220	@ 0xdc
@   0x08002b96: 0800        lsrs	r0, r0, #32
@   0x08002b98: 2c04        cmp	r4, #4
@   0x08002b9a: 0800        lsrs	r0, r0, #32
@   0x08002b9c: 2c16        cmp	r4, #22
@   0x08002b9e: 0800        lsrs	r0, r0, #32
@   0x08002ba0: 2c38        cmp	r4, #56	@ 0x38
@   0x08002ba2: 0800        lsrs	r0, r0, #32
@   0x08002ba4: 2cf8        cmp	r4, #248	@ 0xf8
@   0x08002ba6: 0800        lsrs	r0, r0, #32
@   0x08002ba8: 2d0e        cmp	r5, #14
@   0x08002baa: 0800        lsrs	r0, r0, #32
@   0x08002bac: 2d38        cmp	r5, #56	@ 0x38
@   0x08002bae: 0800        lsrs	r0, r0, #32
@   0x08002bb0: 2d6c        cmp	r5, #108	@ 0x6c
@   0x08002bb2: 0800        lsrs	r0, r0, #32
@   0x08002bb4: 2db4        cmp	r5, #180	@ 0xb4
@   0x08002bb6: 0800        lsrs	r0, r0, #32
@   0x08002bb8: 2de4        cmp	r5, #228	@ 0xe4
@   0x08002bba: 0800        lsrs	r0, r0, #32
@   0x08002bbc: 2dea        cmp	r5, #234	@ 0xea
@   0x08002bbe: 0800        lsrs	r0, r0, #32
@   0x08002bc0: 4905        ldr	r1, [pc, #20]	@ (0x2bd8)
@   0x08002bc2: 2400        movs	r4, #0
@   0x08002bc4: 2009        movs	r0, #9
@   0x08002bc6: 7288        strb	r0, [r1, #10]
@   0x08002bc8: f007        fb24 	bl	0xa214
@   0x08002bcc: 1c06        adds	r6, r0, #0
@   0x08002bce: 2001        movs	r0, #1
@   0x08002bd0: 7028        strb	r0, [r5, #0]
@   0x08002bd2: 4668        mov	r0, sp
@   0x08002bd4: 7004        strb	r4, [r0, #0]
@   0x08002bd6: e10a        b.n	0x2dee
@   0x08002bd8: 5330        strh	r0, [r6, r4]
@   0x08002bda: 0300        lsls	r0, r0, #12
@   0x08002bdc: 4907        ldr	r1, [pc, #28]	@ (0x2bfc)
@   0x08002bde: 4668        mov	r0, sp
@   0x08002be0: f007        fa90 	bl	0xa104
@   0x08002be4: 0600        lsls	r0, r0, #24
@   0x08002be6: 2800        cmp	r0, #0
@   0x08002be8: d100        bne.n	0x2bec
@   0x08002bea: e0f4        b.n	0x2dd6
@   0x08002bec: 2002        movs	r0, #2
@   0x08002bee: 7028        strb	r0, [r5, #0]
@   0x08002bf0: 4803        ldr	r0, [pc, #12]	@ (0x2c00)
@   0x08002bf2: 2100        movs	r1, #0
@   0x08002bf4: 6141        str	r1, [r0, #20]
@   0x08002bf6: 4668        mov	r0, sp
@   0x08002bf8: 7001        strb	r1, [r0, #0]
@   0x08002bfa: e0ec        b.n	0x2dd6
@   0x08002bfc: 2e11        cmp	r6, #17
@   0x08002bfe: 0800        lsrs	r0, r0, #32
@   0x08002c00: 5330        strh	r0, [r6, r4]
@   0x08002c02: 0300        lsls	r0, r0, #12
@   0x08002c04: 2009        movs	r0, #9
@   0x08002c06: f018        fc85 	bl	0x1b514
@   0x08002c0a: 1c30        adds	r0, r6, #0
@   0x08002c0c: f007        fb24 	bl	0xa258
@   0x08002c10: 2003        movs	r0, #3
@   0x08002c12: 7028        strb	r0, [r5, #0]
@   0x08002c14: e0eb        b.n	0x2dee
@   0x08002c16: 4668        mov	r0, sp
@   0x08002c18: f007        f8c0 	bl	0x9d9c
@   0x08002c1c: 2800        cmp	r0, #0
@   0x08002c1e: d100        bne.n	0x2c22
@   0x08002c20: e0e5        b.n	0x2dee
@   0x08002c22: 2004        movs	r0, #4
@   0x08002c24: 7028        strb	r0, [r5, #0]
@   0x08002c26: 4803        ldr	r0, [pc, #12]	@ (0x2c34)
@   0x08002c28: 2100        movs	r1, #0
@   0x08002c2a: 6141        str	r1, [r0, #20]
@   0x08002c2c: 4668        mov	r0, sp
@   0x08002c2e: 7001        strb	r1, [r0, #0]
@   0x08002c30: e0dd        b.n	0x2dee
@   0x08002c32: 0000        movs	r0, r0
@   0x08002c34: 5330        strh	r0, [r6, r4]
@   0x08002c36: 0300        lsls	r0, r0, #12
@   0x08002c38: f7fd        fc44 	bl	0x4c4
@   0x08002c3c: 4905        ldr	r1, [pc, #20]	@ (0x2c54)
@   0x08002c3e: 8008        strh	r0, [r1, #0]
@   0x08002c40: 0400        lsls	r0, r0, #16
@   0x08002c42: 0c00        lsrs	r0, r0, #16
@   0x08002c44: 2840        cmp	r0, #64	@ 0x40
@   0x08002c46: d107        bne.n	0x2c58
@   0x08002c48: 2007        movs	r0, #7
@   0x08002c4a: 7028        strb	r0, [r5, #0]
@   0x08002c4c: f00b        fa08 	bl	0xe060
@   0x08002c50: e0cd        b.n	0x2dee
@   0x08002c52: 0000        movs	r0, r0
@   0x08002c54: 5398        strh	r0, [r3, r6]
@   0x08002c56: 0300        lsls	r0, r0, #12
@   0x08002c58: 4904        ldr	r1, [pc, #16]	@ (0x2c6c)
@   0x08002c5a: 2008        movs	r0, #8
@   0x08002c5c: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08002c5e: 4008        ands	r0, r1
@   0x08002c60: 2800        cmp	r0, #0
@   0x08002c62: d005        beq.n	0x2c70
@   0x08002c64: 2005        movs	r0, #5
@   0x08002c66: 7028        strb	r0, [r5, #0]
@   0x08002c68: e0c1        b.n	0x2dee
@   0x08002c6a: 0000        movs	r0, r0
@   0x08002c6c: 3720        adds	r7, #32
@   0x08002c6e: 0300        lsls	r0, r0, #12
@   0x08002c70: 4c05        ldr	r4, [pc, #20]	@ (0x2c88)
@   0x08002c72: 1c20        adds	r0, r4, #0
@   0x08002c74: 2108        movs	r1, #8
@   0x08002c76: 2200        movs	r2, #0
@   0x08002c78: f003        fd90 	bl	0x679c
@   0x08002c7c: 0600        lsls	r0, r0, #24
@   0x08002c7e: 2800        cmp	r0, #0
@   0x08002c80: d004        beq.n	0x2c8c
@   0x08002c82: 200a        movs	r0, #10
@   0x08002c84: 7028        strb	r0, [r5, #0]
@   0x08002c86: e0b2        b.n	0x2dee
@   0x08002c88: 6110        str	r0, [r2, #16]
@   0x08002c8a: 0300        lsls	r0, r0, #12
@   0x08002c8c: 1c20        adds	r0, r4, #0
@   0x08002c8e: 2108        movs	r1, #8
@   0x08002c90: 2201        movs	r2, #1
@   0x08002c92: f003        fd83 	bl	0x679c
@   0x08002c96: 0600        lsls	r0, r0, #24
@   0x08002c98: 2800        cmp	r0, #0
@   0x08002c9a: d007        beq.n	0x2cac
@   0x08002c9c: 1c20        adds	r0, r4, #0
@   0x08002c9e: 2108        movs	r1, #8
@   0x08002ca0: 2201        movs	r2, #1
@   0x08002ca2: f003        fd0f 	bl	0x66c4
@   0x08002ca6: 2006        movs	r0, #6
@   0x08002ca8: 7028        strb	r0, [r5, #0]
@   0x08002caa: e0a0        b.n	0x2dee
@   0x08002cac: f007        fb14 	bl	0xa2d8
@   0x08002cb0: f7fd        fe14 	bl	0x8dc
@   0x08002cb4: f007        fb38 	bl	0xa328
@   0x08002cb8: f006        fc1e 	bl	0x94f8
@   0x08002cbc: f006        fe62 	bl	0x9984
@   0x08002cc0: 4b0b        ldr	r3, [pc, #44]	@ (0x2cf0)
@   0x08002cc2: 2010        movs	r0, #16
@   0x08002cc4: 8a19        ldrh	r1, [r3, #16]
@   0x08002cc6: 4008        ands	r0, r1
@   0x08002cc8: 2800        cmp	r0, #0
@   0x08002cca: d00b        beq.n	0x2ce4
@   0x08002ccc: 7e18        ldrb	r0, [r3, #24]
@   0x08002cce: 7e59        ldrb	r1, [r3, #25]
@   0x08002cd0: 2408        movs	r4, #8
@   0x08002cd2: 5f1a        ldrsh	r2, [r3, r4]
@   0x08002cd4: 240a        movs	r4, #10
@   0x08002cd6: 5f1b        ldrsh	r3, [r3, r4]
@   0x08002cd8: f00a        f856 	bl	0xcd88
@   0x08002cdc: 0600        lsls	r0, r0, #24
@   0x08002cde: 0e00        lsrs	r0, r0, #24
@   0x08002ce0: f008        f802 	bl	0xace8
@   0x08002ce4: 4903        ldr	r1, [pc, #12]	@ (0x2cf4)
@   0x08002ce6: 6948        ldr	r0, [r1, #20]
@   0x08002ce8: 3001        adds	r0, #1
@   0x08002cea: 6148        str	r0, [r1, #20]
@   0x08002cec: e07f        b.n	0x2dee
@   0x08002cee: 0000        movs	r0, r0
@   0x08002cf0: 35e0        adds	r5, #224	@ 0xe0
@   0x08002cf2: 0300        lsls	r0, r0, #12
@   0x08002cf4: 5330        strh	r0, [r6, r4]
@   0x08002cf6: 0300        lsls	r0, r0, #12
@   0x08002cf8: 1c28        adds	r0, r5, #0
@   0x08002cfa: f006        ff8b 	bl	0x9c14
@   0x08002cfe: 2800        cmp	r0, #0
@   0x08002d00: d101        bne.n	0x2d06
@   0x08002d02: 2009        movs	r0, #9
@   0x08002d04: 7028        strb	r0, [r5, #0]
@   0x08002d06: 4669        mov	r1, sp
@   0x08002d08: 2000        movs	r0, #0
@   0x08002d0a: 7008        strb	r0, [r1, #0]
@   0x08002d0c: e06f        b.n	0x2dee
@   0x08002d0e: f7ff        feeb 	bl	0x2ae8
@   0x08002d12: 4907        ldr	r1, [pc, #28]	@ (0x2d30)
@   0x08002d14: 316c        adds	r1, #108	@ 0x6c
@   0x08002d16: 2008        movs	r0, #8
@   0x08002d18: 2400        movs	r4, #0
@   0x08002d1a: 880a        ldrh	r2, [r1, #0]
@   0x08002d1c: 4310        orrs	r0, r2
@   0x08002d1e: 8008        strh	r0, [r1, #0]
@   0x08002d20: f007        fc0e 	bl	0xa540
@   0x08002d24: 2004        movs	r0, #4
@   0x08002d26: 7028        strb	r0, [r5, #0]
@   0x08002d28: 4802        ldr	r0, [pc, #8]	@ (0x2d34)
@   0x08002d2a: 6144        str	r4, [r0, #20]
@   0x08002d2c: e05f        b.n	0x2dee
@   0x08002d2e: 0000        movs	r0, r0
@   0x08002d30: 3720        adds	r7, #32
@   0x08002d32: 0300        lsls	r0, r0, #12
@   0x08002d34: 5330        strh	r0, [r6, r4]
@   0x08002d36: 0300        lsls	r0, r0, #12
@   0x08002d38: f7fd        fbc4 	bl	0x4c4
@   0x08002d3c: 4909        ldr	r1, [pc, #36]	@ (0x2d64)
@   0x08002d3e: 8008        strh	r0, [r1, #0]
@   0x08002d40: f00b        fcb2 	bl	0xe6a8
@   0x08002d44: 0600        lsls	r0, r0, #24
@   0x08002d46: 0e01        lsrs	r1, r0, #24
@   0x08002d48: 2900        cmp	r1, #0
@   0x08002d4a: d103        bne.n	0x2d54
@   0x08002d4c: 2008        movs	r0, #8
@   0x08002d4e: 7028        strb	r0, [r5, #0]
@   0x08002d50: 4668        mov	r0, sp
@   0x08002d52: 7001        strb	r1, [r0, #0]
@   0x08002d54: 4804        ldr	r0, [pc, #16]	@ (0x2d68)
@   0x08002d56: 7800        ldrb	r0, [r0, #0]
@   0x08002d58: 2800        cmp	r0, #0
@   0x08002d5a: d148        bne.n	0x2dee
@   0x08002d5c: 2004        movs	r0, #4
@   0x08002d5e: 7028        strb	r0, [r5, #0]
@   0x08002d60: e045        b.n	0x2dee
@   0x08002d62: 0000        movs	r0, r0
@   0x08002d64: 5398        strh	r0, [r3, r6]
@   0x08002d66: 0300        lsls	r0, r0, #12
@   0x08002d68: 5328        strh	r0, [r5, r4]
@   0x08002d6a: 0300        lsls	r0, r0, #12
@   0x08002d6c: 4668        mov	r0, sp
@   0x08002d6e: 7800        ldrb	r0, [r0, #0]
@   0x08002d70: 0600        lsls	r0, r0, #24
@   0x08002d72: 1600        asrs	r0, r0, #24
@   0x08002d74: 2800        cmp	r0, #0
@   0x08002d76: d107        bne.n	0x2d88
@   0x08002d78: 20bf        movs	r0, #191	@ 0xbf
@   0x08002d7a: f00d        fc8b 	bl	0x10694
@   0x08002d7e: 4668        mov	r0, sp
@   0x08002d80: 4669        mov	r1, sp
@   0x08002d82: 7809        ldrb	r1, [r1, #0]
@   0x08002d84: 3101        adds	r1, #1
@   0x08002d86: 7001        strb	r1, [r0, #0]
@   0x08002d88: 4668        mov	r0, sp
@   0x08002d8a: 2400        movs	r4, #0
@   0x08002d8c: 5704        ldrsb	r4, [r0, r4]
@   0x08002d8e: 2c01        cmp	r4, #1
@   0x08002d90: d12d        bne.n	0x2dee
@   0x08002d92: f00d        fc91 	bl	0x106b8
@   0x08002d96: 0600        lsls	r0, r0, #24
@   0x08002d98: 2800        cmp	r0, #0
@   0x08002d9a: d128        bne.n	0x2dee
@   0x08002d9c: 4803        ldr	r0, [pc, #12]	@ (0x2dac)
@   0x08002d9e: 2104        movs	r1, #4
@   0x08002da0: 7001        strb	r1, [r0, #0]
@   0x08002da2: 7184        strb	r4, [r0, #6]
@   0x08002da4: 4802        ldr	r0, [pc, #8]	@ (0x2db0)
@   0x08002da6: 7241        strb	r1, [r0, #9]
@   0x08002da8: e021        b.n	0x2dee
@   0x08002daa: 0000        movs	r0, r0
@   0x08002dac: 3480        adds	r4, #128	@ 0x80
@   0x08002dae: 0300        lsls	r0, r0, #12
@   0x08002db0: 5330        strh	r0, [r6, r4]
@   0x08002db2: 0300        lsls	r0, r0, #12
@   0x08002db4: 4909        ldr	r1, [pc, #36]	@ (0x2ddc)
@   0x08002db6: 4668        mov	r0, sp
@   0x08002db8: f007        f9a4 	bl	0xa104
@   0x08002dbc: 0600        lsls	r0, r0, #24
@   0x08002dbe: 2800        cmp	r0, #0
@   0x08002dc0: d009        beq.n	0x2dd6
@   0x08002dc2: 2003        movs	r0, #3
@   0x08002dc4: 7028        strb	r0, [r5, #0]
@   0x08002dc6: 4806        ldr	r0, [pc, #24]	@ (0x2de0)
@   0x08002dc8: 2100        movs	r1, #0
@   0x08002dca: 6141        str	r1, [r0, #20]
@   0x08002dcc: 4668        mov	r0, sp
@   0x08002dce: 7001        strb	r1, [r0, #0]
@   0x08002dd0: 1c30        adds	r0, r6, #0
@   0x08002dd2: f007        fa41 	bl	0xa258
@   0x08002dd6: f7fd        fd81 	bl	0x8dc
@   0x08002dda: e008        b.n	0x2dee
@   0x08002ddc: a26d        add	r2, pc, #436	@ (adr r2, 0x2f94)
@   0x08002dde: 0800        lsrs	r0, r0, #32
@   0x08002de0: 5330        strh	r0, [r6, r4]
@   0x08002de2: 0300        lsls	r0, r0, #12
@   0x08002de4: 200b        movs	r0, #11
@   0x08002de6: 7028        strb	r0, [r5, #0]
@   0x08002de8: e001        b.n	0x2dee
@   0x08002dea: f00b        f849 	bl	0xde80
@   0x08002dee: 4804        ldr	r0, [pc, #16]	@ (0x2e00)
@   0x08002df0: 7a40        ldrb	r0, [r0, #9]
@   0x08002df2: 2810        cmp	r0, #16
@   0x08002df4: d100        bne.n	0x2df8
@   0x08002df6: e6bb        b.n	0x2b70
@   0x08002df8: b001        add	sp, #4
@   0x08002dfa: bc70        pop	{r4, r5, r6}
@   0x08002dfc: bc01        pop	{r0}
@   0x08002dfe: 4700        bx	r0
@   0x08002e00: 5330        strh	r0, [r6, r4]
@   0x08002e02: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002B58
sub_08002B58: @ 0x08002b58
        .incbin "frog_us_baserom.gba", 0x2b58, 0x2ac
        thumb_func_end sub_08002B58
