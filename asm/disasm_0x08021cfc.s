@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021cfc, 0x08021e34)  (312 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021cfc --end 0x8021e34 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021cfc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08021cfe: 4657        mov	r7, sl
@   0x08021d00: 464e        mov	r6, r9
@   0x08021d02: 4645        mov	r5, r8
@   0x08021d04: b4e0        push	{r5, r6, r7}
@   0x08021d06: b082        sub	sp, #8
@   0x08021d08: 9c0a        ldr	r4, [sp, #40]	@ 0x28
@   0x08021d0a: 9d0b        ldr	r5, [sp, #44]	@ 0x2c
@   0x08021d0c: 0600        lsls	r0, r0, #24
@   0x08021d0e: 0e00        lsrs	r0, r0, #24
@   0x08021d10: 4680        mov	r8, r0
@   0x08021d12: 0409        lsls	r1, r1, #16
@   0x08021d14: 0c09        lsrs	r1, r1, #16
@   0x08021d16: 9100        str	r1, [sp, #0]
@   0x08021d18: 0412        lsls	r2, r2, #16
@   0x08021d1a: 0c12        lsrs	r2, r2, #16
@   0x08021d1c: 9201        str	r2, [sp, #4]
@   0x08021d1e: 061b        lsls	r3, r3, #24
@   0x08021d20: 0e1b        lsrs	r3, r3, #24
@   0x08021d22: 0624        lsls	r4, r4, #24
@   0x08021d24: 0e24        lsrs	r4, r4, #24
@   0x08021d26: 1c26        adds	r6, r4, #0
@   0x08021d28: 062d        lsls	r5, r5, #24
@   0x08021d2a: 0e2d        lsrs	r5, r5, #24
@   0x08021d2c: 1c2a        adds	r2, r5, #0
@   0x08021d2e: 2c01        cmp	r4, #1
@   0x08021d30: d116        bne.n	0x21d60
@   0x08021d32: 4a0a        ldr	r2, [pc, #40]	@ (0x21d5c)
@   0x08021d34: 00c1        lsls	r1, r0, #3
@   0x08021d36: 1a08        subs	r0, r1, r0
@   0x08021d38: 00c0        lsls	r0, r0, #3
@   0x08021d3a: 1882        adds	r2, r0, r2
@   0x08021d3c: 4689        mov	r9, r1
@   0x08021d3e: 8a10        ldrh	r0, [r2, #16]
@   0x08021d40: 28ff        cmp	r0, #255	@ 0xff
@   0x08021d42: d101        bne.n	0x21d48
@   0x08021d44: 2000        movs	r0, #0
@   0x08021d46: 8210        strh	r0, [r2, #16]
@   0x08021d48: 8a11        ldrh	r1, [r2, #16]
@   0x08021d4a: 1948        adds	r0, r1, r5
@   0x08021d4c: 8210        strh	r0, [r2, #16]
@   0x08021d4e: 0400        lsls	r0, r0, #16
@   0x08021d50: 1400        asrs	r0, r0, #16
@   0x08021d52: 28ff        cmp	r0, #255	@ 0xff
@   0x08021d54: dd1b        ble.n	0x21d8e
@   0x08021d56: 20ff        movs	r0, #255	@ 0xff
@   0x08021d58: 8210        strh	r0, [r2, #16]
@   0x08021d5a: e018        b.n	0x21d8e
@   0x08021d5c: 3720        adds	r7, #32
@   0x08021d5e: 0300        lsls	r0, r0, #12
@   0x08021d60: 4645        mov	r5, r8
@   0x08021d62: 00ed        lsls	r5, r5, #3
@   0x08021d64: 46a9        mov	r9, r5
@   0x08021d66: 2c00        cmp	r4, #0
@   0x08021d68: d111        bne.n	0x21d8e
@   0x08021d6a: 482f        ldr	r0, [pc, #188]	@ (0x21e28)
@   0x08021d6c: 4644        mov	r4, r8
@   0x08021d6e: 1b29        subs	r1, r5, r4
@   0x08021d70: 00c9        lsls	r1, r1, #3
@   0x08021d72: 1809        adds	r1, r1, r0
@   0x08021d74: 2510        movs	r5, #16
@   0x08021d76: 5f48        ldrsh	r0, [r1, r5]
@   0x08021d78: 2800        cmp	r0, #0
@   0x08021d7a: d101        bne.n	0x21d80
@   0x08021d7c: 20ff        movs	r0, #255	@ 0xff
@   0x08021d7e: 8208        strh	r0, [r1, #16]
@   0x08021d80: 8a0c        ldrh	r4, [r1, #16]
@   0x08021d82: 1aa0        subs	r0, r4, r2
@   0x08021d84: 8208        strh	r0, [r1, #16]
@   0x08021d86: 0400        lsls	r0, r0, #16
@   0x08021d88: 2800        cmp	r0, #0
@   0x08021d8a: da00        bge.n	0x21d8e
@   0x08021d8c: 820e        strh	r6, [r1, #16]
@   0x08021d8e: 4d26        ldr	r5, [pc, #152]	@ (0x21e28)
@   0x08021d90: 46aa        mov	sl, r5
@   0x08021d92: 4649        mov	r1, r9
@   0x08021d94: 4642        mov	r2, r8
@   0x08021d96: 1a88        subs	r0, r1, r2
@   0x08021d98: 00c0        lsls	r0, r0, #3
@   0x08021d9a: 1947        adds	r7, r0, r5
@   0x08021d9c: 8a3c        ldrh	r4, [r7, #16]
@   0x08021d9e: 2510        movs	r5, #16
@   0x08021da0: 5f78        ldrsh	r0, [r7, r5]
@   0x08021da2: 3840        subs	r0, #64	@ 0x40
@   0x08021da4: 2800        cmp	r0, #0
@   0x08021da6: da03        bge.n	0x21db0
@   0x08021da8: 1c20        adds	r0, r4, #0
@   0x08021daa: 30ff        adds	r0, #255	@ 0xff
@   0x08021dac: 0400        lsls	r0, r0, #16
@   0x08021dae: 0c04        lsrs	r4, r0, #16
@   0x08021db0: 4e1e        ldr	r6, [pc, #120]	@ (0x21e2c)
@   0x08021db2: 0424        lsls	r4, r4, #16
@   0x08021db4: 1424        asrs	r4, r4, #16
@   0x08021db6: 0060        lsls	r0, r4, #1
@   0x08021db8: 1980        adds	r0, r0, r6
@   0x08021dba: 2100        movs	r1, #0
@   0x08021dbc: 5e40        ldrsh	r0, [r0, r1]
@   0x08021dbe: 061d        lsls	r5, r3, #24
@   0x08021dc0: 162d        asrs	r5, r5, #24
@   0x08021dc2: 1c29        adds	r1, r5, #0
@   0x08021dc4: f7ec        f91a 	bl	0xdffc
@   0x08021dc8: 9a00        ldr	r2, [sp, #0]
@   0x08021dca: 0411        lsls	r1, r2, #16
@   0x08021dcc: 1409        asrs	r1, r1, #16
@   0x08021dce: 1809        adds	r1, r1, r0
@   0x08021dd0: 8079        strh	r1, [r7, #2]
@   0x08021dd2: 3c40        subs	r4, #64	@ 0x40
@   0x08021dd4: 0064        lsls	r4, r4, #1
@   0x08021dd6: 19a4        adds	r4, r4, r6
@   0x08021dd8: 2100        movs	r1, #0
@   0x08021dda: 5e60        ldrsh	r0, [r4, r1]
@   0x08021ddc: 1c29        adds	r1, r5, #0
@   0x08021dde: f7ec        f90d 	bl	0xdffc
@   0x08021de2: 9a01        ldr	r2, [sp, #4]
@   0x08021de4: 0411        lsls	r1, r2, #16
@   0x08021de6: 1409        asrs	r1, r1, #16
@   0x08021de8: 1809        adds	r1, r1, r0
@   0x08021dea: 80b9        strh	r1, [r7, #4]
@   0x08021dec: 4910        ldr	r1, [pc, #64]	@ (0x21e30)
@   0x08021dee: 2002        movs	r0, #2
@   0x08021df0: 8a0c        ldrh	r4, [r1, #16]
@   0x08021df2: 4020        ands	r0, r4
@   0x08021df4: 2800        cmp	r0, #0
@   0x08021df6: d007        beq.n	0x21e08
@   0x08021df8: 7b49        ldrb	r1, [r1, #13]
@   0x08021dfa: 4588        cmp	r8, r1
@   0x08021dfc: d104        bne.n	0x21e08
@   0x08021dfe: 8878        ldrh	r0, [r7, #2]
@   0x08021e00: 4655        mov	r5, sl
@   0x08021e02: 8068        strh	r0, [r5, #2]
@   0x08021e04: 88b8        ldrh	r0, [r7, #4]
@   0x08021e06: 80a8        strh	r0, [r5, #4]
@   0x08021e08: 4649        mov	r1, r9
@   0x08021e0a: 4642        mov	r2, r8
@   0x08021e0c: 1a88        subs	r0, r1, r2
@   0x08021e0e: 00c0        lsls	r0, r0, #3
@   0x08021e10: 4905        ldr	r1, [pc, #20]	@ (0x21e28)
@   0x08021e12: 1840        adds	r0, r0, r1
@   0x08021e14: f7e3        fdd6 	bl	0x59c4
@   0x08021e18: b002        add	sp, #8
@   0x08021e1a: bc38        pop	{r3, r4, r5}
@   0x08021e1c: 4698        mov	r8, r3
@   0x08021e1e: 46a1        mov	r9, r4
@   0x08021e20: 46aa        mov	sl, r5
@   0x08021e22: bcf0        pop	{r4, r5, r6, r7}
@   0x08021e24: bc01        pop	{r0}
@   0x08021e26: 4700        bx	r0
@   0x08021e28: 3720        adds	r7, #32
@   0x08021e2a: 0300        lsls	r0, r0, #12
@   0x08021e2c: 0ea8        lsrs	r0, r5, #26
@   0x08021e2e: 080c        lsrs	r4, r1, #32
@   0x08021e30: 35e0        adds	r5, #224	@ 0xe0
@   0x08021e32: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08021CFC
sub_08021CFC: @ 0x08021cfc
        .incbin "frog_us_baserom.gba", 0x21cfc, 0x138
        thumb_func_end sub_08021CFC
