@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801dea0, 0x0801e078)  (472 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801dea0 --end 0x801e078 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801dea0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801dea2: 4657        mov	r7, sl
@   0x0801dea4: 464e        mov	r6, r9
@   0x0801dea6: 4645        mov	r5, r8
@   0x0801dea8: b4e0        push	{r5, r6, r7}
@   0x0801deaa: b085        sub	sp, #20
@   0x0801deac: 9000        str	r0, [sp, #0]
@   0x0801deae: 980d        ldr	r0, [sp, #52]	@ 0x34
@   0x0801deb0: 9d0e        ldr	r5, [sp, #56]	@ 0x38
@   0x0801deb2: 9c0f        ldr	r4, [sp, #60]	@ 0x3c
@   0x0801deb4: 0609        lsls	r1, r1, #24
@   0x0801deb6: 0e09        lsrs	r1, r1, #24
@   0x0801deb8: 9101        str	r1, [sp, #4]
@   0x0801deba: 0612        lsls	r2, r2, #24
@   0x0801debc: 0e16        lsrs	r6, r2, #24
@   0x0801debe: 061b        lsls	r3, r3, #24
@   0x0801dec0: 0e1f        lsrs	r7, r3, #24
@   0x0801dec2: 0400        lsls	r0, r0, #16
@   0x0801dec4: 0c00        lsrs	r0, r0, #16
@   0x0801dec6: 4681        mov	r9, r0
@   0x0801dec8: 0624        lsls	r4, r4, #24
@   0x0801deca: 0e24        lsrs	r4, r4, #24
@   0x0801decc: 1c20        adds	r0, r4, #0
@   0x0801dece: 072d        lsls	r5, r5, #28
@   0x0801ded0: 0c2d        lsrs	r5, r5, #16
@   0x0801ded2: 2c01        cmp	r4, #1
@   0x0801ded4: d00c        beq.n	0x1def0
@   0x0801ded6: 2c01        cmp	r4, #1
@   0x0801ded8: dc02        bgt.n	0x1dee0
@   0x0801deda: 2c00        cmp	r4, #0
@   0x0801dedc: d005        beq.n	0x1deea
@   0x0801dede: e015        b.n	0x1df0c
@   0x0801dee0: 2802        cmp	r0, #2
@   0x0801dee2: d00b        beq.n	0x1defc
@   0x0801dee4: 2803        cmp	r0, #3
@   0x0801dee6: d00f        beq.n	0x1df08
@   0x0801dee8: e010        b.n	0x1df0c
@   0x0801deea: 2080        movs	r0, #128	@ 0x80
@   0x0801deec: 0480        lsls	r0, r0, #18
@   0x0801deee: e00c        b.n	0x1df0a
@   0x0801def0: 4901        ldr	r1, [pc, #4]	@ (0x1def8)
@   0x0801def2: 4688        mov	r8, r1
@   0x0801def4: e00a        b.n	0x1df0c
@   0x0801def6: 0000        movs	r0, r0
@   0x0801def8: 0800        lsrs	r0, r0, #32
@   0x0801defa: 0200        lsls	r0, r0, #8
@   0x0801defc: 4a01        ldr	r2, [pc, #4]	@ (0x1df04)
@   0x0801defe: 4690        mov	r8, r2
@   0x0801df00: e004        b.n	0x1df0c
@   0x0801df02: 0000        movs	r0, r0
@   0x0801df04: 1000        asrs	r0, r0, #32
@   0x0801df06: 0200        lsls	r0, r0, #8
@   0x0801df08: 480b        ldr	r0, [pc, #44]	@ (0x1df38)
@   0x0801df0a: 4680        mov	r8, r0
@   0x0801df0c: 2100        movs	r1, #0
@   0x0801df0e: 468a        mov	sl, r1
@   0x0801df10: 9a01        ldr	r2, [sp, #4]
@   0x0801df12: 4592        cmp	sl, r2
@   0x0801df14: d300        bcc.n	0x1df18
@   0x0801df16: e0a6        b.n	0x1e066
@   0x0801df18: 0428        lsls	r0, r5, #16
@   0x0801df1a: 1400        asrs	r0, r0, #16
@   0x0801df1c: 9004        str	r0, [sp, #16]
@   0x0801df1e: 9b00        ldr	r3, [sp, #0]
@   0x0801df20: 4453        add	r3, sl
@   0x0801df22: 781a        ldrb	r2, [r3, #0]
@   0x0801df24: 1c10        adds	r0, r2, #0
@   0x0801df26: 3830        subs	r0, #48	@ 0x30
@   0x0801df28: 0600        lsls	r0, r0, #24
@   0x0801df2a: 0e00        lsrs	r0, r0, #24
@   0x0801df2c: 2809        cmp	r0, #9
@   0x0801df2e: d817        bhi.n	0x1df60
@   0x0801df30: 2a30        cmp	r2, #48	@ 0x30
@   0x0801df32: d103        bne.n	0x1df3c
@   0x0801df34: 2109        movs	r1, #9
@   0x0801df36: e005        b.n	0x1df44
@   0x0801df38: 1800        adds	r0, r0, r0
@   0x0801df3a: 0200        lsls	r0, r0, #8
@   0x0801df3c: 1c10        adds	r0, r2, #0
@   0x0801df3e: 3831        subs	r0, #49	@ 0x31
@   0x0801df40: 0400        lsls	r0, r0, #16
@   0x0801df42: 0c01        lsrs	r1, r0, #16
@   0x0801df44: 01ba        lsls	r2, r7, #6
@   0x0801df46: 0070        lsls	r0, r6, #1
@   0x0801df48: 4440        add	r0, r8
@   0x0801df4a: 1812        adds	r2, r2, r0
@   0x0801df4c: 0048        lsls	r0, r1, #1
@   0x0801df4e: 4448        add	r0, r9
@   0x0801df50: 1829        adds	r1, r5, r0
@   0x0801df52: 8011        strh	r1, [r2, #0]
@   0x0801df54: 3240        adds	r2, #64	@ 0x40
@   0x0801df56: 3001        adds	r0, #1
@   0x0801df58: 9904        ldr	r1, [sp, #16]
@   0x0801df5a: 1808        adds	r0, r1, r0
@   0x0801df5c: 8010        strh	r0, [r2, #0]
@   0x0801df5e: e06d        b.n	0x1e03c
@   0x0801df60: 1c11        adds	r1, r2, #0
@   0x0801df62: 3941        subs	r1, #65	@ 0x41
@   0x0801df64: 0608        lsls	r0, r1, #24
@   0x0801df66: 0e00        lsrs	r0, r0, #24
@   0x0801df68: 2819        cmp	r0, #25
@   0x0801df6a: d905        bls.n	0x1df78
@   0x0801df6c: 1c11        adds	r1, r2, #0
@   0x0801df6e: 3961        subs	r1, #97	@ 0x61
@   0x0801df70: 0608        lsls	r0, r1, #24
@   0x0801df72: 0e00        lsrs	r0, r0, #24
@   0x0801df74: 2819        cmp	r0, #25
@   0x0801df76: d811        bhi.n	0x1df9c
@   0x0801df78: 0409        lsls	r1, r1, #16
@   0x0801df7a: 01ba        lsls	r2, r7, #6
@   0x0801df7c: 0070        lsls	r0, r6, #1
@   0x0801df7e: 4440        add	r0, r8
@   0x0801df80: 1812        adds	r2, r2, r0
@   0x0801df82: 0bc9        lsrs	r1, r1, #15
@   0x0801df84: 1c08        adds	r0, r1, #0
@   0x0801df86: 3014        adds	r0, #20
@   0x0801df88: 4448        add	r0, r9
@   0x0801df8a: 1828        adds	r0, r5, r0
@   0x0801df8c: 8010        strh	r0, [r2, #0]
@   0x0801df8e: 3240        adds	r2, #64	@ 0x40
@   0x0801df90: 4449        add	r1, r9
@   0x0801df92: 3115        adds	r1, #21
@   0x0801df94: 9804        ldr	r0, [sp, #16]
@   0x0801df96: 1841        adds	r1, r0, r1
@   0x0801df98: 8011        strh	r1, [r2, #0]
@   0x0801df9a: e04f        b.n	0x1e03c
@   0x0801df9c: 2a5b        cmp	r2, #91	@ 0x5b
@   0x0801df9e: d12b        bne.n	0x1dff8
@   0x0801dfa0: 7919        ldrb	r1, [r3, #4]
@   0x0801dfa2: 295d        cmp	r1, #93	@ 0x5d
@   0x0801dfa4: d128        bne.n	0x1dff8
@   0x0801dfa6: 1c58        adds	r0, r3, #1
@   0x0801dfa8: 2103        movs	r1, #3
@   0x0801dfaa: f7fe        ff89 	bl	0x1cec0
@   0x0801dfae: 1c04        adds	r4, r0, #0
@   0x0801dfb0: 3cc0        subs	r4, #192	@ 0xc0
@   0x0801dfb2: 2c3f        cmp	r4, #63	@ 0x3f
@   0x0801dfb4: d817        bhi.n	0x1dfe6
@   0x0801dfb6: 9803        ldr	r0, [sp, #12]
@   0x0801dfb8: 0042        lsls	r2, r0, #1
@   0x0801dfba: 19d2        adds	r2, r2, r7
@   0x0801dfbc: 0192        lsls	r2, r2, #6
@   0x0801dfbe: 9802        ldr	r0, [sp, #8]
@   0x0801dfc0: 0041        lsls	r1, r0, #1
@   0x0801dfc2: 0070        lsls	r0, r6, #1
@   0x0801dfc4: 4440        add	r0, r8
@   0x0801dfc6: 1809        adds	r1, r1, r0
@   0x0801dfc8: 1852        adds	r2, r2, r1
@   0x0801dfca: 4b0a        ldr	r3, [pc, #40]	@ (0x1dff4)
@   0x0801dfcc: 0061        lsls	r1, r4, #1
@   0x0801dfce: 1909        adds	r1, r1, r4
@   0x0801dfd0: 1c48        adds	r0, r1, #1
@   0x0801dfd2: 0040        lsls	r0, r0, #1
@   0x0801dfd4: 18c0        adds	r0, r0, r3
@   0x0801dfd6: 8800        ldrh	r0, [r0, #0]
@   0x0801dfd8: 8010        strh	r0, [r2, #0]
@   0x0801dfda: 3240        adds	r2, #64	@ 0x40
@   0x0801dfdc: 3102        adds	r1, #2
@   0x0801dfde: 0049        lsls	r1, r1, #1
@   0x0801dfe0: 18c9        adds	r1, r1, r3
@   0x0801dfe2: 8808        ldrh	r0, [r1, #0]
@   0x0801dfe4: 8010        strh	r0, [r2, #0]
@   0x0801dfe6: 4650        mov	r0, sl
@   0x0801dfe8: 3004        adds	r0, #4
@   0x0801dfea: 0600        lsls	r0, r0, #24
@   0x0801dfec: 0e00        lsrs	r0, r0, #24
@   0x0801dfee: 4682        mov	sl, r0
@   0x0801dff0: e024        b.n	0x1e03c
@   0x0801dff2: 0000        movs	r0, r0
@   0x0801dff4: ee64        081b 	mcr	8, 3, r0, cr4, cr11, {0}
@   0x0801dff8: 2a20        cmp	r2, #32
@   0x0801dffa: d107        bne.n	0x1e00c
@   0x0801dffc: 01b8        lsls	r0, r7, #6
@   0x0801dffe: 0071        lsls	r1, r6, #1
@   0x0801e000: 4441        add	r1, r8
@   0x0801e002: 1840        adds	r0, r0, r1
@   0x0801e004: 2100        movs	r1, #0
@   0x0801e006: 8001        strh	r1, [r0, #0]
@   0x0801e008: 3040        adds	r0, #64	@ 0x40
@   0x0801e00a: e016        b.n	0x1e03a
@   0x0801e00c: 2a2a        cmp	r2, #42	@ 0x2a
@   0x0801e00e: d10a        bne.n	0x1e026
@   0x0801e010: 01b9        lsls	r1, r7, #6
@   0x0801e012: 0070        lsls	r0, r6, #1
@   0x0801e014: 4440        add	r0, r8
@   0x0801e016: 1809        adds	r1, r1, r0
@   0x0801e018: 1c28        adds	r0, r5, #0
@   0x0801e01a: 3024        adds	r0, #36	@ 0x24
@   0x0801e01c: 8008        strh	r0, [r1, #0]
@   0x0801e01e: 3140        adds	r1, #64	@ 0x40
@   0x0801e020: 381b        subs	r0, #27
@   0x0801e022: 8008        strh	r0, [r1, #0]
@   0x0801e024: e00a        b.n	0x1e03c
@   0x0801e026: 2a7e        cmp	r2, #126	@ 0x7e
@   0x0801e028: d108        bne.n	0x1e03c
@   0x0801e02a: 01b8        lsls	r0, r7, #6
@   0x0801e02c: 0071        lsls	r1, r6, #1
@   0x0801e02e: 4441        add	r1, r8
@   0x0801e030: 1840        adds	r0, r0, r1
@   0x0801e032: 22c9        movs	r2, #201	@ 0xc9
@   0x0801e034: 0052        lsls	r2, r2, #1
@   0x0801e036: 1c11        adds	r1, r2, #0
@   0x0801e038: 1869        adds	r1, r5, r1
@   0x0801e03a: 8001        strh	r1, [r0, #0]
@   0x0801e03c: 2e1e        cmp	r6, #30
@   0x0801e03e: d906        bls.n	0x1e04e
@   0x0801e040: 2f1e        cmp	r7, #30
@   0x0801e042: d810        bhi.n	0x1e066
@   0x0801e044: 2600        movs	r6, #0
@   0x0801e046: 1c78        adds	r0, r7, #1
@   0x0801e048: 0600        lsls	r0, r0, #24
@   0x0801e04a: 0e07        lsrs	r7, r0, #24
@   0x0801e04c: e002        b.n	0x1e054
@   0x0801e04e: 1c70        adds	r0, r6, #1
@   0x0801e050: 0600        lsls	r0, r0, #24
@   0x0801e052: 0e06        lsrs	r6, r0, #24
@   0x0801e054: 4650        mov	r0, sl
@   0x0801e056: 3001        adds	r0, #1
@   0x0801e058: 0600        lsls	r0, r0, #24
@   0x0801e05a: 0e00        lsrs	r0, r0, #24
@   0x0801e05c: 4682        mov	sl, r0
@   0x0801e05e: 9801        ldr	r0, [sp, #4]
@   0x0801e060: 4582        cmp	sl, r0
@   0x0801e062: d200        bcs.n	0x1e066
@   0x0801e064: e75b        b.n	0x1df1e
@   0x0801e066: b005        add	sp, #20
@   0x0801e068: bc38        pop	{r3, r4, r5}
@   0x0801e06a: 4698        mov	r8, r3
@   0x0801e06c: 46a1        mov	r9, r4
@   0x0801e06e: 46aa        mov	sl, r5
@   0x0801e070: bcf0        pop	{r4, r5, r6, r7}
@   0x0801e072: bc01        pop	{r0}
@   0x0801e074: 4700        bx	r0

        thumb_func_start sub_0801DEA0
sub_0801DEA0: @ 0x0801dea0
        .incbin "frog_us_baserom.gba", 0x1dea0, 0x1d8
        thumb_func_end sub_0801DEA0
