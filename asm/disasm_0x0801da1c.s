@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801da1c, 0x0801dbb4)  (408 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801da1c --end 0x801dbb4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801da1c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801da1e: 4657        mov	r7, sl
@   0x0801da20: 464e        mov	r6, r9
@   0x0801da22: 4645        mov	r5, r8
@   0x0801da24: b4e0        push	{r5, r6, r7}
@   0x0801da26: b08f        sub	sp, #60	@ 0x3c
@   0x0801da28: 4912        ldr	r1, [pc, #72]	@ (0x1da74)
@   0x0801da2a: 8808        ldrh	r0, [r1, #0]
@   0x0801da2c: 900d        str	r0, [sp, #52]	@ 0x34
@   0x0801da2e: 4a12        ldr	r2, [pc, #72]	@ (0x1da78)
@   0x0801da30: 1c10        adds	r0, r2, #0
@   0x0801da32: 8008        strh	r0, [r1, #0]
@   0x0801da34: 2000        movs	r0, #0
@   0x0801da36: 4680        mov	r8, r0
@   0x0801da38: 2600        movs	r6, #0
@   0x0801da3a: 2700        movs	r7, #0
@   0x0801da3c: 2101        movs	r1, #1
@   0x0801da3e: 4689        mov	r9, r1
@   0x0801da40: 2206        movs	r2, #6
@   0x0801da42: 4692        mov	sl, r2
@   0x0801da44: f7ff        ff1c 	bl	0x1d880
@   0x0801da48: 2500        movs	r5, #0
@   0x0801da4a: 2d0b        cmp	r5, #11
@   0x0801da4c: d81e        bhi.n	0x1da8c
@   0x0801da4e: 1c28        adds	r0, r5, #0
@   0x0801da50: 1c29        adds	r1, r5, #0
@   0x0801da52: f000        fbd3 	bl	0x1e1fc
@   0x0801da56: 2800        cmp	r0, #0
@   0x0801da58: d010        beq.n	0x1da7c
@   0x0801da5a: 00a8        lsls	r0, r5, #2
@   0x0801da5c: 466a        mov	r2, sp
@   0x0801da5e: 1811        adds	r1, r2, r0
@   0x0801da60: 02e8        lsls	r0, r5, #11
@   0x0801da62: 2280        movs	r2, #128	@ 0x80
@   0x0801da64: 0492        lsls	r2, r2, #18
@   0x0801da66: 1880        adds	r0, r0, r2
@   0x0801da68: 6008        str	r0, [r1, #0]
@   0x0801da6a: 1c68        adds	r0, r5, #1
@   0x0801da6c: 0600        lsls	r0, r0, #24
@   0x0801da6e: 0e05        lsrs	r5, r0, #24
@   0x0801da70: e7eb        b.n	0x1da4a
@   0x0801da72: 0000        movs	r0, r0
@   0x0801da74: 01e2        lsls	r2, r4, #7
@   0x0801da76: 0500        lsls	r0, r0, #20
@   0x0801da78: 03df        lsls	r7, r3, #15
@   0x0801da7a: 0000        movs	r0, r0
@   0x0801da7c: 00a8        lsls	r0, r5, #2
@   0x0801da7e: 466a        mov	r2, sp
@   0x0801da80: 1811        adds	r1, r2, r0
@   0x0801da82: 02e8        lsls	r0, r5, #11
@   0x0801da84: 2280        movs	r2, #128	@ 0x80
@   0x0801da86: 0492        lsls	r2, r2, #18
@   0x0801da88: 1880        adds	r0, r0, r2
@   0x0801da8a: 6008        str	r0, [r1, #0]
@   0x0801da8c: 4905        ldr	r1, [pc, #20]	@ (0x1daa4)
@   0x0801da8e: 9800        ldr	r0, [sp, #0]
@   0x0801da90: 6008        str	r0, [r1, #0]
@   0x0801da92: 4805        ldr	r0, [pc, #20]	@ (0x1daa8)
@   0x0801da94: 6048        str	r0, [r1, #4]
@   0x0801da96: 4805        ldr	r0, [pc, #20]	@ (0x1daac)
@   0x0801da98: 6088        str	r0, [r1, #8]
@   0x0801da9a: 6888        ldr	r0, [r1, #8]
@   0x0801da9c: 20bf        movs	r0, #191	@ 0xbf
@   0x0801da9e: f7f2        fe25 	bl	0x106ec
@   0x0801daa2: e008        b.n	0x1dab6
@   0x0801daa4: 00d4        lsls	r4, r2, #3
@   0x0801daa6: 0400        lsls	r0, r0, #16
@   0x0801daa8: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801daac: 0400        lsls	r0, r0, #16
@   0x0801daae: 8000        strh	r0, [r0, #0]
@   0x0801dab0: 2002        movs	r0, #2
@   0x0801dab2: f000        fbdd 	bl	0x1e270
@   0x0801dab6: f7f2        fe2b 	bl	0x10710
@   0x0801daba: 2800        cmp	r0, #0
@   0x0801dabc: d1f8        bne.n	0x1dab0
@   0x0801dabe: 4a10        ldr	r2, [pc, #64]	@ (0x1db00)
@   0x0801dac0: 4c10        ldr	r4, [pc, #64]	@ (0x1db04)
@   0x0801dac2: 2002        movs	r0, #2
@   0x0801dac4: 920e        str	r2, [sp, #56]	@ 0x38
@   0x0801dac6: f000        fbd3 	bl	0x1e270
@   0x0801daca: 1c78        adds	r0, r7, #1
@   0x0801dacc: 0600        lsls	r0, r0, #24
@   0x0801dace: 0e07        lsrs	r7, r0, #24
@   0x0801dad0: 9a0e        ldr	r2, [sp, #56]	@ 0x38
@   0x0801dad2: 8017        strh	r7, [r2, #0]
@   0x0801dad4: 2107        movs	r1, #7
@   0x0801dad6: 4039        ands	r1, r7
@   0x0801dad8: 2900        cmp	r1, #0
@   0x0801dada: d136        bne.n	0x1db4a
@   0x0801dadc: 45a8        cmp	r8, r5
@   0x0801dade: d217        bcs.n	0x1db10
@   0x0801dae0: 4640        mov	r0, r8
@   0x0801dae2: 3001        adds	r0, #1
@   0x0801dae4: 0080        lsls	r0, r0, #2
@   0x0801dae6: 4468        add	r0, sp
@   0x0801dae8: 01b1        lsls	r1, r6, #6
@   0x0801daea: 6800        ldr	r0, [r0, #0]
@   0x0801daec: 1840        adds	r0, r0, r1
@   0x0801daee: 6020        str	r0, [r4, #0]
@   0x0801daf0: 4805        ldr	r0, [pc, #20]	@ (0x1db08)
@   0x0801daf2: 1809        adds	r1, r1, r0
@   0x0801daf4: 6061        str	r1, [r4, #4]
@   0x0801daf6: 4805        ldr	r0, [pc, #20]	@ (0x1db0c)
@   0x0801daf8: 60a0        str	r0, [r4, #8]
@   0x0801dafa: 68a0        ldr	r0, [r4, #8]
@   0x0801dafc: e022        b.n	0x1db44
@   0x0801dafe: 0000        movs	r0, r0
@   0x0801db00: 001e        movs	r6, r3
@   0x0801db02: 0400        lsls	r0, r0, #16
@   0x0801db04: 00d4        lsls	r4, r2, #3
@   0x0801db06: 0400        lsls	r0, r0, #16
@   0x0801db08: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801db0c: 0020        movs	r0, r4
@   0x0801db0e: 8000        strh	r0, [r0, #0]
@   0x0801db10: 4650        mov	r0, sl
@   0x0801db12: 2800        cmp	r0, #0
@   0x0801db14: d014        beq.n	0x1db40
@   0x0801db16: a80c        add	r0, sp, #48	@ 0x30
@   0x0801db18: 8001        strh	r1, [r0, #0]
@   0x0801db1a: 6020        str	r0, [r4, #0]
@   0x0801db1c: 01b0        lsls	r0, r6, #6
@   0x0801db1e: 4906        ldr	r1, [pc, #24]	@ (0x1db38)
@   0x0801db20: 1840        adds	r0, r0, r1
@   0x0801db22: 6060        str	r0, [r4, #4]
@   0x0801db24: 4805        ldr	r0, [pc, #20]	@ (0x1db3c)
@   0x0801db26: 60a0        str	r0, [r4, #8]
@   0x0801db28: 68a0        ldr	r0, [r4, #8]
@   0x0801db2a: 4650        mov	r0, sl
@   0x0801db2c: 3801        subs	r0, #1
@   0x0801db2e: 0600        lsls	r0, r0, #24
@   0x0801db30: 0e00        lsrs	r0, r0, #24
@   0x0801db32: 4682        mov	sl, r0
@   0x0801db34: e006        b.n	0x1db44
@   0x0801db36: 0000        movs	r0, r0
@   0x0801db38: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801db3c: 0020        movs	r0, r4
@   0x0801db3e: 8100        strh	r0, [r0, #8]
@   0x0801db40: 2000        movs	r0, #0
@   0x0801db42: 4681        mov	r9, r0
@   0x0801db44: 1c70        adds	r0, r6, #1
@   0x0801db46: 0600        lsls	r0, r0, #24
@   0x0801db48: 0e06        lsrs	r6, r0, #24
@   0x0801db4a: 2e1f        cmp	r6, #31
@   0x0801db4c: d90d        bls.n	0x1db6a
@   0x0801db4e: 45a8        cmp	r8, r5
@   0x0801db50: d205        bcs.n	0x1db5e
@   0x0801db52: 4640        mov	r0, r8
@   0x0801db54: 3001        adds	r0, #1
@   0x0801db56: 0600        lsls	r0, r0, #24
@   0x0801db58: 0e00        lsrs	r0, r0, #24
@   0x0801db5a: 4680        mov	r8, r0
@   0x0801db5c: e001        b.n	0x1db62
@   0x0801db5e: 2100        movs	r1, #0
@   0x0801db60: 4689        mov	r9, r1
@   0x0801db62: 2000        movs	r0, #0
@   0x0801db64: 8010        strh	r0, [r2, #0]
@   0x0801db66: 2600        movs	r6, #0
@   0x0801db68: 2700        movs	r7, #0
@   0x0801db6a: 4648        mov	r0, r9
@   0x0801db6c: 2800        cmp	r0, #0
@   0x0801db6e: d1a8        bne.n	0x1dac2
@   0x0801db70: 480c        ldr	r0, [pc, #48]	@ (0x1dba4)
@   0x0801db72: 2400        movs	r4, #0
@   0x0801db74: 4649        mov	r1, r9
@   0x0801db76: 8001        strh	r1, [r0, #0]
@   0x0801db78: f002        ffea 	bl	0x20b50
@   0x0801db7c: f000        fa7c 	bl	0x1e078
@   0x0801db80: 4809        ldr	r0, [pc, #36]	@ (0x1dba8)
@   0x0801db82: 466a        mov	r2, sp
@   0x0801db84: 8e92        ldrh	r2, [r2, #52]	@ 0x34
@   0x0801db86: 8002        strh	r2, [r0, #0]
@   0x0801db88: 4908        ldr	r1, [pc, #32]	@ (0x1dbac)
@   0x0801db8a: 2004        movs	r0, #4
@   0x0801db8c: 7248        strb	r0, [r1, #9]
@   0x0801db8e: 4808        ldr	r0, [pc, #32]	@ (0x1dbb0)
@   0x0801db90: 7004        strb	r4, [r0, #0]
@   0x0801db92: b00f        add	sp, #60	@ 0x3c
@   0x0801db94: bc38        pop	{r3, r4, r5}
@   0x0801db96: 4698        mov	r8, r3
@   0x0801db98: 46a1        mov	r9, r4
@   0x0801db9a: 46aa        mov	sl, r5
@   0x0801db9c: bcf0        pop	{r4, r5, r6, r7}
@   0x0801db9e: bc01        pop	{r0}
@   0x0801dba0: 4700        bx	r0
@   0x0801dba2: 0000        movs	r0, r0
@   0x0801dba4: 001e        movs	r6, r3
@   0x0801dba6: 0400        lsls	r0, r0, #16
@   0x0801dba8: 01e2        lsls	r2, r4, #7
@   0x0801dbaa: 0500        lsls	r0, r0, #20
@   0x0801dbac: 5330        strh	r0, [r6, r4]
@   0x0801dbae: 0300        lsls	r0, r0, #12
@   0x0801dbb0: 3480        adds	r4, #128	@ 0x80
@   0x0801dbb2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801DA1C
sub_0801DA1C: @ 0x0801da1c
        .incbin "frog_us_baserom.gba", 0x1da1c, 0x198
        thumb_func_end sub_0801DA1C
