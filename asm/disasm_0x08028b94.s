@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028b94, 0x080292e0)  (1868 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028b94 --end 0x80292e0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028b94: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08028b96: 4657        mov	r7, sl
@   0x08028b98: 464e        mov	r6, r9
@   0x08028b9a: 4645        mov	r5, r8
@   0x08028b9c: b4e0        push	{r5, r6, r7}
@   0x08028b9e: b088        sub	sp, #32
@   0x08028ba0: 4d0b        ldr	r5, [pc, #44]	@ (0x28bd0)
@   0x08028ba2: 1c2f        adds	r7, r5, #0
@   0x08028ba4: 3738        adds	r7, #56	@ 0x38
@   0x08028ba6: 2070        movs	r0, #112	@ 0x70
@   0x08028ba8: 4240        negs	r0, r0
@   0x08028baa: 1940        adds	r0, r0, r5
@   0x08028bac: 4684        mov	ip, r0
@   0x08028bae: 1c2e        adds	r6, r5, #0
@   0x08028bb0: 3e38        subs	r6, #56	@ 0x38
@   0x08028bb2: 2102        movs	r1, #2
@   0x08028bb4: 5e68        ldrsh	r0, [r5, r1]
@   0x08028bb6: 4662        mov	r2, ip
@   0x08028bb8: 2302        movs	r3, #2
@   0x08028bba: 5ed1        ldrsh	r1, [r2, r3]
@   0x08028bbc: 1a40        subs	r0, r0, r1
@   0x08028bbe: 2800        cmp	r0, #0
@   0x08028bc0: db08        blt.n	0x28bd4
@   0x08028bc2: 8868        ldrh	r0, [r5, #2]
@   0x08028bc4: 8852        ldrh	r2, [r2, #2]
@   0x08028bc6: 1a81        subs	r1, r0, r2
@   0x08028bc8: 0609        lsls	r1, r1, #24
@   0x08028bca: 0e0c        lsrs	r4, r1, #24
@   0x08028bcc: 1c03        adds	r3, r0, #0
@   0x08028bce: e008        b.n	0x28be2
@   0x08028bd0: 4c58        ldr	r4, [pc, #352]	@ (0x28d34)
@   0x08028bd2: 0300        lsls	r0, r0, #12
@   0x08028bd4: 4664        mov	r4, ip
@   0x08028bd6: 8862        ldrh	r2, [r4, #2]
@   0x08028bd8: 8869        ldrh	r1, [r5, #2]
@   0x08028bda: 1a50        subs	r0, r2, r1
@   0x08028bdc: 0600        lsls	r0, r0, #24
@   0x08028bde: 0e04        lsrs	r4, r0, #24
@   0x08028be0: 1c0b        adds	r3, r1, #0
@   0x08028be2: 9404        str	r4, [sp, #16]
@   0x08028be4: 2102        movs	r1, #2
@   0x08028be6: 5e68        ldrsh	r0, [r5, r1]
@   0x08028be8: 2402        movs	r4, #2
@   0x08028bea: 5f31        ldrsh	r1, [r6, r4]
@   0x08028bec: 1a40        subs	r0, r0, r1
@   0x08028bee: 2800        cmp	r0, #0
@   0x08028bf0: db02        blt.n	0x28bf8
@   0x08028bf2: 8871        ldrh	r1, [r6, #2]
@   0x08028bf4: 1a58        subs	r0, r3, r1
@   0x08028bf6: e001        b.n	0x28bfc
@   0x08028bf8: 8871        ldrh	r1, [r6, #2]
@   0x08028bfa: 1ac8        subs	r0, r1, r3
@   0x08028bfc: 0600        lsls	r0, r0, #24
@   0x08028bfe: 0e00        lsrs	r0, r0, #24
@   0x08028c00: 1c0c        adds	r4, r1, #0
@   0x08028c02: 9005        str	r0, [sp, #20]
@   0x08028c04: 2102        movs	r1, #2
@   0x08028c06: 5e78        ldrsh	r0, [r7, r1]
@   0x08028c08: 4663        mov	r3, ip
@   0x08028c0a: 2102        movs	r1, #2
@   0x08028c0c: 5e5b        ldrsh	r3, [r3, r1]
@   0x08028c0e: 1ac0        subs	r0, r0, r3
@   0x08028c10: 2800        cmp	r0, #0
@   0x08028c12: db02        blt.n	0x28c1a
@   0x08028c14: 8879        ldrh	r1, [r7, #2]
@   0x08028c16: 1a88        subs	r0, r1, r2
@   0x08028c18: e001        b.n	0x28c1e
@   0x08028c1a: 8879        ldrh	r1, [r7, #2]
@   0x08028c1c: 1a50        subs	r0, r2, r1
@   0x08028c1e: 0600        lsls	r0, r0, #24
@   0x08028c20: 0e00        lsrs	r0, r0, #24
@   0x08028c22: 1c0b        adds	r3, r1, #0
@   0x08028c24: 9006        str	r0, [sp, #24]
@   0x08028c26: 2202        movs	r2, #2
@   0x08028c28: 5eb8        ldrsh	r0, [r7, r2]
@   0x08028c2a: 2202        movs	r2, #2
@   0x08028c2c: 5eb1        ldrsh	r1, [r6, r2]
@   0x08028c2e: 1a40        subs	r0, r0, r1
@   0x08028c30: 2800        cmp	r0, #0
@   0x08028c32: db01        blt.n	0x28c38
@   0x08028c34: 1b18        subs	r0, r3, r4
@   0x08028c36: e000        b.n	0x28c3a
@   0x08028c38: 1ae0        subs	r0, r4, r3
@   0x08028c3a: 0600        lsls	r0, r0, #24
@   0x08028c3c: 0e00        lsrs	r0, r0, #24
@   0x08028c3e: 9007        str	r0, [sp, #28]
@   0x08028c40: 2304        movs	r3, #4
@   0x08028c42: 5ee8        ldrsh	r0, [r5, r3]
@   0x08028c44: 4664        mov	r4, ip
@   0x08028c46: 2204        movs	r2, #4
@   0x08028c48: 5ea1        ldrsh	r1, [r4, r2]
@   0x08028c4a: 1a40        subs	r0, r0, r1
@   0x08028c4c: 2800        cmp	r0, #0
@   0x08028c4e: db06        blt.n	0x28c5e
@   0x08028c50: 88a8        ldrh	r0, [r5, #4]
@   0x08028c52: 88a2        ldrh	r2, [r4, #4]
@   0x08028c54: 1a81        subs	r1, r0, r2
@   0x08028c56: 0609        lsls	r1, r1, #24
@   0x08028c58: 0e0c        lsrs	r4, r1, #24
@   0x08028c5a: 1c03        adds	r3, r0, #0
@   0x08028c5c: e006        b.n	0x28c6c
@   0x08028c5e: 4663        mov	r3, ip
@   0x08028c60: 889a        ldrh	r2, [r3, #4]
@   0x08028c62: 88a9        ldrh	r1, [r5, #4]
@   0x08028c64: 1a50        subs	r0, r2, r1
@   0x08028c66: 0600        lsls	r0, r0, #24
@   0x08028c68: 0e04        lsrs	r4, r0, #24
@   0x08028c6a: 1c0b        adds	r3, r1, #0
@   0x08028c6c: 46a2        mov	sl, r4
@   0x08028c6e: 2404        movs	r4, #4
@   0x08028c70: 5f28        ldrsh	r0, [r5, r4]
@   0x08028c72: 2504        movs	r5, #4
@   0x08028c74: 5f71        ldrsh	r1, [r6, r5]
@   0x08028c76: 1a40        subs	r0, r0, r1
@   0x08028c78: 2800        cmp	r0, #0
@   0x08028c7a: db02        blt.n	0x28c82
@   0x08028c7c: 88b1        ldrh	r1, [r6, #4]
@   0x08028c7e: 1a58        subs	r0, r3, r1
@   0x08028c80: e001        b.n	0x28c86
@   0x08028c82: 88b1        ldrh	r1, [r6, #4]
@   0x08028c84: 1ac8        subs	r0, r1, r3
@   0x08028c86: 0600        lsls	r0, r0, #24
@   0x08028c88: 0e00        lsrs	r0, r0, #24
@   0x08028c8a: 1c0c        adds	r4, r1, #0
@   0x08028c8c: 4680        mov	r8, r0
@   0x08028c8e: 2104        movs	r1, #4
@   0x08028c90: 5e78        ldrsh	r0, [r7, r1]
@   0x08028c92: 4663        mov	r3, ip
@   0x08028c94: 2504        movs	r5, #4
@   0x08028c96: 5f59        ldrsh	r1, [r3, r5]
@   0x08028c98: 1a40        subs	r0, r0, r1
@   0x08028c9a: 2800        cmp	r0, #0
@   0x08028c9c: db02        blt.n	0x28ca4
@   0x08028c9e: 88b9        ldrh	r1, [r7, #4]
@   0x08028ca0: 1a88        subs	r0, r1, r2
@   0x08028ca2: e001        b.n	0x28ca8
@   0x08028ca4: 88b9        ldrh	r1, [r7, #4]
@   0x08028ca6: 1a50        subs	r0, r2, r1
@   0x08028ca8: 0600        lsls	r0, r0, #24
@   0x08028caa: 0e00        lsrs	r0, r0, #24
@   0x08028cac: 1c0b        adds	r3, r1, #0
@   0x08028cae: 4681        mov	r9, r0
@   0x08028cb0: 2104        movs	r1, #4
@   0x08028cb2: 5e78        ldrsh	r0, [r7, r1]
@   0x08028cb4: 2204        movs	r2, #4
@   0x08028cb6: 5eb1        ldrsh	r1, [r6, r2]
@   0x08028cb8: 1a40        subs	r0, r0, r1
@   0x08028cba: 2800        cmp	r0, #0
@   0x08028cbc: db01        blt.n	0x28cc2
@   0x08028cbe: 1b18        subs	r0, r3, r4
@   0x08028cc0: e000        b.n	0x28cc4
@   0x08028cc2: 1ae0        subs	r0, r4, r3
@   0x08028cc4: 0600        lsls	r0, r0, #24
@   0x08028cc6: 0e00        lsrs	r0, r0, #24
@   0x08028cc8: 1c04        adds	r4, r0, #0
@   0x08028cca: 4d23        ldr	r5, [pc, #140]	@ (0x28d58)
@   0x08028ccc: 1c28        adds	r0, r5, #0
@   0x08028cce: 2103        movs	r1, #3
@   0x08028cd0: 2206        movs	r2, #6
@   0x08028cd2: f7dd        fd63 	bl	0x679c
@   0x08028cd6: 0600        lsls	r0, r0, #24
@   0x08028cd8: 2800        cmp	r0, #0
@   0x08028cda: d000        beq.n	0x28cde
@   0x08028cdc: e08c        b.n	0x28df8
@   0x08028cde: 1c28        adds	r0, r5, #0
@   0x08028ce0: 2103        movs	r1, #3
@   0x08028ce2: 2205        movs	r2, #5
@   0x08028ce4: f7dd        fd5a 	bl	0x679c
@   0x08028ce8: 0600        lsls	r0, r0, #24
@   0x08028cea: 2800        cmp	r0, #0
@   0x08028cec: d100        bne.n	0x28cf0
@   0x08028cee: e083        b.n	0x28df8
@   0x08028cf0: 9b07        ldr	r3, [sp, #28]
@   0x08028cf2: 0618        lsls	r0, r3, #24
@   0x08028cf4: 1600        asrs	r0, r0, #24
@   0x08028cf6: 2803        cmp	r0, #3
@   0x08028cf8: dc3c        bgt.n	0x28d74
@   0x08028cfa: 0620        lsls	r0, r4, #24
@   0x08028cfc: 1600        asrs	r0, r0, #24
@   0x08028cfe: 2803        cmp	r0, #3
@   0x08028d00: dc38        bgt.n	0x28d74
@   0x08028d02: 4916        ldr	r1, [pc, #88]	@ (0x28d5c)
@   0x08028d04: 4816        ldr	r0, [pc, #88]	@ (0x28d60)
@   0x08028d06: 9000        str	r0, [sp, #0]
@   0x08028d08: 2006        movs	r0, #6
@   0x08028d0a: 9001        str	r0, [sp, #4]
@   0x08028d0c: 2402        movs	r4, #2
@   0x08028d0e: 9402        str	r4, [sp, #8]
@   0x08028d10: 2003        movs	r0, #3
@   0x08028d12: 9003        str	r0, [sp, #12]
@   0x08028d14: 2060        movs	r0, #96	@ 0x60
@   0x08028d16: 2210        movs	r2, #16
@   0x08028d18: 2349        movs	r3, #73	@ 0x49
@   0x08028d1a: f7f8        f9c1 	bl	0x210a0
@   0x08028d1e: 1c28        adds	r0, r5, #0
@   0x08028d20: 2105        movs	r1, #5
@   0x08028d22: 2206        movs	r2, #6
@   0x08028d24: f7dd        fcce 	bl	0x66c4
@   0x08028d28: 2065        movs	r0, #101	@ 0x65
@   0x08028d2a: f7f7        ffa5 	bl	0x20c78
@   0x08028d2e: 490d        ldr	r1, [pc, #52]	@ (0x28d64)
@   0x08028d30: 4a0d        ldr	r2, [pc, #52]	@ (0x28d68)
@   0x08028d32: 1888        adds	r0, r1, r2
@   0x08028d34: 7004        strb	r4, [r0, #0]
@   0x08028d36: 4b0d        ldr	r3, [pc, #52]	@ (0x28d6c)
@   0x08028d38: 18ca        adds	r2, r1, r3
@   0x08028d3a: 2002        movs	r0, #2
@   0x08028d3c: 8814        ldrh	r4, [r2, #0]
@   0x08028d3e: 4320        orrs	r0, r4
@   0x08028d40: 8010        strh	r0, [r2, #0]
@   0x08028d42: 480b        ldr	r0, [pc, #44]	@ (0x28d70)
@   0x08028d44: 1809        adds	r1, r1, r0
@   0x08028d46: 2014        movs	r0, #20
@   0x08028d48: 7008        strb	r0, [r1, #0]
@   0x08028d4a: 1c28        adds	r0, r5, #0
@   0x08028d4c: 2103        movs	r1, #3
@   0x08028d4e: 2206        movs	r2, #6
@   0x08028d50: f7dd        fc56 	bl	0x6600
@   0x08028d54: 1c28        adds	r0, r5, #0
@   0x08028d56: e0da        b.n	0x28f0e
@   0x08028d58: 6110        str	r0, [r2, #16]
@   0x08028d5a: 0300        lsls	r0, r0, #12
@   0x08028d5c: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x08028d5e: 0831        lsrs	r1, r6, #32
@   0x08028d60: 02f5        lsls	r5, r6, #11
@   0x08028d62: 0000        movs	r0, r0
@   0x08028d64: 3720        adds	r7, #32
@   0x08028d66: 0300        lsls	r0, r0, #12
@   0x08028d68: 13ca        asrs	r2, r1, #15
@   0x08028d6a: 0000        movs	r0, r0
@   0x08028d6c: 13e4        asrs	r4, r4, #15
@   0x08028d6e: 0000        movs	r0, r0
@   0x08028d70: 13da        asrs	r2, r3, #15
@   0x08028d72: 0000        movs	r0, r0
@   0x08028d74: 9906        ldr	r1, [sp, #24]
@   0x08028d76: 0608        lsls	r0, r1, #24
@   0x08028d78: 1600        asrs	r0, r0, #24
@   0x08028d7a: 2803        cmp	r0, #3
@   0x08028d7c: dd00        ble.n	0x28d80
@   0x08028d7e: e1dc        b.n	0x2913a
@   0x08028d80: 464a        mov	r2, r9
@   0x08028d82: 0610        lsls	r0, r2, #24
@   0x08028d84: 1600        asrs	r0, r0, #24
@   0x08028d86: 2803        cmp	r0, #3
@   0x08028d88: dd00        ble.n	0x28d8c
@   0x08028d8a: e1d6        b.n	0x2913a
@   0x08028d8c: 4914        ldr	r1, [pc, #80]	@ (0x28de0)
@   0x08028d8e: 4815        ldr	r0, [pc, #84]	@ (0x28de4)
@   0x08028d90: 9000        str	r0, [sp, #0]
@   0x08028d92: 2006        movs	r0, #6
@   0x08028d94: 9001        str	r0, [sp, #4]
@   0x08028d96: 2502        movs	r5, #2
@   0x08028d98: 9502        str	r5, [sp, #8]
@   0x08028d9a: 2003        movs	r0, #3
@   0x08028d9c: 9003        str	r0, [sp, #12]
@   0x08028d9e: 205f        movs	r0, #95	@ 0x5f
@   0x08028da0: 2210        movs	r2, #16
@   0x08028da2: 2349        movs	r3, #73	@ 0x49
@   0x08028da4: f7f8        f97c 	bl	0x210a0
@   0x08028da8: 4c0f        ldr	r4, [pc, #60]	@ (0x28de8)
@   0x08028daa: 1c20        adds	r0, r4, #0
@   0x08028dac: 2105        movs	r1, #5
@   0x08028dae: 2207        movs	r2, #7
@   0x08028db0: f7dd        fc88 	bl	0x66c4
@   0x08028db4: 2065        movs	r0, #101	@ 0x65
@   0x08028db6: f7f7        ff5f 	bl	0x20c78
@   0x08028dba: 490c        ldr	r1, [pc, #48]	@ (0x28dec)
@   0x08028dbc: 4b0c        ldr	r3, [pc, #48]	@ (0x28df0)
@   0x08028dbe: 18c8        adds	r0, r1, r3
@   0x08028dc0: 7005        strb	r5, [r0, #0]
@   0x08028dc2: 4d0c        ldr	r5, [pc, #48]	@ (0x28df4)
@   0x08028dc4: 194a        adds	r2, r1, r5
@   0x08028dc6: 2002        movs	r0, #2
@   0x08028dc8: 8813        ldrh	r3, [r2, #0]
@   0x08028dca: 4318        orrs	r0, r3
@   0x08028dcc: 8010        strh	r0, [r2, #0]
@   0x08028dce: 3d0a        subs	r5, #10
@   0x08028dd0: 1949        adds	r1, r1, r5
@   0x08028dd2: 2014        movs	r0, #20
@   0x08028dd4: 7008        strb	r0, [r1, #0]
@   0x08028dd6: 1c20        adds	r0, r4, #0
@   0x08028dd8: 2103        movs	r1, #3
@   0x08028dda: 2206        movs	r2, #6
@   0x08028ddc: e094        b.n	0x28f08
@   0x08028dde: 0000        movs	r0, r0
@   0x08028de0: 6f24        ldr	r4, [r4, #112]	@ 0x70
@   0x08028de2: 0831        lsrs	r1, r6, #32
@   0x08028de4: 02f5        lsls	r5, r6, #11
@   0x08028de6: 0000        movs	r0, r0
@   0x08028de8: 6110        str	r0, [r2, #16]
@   0x08028dea: 0300        lsls	r0, r0, #12
@   0x08028dec: 3720        adds	r7, #32
@   0x08028dee: 0300        lsls	r0, r0, #12
@   0x08028df0: 13ca        asrs	r2, r1, #15
@   0x08028df2: 0000        movs	r0, r0
@   0x08028df4: 13e4        asrs	r4, r4, #15
@   0x08028df6: 0000        movs	r0, r0
@   0x08028df8: 4d23        ldr	r5, [pc, #140]	@ (0x28e88)
@   0x08028dfa: 1c28        adds	r0, r5, #0
@   0x08028dfc: 2103        movs	r1, #3
@   0x08028dfe: 2205        movs	r2, #5
@   0x08028e00: f7dd        fccc 	bl	0x679c
@   0x08028e04: 0600        lsls	r0, r0, #24
@   0x08028e06: 2800        cmp	r0, #0
@   0x08028e08: d000        beq.n	0x28e0c
@   0x08028e0a: e09d        b.n	0x28f48
@   0x08028e0c: 1c28        adds	r0, r5, #0
@   0x08028e0e: 2103        movs	r1, #3
@   0x08028e10: 2206        movs	r2, #6
@   0x08028e12: f7dd        fcc3 	bl	0x679c
@   0x08028e16: 0600        lsls	r0, r0, #24
@   0x08028e18: 2800        cmp	r0, #0
@   0x08028e1a: d100        bne.n	0x28e1e
@   0x08028e1c: e094        b.n	0x28f48
@   0x08028e1e: 9905        ldr	r1, [sp, #20]
@   0x08028e20: 0608        lsls	r0, r1, #24
@   0x08028e22: 1600        asrs	r0, r0, #24
@   0x08028e24: 2803        cmp	r0, #3
@   0x08028e26: dc3b        bgt.n	0x28ea0
@   0x08028e28: 4642        mov	r2, r8
@   0x08028e2a: 0610        lsls	r0, r2, #24
@   0x08028e2c: 1600        asrs	r0, r0, #24
@   0x08028e2e: 2803        cmp	r0, #3
@   0x08028e30: dc36        bgt.n	0x28ea0
@   0x08028e32: 4916        ldr	r1, [pc, #88]	@ (0x28e8c)
@   0x08028e34: 4816        ldr	r0, [pc, #88]	@ (0x28e90)
@   0x08028e36: 9000        str	r0, [sp, #0]
@   0x08028e38: 2006        movs	r0, #6
@   0x08028e3a: 9001        str	r0, [sp, #4]
@   0x08028e3c: 2402        movs	r4, #2
@   0x08028e3e: 9402        str	r4, [sp, #8]
@   0x08028e40: 2003        movs	r0, #3
@   0x08028e42: 9003        str	r0, [sp, #12]
@   0x08028e44: 2060        movs	r0, #96	@ 0x60
@   0x08028e46: 2210        movs	r2, #16
@   0x08028e48: 2349        movs	r3, #73	@ 0x49
@   0x08028e4a: f7f8        f929 	bl	0x210a0
@   0x08028e4e: 1c28        adds	r0, r5, #0
@   0x08028e50: 2105        movs	r1, #5
@   0x08028e52: 2206        movs	r2, #6
@   0x08028e54: f7dd        fc36 	bl	0x66c4
@   0x08028e58: 2065        movs	r0, #101	@ 0x65
@   0x08028e5a: f7f7        ff0d 	bl	0x20c78
@   0x08028e5e: 490d        ldr	r1, [pc, #52]	@ (0x28e94)
@   0x08028e60: 4b0d        ldr	r3, [pc, #52]	@ (0x28e98)
@   0x08028e62: 18c8        adds	r0, r1, r3
@   0x08028e64: 7004        strb	r4, [r0, #0]
@   0x08028e66: 4c0d        ldr	r4, [pc, #52]	@ (0x28e9c)
@   0x08028e68: 190a        adds	r2, r1, r4
@   0x08028e6a: 2002        movs	r0, #2
@   0x08028e6c: 8813        ldrh	r3, [r2, #0]
@   0x08028e6e: 4318        orrs	r0, r3
@   0x08028e70: 8010        strh	r0, [r2, #0]
@   0x08028e72: 3c0a        subs	r4, #10
@   0x08028e74: 1909        adds	r1, r1, r4
@   0x08028e76: 2014        movs	r0, #20
@   0x08028e78: 7008        strb	r0, [r1, #0]
@   0x08028e7a: 1c28        adds	r0, r5, #0
@   0x08028e7c: 2103        movs	r1, #3
@   0x08028e7e: 2205        movs	r2, #5
@   0x08028e80: f7dd        fbbe 	bl	0x6600
@   0x08028e84: 1c28        adds	r0, r5, #0
@   0x08028e86: e042        b.n	0x28f0e
@   0x08028e88: 6110        str	r0, [r2, #16]
@   0x08028e8a: 0300        lsls	r0, r0, #12
@   0x08028e8c: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x08028e8e: 0831        lsrs	r1, r6, #32
@   0x08028e90: 02f5        lsls	r5, r6, #11
@   0x08028e92: 0000        movs	r0, r0
@   0x08028e94: 3720        adds	r7, #32
@   0x08028e96: 0300        lsls	r0, r0, #12
@   0x08028e98: 13ca        asrs	r2, r1, #15
@   0x08028e9a: 0000        movs	r0, r0
@   0x08028e9c: 13e4        asrs	r4, r4, #15
@   0x08028e9e: 0000        movs	r0, r0
@   0x08028ea0: 9d04        ldr	r5, [sp, #16]
@   0x08028ea2: 0628        lsls	r0, r5, #24
@   0x08028ea4: 1600        asrs	r0, r0, #24
@   0x08028ea6: 2803        cmp	r0, #3
@   0x08028ea8: dd00        ble.n	0x28eac
@   0x08028eaa: e146        b.n	0x2913a
@   0x08028eac: 4651        mov	r1, sl
@   0x08028eae: 0608        lsls	r0, r1, #24
@   0x08028eb0: 1600        asrs	r0, r0, #24
@   0x08028eb2: 2803        cmp	r0, #3
@   0x08028eb4: dd00        ble.n	0x28eb8
@   0x08028eb6: e140        b.n	0x2913a
@   0x08028eb8: 491b        ldr	r1, [pc, #108]	@ (0x28f28)
@   0x08028eba: 481c        ldr	r0, [pc, #112]	@ (0x28f2c)
@   0x08028ebc: 9000        str	r0, [sp, #0]
@   0x08028ebe: 2006        movs	r0, #6
@   0x08028ec0: 9001        str	r0, [sp, #4]
@   0x08028ec2: 2502        movs	r5, #2
@   0x08028ec4: 9502        str	r5, [sp, #8]
@   0x08028ec6: 2003        movs	r0, #3
@   0x08028ec8: 9003        str	r0, [sp, #12]
@   0x08028eca: 205f        movs	r0, #95	@ 0x5f
@   0x08028ecc: 2210        movs	r2, #16
@   0x08028ece: 2349        movs	r3, #73	@ 0x49
@   0x08028ed0: f7f8        f8e6 	bl	0x210a0
@   0x08028ed4: 4c16        ldr	r4, [pc, #88]	@ (0x28f30)
@   0x08028ed6: 1c20        adds	r0, r4, #0
@   0x08028ed8: 2105        movs	r1, #5
@   0x08028eda: 2207        movs	r2, #7
@   0x08028edc: f7dd        fbf2 	bl	0x66c4
@   0x08028ee0: 2065        movs	r0, #101	@ 0x65
@   0x08028ee2: f7f7        fec9 	bl	0x20c78
@   0x08028ee6: 4913        ldr	r1, [pc, #76]	@ (0x28f34)
@   0x08028ee8: 4a13        ldr	r2, [pc, #76]	@ (0x28f38)
@   0x08028eea: 1888        adds	r0, r1, r2
@   0x08028eec: 7005        strb	r5, [r0, #0]
@   0x08028eee: 4b13        ldr	r3, [pc, #76]	@ (0x28f3c)
@   0x08028ef0: 18ca        adds	r2, r1, r3
@   0x08028ef2: 2002        movs	r0, #2
@   0x08028ef4: 8815        ldrh	r5, [r2, #0]
@   0x08028ef6: 4328        orrs	r0, r5
@   0x08028ef8: 8010        strh	r0, [r2, #0]
@   0x08028efa: 4811        ldr	r0, [pc, #68]	@ (0x28f40)
@   0x08028efc: 1809        adds	r1, r1, r0
@   0x08028efe: 2014        movs	r0, #20
@   0x08028f00: 7008        strb	r0, [r1, #0]
@   0x08028f02: 1c20        adds	r0, r4, #0
@   0x08028f04: 2103        movs	r1, #3
@   0x08028f06: 2205        movs	r2, #5
@   0x08028f08: f7dd        fb7a 	bl	0x6600
@   0x08028f0c: 1c20        adds	r0, r4, #0
@   0x08028f0e: 2108        movs	r1, #8
@   0x08028f10: 2200        movs	r2, #0
@   0x08028f12: f7dd        fb75 	bl	0x6600
@   0x08028f16: 480b        ldr	r0, [pc, #44]	@ (0x28f44)
@   0x08028f18: 7e01        ldrb	r1, [r0, #24]
@   0x08028f1a: 200c        movs	r0, #12
@   0x08028f1c: 2200        movs	r2, #0
@   0x08028f1e: 2301        movs	r3, #1
@   0x08028f20: f7e1        fc8c 	bl	0xa83c
@   0x08028f24: e109        b.n	0x2913a
@   0x08028f26: 0000        movs	r0, r0
@   0x08028f28: 6f24        ldr	r4, [r4, #112]	@ 0x70
@   0x08028f2a: 0831        lsrs	r1, r6, #32
@   0x08028f2c: 02f5        lsls	r5, r6, #11
@   0x08028f2e: 0000        movs	r0, r0
@   0x08028f30: 6110        str	r0, [r2, #16]
@   0x08028f32: 0300        lsls	r0, r0, #12
@   0x08028f34: 3720        adds	r7, #32
@   0x08028f36: 0300        lsls	r0, r0, #12
@   0x08028f38: 13ca        asrs	r2, r1, #15
@   0x08028f3a: 0000        movs	r0, r0
@   0x08028f3c: 13e4        asrs	r4, r4, #15
@   0x08028f3e: 0000        movs	r0, r0
@   0x08028f40: 13da        asrs	r2, r3, #15
@   0x08028f42: 0000        movs	r0, r0
@   0x08028f44: 35e0        adds	r5, #224	@ 0xe0
@   0x08028f46: 0300        lsls	r0, r0, #12
@   0x08028f48: 4d1f        ldr	r5, [pc, #124]	@ (0x28fc8)
@   0x08028f4a: 1c28        adds	r0, r5, #0
@   0x08028f4c: 2103        movs	r1, #3
@   0x08028f4e: 2205        movs	r2, #5
@   0x08028f50: f7dd        fc24 	bl	0x679c
@   0x08028f54: 0600        lsls	r0, r0, #24
@   0x08028f56: 2800        cmp	r0, #0
@   0x08028f58: d000        beq.n	0x28f5c
@   0x08028f5a: e0ee        b.n	0x2913a
@   0x08028f5c: 1c28        adds	r0, r5, #0
@   0x08028f5e: 2103        movs	r1, #3
@   0x08028f60: 2206        movs	r2, #6
@   0x08028f62: f7dd        fc1b 	bl	0x679c
@   0x08028f66: 0600        lsls	r0, r0, #24
@   0x08028f68: 2800        cmp	r0, #0
@   0x08028f6a: d000        beq.n	0x28f6e
@   0x08028f6c: e0e5        b.n	0x2913a
@   0x08028f6e: 9905        ldr	r1, [sp, #20]
@   0x08028f70: 0608        lsls	r0, r1, #24
@   0x08028f72: 1600        asrs	r0, r0, #24
@   0x08028f74: 2803        cmp	r0, #3
@   0x08028f76: dc33        bgt.n	0x28fe0
@   0x08028f78: 4642        mov	r2, r8
@   0x08028f7a: 0610        lsls	r0, r2, #24
@   0x08028f7c: 1600        asrs	r0, r0, #24
@   0x08028f7e: 2803        cmp	r0, #3
@   0x08028f80: dc2e        bgt.n	0x28fe0
@   0x08028f82: 4912        ldr	r1, [pc, #72]	@ (0x28fcc)
@   0x08028f84: 4812        ldr	r0, [pc, #72]	@ (0x28fd0)
@   0x08028f86: 9000        str	r0, [sp, #0]
@   0x08028f88: 2006        movs	r0, #6
@   0x08028f8a: 9001        str	r0, [sp, #4]
@   0x08028f8c: 2002        movs	r0, #2
@   0x08028f8e: 9002        str	r0, [sp, #8]
@   0x08028f90: 2403        movs	r4, #3
@   0x08028f92: 9403        str	r4, [sp, #12]
@   0x08028f94: 2060        movs	r0, #96	@ 0x60
@   0x08028f96: 2210        movs	r2, #16
@   0x08028f98: 2349        movs	r3, #73	@ 0x49
@   0x08028f9a: f7f8        f881 	bl	0x210a0
@   0x08028f9e: 1c28        adds	r0, r5, #0
@   0x08028fa0: 2105        movs	r1, #5
@   0x08028fa2: 2206        movs	r2, #6
@   0x08028fa4: f7dd        fb8e 	bl	0x66c4
@   0x08028fa8: 2065        movs	r0, #101	@ 0x65
@   0x08028faa: f7f7        fe65 	bl	0x20c78
@   0x08028fae: 4809        ldr	r0, [pc, #36]	@ (0x28fd4)
@   0x08028fb0: 4b09        ldr	r3, [pc, #36]	@ (0x28fd8)
@   0x08028fb2: 18c1        adds	r1, r0, r3
@   0x08028fb4: 700c        strb	r4, [r1, #0]
@   0x08028fb6: 4c09        ldr	r4, [pc, #36]	@ (0x28fdc)
@   0x08028fb8: 1900        adds	r0, r0, r4
@   0x08028fba: 2102        movs	r1, #2
@   0x08028fbc: 8802        ldrh	r2, [r0, #0]
@   0x08028fbe: 4311        orrs	r1, r2
@   0x08028fc0: 8001        strh	r1, [r0, #0]
@   0x08028fc2: 1c28        adds	r0, r5, #0
@   0x08028fc4: e038        b.n	0x29038
@   0x08028fc6: 0000        movs	r0, r0
@   0x08028fc8: 6110        str	r0, [r2, #16]
@   0x08028fca: 0300        lsls	r0, r0, #12
@   0x08028fcc: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x08028fce: 0831        lsrs	r1, r6, #32
@   0x08028fd0: 02f5        lsls	r5, r6, #11
@   0x08028fd2: 0000        movs	r0, r0
@   0x08028fd4: 3720        adds	r7, #32
@   0x08028fd6: 0300        lsls	r0, r0, #12
@   0x08028fd8: 13ca        asrs	r2, r1, #15
@   0x08028fda: 0000        movs	r0, r0
@   0x08028fdc: 13e4        asrs	r4, r4, #15
@   0x08028fde: 0000        movs	r0, r0
@   0x08028fe0: 9b04        ldr	r3, [sp, #16]
@   0x08028fe2: 0618        lsls	r0, r3, #24
@   0x08028fe4: 1600        asrs	r0, r0, #24
@   0x08028fe6: 2803        cmp	r0, #3
@   0x08028fe8: dc38        bgt.n	0x2905c
@   0x08028fea: 4655        mov	r5, sl
@   0x08028fec: 0628        lsls	r0, r5, #24
@   0x08028fee: 1600        asrs	r0, r0, #24
@   0x08028ff0: 2803        cmp	r0, #3
@   0x08028ff2: dc33        bgt.n	0x2905c
@   0x08028ff4: 4913        ldr	r1, [pc, #76]	@ (0x29044)
@   0x08028ff6: 4814        ldr	r0, [pc, #80]	@ (0x29048)
@   0x08028ff8: 9000        str	r0, [sp, #0]
@   0x08028ffa: 2006        movs	r0, #6
@   0x08028ffc: 9001        str	r0, [sp, #4]
@   0x08028ffe: 2002        movs	r0, #2
@   0x08029000: 9002        str	r0, [sp, #8]
@   0x08029002: 2503        movs	r5, #3
@   0x08029004: 9503        str	r5, [sp, #12]
@   0x08029006: 205f        movs	r0, #95	@ 0x5f
@   0x08029008: 2210        movs	r2, #16
@   0x0802900a: 2349        movs	r3, #73	@ 0x49
@   0x0802900c: f7f8        f848 	bl	0x210a0
@   0x08029010: 4c0e        ldr	r4, [pc, #56]	@ (0x2904c)
@   0x08029012: 1c20        adds	r0, r4, #0
@   0x08029014: 2105        movs	r1, #5
@   0x08029016: 2207        movs	r2, #7
@   0x08029018: f7dd        fb54 	bl	0x66c4
@   0x0802901c: 2065        movs	r0, #101	@ 0x65
@   0x0802901e: f7f7        fe2b 	bl	0x20c78
@   0x08029022: 480b        ldr	r0, [pc, #44]	@ (0x29050)
@   0x08029024: 4a0b        ldr	r2, [pc, #44]	@ (0x29054)
@   0x08029026: 1881        adds	r1, r0, r2
@   0x08029028: 700d        strb	r5, [r1, #0]
@   0x0802902a: 4b0b        ldr	r3, [pc, #44]	@ (0x29058)
@   0x0802902c: 18c0        adds	r0, r0, r3
@   0x0802902e: 2102        movs	r1, #2
@   0x08029030: 8805        ldrh	r5, [r0, #0]
@   0x08029032: 4329        orrs	r1, r5
@   0x08029034: 8001        strh	r1, [r0, #0]
@   0x08029036: 1c20        adds	r0, r4, #0
@   0x08029038: 2103        movs	r1, #3
@   0x0802903a: 2205        movs	r2, #5
@   0x0802903c: f7dd        fae0 	bl	0x6600
@   0x08029040: e07b        b.n	0x2913a
@   0x08029042: 0000        movs	r0, r0
@   0x08029044: 6f24        ldr	r4, [r4, #112]	@ 0x70
@   0x08029046: 0831        lsrs	r1, r6, #32
@   0x08029048: 02f5        lsls	r5, r6, #11
@   0x0802904a: 0000        movs	r0, r0
@   0x0802904c: 6110        str	r0, [r2, #16]
@   0x0802904e: 0300        lsls	r0, r0, #12
@   0x08029050: 3720        adds	r7, #32
@   0x08029052: 0300        lsls	r0, r0, #12
@   0x08029054: 13ca        asrs	r2, r1, #15
@   0x08029056: 0000        movs	r0, r0
@   0x08029058: 13e4        asrs	r4, r4, #15
@   0x0802905a: 0000        movs	r0, r0
@   0x0802905c: 9907        ldr	r1, [sp, #28]
@   0x0802905e: 0608        lsls	r0, r1, #24
@   0x08029060: 1600        asrs	r0, r0, #24
@   0x08029062: 2803        cmp	r0, #3
@   0x08029064: dc38        bgt.n	0x290d8
@   0x08029066: 0620        lsls	r0, r4, #24
@   0x08029068: 1600        asrs	r0, r0, #24
@   0x0802906a: 2803        cmp	r0, #3
@   0x0802906c: dc34        bgt.n	0x290d8
@   0x0802906e: 4914        ldr	r1, [pc, #80]	@ (0x290c0)
@   0x08029070: 4814        ldr	r0, [pc, #80]	@ (0x290c4)
@   0x08029072: 9000        str	r0, [sp, #0]
@   0x08029074: 2006        movs	r0, #6
@   0x08029076: 9001        str	r0, [sp, #4]
@   0x08029078: 2002        movs	r0, #2
@   0x0802907a: 9002        str	r0, [sp, #8]
@   0x0802907c: 2003        movs	r0, #3
@   0x0802907e: 9003        str	r0, [sp, #12]
@   0x08029080: 2060        movs	r0, #96	@ 0x60
@   0x08029082: 2210        movs	r2, #16
@   0x08029084: 2349        movs	r3, #73	@ 0x49
@   0x08029086: f7f8        f80b 	bl	0x210a0
@   0x0802908a: 4c0f        ldr	r4, [pc, #60]	@ (0x290c8)
@   0x0802908c: 1c20        adds	r0, r4, #0
@   0x0802908e: 2105        movs	r1, #5
@   0x08029090: 2206        movs	r2, #6
@   0x08029092: f7dd        fb17 	bl	0x66c4
@   0x08029096: 2065        movs	r0, #101	@ 0x65
@   0x08029098: f7f7        fdee 	bl	0x20c78
@   0x0802909c: 490b        ldr	r1, [pc, #44]	@ (0x290cc)
@   0x0802909e: 4b0c        ldr	r3, [pc, #48]	@ (0x290d0)
@   0x080290a0: 18ca        adds	r2, r1, r3
@   0x080290a2: 2001        movs	r0, #1
@   0x080290a4: 7010        strb	r0, [r2, #0]
@   0x080290a6: 4d0b        ldr	r5, [pc, #44]	@ (0x290d4)
@   0x080290a8: 1949        adds	r1, r1, r5
@   0x080290aa: 2002        movs	r0, #2
@   0x080290ac: 880a        ldrh	r2, [r1, #0]
@   0x080290ae: 4310        orrs	r0, r2
@   0x080290b0: 8008        strh	r0, [r1, #0]
@   0x080290b2: 1c20        adds	r0, r4, #0
@   0x080290b4: 2103        movs	r1, #3
@   0x080290b6: 2206        movs	r2, #6
@   0x080290b8: f7dd        faa2 	bl	0x6600
@   0x080290bc: e03d        b.n	0x2913a
@   0x080290be: 0000        movs	r0, r0
@   0x080290c0: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x080290c2: 0831        lsrs	r1, r6, #32
@   0x080290c4: 02f5        lsls	r5, r6, #11
@   0x080290c6: 0000        movs	r0, r0
@   0x080290c8: 6110        str	r0, [r2, #16]
@   0x080290ca: 0300        lsls	r0, r0, #12
@   0x080290cc: 3720        adds	r7, #32
@   0x080290ce: 0300        lsls	r0, r0, #12
@   0x080290d0: 13ca        asrs	r2, r1, #15
@   0x080290d2: 0000        movs	r0, r0
@   0x080290d4: 13e4        asrs	r4, r4, #15
@   0x080290d6: 0000        movs	r0, r0
@   0x080290d8: 9b06        ldr	r3, [sp, #24]
@   0x080290da: 0618        lsls	r0, r3, #24
@   0x080290dc: 1600        asrs	r0, r0, #24
@   0x080290de: 2803        cmp	r0, #3
@   0x080290e0: dc2b        bgt.n	0x2913a
@   0x080290e2: 464c        mov	r4, r9
@   0x080290e4: 0620        lsls	r0, r4, #24
@   0x080290e6: 1600        asrs	r0, r0, #24
@   0x080290e8: 2803        cmp	r0, #3
@   0x080290ea: dc26        bgt.n	0x2913a
@   0x080290ec: 4938        ldr	r1, [pc, #224]	@ (0x291d0)
@   0x080290ee: 4839        ldr	r0, [pc, #228]	@ (0x291d4)
@   0x080290f0: 9000        str	r0, [sp, #0]
@   0x080290f2: 2006        movs	r0, #6
@   0x080290f4: 9001        str	r0, [sp, #4]
@   0x080290f6: 2002        movs	r0, #2
@   0x080290f8: 9002        str	r0, [sp, #8]
@   0x080290fa: 2003        movs	r0, #3
@   0x080290fc: 9003        str	r0, [sp, #12]
@   0x080290fe: 205f        movs	r0, #95	@ 0x5f
@   0x08029100: 2210        movs	r2, #16
@   0x08029102: 2349        movs	r3, #73	@ 0x49
@   0x08029104: f7f7        ffcc 	bl	0x210a0
@   0x08029108: 4c33        ldr	r4, [pc, #204]	@ (0x291d8)
@   0x0802910a: 1c20        adds	r0, r4, #0
@   0x0802910c: 2105        movs	r1, #5
@   0x0802910e: 2207        movs	r2, #7
@   0x08029110: f7dd        fad8 	bl	0x66c4
@   0x08029114: 2065        movs	r0, #101	@ 0x65
@   0x08029116: f7f7        fdaf 	bl	0x20c78
@   0x0802911a: 4930        ldr	r1, [pc, #192]	@ (0x291dc)
@   0x0802911c: 4d30        ldr	r5, [pc, #192]	@ (0x291e0)
@   0x0802911e: 194a        adds	r2, r1, r5
@   0x08029120: 2001        movs	r0, #1
@   0x08029122: 7010        strb	r0, [r2, #0]
@   0x08029124: 482f        ldr	r0, [pc, #188]	@ (0x291e4)
@   0x08029126: 1809        adds	r1, r1, r0
@   0x08029128: 2002        movs	r0, #2
@   0x0802912a: 880a        ldrh	r2, [r1, #0]
@   0x0802912c: 4310        orrs	r0, r2
@   0x0802912e: 8008        strh	r0, [r1, #0]
@   0x08029130: 1c20        adds	r0, r4, #0
@   0x08029132: 2103        movs	r1, #3
@   0x08029134: 2206        movs	r2, #6
@   0x08029136: f7dd        fa63 	bl	0x6600
@   0x0802913a: 4d27        ldr	r5, [pc, #156]	@ (0x291d8)
@   0x0802913c: 1c28        adds	r0, r5, #0
@   0x0802913e: 2108        movs	r1, #8
@   0x08029140: 2200        movs	r2, #0
@   0x08029142: f7dd        fb2b 	bl	0x679c
@   0x08029146: 0600        lsls	r0, r0, #24
@   0x08029148: 2800        cmp	r0, #0
@   0x0802914a: d000        beq.n	0x2914e
@   0x0802914c: e0ae        b.n	0x292ac
@   0x0802914e: 1c28        adds	r0, r5, #0
@   0x08029150: 2105        movs	r1, #5
@   0x08029152: 2207        movs	r2, #7
@   0x08029154: f7dd        fb22 	bl	0x679c
@   0x08029158: 0600        lsls	r0, r0, #24
@   0x0802915a: 2800        cmp	r0, #0
@   0x0802915c: d04a        beq.n	0x291f4
@   0x0802915e: 4f1c        ldr	r7, [pc, #112]	@ (0x291d0)
@   0x08029160: 1c38        adds	r0, r7, #0
@   0x08029162: 215f        movs	r1, #95	@ 0x5f
@   0x08029164: f7f8        fc2a 	bl	0x219bc
@   0x08029168: 4e1c        ldr	r6, [pc, #112]	@ (0x291dc)
@   0x0802916a: 4b1f        ldr	r3, [pc, #124]	@ (0x291e8)
@   0x0802916c: 18f4        adds	r4, r6, r3
@   0x0802916e: 8821        ldrh	r1, [r4, #0]
@   0x08029170: 2280        movs	r2, #128	@ 0x80
@   0x08029172: 0192        lsls	r2, r2, #6
@   0x08029174: 1c10        adds	r0, r2, #0
@   0x08029176: 4008        ands	r0, r1
@   0x08029178: 2800        cmp	r0, #0
@   0x0802917a: d105        bne.n	0x29188
@   0x0802917c: 1c10        adds	r0, r2, #0
@   0x0802917e: 4308        orrs	r0, r1
@   0x08029180: 8020        strh	r0, [r4, #0]
@   0x08029182: 2058        movs	r0, #88	@ 0x58
@   0x08029184: f7f7        fd78 	bl	0x20c78
@   0x08029188: 4918        ldr	r1, [pc, #96]	@ (0x291ec)
@   0x0802918a: 1870        adds	r0, r6, r1
@   0x0802918c: 2200        movs	r2, #0
@   0x0802918e: 5e81        ldrsh	r1, [r0, r2]
@   0x08029190: 20cc        movs	r0, #204	@ 0xcc
@   0x08029192: 0040        lsls	r0, r0, #1
@   0x08029194: 4281        cmp	r1, r0
@   0x08029196: dd16        ble.n	0x291c6
@   0x08029198: 1c28        adds	r0, r5, #0
@   0x0802919a: 2105        movs	r1, #5
@   0x0802919c: 2207        movs	r2, #7
@   0x0802919e: f7dd        fa91 	bl	0x66c4
@   0x080291a2: 480c        ldr	r0, [pc, #48]	@ (0x291d4)
@   0x080291a4: 9000        str	r0, [sp, #0]
@   0x080291a6: 2006        movs	r0, #6
@   0x080291a8: 9001        str	r0, [sp, #4]
@   0x080291aa: 2002        movs	r0, #2
@   0x080291ac: 9002        str	r0, [sp, #8]
@   0x080291ae: 2003        movs	r0, #3
@   0x080291b0: 9003        str	r0, [sp, #12]
@   0x080291b2: 205f        movs	r0, #95	@ 0x5f
@   0x080291b4: 1c39        adds	r1, r7, #0
@   0x080291b6: 2210        movs	r2, #16
@   0x080291b8: 2349        movs	r3, #73	@ 0x49
@   0x080291ba: f7f7        ff71 	bl	0x210a0
@   0x080291be: 480c        ldr	r0, [pc, #48]	@ (0x291f0)
@   0x080291c0: 8823        ldrh	r3, [r4, #0]
@   0x080291c2: 4018        ands	r0, r3
@   0x080291c4: 8020        strh	r0, [r4, #0]
@   0x080291c6: 1c38        adds	r0, r7, #0
@   0x080291c8: 215f        movs	r1, #95	@ 0x5f
@   0x080291ca: f7f8        fe8f 	bl	0x21eec
@   0x080291ce: e014        b.n	0x291fa
@   0x080291d0: 6f24        ldr	r4, [r4, #112]	@ 0x70
@   0x080291d2: 0831        lsrs	r1, r6, #32
@   0x080291d4: 02f5        lsls	r5, r6, #11
@   0x080291d6: 0000        movs	r0, r0
@   0x080291d8: 6110        str	r0, [r2, #16]
@   0x080291da: 0300        lsls	r0, r0, #12
@   0x080291dc: 3720        adds	r7, #32
@   0x080291de: 0300        lsls	r0, r0, #12
@   0x080291e0: 13ca        asrs	r2, r1, #15
@   0x080291e2: 0000        movs	r0, r0
@   0x080291e4: 13e4        asrs	r4, r4, #15
@   0x080291e6: 0000        movs	r0, r0
@   0x080291e8: 14fc        asrs	r4, r7, #19
@   0x080291ea: 0000        movs	r0, r0
@   0x080291ec: 14ca        asrs	r2, r1, #19
@   0x080291ee: 0000        movs	r0, r0
@   0x080291f0: dfff        svc	255	@ 0xff
@   0x080291f2: 0000        movs	r0, r0
@   0x080291f4: 4822        ldr	r0, [pc, #136]	@ (0x29280)
@   0x080291f6: f7dc        fbe5 	bl	0x59c4
@   0x080291fa: 4f22        ldr	r7, [pc, #136]	@ (0x29284)
@   0x080291fc: 1c38        adds	r0, r7, #0
@   0x080291fe: 2105        movs	r1, #5
@   0x08029200: 2206        movs	r2, #6
@   0x08029202: f7dd        facb 	bl	0x679c
@   0x08029206: 0600        lsls	r0, r0, #24
@   0x08029208: 2800        cmp	r0, #0
@   0x0802920a: d049        beq.n	0x292a0
@   0x0802920c: 4e1e        ldr	r6, [pc, #120]	@ (0x29288)
@   0x0802920e: 1c30        adds	r0, r6, #0
@   0x08029210: 2160        movs	r1, #96	@ 0x60
@   0x08029212: f7f8        fbd3 	bl	0x219bc
@   0x08029216: 4d1d        ldr	r5, [pc, #116]	@ (0x2928c)
@   0x08029218: 481d        ldr	r0, [pc, #116]	@ (0x29290)
@   0x0802921a: 182c        adds	r4, r5, r0
@   0x0802921c: 8821        ldrh	r1, [r4, #0]
@   0x0802921e: 2280        movs	r2, #128	@ 0x80
@   0x08029220: 0192        lsls	r2, r2, #6
@   0x08029222: 1c10        adds	r0, r2, #0
@   0x08029224: 4008        ands	r0, r1
@   0x08029226: 2800        cmp	r0, #0
@   0x08029228: d105        bne.n	0x29236
@   0x0802922a: 1c10        adds	r0, r2, #0
@   0x0802922c: 4308        orrs	r0, r1
@   0x0802922e: 8020        strh	r0, [r4, #0]
@   0x08029230: 2058        movs	r0, #88	@ 0x58
@   0x08029232: f7f7        fd21 	bl	0x20c78
@   0x08029236: 4917        ldr	r1, [pc, #92]	@ (0x29294)
@   0x08029238: 1868        adds	r0, r5, r1
@   0x0802923a: 2200        movs	r2, #0
@   0x0802923c: 5e81        ldrsh	r1, [r0, r2]
@   0x0802923e: 20cc        movs	r0, #204	@ 0xcc
@   0x08029240: 0040        lsls	r0, r0, #1
@   0x08029242: 4281        cmp	r1, r0
@   0x08029244: dd16        ble.n	0x29274
@   0x08029246: 1c38        adds	r0, r7, #0
@   0x08029248: 2105        movs	r1, #5
@   0x0802924a: 2206        movs	r2, #6
@   0x0802924c: f7dd        fa3a 	bl	0x66c4
@   0x08029250: 4811        ldr	r0, [pc, #68]	@ (0x29298)
@   0x08029252: 9000        str	r0, [sp, #0]
@   0x08029254: 2006        movs	r0, #6
@   0x08029256: 9001        str	r0, [sp, #4]
@   0x08029258: 2002        movs	r0, #2
@   0x0802925a: 9002        str	r0, [sp, #8]
@   0x0802925c: 2003        movs	r0, #3
@   0x0802925e: 9003        str	r0, [sp, #12]
@   0x08029260: 2060        movs	r0, #96	@ 0x60
@   0x08029262: 1c31        adds	r1, r6, #0
@   0x08029264: 2210        movs	r2, #16
@   0x08029266: 2349        movs	r3, #73	@ 0x49
@   0x08029268: f7f7        ff1a 	bl	0x210a0
@   0x0802926c: 480b        ldr	r0, [pc, #44]	@ (0x2929c)
@   0x0802926e: 8823        ldrh	r3, [r4, #0]
@   0x08029270: 4018        ands	r0, r3
@   0x08029272: 8020        strh	r0, [r4, #0]
@   0x08029274: 1c30        adds	r0, r6, #0
@   0x08029276: 2160        movs	r1, #96	@ 0x60
@   0x08029278: f7f8        fe38 	bl	0x21eec
@   0x0802927c: e022        b.n	0x292c4
@   0x0802927e: 0000        movs	r0, r0
@   0x08029280: 4be8        ldr	r3, [pc, #928]	@ (0x29624)
@   0x08029282: 0300        lsls	r0, r0, #12
@   0x08029284: 6110        str	r0, [r2, #16]
@   0x08029286: 0300        lsls	r0, r0, #12
@   0x08029288: 6f44        ldr	r4, [r0, #116]	@ 0x74
@   0x0802928a: 0831        lsrs	r1, r6, #32
@   0x0802928c: 3720        adds	r7, #32
@   0x0802928e: 0300        lsls	r0, r0, #12
@   0x08029290: 1534        asrs	r4, r6, #20
@   0x08029292: 0000        movs	r0, r0
@   0x08029294: 1502        asrs	r2, r0, #20
@   0x08029296: 0000        movs	r0, r0
@   0x08029298: 02f5        lsls	r5, r6, #11
@   0x0802929a: 0000        movs	r0, r0
@   0x0802929c: dfff        svc	255	@ 0xff
@   0x0802929e: 0000        movs	r0, r0
@   0x080292a0: 4801        ldr	r0, [pc, #4]	@ (0x292a8)
@   0x080292a2: f7dc        fb8f 	bl	0x59c4
@   0x080292a6: e00d        b.n	0x292c4
@   0x080292a8: 4c20        ldr	r4, [pc, #128]	@ (0x2932c)
@   0x080292aa: 0300        lsls	r0, r0, #12
@   0x080292ac: 4909        ldr	r1, [pc, #36]	@ (0x292d4)
@   0x080292ae: 4c0a        ldr	r4, [pc, #40]	@ (0x292d8)
@   0x080292b0: 190a        adds	r2, r1, r4
@   0x080292b2: 2308        movs	r3, #8
@   0x080292b4: 8810        ldrh	r0, [r2, #0]
@   0x080292b6: 4318        orrs	r0, r3
@   0x080292b8: 8010        strh	r0, [r2, #0]
@   0x080292ba: 4d08        ldr	r5, [pc, #32]	@ (0x292dc)
@   0x080292bc: 1949        adds	r1, r1, r5
@   0x080292be: 8808        ldrh	r0, [r1, #0]
@   0x080292c0: 4318        orrs	r0, r3
@   0x080292c2: 8008        strh	r0, [r1, #0]
@   0x080292c4: b008        add	sp, #32
@   0x080292c6: bc38        pop	{r3, r4, r5}
@   0x080292c8: 4698        mov	r8, r3
@   0x080292ca: 46a1        mov	r9, r4
@   0x080292cc: 46aa        mov	sl, r5
@   0x080292ce: bcf0        pop	{r4, r5, r6, r7}
@   0x080292d0: bc01        pop	{r0}
@   0x080292d2: 4700        bx	r0
@   0x080292d4: 3720        adds	r7, #32
@   0x080292d6: 0300        lsls	r0, r0, #12
@   0x080292d8: 14fc        asrs	r4, r7, #19
@   0x080292da: 0000        movs	r0, r0
@   0x080292dc: 1534        asrs	r4, r6, #20

        thumb_func_start sub_08028B94
sub_08028B94: @ 0x08028b94
        .incbin "baserom.gba", 0x28b94, 0x74c
        thumb_func_end sub_08028B94
