@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801aa60, 0x0801ac84)  (548 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801aa60 --end 0x801ac84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801aa60: b570        push<und>	{r4, r5, r6, lr}
@   0x0801aa62: 464e        mov<und>	r6, r9
@   0x0801aa64: 4645        mov<und>	r5, r8
@   0x0801aa66: b460        push	{r5, r6}
@   0x0801aa68: 0600        lsls	r0, r0, #24
@   0x0801aa6a: 4d27        ldr	r5, [pc, #156]	@ (0x1ab08)
@   0x0801aa6c: 4c27        ldr	r4, [pc, #156]	@ (0x1ab0c)
@   0x0801aa6e: 4928        ldr	r1, [pc, #160]	@ (0x1ab10)
@   0x0801aa70: 4a28        ldr	r2, [pc, #160]	@ (0x1ab14)
@   0x0801aa72: 4690        mov	r8, r2
@   0x0801aa74: 6812        ldr	r2, [r2, #0]
@   0x0801aa76: 600a        str	r2, [r1, #0]
@   0x0801aa78: 4b27        ldr	r3, [pc, #156]	@ (0x1ab18)
@   0x0801aa7a: 4699        mov	r9, r3
@   0x0801aa7c: 604b        str	r3, [r1, #4]
@   0x0801aa7e: 4e27        ldr	r6, [pc, #156]	@ (0x1ab1c)
@   0x0801aa80: 608e        str	r6, [r1, #8]
@   0x0801aa82: 688a        ldr	r2, [r1, #8]
@   0x0801aa84: 600c        str	r4, [r1, #0]
@   0x0801aa86: 4a26        ldr	r2, [pc, #152]	@ (0x1ab20)
@   0x0801aa88: 604a        str	r2, [r1, #4]
@   0x0801aa8a: 4b26        ldr	r3, [pc, #152]	@ (0x1ab24)
@   0x0801aa8c: 608b        str	r3, [r1, #8]
@   0x0801aa8e: 688a        ldr	r2, [r1, #8]
@   0x0801aa90: 1c22        adds	r2, r4, #0
@   0x0801aa92: 3208        adds	r2, #8
@   0x0801aa94: 600a        str	r2, [r1, #0]
@   0x0801aa96: 4a24        ldr	r2, [pc, #144]	@ (0x1ab28)
@   0x0801aa98: 604a        str	r2, [r1, #4]
@   0x0801aa9a: 608b        str	r3, [r1, #8]
@   0x0801aa9c: 688a        ldr	r2, [r1, #8]
@   0x0801aa9e: 1c22        adds	r2, r4, #0
@   0x0801aaa0: 3210        adds	r2, #16
@   0x0801aaa2: 600a        str	r2, [r1, #0]
@   0x0801aaa4: 4a21        ldr	r2, [pc, #132]	@ (0x1ab2c)
@   0x0801aaa6: 604a        str	r2, [r1, #4]
@   0x0801aaa8: 608b        str	r3, [r1, #8]
@   0x0801aaaa: 688a        ldr	r2, [r1, #8]
@   0x0801aaac: 3418        adds	r4, #24
@   0x0801aaae: 600c        str	r4, [r1, #0]
@   0x0801aab0: 4a1f        ldr	r2, [pc, #124]	@ (0x1ab30)
@   0x0801aab2: 604a        str	r2, [r1, #4]
@   0x0801aab4: 608b        str	r3, [r1, #8]
@   0x0801aab6: 688a        ldr	r2, [r1, #8]
@   0x0801aab8: 0d80        lsrs	r0, r0, #22
@   0x0801aaba: 3004        adds	r0, #4
@   0x0801aabc: 4440        add	r0, r8
@   0x0801aabe: 6800        ldr	r0, [r0, #0]
@   0x0801aac0: 6008        str	r0, [r1, #0]
@   0x0801aac2: 4648        mov	r0, r9
@   0x0801aac4: 6048        str	r0, [r1, #4]
@   0x0801aac6: 608e        str	r6, [r1, #8]
@   0x0801aac8: 6888        ldr	r0, [r1, #8]
@   0x0801aaca: 600d        str	r5, [r1, #0]
@   0x0801aacc: 4819        ldr	r0, [pc, #100]	@ (0x1ab34)
@   0x0801aace: 6048        str	r0, [r1, #4]
@   0x0801aad0: 608b        str	r3, [r1, #8]
@   0x0801aad2: 6888        ldr	r0, [r1, #8]
@   0x0801aad4: 1c28        adds	r0, r5, #0
@   0x0801aad6: 3008        adds	r0, #8
@   0x0801aad8: 6008        str	r0, [r1, #0]
@   0x0801aada: 4817        ldr	r0, [pc, #92]	@ (0x1ab38)
@   0x0801aadc: 6048        str	r0, [r1, #4]
@   0x0801aade: 608b        str	r3, [r1, #8]
@   0x0801aae0: 6888        ldr	r0, [r1, #8]
@   0x0801aae2: 1c28        adds	r0, r5, #0
@   0x0801aae4: 3010        adds	r0, #16
@   0x0801aae6: 6008        str	r0, [r1, #0]
@   0x0801aae8: 4814        ldr	r0, [pc, #80]	@ (0x1ab3c)
@   0x0801aaea: 6048        str	r0, [r1, #4]
@   0x0801aaec: 608b        str	r3, [r1, #8]
@   0x0801aaee: 6888        ldr	r0, [r1, #8]
@   0x0801aaf0: 3518        adds	r5, #24
@   0x0801aaf2: 600d        str	r5, [r1, #0]
@   0x0801aaf4: 4812        ldr	r0, [pc, #72]	@ (0x1ab40)
@   0x0801aaf6: 6048        str	r0, [r1, #4]
@   0x0801aaf8: 608b        str	r3, [r1, #8]
@   0x0801aafa: 6888        ldr	r0, [r1, #8]
@   0x0801aafc: bc18        pop	{r3, r4}
@   0x0801aafe: 4698        mov	r8, r3
@   0x0801ab00: 46a1        mov	r9, r4
@   0x0801ab02: bc70        pop	{r4, r5, r6}
@   0x0801ab04: bc01        pop	{r0}
@   0x0801ab06: 4700        bx	r0
@   0x0801ab08: ab78        add	r3, sp, #480	@ 0x1e0
@   0x0801ab0a: 081d        lsrs	r5, r3, #32
@   0x0801ab0c: ab58        add	r3, sp, #352	@ 0x160
@   0x0801ab0e: 081d        lsrs	r5, r3, #32
@   0x0801ab10: 00d4        lsls	r4, r2, #3
@   0x0801ab12: 0400        lsls	r0, r0, #16
@   0x0801ab14: 8f3c        ldrh	r4, [r7, #56]	@ 0x38
@   0x0801ab16: 0830        lsrs	r0, r6, #32
@   0x0801ab18: 01e0        lsls	r0, r4, #7
@   0x0801ab1a: 0500        lsls	r0, r0, #20
@   0x0801ab1c: 0010        movs	r0, r2
@   0x0801ab1e: 8000        strh	r0, [r0, #0]
@   0x0801ab20: fbf4        0600 			@ <UNDEFINED> instruction: 0xfbf40600
@   0x0801ab24: 0004        movs	r4, r0
@   0x0801ab26: 8000        strh	r0, [r0, #0]
@   0x0801ab28: fc34        0600 			@ <UNDEFINED> instruction: 0xfc340600
@   0x0801ab2c: fc74        0600 			@ <UNDEFINED> instruction: 0xfc740600
@   0x0801ab30: fcb4        0600 			@ <UNDEFINED> instruction: 0xfcb40600
@   0x0801ab34: f841        0600 	str.w	r0, [r1, <undefined>]
@   0x0801ab38: f881        0600 	strb.w	r0, [r1, #1536]	@ 0x600
@   0x0801ab3c: f8c1        0600 	str.w	r0, [r1, #1536]	@ 0x600
@   0x0801ab40: f901        0600 	vst1.8	{d0-d2}, [r1], r0
@   0x0801ab44: b530        push	{r4, r5, lr}
@   0x0801ab46: 0600        lsls	r0, r0, #24
@   0x0801ab48: 21ff        movs	r1, #255	@ 0xff
@   0x0801ab4a: 0609        lsls	r1, r1, #24
@   0x0801ab4c: 1840        adds	r0, r0, r1
@   0x0801ab4e: 0e04        lsrs	r4, r0, #24
@   0x0801ab50: 1c20        adds	r0, r4, #0
@   0x0801ab52: 2103        movs	r1, #3
@   0x0801ab54: f019        fa02 	bl	0x33f5c
@   0x0801ab58: 0600        lsls	r0, r0, #24
@   0x0801ab5a: 2800        cmp	r0, #0
@   0x0801ab5c: d106        bne.n	0x1ab6c
@   0x0801ab5e: 1c20        adds	r0, r4, #0
@   0x0801ab60: 2103        movs	r1, #3
@   0x0801ab62: f019        f9bf 	bl	0x33ee4
@   0x0801ab66: 0600        lsls	r0, r0, #24
@   0x0801ab68: 0e04        lsrs	r4, r0, #24
@   0x0801ab6a: e006        b.n	0x1ab7a
@   0x0801ab6c: 2c0d        cmp	r4, #13
@   0x0801ab6e: d003        beq.n	0x1ab78
@   0x0801ab70: 2001        movs	r0, #1
@   0x0801ab72: e080        b.n	0x1ac76
@   0x0801ab74: 1c48        adds	r0, r1, #1
@   0x0801ab76: e013        b.n	0x1aba0
@   0x0801ab78: 2405        movs	r4, #5
@   0x0801ab7a: 2c05        cmp	r4, #5
@   0x0801ab7c: d11a        bne.n	0x1abb4
@   0x0801ab7e: 210f        movs	r1, #15
@   0x0801ab80: 480a        ldr	r0, [pc, #40]	@ (0x1abac)
@   0x0801ab82: 68c2        ldr	r2, [r0, #12]
@   0x0801ab84: 2301        movs	r3, #1
@   0x0801ab86: 0608        lsls	r0, r1, #24
@   0x0801ab88: 1601        asrs	r1, r0, #24
@   0x0801ab8a: 1c10        adds	r0, r2, #0
@   0x0801ab8c: 40c8        lsrs	r0, r1
@   0x0801ab8e: 4018        ands	r0, r3
@   0x0801ab90: 2800        cmp	r0, #0
@   0x0801ab92: d1ef        bne.n	0x1ab74
@   0x0801ab94: 1e48        subs	r0, r1, #1
@   0x0801ab96: 0600        lsls	r0, r0, #24
@   0x0801ab98: 0e01        lsrs	r1, r0, #24
@   0x0801ab9a: 2800        cmp	r0, #0
@   0x0801ab9c: daf3        bge.n	0x1ab86
@   0x0801ab9e: 2000        movs	r0, #0
@   0x0801aba0: 0600        lsls	r0, r0, #24
@   0x0801aba2: 0e00        lsrs	r0, r0, #24
@   0x0801aba4: 280d        cmp	r0, #13
@   0x0801aba6: d905        bls.n	0x1abb4
@   0x0801aba8: e7e2        b.n	0x1ab70
@   0x0801abaa: 0000        movs	r0, r0
@   0x0801abac: 5330        strh	r0, [r6, r4]
@   0x0801abae: 0300        lsls	r0, r0, #12
@   0x0801abb0: 1c48        adds	r0, r1, #1
@   0x0801abb2: e012        b.n	0x1abda
@   0x0801abb4: 2c04        cmp	r4, #4
@   0x0801abb6: d114        bne.n	0x1abe2
@   0x0801abb8: 210f        movs	r1, #15
@   0x0801abba: 4824        ldr	r0, [pc, #144]	@ (0x1ac4c)
@   0x0801abbc: 68c2        ldr	r2, [r0, #12]
@   0x0801abbe: 2301        movs	r3, #1
@   0x0801abc0: 0608        lsls	r0, r1, #24
@   0x0801abc2: 1601        asrs	r1, r0, #24
@   0x0801abc4: 1c10        adds	r0, r2, #0
@   0x0801abc6: 40c8        lsrs	r0, r1
@   0x0801abc8: 4018        ands	r0, r3
@   0x0801abca: 2800        cmp	r0, #0
@   0x0801abcc: d1f0        bne.n	0x1abb0
@   0x0801abce: 1e48        subs	r0, r1, #1
@   0x0801abd0: 0600        lsls	r0, r0, #24
@   0x0801abd2: 0e01        lsrs	r1, r0, #24
@   0x0801abd4: 2800        cmp	r0, #0
@   0x0801abd6: daf3        bge.n	0x1abc0
@   0x0801abd8: 2000        movs	r0, #0
@   0x0801abda: 0600        lsls	r0, r0, #24
@   0x0801abdc: 0e00        lsrs	r0, r0, #24
@   0x0801abde: 280c        cmp	r0, #12
@   0x0801abe0: d8c6        bhi.n	0x1ab70
@   0x0801abe2: 1c20        adds	r0, r4, #0
@   0x0801abe4: f7ff        fdc6 	bl	0x1a774
@   0x0801abe8: 2003        movs	r0, #3
@   0x0801abea: 2114        movs	r1, #20
@   0x0801abec: f7ff        fe52 	bl	0x1a894
@   0x0801abf0: 1c20        adds	r0, r4, #0
@   0x0801abf2: f7ff        ff35 	bl	0x1aa60
@   0x0801abf6: 1c20        adds	r0, r4, #0
@   0x0801abf8: f000        f88a 	bl	0x1ad10
@   0x0801abfc: 4d14        ldr	r5, [pc, #80]	@ (0x1ac50)
@   0x0801abfe: f7e5        fc61 	bl	0x4c4
@   0x0801ac02: 8028        strh	r0, [r5, #0]
@   0x0801ac04: 1c20        adds	r0, r4, #0
@   0x0801ac06: f000        fb0d 	bl	0x1b224
@   0x0801ac0a: 0600        lsls	r0, r0, #24
@   0x0801ac0c: 0e00        lsrs	r0, r0, #24
@   0x0801ac0e: 28fe        cmp	r0, #254	@ 0xfe
@   0x0801ac10: d1f5        bne.n	0x1abfe
@   0x0801ac12: 2003        movs	r0, #3
@   0x0801ac14: 2114        movs	r1, #20
@   0x0801ac16: f7ff        feb3 	bl	0x1a980
@   0x0801ac1a: 480e        ldr	r0, [pc, #56]	@ (0x1ac54)
@   0x0801ac1c: 2100        movs	r1, #0
@   0x0801ac1e: 8001        strh	r1, [r0, #0]
@   0x0801ac20: 3004        adds	r0, #4
@   0x0801ac22: 8001        strh	r1, [r0, #0]
@   0x0801ac24: 3802        subs	r0, #2
@   0x0801ac26: 8001        strh	r1, [r0, #0]
@   0x0801ac28: 3004        adds	r0, #4
@   0x0801ac2a: 8001        strh	r1, [r0, #0]
@   0x0801ac2c: 3002        adds	r0, #2
@   0x0801ac2e: 8001        strh	r1, [r0, #0]
@   0x0801ac30: 3002        adds	r0, #2
@   0x0801ac32: 8001        strh	r1, [r0, #0]
@   0x0801ac34: 2c04        cmp	r4, #4
@   0x0801ac36: d113        bne.n	0x1ac60
@   0x0801ac38: 4807        ldr	r0, [pc, #28]	@ (0x1ac58)
@   0x0801ac3a: 6881        ldr	r1, [r0, #8]
@   0x0801ac3c: 1c02        adds	r2, r0, #0
@   0x0801ac3e: 2900        cmp	r1, #0
@   0x0801ac40: d00e        beq.n	0x1ac60
@   0x0801ac42: 4906        ldr	r1, [pc, #24]	@ (0x1ac5c)
@   0x0801ac44: 8848        ldrh	r0, [r1, #2]
@   0x0801ac46: 3832        subs	r0, #50	@ 0x32
@   0x0801ac48: e013        b.n	0x1ac72
@   0x0801ac4a: 0000        movs	r0, r0
@   0x0801ac4c: 5330        strh	r0, [r6, r4]
@   0x0801ac4e: 0300        lsls	r0, r0, #12
@   0x0801ac50: 5398        strh	r0, [r3, r6]
@   0x0801ac52: 0300        lsls	r0, r0, #12
@   0x0801ac54: 0040        lsls	r0, r0, #1
@   0x0801ac56: 0400        lsls	r0, r0, #16
@   0x0801ac58: 3540        adds	r5, #64	@ 0x40
@   0x0801ac5a: 0300        lsls	r0, r0, #12
@   0x0801ac5c: 35e0        adds	r5, #224	@ 0xe0
@   0x0801ac5e: 0300        lsls	r0, r0, #12
@   0x0801ac60: 4a06        ldr	r2, [pc, #24]	@ (0x1ac7c)
@   0x0801ac62: 2c05        cmp	r4, #5
@   0x0801ac64: d106        bne.n	0x1ac74
@   0x0801ac66: 6890        ldr	r0, [r2, #8]
@   0x0801ac68: 2800        cmp	r0, #0
@   0x0801ac6a: d003        beq.n	0x1ac74
@   0x0801ac6c: 4904        ldr	r1, [pc, #16]	@ (0x1ac80)
@   0x0801ac6e: 8848        ldrh	r0, [r1, #2]
@   0x0801ac70: 384b        subs	r0, #75	@ 0x4b
@   0x0801ac72: 8048        strh	r0, [r1, #2]
@   0x0801ac74: 6890        ldr	r0, [r2, #8]
@   0x0801ac76: bc30        pop	{r4, r5}
@   0x0801ac78: bc02        pop	{r1}
@   0x0801ac7a: 4708        bx	r1
@   0x0801ac7c: 3540        adds	r5, #64	@ 0x40
@   0x0801ac7e: 0300        lsls	r0, r0, #12
@   0x0801ac80: 35e0        adds	r5, #224	@ 0xe0
@   0x0801ac82: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801AA60
sub_0801AA60: @ 0x0801aa60
        .incbin "frog_us_baserom.gba", 0x1aa60, 0x224
        thumb_func_end sub_0801AA60
