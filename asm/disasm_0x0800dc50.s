@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800dc50, 0x0800dd80)  (304 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800dc50 --end 0x800dd80 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800dc50: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800dc52: 4657        mov	r7, sl
@   0x0800dc54: 464e        mov	r6, r9
@   0x0800dc56: 4645        mov	r5, r8
@   0x0800dc58: b4e0        push	{r5, r6, r7}
@   0x0800dc5a: 2500        movs	r5, #0
@   0x0800dc5c: 4925        ldr	r1, [pc, #148]	@ (0xdcf4)
@   0x0800dc5e: 680e        ldr	r6, [r1, #0]
@   0x0800dc60: 4a25        ldr	r2, [pc, #148]	@ (0xdcf8)
@   0x0800dc62: 7a8b        ldrb	r3, [r1, #10]
@   0x0800dc64: 00d8        lsls	r0, r3, #3
@   0x0800dc66: 1880        adds	r0, r0, r2
@   0x0800dc68: 7840        ldrb	r0, [r0, #1]
@   0x0800dc6a: 4285        cmp	r5, r0
@   0x0800dc6c: d219        bcs.n	0xdca2
@   0x0800dc6e: 4823        ldr	r0, [pc, #140]	@ (0xdcfc)
@   0x0800dc70: 7e80        ldrb	r0, [r0, #26]
@   0x0800dc72: 2803        cmp	r0, #3
@   0x0800dc74: d815        bhi.n	0xdca2
@   0x0800dc76: 1c0c        adds	r4, r1, #0
@   0x0800dc78: 1c17        adds	r7, r2, #0
@   0x0800dc7a: f7fc        fc51 	bl	0xa520
@   0x0800dc7e: f7fc        fb2b 	bl	0xa2d8
@   0x0800dc82: f7f2        fe2b 	bl	0x8dc
@   0x0800dc86: f7fc        fb4f 	bl	0xa328
@   0x0800dc8a: 6821        ldr	r1, [r4, #0]
@   0x0800dc8c: 1b89        subs	r1, r1, r6
@   0x0800dc8e: 7aa2        ldrb	r2, [r4, #10]
@   0x0800dc90: 00d0        lsls	r0, r2, #3
@   0x0800dc92: 19c0        adds	r0, r0, r7
@   0x0800dc94: 7840        ldrb	r0, [r0, #1]
@   0x0800dc96: 4281        cmp	r1, r0
@   0x0800dc98: d203        bcs.n	0xdca2
@   0x0800dc9a: 4818        ldr	r0, [pc, #96]	@ (0xdcfc)
@   0x0800dc9c: 7e80        ldrb	r0, [r0, #26]
@   0x0800dc9e: 2803        cmp	r0, #3
@   0x0800dca0: d9eb        bls.n	0xdc7a
@   0x0800dca2: 4915        ldr	r1, [pc, #84]	@ (0xdcf8)
@   0x0800dca4: 4a13        ldr	r2, [pc, #76]	@ (0xdcf4)
@   0x0800dca6: 7a93        ldrb	r3, [r2, #10]
@   0x0800dca8: 00d8        lsls	r0, r3, #3
@   0x0800dcaa: 1840        adds	r0, r0, r1
@   0x0800dcac: 7800        ldrb	r0, [r0, #0]
@   0x0800dcae: 0600        lsls	r0, r0, #24
@   0x0800dcb0: 1600        asrs	r0, r0, #24
@   0x0800dcb2: 2800        cmp	r0, #0
@   0x0800dcb4: d056        beq.n	0xdd64
@   0x0800dcb6: 2100        movs	r1, #0
@   0x0800dcb8: 4281        cmp	r1, r0
@   0x0800dcba: da53        bge.n	0xdd64
@   0x0800dcbc: 4691        mov	r9, r2
@   0x0800dcbe: 20fe        movs	r0, #254	@ 0xfe
@   0x0800dcc0: 4005        ands	r5, r0
@   0x0800dcc2: 2000        movs	r0, #0
@   0x0800dcc4: 060f        lsls	r7, r1, #24
@   0x0800dcc6: 2800        cmp	r0, #0
@   0x0800dcc8: d13f        bne.n	0xdd4a
@   0x0800dcca: 4c0b        ldr	r4, [pc, #44]	@ (0xdcf8)
@   0x0800dccc: 46a2        mov	sl, r4
@   0x0800dcce: 15b8        asrs	r0, r7, #22
@   0x0800dcd0: 4680        mov	r8, r0
@   0x0800dcd2: 2002        movs	r0, #2
@   0x0800dcd4: 4028        ands	r0, r5
@   0x0800dcd6: 2800        cmp	r0, #0
@   0x0800dcd8: d012        beq.n	0xdd00
@   0x0800dcda: 464a        mov	r2, r9
@   0x0800dcdc: 6811        ldr	r1, [r2, #0]
@   0x0800dcde: 1b89        subs	r1, r1, r6
@   0x0800dce0: 7a93        ldrb	r3, [r2, #10]
@   0x0800dce2: 00d8        lsls	r0, r3, #3
@   0x0800dce4: 4450        add	r0, sl
@   0x0800dce6: 7880        ldrb	r0, [r0, #2]
@   0x0800dce8: 4281        cmp	r1, r0
@   0x0800dcea: d923        bls.n	0xdd34
@   0x0800dcec: 20fd        movs	r0, #253	@ 0xfd
@   0x0800dcee: 4005        ands	r5, r0
@   0x0800dcf0: e020        b.n	0xdd34
@   0x0800dcf2: 0000        movs	r0, r0
@   0x0800dcf4: 5330        strh	r0, [r6, r4]
@   0x0800dcf6: 0300        lsls	r0, r0, #12
@   0x0800dcf8: 0e20        lsrs	r0, r4, #24
@   0x0800dcfa: 080c        lsrs	r4, r1, #32
@   0x0800dcfc: 3720        adds	r7, #32
@   0x0800dcfe: 0300        lsls	r0, r0, #12
@   0x0800dd00: 4c1c        ldr	r4, [pc, #112]	@ (0xdd74)
@   0x0800dd02: 7aa1        ldrb	r1, [r4, #10]
@   0x0800dd04: 00c8        lsls	r0, r1, #3
@   0x0800dd06: 4a1c        ldr	r2, [pc, #112]	@ (0xdd78)
@   0x0800dd08: 1880        adds	r0, r0, r2
@   0x0800dd0a: 6801        ldr	r1, [r0, #0]
@   0x0800dd0c: 4441        add	r1, r8
@   0x0800dd0e: 2300        movs	r3, #0
@   0x0800dd10: 5ec8        ldrsh	r0, [r1, r3]
@   0x0800dd12: 2202        movs	r2, #2
@   0x0800dd14: 5e89        ldrsh	r1, [r1, r2]
@   0x0800dd16: f7fc        fb9f 	bl	0xa458
@   0x0800dd1a: 0600        lsls	r0, r0, #24
@   0x0800dd1c: 0e01        lsrs	r1, r0, #24
@   0x0800dd1e: 29ff        cmp	r1, #255	@ 0xff
@   0x0800dd20: d104        bne.n	0xdd2c
@   0x0800dd22: 6826        ldr	r6, [r4, #0]
@   0x0800dd24: 2302        movs	r3, #2
@   0x0800dd26: 431d        orrs	r5, r3
@   0x0800dd28: 0628        lsls	r0, r5, #24
@   0x0800dd2a: 0e05        lsrs	r5, r0, #24
@   0x0800dd2c: 2901        cmp	r1, #1
@   0x0800dd2e: d101        bne.n	0xdd34
@   0x0800dd30: 2401        movs	r4, #1
@   0x0800dd32: 4325        orrs	r5, r4
@   0x0800dd34: f7fc        fad0 	bl	0xa2d8
@   0x0800dd38: f7f2        fdd0 	bl	0x8dc
@   0x0800dd3c: f7fc        faf4 	bl	0xa328
@   0x0800dd40: 1c28        adds	r0, r5, #0
@   0x0800dd42: 2101        movs	r1, #1
@   0x0800dd44: 4008        ands	r0, r1
@   0x0800dd46: 2800        cmp	r0, #0
@   0x0800dd48: d0c3        beq.n	0xdcd2
@   0x0800dd4a: 2380        movs	r3, #128	@ 0x80
@   0x0800dd4c: 045b        lsls	r3, r3, #17
@   0x0800dd4e: 18fa        adds	r2, r7, r3
@   0x0800dd50: 490a        ldr	r1, [pc, #40]	@ (0xdd7c)
@   0x0800dd52: 464c        mov	r4, r9
@   0x0800dd54: 7aa4        ldrb	r4, [r4, #10]
@   0x0800dd56: 00e0        lsls	r0, r4, #3
@   0x0800dd58: 1840        adds	r0, r0, r1
@   0x0800dd5a: 0e11        lsrs	r1, r2, #24
@   0x0800dd5c: 7800        ldrb	r0, [r0, #0]
@   0x0800dd5e: 0600        lsls	r0, r0, #24
@   0x0800dd60: 4282        cmp	r2, r0
@   0x0800dd62: dbac        blt.n	0xdcbe
@   0x0800dd64: bc38        pop	{r3, r4, r5}
@   0x0800dd66: 4698        mov	r8, r3
@   0x0800dd68: 46a1        mov	r9, r4
@   0x0800dd6a: 46aa        mov	sl, r5
@   0x0800dd6c: bcf0        pop	{r4, r5, r6, r7}
@   0x0800dd6e: bc01        pop	{r0}
@   0x0800dd70: 4700        bx	r0
@   0x0800dd72: 0000        movs	r0, r0
@   0x0800dd74: 5330        strh	r0, [r6, r4]
@   0x0800dd76: 0300        lsls	r0, r0, #12
@   0x0800dd78: 0e24        lsrs	r4, r4, #24
@   0x0800dd7a: 080c        lsrs	r4, r1, #32
@   0x0800dd7c: 0e20        lsrs	r0, r4, #24
@   0x0800dd7e: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800DC50
sub_0800DC50: @ 0x0800dc50
        .incbin "frog_us_baserom.gba", 0xdc50, 0x130
        thumb_func_end sub_0800DC50
