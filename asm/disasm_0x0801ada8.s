@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801ada8, 0x0801b0ac)  (772 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801ada8 --end 0x801b0ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801ada8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801adaa: 464f        mov	r7, r9
@   0x0801adac: 4646        mov	r6, r8
@   0x0801adae: b4c0        push	{r6, r7}
@   0x0801adb0: b082        sub	sp, #8
@   0x0801adb2: 0600        lsls	r0, r0, #24
@   0x0801adb4: 0e00        lsrs	r0, r0, #24
@   0x0801adb6: 4680        mov	r8, r0
@   0x0801adb8: 4816        ldr	r0, [pc, #88]	@ (0x1ae14)
@   0x0801adba: 68c2        ldr	r2, [r0, #12]
@   0x0801adbc: 4916        ldr	r1, [pc, #88]	@ (0x1ae18)
@   0x0801adbe: 1c05        adds	r5, r0, #0
@   0x0801adc0: 4816        ldr	r0, [pc, #88]	@ (0x1ae1c)
@   0x0801adc2: 4681        mov	r9, r0
@   0x0801adc4: 8812        ldrh	r2, [r2, #0]
@   0x0801adc6: 428a        cmp	r2, r1
@   0x0801adc8: d100        bne.n	0x1adcc
@   0x0801adca: e0cf        b.n	0x1af6c
@   0x0801adcc: 1c2e        adds	r6, r5, #0
@   0x0801adce: 464f        mov	r7, r9
@   0x0801add0: 4913        ldr	r1, [pc, #76]	@ (0x1ae20)
@   0x0801add2: 468c        mov	ip, r1
@   0x0801add4: 68f5        ldr	r5, [r6, #12]
@   0x0801add6: 8829        ldrh	r1, [r5, #0]
@   0x0801add8: 4812        ldr	r0, [pc, #72]	@ (0x1ae24)
@   0x0801adda: 4281        cmp	r1, r0
@   0x0801addc: d13d        bne.n	0x1ae5a
@   0x0801adde: 2600        movs	r6, #0
@   0x0801ade0: 2400        movs	r4, #0
@   0x0801ade2: 464b        mov	r3, r9
@   0x0801ade4: 8818        ldrh	r0, [r3, #0]
@   0x0801ade6: 2810        cmp	r0, #16
@   0x0801ade8: d100        bne.n	0x1adec
@   0x0801adea: e149        b.n	0x1b080
@   0x0801adec: 2820        cmp	r0, #32
@   0x0801adee: d100        bne.n	0x1adf2
@   0x0801adf0: e146        b.n	0x1b080
@   0x0801adf2: 4a0d        ldr	r2, [pc, #52]	@ (0x1ae28)
@   0x0801adf4: 4d07        ldr	r5, [pc, #28]	@ (0x1ae14)
@   0x0801adf6: 4809        ldr	r0, [pc, #36]	@ (0x1ae1c)
@   0x0801adf8: 4681        mov	r9, r0
@   0x0801adfa: 480b        ldr	r0, [pc, #44]	@ (0x1ae28)
@   0x0801adfc: 6800        ldr	r0, [r0, #0]
@   0x0801adfe: 1b80        subs	r0, r0, r6
@   0x0801ae00: 2803        cmp	r0, #3
@   0x0801ae02: d923        bls.n	0x1ae4c
@   0x0801ae04: 2c00        cmp	r4, #0
@   0x0801ae06: d013        beq.n	0x1ae30
@   0x0801ae08: 6968        ldr	r0, [r5, #20]
@   0x0801ae0a: 306c        adds	r0, #108	@ 0x6c
@   0x0801ae0c: 4b07        ldr	r3, [pc, #28]	@ (0x1ae2c)
@   0x0801ae0e: 1c19        adds	r1, r3, #0
@   0x0801ae10: 8001        strh	r1, [r0, #0]
@   0x0801ae12: e010        b.n	0x1ae36
@   0x0801ae14: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801ae16: 0300        lsls	r0, r0, #12
@   0x0801ae18: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0801ae1c: 5398        strh	r0, [r3, r6]
@   0x0801ae1e: 0300        lsls	r0, r0, #12
@   0x0801ae20: ee64        081b 	mcr	8, 3, r0, cr4, cr11, {0}
@   0x0801ae24: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x0801ae28: 5330        strh	r0, [r6, r4]
@   0x0801ae2a: 0300        lsls	r0, r0, #12
@   0x0801ae2c: e0e4        b.n	0x1aff8
@   0x0801ae2e: 0000        movs	r0, r0
@   0x0801ae30: 6968        ldr	r0, [r5, #20]
@   0x0801ae32: 306c        adds	r0, #108	@ 0x6c
@   0x0801ae34: 8004        strh	r4, [r0, #0]
@   0x0801ae36: 2000        movs	r0, #0
@   0x0801ae38: 2c00        cmp	r4, #0
@   0x0801ae3a: d100        bne.n	0x1ae3e
@   0x0801ae3c: 2001        movs	r0, #1
@   0x0801ae3e: 1c04        adds	r4, r0, #0
@   0x0801ae40: 6816        ldr	r6, [r2, #0]
@   0x0801ae42: 9201        str	r2, [sp, #4]
@   0x0801ae44: f7e5        fb3e 	bl	0x4c4
@   0x0801ae48: 8038        strh	r0, [r7, #0]
@   0x0801ae4a: 9a01        ldr	r2, [sp, #4]
@   0x0801ae4c: 8838        ldrh	r0, [r7, #0]
@   0x0801ae4e: 2810        cmp	r0, #16
@   0x0801ae50: d100        bne.n	0x1ae54
@   0x0801ae52: e115        b.n	0x1b080
@   0x0801ae54: 2820        cmp	r0, #32
@   0x0801ae56: d1d0        bne.n	0x1adfa
@   0x0801ae58: e112        b.n	0x1b080
@   0x0801ae5a: 480b        ldr	r0, [pc, #44]	@ (0x1ae88)
@   0x0801ae5c: 4281        cmp	r1, r0
@   0x0801ae5e: d143        bne.n	0x1aee8
@   0x0801ae60: 2600        movs	r6, #0
@   0x0801ae62: 803e        strh	r6, [r7, #0]
@   0x0801ae64: 2400        movs	r4, #0
@   0x0801ae66: 4a09        ldr	r2, [pc, #36]	@ (0x1ae8c)
@   0x0801ae68: 4d09        ldr	r5, [pc, #36]	@ (0x1ae90)
@   0x0801ae6a: 480a        ldr	r0, [pc, #40]	@ (0x1ae94)
@   0x0801ae6c: 4681        mov	r9, r0
@   0x0801ae6e: 4807        ldr	r0, [pc, #28]	@ (0x1ae8c)
@   0x0801ae70: 6800        ldr	r0, [r0, #0]
@   0x0801ae72: 1b80        subs	r0, r0, r6
@   0x0801ae74: 2803        cmp	r0, #3
@   0x0801ae76: d91f        bls.n	0x1aeb8
@   0x0801ae78: 2c00        cmp	r4, #0
@   0x0801ae7a: d00f        beq.n	0x1ae9c
@   0x0801ae7c: 6968        ldr	r0, [r5, #20]
@   0x0801ae7e: 306c        adds	r0, #108	@ 0x6c
@   0x0801ae80: 4b05        ldr	r3, [pc, #20]	@ (0x1ae98)
@   0x0801ae82: 1c19        adds	r1, r3, #0
@   0x0801ae84: 8001        strh	r1, [r0, #0]
@   0x0801ae86: e00c        b.n	0x1aea2
@   0x0801ae88: fffc        0000 	vrev64.<illegal width 64>	d16, d0
@   0x0801ae8c: 5330        strh	r0, [r6, r4]
@   0x0801ae8e: 0300        lsls	r0, r0, #12
@   0x0801ae90: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801ae92: 0300        lsls	r0, r0, #12
@   0x0801ae94: 5398        strh	r0, [r3, r6]
@   0x0801ae96: 0300        lsls	r0, r0, #12
@   0x0801ae98: e0e4        b.n	0x1b064
@   0x0801ae9a: 0000        movs	r0, r0
@   0x0801ae9c: 6968        ldr	r0, [r5, #20]
@   0x0801ae9e: 306c        adds	r0, #108	@ 0x6c
@   0x0801aea0: 8004        strh	r4, [r0, #0]
@   0x0801aea2: 2000        movs	r0, #0
@   0x0801aea4: 2c00        cmp	r4, #0
@   0x0801aea6: d100        bne.n	0x1aeaa
@   0x0801aea8: 2001        movs	r0, #1
@   0x0801aeaa: 1c04        adds	r4, r0, #0
@   0x0801aeac: 6816        ldr	r6, [r2, #0]
@   0x0801aeae: 9201        str	r2, [sp, #4]
@   0x0801aeb0: f7e5        fb08 	bl	0x4c4
@   0x0801aeb4: 8038        strh	r0, [r7, #0]
@   0x0801aeb6: 9a01        ldr	r2, [sp, #4]
@   0x0801aeb8: 8838        ldrh	r0, [r7, #0]
@   0x0801aeba: 2810        cmp	r0, #16
@   0x0801aebc: d001        beq.n	0x1aec2
@   0x0801aebe: 2820        cmp	r0, #32
@   0x0801aec0: d1d5        bne.n	0x1ae6e
@   0x0801aec2: 2820        cmp	r0, #32
@   0x0801aec4: d100        bne.n	0x1aec8
@   0x0801aec6: e0db        b.n	0x1b080
@   0x0801aec8: 4906        ldr	r1, [pc, #24]	@ (0x1aee4)
@   0x0801aeca: 6848        ldr	r0, [r1, #4]
@   0x0801aecc: 2800        cmp	r0, #0
@   0x0801aece: d163        bne.n	0x1af98
@   0x0801aed0: 2001        movs	r0, #1
@   0x0801aed2: 6048        str	r0, [r1, #4]
@   0x0801aed4: 7848        ldrb	r0, [r1, #1]
@   0x0801aed6: 3001        adds	r0, #1
@   0x0801aed8: 7048        strb	r0, [r1, #1]
@   0x0801aeda: 4640        mov	r0, r8
@   0x0801aedc: f7ff        fed2 	bl	0x1ac84
@   0x0801aee0: e03a        b.n	0x1af58
@   0x0801aee2: 0000        movs	r0, r0
@   0x0801aee4: 3540        adds	r5, #64	@ 0x40
@   0x0801aee6: 0300        lsls	r0, r0, #12
@   0x0801aee8: 4808        ldr	r0, [pc, #32]	@ (0x1af0c)
@   0x0801aeea: 4281        cmp	r1, r0
@   0x0801aeec: d010        beq.n	0x1af10
@   0x0801aeee: 6972        ldr	r2, [r6, #20]
@   0x0801aef0: 8e31        ldrh	r1, [r6, #48]	@ 0x30
@   0x0801aef2: 0048        lsls	r0, r1, #1
@   0x0801aef4: 1880        adds	r0, r0, r2
@   0x0801aef6: 2100        movs	r1, #0
@   0x0801aef8: 8001        strh	r1, [r0, #0]
@   0x0801aefa: 8e33        ldrh	r3, [r6, #48]	@ 0x30
@   0x0801aefc: 0058        lsls	r0, r3, #1
@   0x0801aefe: 1880        adds	r0, r0, r2
@   0x0801af00: 3040        adds	r0, #64	@ 0x40
@   0x0801af02: 8829        ldrh	r1, [r5, #0]
@   0x0801af04: 8001        strh	r1, [r0, #0]
@   0x0801af06: 1ca8        adds	r0, r5, #2
@   0x0801af08: 60f0        str	r0, [r6, #12]
@   0x0801af0a: e01c        b.n	0x1af46
@   0x0801af0c: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x0801af10: 1cab        adds	r3, r5, #2
@   0x0801af12: 60f3        str	r3, [r6, #12]
@   0x0801af14: 6974        ldr	r4, [r6, #20]
@   0x0801af16: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0801af18: 0042        lsls	r2, r0, #1
@   0x0801af1a: 1912        adds	r2, r2, r4
@   0x0801af1c: 886d        ldrh	r5, [r5, #2]
@   0x0801af1e: 491a        ldr	r1, [pc, #104]	@ (0x1af88)
@   0x0801af20: 1868        adds	r0, r5, r1
@   0x0801af22: 0041        lsls	r1, r0, #1
@   0x0801af24: 1809        adds	r1, r1, r0
@   0x0801af26: 1c48        adds	r0, r1, #1
@   0x0801af28: 0040        lsls	r0, r0, #1
@   0x0801af2a: 4460        add	r0, ip
@   0x0801af2c: 8800        ldrh	r0, [r0, #0]
@   0x0801af2e: 8010        strh	r0, [r2, #0]
@   0x0801af30: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0801af32: 0042        lsls	r2, r0, #1
@   0x0801af34: 1912        adds	r2, r2, r4
@   0x0801af36: 3240        adds	r2, #64	@ 0x40
@   0x0801af38: 3102        adds	r1, #2
@   0x0801af3a: 0049        lsls	r1, r1, #1
@   0x0801af3c: 4461        add	r1, ip
@   0x0801af3e: 8808        ldrh	r0, [r1, #0]
@   0x0801af40: 8010        strh	r0, [r2, #0]
@   0x0801af42: 3302        adds	r3, #2
@   0x0801af44: 60f3        str	r3, [r6, #12]
@   0x0801af46: 8e30        ldrh	r0, [r6, #48]	@ 0x30
@   0x0801af48: 3001        adds	r0, #1
@   0x0801af4a: 8630        strh	r0, [r6, #48]	@ 0x30
@   0x0801af4c: 68f1        ldr	r1, [r6, #12]
@   0x0801af4e: 480f        ldr	r0, [pc, #60]	@ (0x1af8c)
@   0x0801af50: 8809        ldrh	r1, [r1, #0]
@   0x0801af52: 4281        cmp	r1, r0
@   0x0801af54: d000        beq.n	0x1af58
@   0x0801af56: e73d        b.n	0x1add4
@   0x0801af58: 480d        ldr	r0, [pc, #52]	@ (0x1af90)
@   0x0801af5a: 68c2        ldr	r2, [r0, #12]
@   0x0801af5c: 490b        ldr	r1, [pc, #44]	@ (0x1af8c)
@   0x0801af5e: 1c05        adds	r5, r0, #0
@   0x0801af60: 4b0c        ldr	r3, [pc, #48]	@ (0x1af94)
@   0x0801af62: 4699        mov	r9, r3
@   0x0801af64: 8812        ldrh	r2, [r2, #0]
@   0x0801af66: 428a        cmp	r2, r1
@   0x0801af68: d000        beq.n	0x1af6c
@   0x0801af6a: e07c        b.n	0x1b066
@   0x0801af6c: 2000        movs	r0, #0
@   0x0801af6e: 8628        strh	r0, [r5, #48]	@ 0x30
@   0x0801af70: 8e68        ldrh	r0, [r5, #50]	@ 0x32
@   0x0801af72: 2800        cmp	r0, #0
@   0x0801af74: d119        bne.n	0x1afaa
@   0x0801af76: 2001        movs	r0, #1
@   0x0801af78: 8668        strh	r0, [r5, #50]	@ 0x32
@   0x0801af7a: 6a6e        ldr	r6, [r5, #36]	@ 0x24
@   0x0801af7c: 6968        ldr	r0, [r5, #20]
@   0x0801af7e: 6268        str	r0, [r5, #36]	@ 0x24
@   0x0801af80: 616e        str	r6, [r5, #20]
@   0x0801af82: 4804        ldr	r0, [pc, #16]	@ (0x1af94)
@   0x0801af84: 4681        mov	r9, r0
@   0x0801af86: e06b        b.n	0x1b060
@   0x0801af88: 1f19        subs	r1, r3, #4
@   0x0801af8a: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801af8e: 0000        movs	r0, r0
@   0x0801af90: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801af92: 0300        lsls	r0, r0, #12
@   0x0801af94: 5398        strh	r0, [r3, r6]
@   0x0801af96: 0300        lsls	r0, r0, #12
@   0x0801af98: 2000        movs	r0, #0
@   0x0801af9a: 6048        str	r0, [r1, #4]
@   0x0801af9c: 7848        ldrb	r0, [r1, #1]
@   0x0801af9e: 3001        adds	r0, #1
@   0x0801afa0: 7048        strb	r0, [r1, #1]
@   0x0801afa2: 4640        mov	r0, r8
@   0x0801afa4: f7ff        feb4 	bl	0x1ad10
@   0x0801afa8: e7d6        b.n	0x1af58
@   0x0801afaa: 2600        movs	r6, #0
@   0x0801afac: 2400        movs	r4, #0
@   0x0801afae: 480b        ldr	r0, [pc, #44]	@ (0x1afdc)
@   0x0801afb0: 8801        ldrh	r1, [r0, #0]
@   0x0801afb2: 4681        mov	r9, r0
@   0x0801afb4: 2910        cmp	r1, #16
@   0x0801afb6: d02e        beq.n	0x1b016
@   0x0801afb8: 2920        cmp	r1, #32
@   0x0801afba: d02c        beq.n	0x1b016
@   0x0801afbc: 4a08        ldr	r2, [pc, #32]	@ (0x1afe0)
@   0x0801afbe: 464f        mov	r7, r9
@   0x0801afc0: 4807        ldr	r0, [pc, #28]	@ (0x1afe0)
@   0x0801afc2: 6800        ldr	r0, [r0, #0]
@   0x0801afc4: 1b80        subs	r0, r0, r6
@   0x0801afc6: 2803        cmp	r0, #3
@   0x0801afc8: d91c        bls.n	0x1b004
@   0x0801afca: 2c00        cmp	r4, #0
@   0x0801afcc: d00c        beq.n	0x1afe8
@   0x0801afce: 6968        ldr	r0, [r5, #20]
@   0x0801afd0: 306c        adds	r0, #108	@ 0x6c
@   0x0801afd2: 4b04        ldr	r3, [pc, #16]	@ (0x1afe4)
@   0x0801afd4: 1c19        adds	r1, r3, #0
@   0x0801afd6: 8001        strh	r1, [r0, #0]
@   0x0801afd8: e009        b.n	0x1afee
@   0x0801afda: 0000        movs	r0, r0
@   0x0801afdc: 5398        strh	r0, [r3, r6]
@   0x0801afde: 0300        lsls	r0, r0, #12
@   0x0801afe0: 5330        strh	r0, [r6, r4]
@   0x0801afe2: 0300        lsls	r0, r0, #12
@   0x0801afe4: e0e4        b.n	0x1b1b0
@   0x0801afe6: 0000        movs	r0, r0
@   0x0801afe8: 6968        ldr	r0, [r5, #20]
@   0x0801afea: 306c        adds	r0, #108	@ 0x6c
@   0x0801afec: 8004        strh	r4, [r0, #0]
@   0x0801afee: 2000        movs	r0, #0
@   0x0801aff0: 2c00        cmp	r4, #0
@   0x0801aff2: d100        bne.n	0x1aff6
@   0x0801aff4: 2001        movs	r0, #1
@   0x0801aff6: 1c04        adds	r4, r0, #0
@   0x0801aff8: 6816        ldr	r6, [r2, #0]
@   0x0801affa: 9201        str	r2, [sp, #4]
@   0x0801affc: f7e5        fa62 	bl	0x4c4
@   0x0801b000: 8038        strh	r0, [r7, #0]
@   0x0801b002: 9a01        ldr	r2, [sp, #4]
@   0x0801b004: 8838        ldrh	r0, [r7, #0]
@   0x0801b006: 491a        ldr	r1, [pc, #104]	@ (0x1b070)
@   0x0801b008: 4689        mov	r9, r1
@   0x0801b00a: 2820        cmp	r0, #32
@   0x0801b00c: d038        beq.n	0x1b080
@   0x0801b00e: 2810        cmp	r0, #16
@   0x0801b010: d001        beq.n	0x1b016
@   0x0801b012: 2820        cmp	r0, #32
@   0x0801b014: d1d4        bne.n	0x1afc0
@   0x0801b016: 4d17        ldr	r5, [pc, #92]	@ (0x1b074)
@   0x0801b018: 2400        movs	r4, #0
@   0x0801b01a: 866c        strh	r4, [r5, #50]	@ 0x32
@   0x0801b01c: 6a6e        ldr	r6, [r5, #36]	@ 0x24
@   0x0801b01e: 696a        ldr	r2, [r5, #20]
@   0x0801b020: 626a        str	r2, [r5, #36]	@ 0x24
@   0x0801b022: 616e        str	r6, [r5, #20]
@   0x0801b024: 4668        mov	r0, sp
@   0x0801b026: 8004        strh	r4, [r0, #0]
@   0x0801b028: 4813        ldr	r0, [pc, #76]	@ (0x1b078)
@   0x0801b02a: 466b        mov	r3, sp
@   0x0801b02c: 6003        str	r3, [r0, #0]
@   0x0801b02e: 6042        str	r2, [r0, #4]
@   0x0801b030: 4b12        ldr	r3, [pc, #72]	@ (0x1b07c)
@   0x0801b032: 6083        str	r3, [r0, #8]
@   0x0801b034: 6881        ldr	r1, [r0, #8]
@   0x0801b036: 4669        mov	r1, sp
@   0x0801b038: 800c        strh	r4, [r1, #0]
@   0x0801b03a: 6001        str	r1, [r0, #0]
@   0x0801b03c: 3240        adds	r2, #64	@ 0x40
@   0x0801b03e: 6042        str	r2, [r0, #4]
@   0x0801b040: 6083        str	r3, [r0, #8]
@   0x0801b042: 6881        ldr	r1, [r0, #8]
@   0x0801b044: 4669        mov	r1, sp
@   0x0801b046: 800c        strh	r4, [r1, #0]
@   0x0801b048: 6001        str	r1, [r0, #0]
@   0x0801b04a: 6046        str	r6, [r0, #4]
@   0x0801b04c: 6083        str	r3, [r0, #8]
@   0x0801b04e: 6881        ldr	r1, [r0, #8]
@   0x0801b050: 4669        mov	r1, sp
@   0x0801b052: 800c        strh	r4, [r1, #0]
@   0x0801b054: 6001        str	r1, [r0, #0]
@   0x0801b056: 1c31        adds	r1, r6, #0
@   0x0801b058: 3140        adds	r1, #64	@ 0x40
@   0x0801b05a: 6041        str	r1, [r0, #4]
@   0x0801b05c: 6083        str	r3, [r0, #8]
@   0x0801b05e: 6880        ldr	r0, [r0, #8]
@   0x0801b060: 68e8        ldr	r0, [r5, #12]
@   0x0801b062: 3002        adds	r0, #2
@   0x0801b064: 60e8        str	r0, [r5, #12]
@   0x0801b066: 2000        movs	r0, #0
@   0x0801b068: 4649        mov	r1, r9
@   0x0801b06a: 8008        strh	r0, [r1, #0]
@   0x0801b06c: 2000        movs	r0, #0
@   0x0801b06e: e00b        b.n	0x1b088
@   0x0801b070: 5398        strh	r0, [r3, r6]
@   0x0801b072: 0300        lsls	r0, r0, #12
@   0x0801b074: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801b076: 0300        lsls	r0, r0, #12
@   0x0801b078: 00d4        lsls	r4, r2, #3
@   0x0801b07a: 0400        lsls	r0, r0, #16
@   0x0801b07c: 0017        movs	r7, r2
@   0x0801b07e: 8100        strh	r0, [r0, #8]
@   0x0801b080: 2000        movs	r0, #0
@   0x0801b082: 464b        mov	r3, r9
@   0x0801b084: 8018        strh	r0, [r3, #0]
@   0x0801b086: 20fe        movs	r0, #254	@ 0xfe
@   0x0801b088: b002        add	sp, #8
@   0x0801b08a: bc18        pop	{r3, r4}
@   0x0801b08c: 4698        mov	r8, r3
@   0x0801b08e: 46a1        mov	r9, r4
@   0x0801b090: bcf0        pop	{r4, r5, r6, r7}
@   0x0801b092: bc02        pop	{r1}
@   0x0801b094: 4708        bx	r1
@   0x0801b096: 0000        movs	r0, r0
@   0x0801b098: 0600        lsls	r0, r0, #24
@   0x0801b09a: 2180        movs	r1, #128	@ 0x80
@   0x0801b09c: 0509        lsls	r1, r1, #20
@   0x0801b09e: 1840        adds	r0, r0, r1
@   0x0801b0a0: 0e00        lsrs	r0, r0, #24
@   0x0801b0a2: 4901        ldr	r1, [pc, #4]	@ (0x1b0a8)
@   0x0801b0a4: 7248        strb	r0, [r1, #9]
@   0x0801b0a6: 4770        bx	lr
@   0x0801b0a8: 5330        strh	r0, [r6, r4]
@   0x0801b0aa: 0300        lsls	r0, r0, #12

        thumb_func_start Credits_RunScript
Credits_RunScript: @ 0x0801ada8
        .incbin "frog_us_baserom.gba", 0x1ada8, 0x304
        thumb_func_end Credits_RunScript
