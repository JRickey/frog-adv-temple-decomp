@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006bb4, 0x08006d24)  (368 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006bb4 --end 0x8006d24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006bb4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08006bb6: 4657        mov	r7, sl
@   0x08006bb8: 464e        mov	r6, r9
@   0x08006bba: 4645        mov	r5, r8
@   0x08006bbc: b4e0        push	{r5, r6, r7}
@   0x08006bbe: b085        sub	sp, #20
@   0x08006bc0: 1c0a        adds	r2, r1, #0
@   0x08006bc2: 0600        lsls	r0, r0, #24
@   0x08006bc4: 0e00        lsrs	r0, r0, #24
@   0x08006bc6: 4684        mov	ip, r0
@   0x08006bc8: 2000        movs	r0, #0
@   0x08006bca: 9004        str	r0, [sp, #16]
@   0x08006bcc: 491a        ldr	r1, [pc, #104]	@ (0x6c38)
@   0x08006bce: 4688        mov	r8, r1
@   0x08006bd0: 4663        mov	r3, ip
@   0x08006bd2: 0619        lsls	r1, r3, #24
@   0x08006bd4: 1548        asrs	r0, r1, #21
@   0x08006bd6: 4440        add	r0, r8
@   0x08006bd8: 7800        ldrb	r0, [r0, #0]
@   0x08006bda: 0600        lsls	r0, r0, #24
@   0x08006bdc: 1600        asrs	r0, r0, #24
@   0x08006bde: 9c04        ldr	r4, [sp, #16]
@   0x08006be0: 4284        cmp	r4, r0
@   0x08006be2: db00        blt.n	0x6be6
@   0x08006be4: e095        b.n	0x6d12
@   0x08006be6: 46c1        mov	r9, r8
@   0x08006be8: 2704        movs	r7, #4
@   0x08006bea: 4447        add	r7, r8
@   0x08006bec: 46ba        mov	sl, r7
@   0x08006bee: 466d        mov	r5, sp
@   0x08006bf0: 2600        movs	r6, #0
@   0x08006bf2: 1c13        adds	r3, r2, #0
@   0x08006bf4: 1548        asrs	r0, r1, #21
@   0x08006bf6: 4450        add	r0, sl
@   0x08006bf8: 6802        ldr	r2, [r0, #0]
@   0x08006bfa: 9904        ldr	r1, [sp, #16]
@   0x08006bfc: 0108        lsls	r0, r1, #4
@   0x08006bfe: 4669        mov	r1, sp
@   0x08006c00: 1880        adds	r0, r0, r2
@   0x08006c02: c894        ldmia	r0!, {r2, r4, r7}
@   0x08006c04: c194        stmia	r1!, {r2, r4, r7}
@   0x08006c06: 6800        ldr	r0, [r0, #0]
@   0x08006c08: 6008        str	r0, [r1, #0]
@   0x08006c0a: 8828        ldrh	r0, [r5, #0]
@   0x08006c0c: 8018        strh	r0, [r3, #0]
@   0x08006c0e: 8868        ldrh	r0, [r5, #2]
@   0x08006c10: 8058        strh	r0, [r3, #2]
@   0x08006c12: 2006        movs	r0, #6
@   0x08006c14: 5628        ldrsb	r0, [r5, r0]
@   0x08006c16: 2801        cmp	r0, #1
@   0x08006c18: dc10        bgt.n	0x6c3c
@   0x08006c1a: 2104        movs	r1, #4
@   0x08006c1c: 5669        ldrsb	r1, [r5, r1]
@   0x08006c1e: 0048        lsls	r0, r1, #1
@   0x08006c20: 1840        adds	r0, r0, r1
@   0x08006c22: 00c0        lsls	r0, r0, #3
@   0x08006c24: 380c        subs	r0, #12
@   0x08006c26: 8098        strh	r0, [r3, #4]
@   0x08006c28: 2105        movs	r1, #5
@   0x08006c2a: 5669        ldrsb	r1, [r5, r1]
@   0x08006c2c: 0048        lsls	r0, r1, #1
@   0x08006c2e: 1840        adds	r0, r0, r1
@   0x08006c30: 00c0        lsls	r0, r0, #3
@   0x08006c32: 300c        adds	r0, #12
@   0x08006c34: e00f        b.n	0x6c56
@   0x08006c36: 0000        movs	r0, r0
@   0x08006c38: 0ab0        lsrs	r0, r6, #10
@   0x08006c3a: 080c        lsrs	r4, r1, #32
@   0x08006c3c: 2104        movs	r1, #4
@   0x08006c3e: 5669        ldrsb	r1, [r5, r1]
@   0x08006c40: 0048        lsls	r0, r1, #1
@   0x08006c42: 1840        adds	r0, r0, r1
@   0x08006c44: 00c0        lsls	r0, r0, #3
@   0x08006c46: 300c        adds	r0, #12
@   0x08006c48: 8098        strh	r0, [r3, #4]
@   0x08006c4a: 2105        movs	r1, #5
@   0x08006c4c: 5669        ldrsb	r1, [r5, r1]
@   0x08006c4e: 0048        lsls	r0, r1, #1
@   0x08006c50: 1840        adds	r0, r0, r1
@   0x08006c52: 00c0        lsls	r0, r0, #3
@   0x08006c54: 380c        subs	r0, #12
@   0x08006c56: 80d8        strh	r0, [r3, #6]
@   0x08006c58: 7a28        ldrb	r0, [r5, #8]
@   0x08006c5a: 7498        strb	r0, [r3, #18]
@   0x08006c5c: 7a68        ldrb	r0, [r5, #9]
@   0x08006c5e: 7618        strb	r0, [r3, #24]
@   0x08006c60: 769e        strb	r6, [r3, #26]
@   0x08006c62: 7929        ldrb	r1, [r5, #4]
@   0x08006c64: 796a        ldrb	r2, [r5, #5]
@   0x08006c66: 1c08        adds	r0, r1, #0
@   0x08006c68: 4350        muls	r0, r2
@   0x08006c6a: 7718        strb	r0, [r3, #28]
@   0x08006c6c: 9803        ldr	r0, [sp, #12]
@   0x08006c6e: 6218        str	r0, [r3, #32]
@   0x08006c70: 4664        mov	r4, ip
@   0x08006c72: 0621        lsls	r1, r4, #24
@   0x08006c74: 1548        asrs	r0, r1, #21
@   0x08006c76: 464f        mov	r7, r9
@   0x08006c78: 19c4        adds	r4, r0, r7
@   0x08006c7a: 7860        ldrb	r0, [r4, #1]
@   0x08006c7c: 7218        strb	r0, [r3, #8]
@   0x08006c7e: 2206        movs	r2, #6
@   0x08006c80: 56aa        ldrsb	r2, [r5, r2]
@   0x08006c82: 2a01        cmp	r2, #1
@   0x08006c84: d016        beq.n	0x6cb4
@   0x08006c86: 2a01        cmp	r2, #1
@   0x08006c88: dc02        bgt.n	0x6c90
@   0x08006c8a: 2a00        cmp	r2, #0
@   0x08006c8c: d005        beq.n	0x6c9a
@   0x08006c8e: e034        b.n	0x6cfa
@   0x08006c90: 2a02        cmp	r2, #2
@   0x08006c92: d01b        beq.n	0x6ccc
@   0x08006c94: 2a03        cmp	r2, #3
@   0x08006c96: d025        beq.n	0x6ce4
@   0x08006c98: e02f        b.n	0x6cfa
@   0x08006c9a: 2000        movs	r0, #0
@   0x08006c9c: 5620        ldrsb	r0, [r4, r0]
@   0x08006c9e: 2801        cmp	r0, #1
@   0x08006ca0: dd01        ble.n	0x6ca6
@   0x08006ca2: 765a        strb	r2, [r3, #25]
@   0x08006ca4: e001        b.n	0x6caa
@   0x08006ca6: 2012        movs	r0, #18
@   0x08006ca8: 7658        strb	r0, [r3, #25]
@   0x08006caa: 741e        strb	r6, [r3, #16]
@   0x08006cac: 79ea        ldrb	r2, [r5, #7]
@   0x08006cae: 4250        negs	r0, r2
@   0x08006cb0: 7458        strb	r0, [r3, #17]
@   0x08006cb2: e022        b.n	0x6cfa
@   0x08006cb4: 2000        movs	r0, #0
@   0x08006cb6: 5620        ldrsb	r0, [r4, r0]
@   0x08006cb8: 2801        cmp	r0, #1
@   0x08006cba: dd01        ble.n	0x6cc0
@   0x08006cbc: 200c        movs	r0, #12
@   0x08006cbe: e000        b.n	0x6cc2
@   0x08006cc0: 2014        movs	r0, #20
@   0x08006cc2: 7658        strb	r0, [r3, #25]
@   0x08006cc4: 741e        strb	r6, [r3, #16]
@   0x08006cc6: 79e8        ldrb	r0, [r5, #7]
@   0x08006cc8: 7458        strb	r0, [r3, #17]
@   0x08006cca: e016        b.n	0x6cfa
@   0x08006ccc: 2000        movs	r0, #0
@   0x08006cce: 5620        ldrsb	r0, [r4, r0]
@   0x08006cd0: 2801        cmp	r0, #1
@   0x08006cd2: dd01        ble.n	0x6cd8
@   0x08006cd4: 2018        movs	r0, #24
@   0x08006cd6: e000        b.n	0x6cda
@   0x08006cd8: 2015        movs	r0, #21
@   0x08006cda: 7658        strb	r0, [r3, #25]
@   0x08006cdc: 745e        strb	r6, [r3, #17]
@   0x08006cde: 79ec        ldrb	r4, [r5, #7]
@   0x08006ce0: 4260        negs	r0, r4
@   0x08006ce2: e009        b.n	0x6cf8
@   0x08006ce4: 2000        movs	r0, #0
@   0x08006ce6: 5620        ldrsb	r0, [r4, r0]
@   0x08006ce8: 2801        cmp	r0, #1
@   0x08006cea: dd01        ble.n	0x6cf0
@   0x08006cec: 2024        movs	r0, #36	@ 0x24
@   0x08006cee: e000        b.n	0x6cf2
@   0x08006cf0: 2017        movs	r0, #23
@   0x08006cf2: 7658        strb	r0, [r3, #25]
@   0x08006cf4: 745e        strb	r6, [r3, #17]
@   0x08006cf6: 79e8        ldrb	r0, [r5, #7]
@   0x08006cf8: 7418        strb	r0, [r3, #16]
@   0x08006cfa: 3324        adds	r3, #36	@ 0x24
@   0x08006cfc: 9f04        ldr	r7, [sp, #16]
@   0x08006cfe: 3701        adds	r7, #1
@   0x08006d00: 9704        str	r7, [sp, #16]
@   0x08006d02: 1548        asrs	r0, r1, #21
@   0x08006d04: 4440        add	r0, r8
@   0x08006d06: 7800        ldrb	r0, [r0, #0]
@   0x08006d08: 0600        lsls	r0, r0, #24
@   0x08006d0a: 1600        asrs	r0, r0, #24
@   0x08006d0c: 4287        cmp	r7, r0
@   0x08006d0e: da00        bge.n	0x6d12
@   0x08006d10: e770        b.n	0x6bf4
@   0x08006d12: b005        add	sp, #20
@   0x08006d14: bc38        pop	{r3, r4, r5}
@   0x08006d16: 4698        mov	r8, r3
@   0x08006d18: 46a1        mov	r9, r4
@   0x08006d1a: 46aa        mov	sl, r5
@   0x08006d1c: bcf0        pop	{r4, r5, r6, r7}
@   0x08006d1e: bc01        pop	{r0}
@   0x08006d20: 4700        bx	r0

        thumb_func_start sub_08006BB4
sub_08006BB4: @ 0x08006bb4
        .incbin "frog_us_baserom.gba", 0x6bb4, 0x170
        thumb_func_end sub_08006BB4
