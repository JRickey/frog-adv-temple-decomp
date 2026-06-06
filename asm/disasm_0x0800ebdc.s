@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ebdc, 0x0800ee34)  (600 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ebdc --end 0x800ee34 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ebdc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800ebde: 4657        mov	r7, sl
@   0x0800ebe0: 464e        mov	r6, r9
@   0x0800ebe2: 4645        mov	r5, r8
@   0x0800ebe4: b4e0        push	{r5, r6, r7}
@   0x0800ebe6: b082        sub	sp, #8
@   0x0800ebe8: 0600        lsls	r0, r0, #24
@   0x0800ebea: 0e00        lsrs	r0, r0, #24
@   0x0800ebec: 9000        str	r0, [sp, #0]
@   0x0800ebee: 2000        movs	r0, #0
@   0x0800ebf0: 4681        mov	r9, r0
@   0x0800ebf2: 9900        ldr	r1, [sp, #0]
@   0x0800ebf4: 4589        cmp	r9, r1
@   0x0800ebf6: d300        bcc.n	0xebfa
@   0x0800ebf8: e0f3        b.n	0xede2
@   0x0800ebfa: 4a35        ldr	r2, [pc, #212]	@ (0xecd0)
@   0x0800ebfc: 4694        mov	ip, r2
@   0x0800ebfe: 464f        mov	r7, r9
@   0x0800ec00: 017b        lsls	r3, r7, #5
@   0x0800ec02: 4661        mov	r1, ip
@   0x0800ec04: 3104        adds	r1, #4
@   0x0800ec06: 1859        adds	r1, r3, r1
@   0x0800ec08: 4a32        ldr	r2, [pc, #200]	@ (0xecd4)
@   0x0800ec0a: 1898        adds	r0, r3, r2
@   0x0800ec0c: 6800        ldr	r0, [r0, #0]
@   0x0800ec0e: 6008        str	r0, [r1, #0]
@   0x0800ec10: 4662        mov	r2, ip
@   0x0800ec12: 3208        adds	r2, #8
@   0x0800ec14: 189a        adds	r2, r3, r2
@   0x0800ec16: 4661        mov	r1, ip
@   0x0800ec18: 3110        adds	r1, #16
@   0x0800ec1a: 1859        adds	r1, r3, r1
@   0x0800ec1c: 6808        ldr	r0, [r1, #0]
@   0x0800ec1e: 6010        str	r0, [r2, #0]
@   0x0800ec20: 2700        movs	r7, #0
@   0x0800ec22: 2000        movs	r0, #0
@   0x0800ec24: 4682        mov	sl, r0
@   0x0800ec26: 6809        ldr	r1, [r1, #0]
@   0x0800ec28: 1c1d        adds	r5, r3, #0
@   0x0800ec2a: 292f        cmp	r1, #47	@ 0x2f
@   0x0800ec2c: dd0e        ble.n	0xec4c
@   0x0800ec2e: 4662        mov	r2, ip
@   0x0800ec30: 18a8        adds	r0, r5, r2
@   0x0800ec32: 8b00        ldrh	r0, [r0, #24]
@   0x0800ec34: 00c0        lsls	r0, r0, #3
@   0x0800ec36: 38d0        subs	r0, #208	@ 0xd0
@   0x0800ec38: 4281        cmp	r1, r0
@   0x0800ec3a: dc07        bgt.n	0xec4c
@   0x0800ec3c: 1c08        adds	r0, r1, #0
@   0x0800ec3e: 3830        subs	r0, #48	@ 0x30
@   0x0800ec40: 2800        cmp	r0, #0
@   0x0800ec42: da00        bge.n	0xec46
@   0x0800ec44: 3007        adds	r0, #7
@   0x0800ec46: 0340        lsls	r0, r0, #13
@   0x0800ec48: 0c00        lsrs	r0, r0, #16
@   0x0800ec4a: 4682        mov	sl, r0
@   0x0800ec4c: 4660        mov	r0, ip
@   0x0800ec4e: 182a        adds	r2, r5, r0
@   0x0800ec50: 4661        mov	r1, ip
@   0x0800ec52: 3110        adds	r1, #16
@   0x0800ec54: 1869        adds	r1, r5, r1
@   0x0800ec56: 6808        ldr	r0, [r1, #0]
@   0x0800ec58: 82d0        strh	r0, [r2, #22]
@   0x0800ec5a: 8b12        ldrh	r2, [r2, #24]
@   0x0800ec5c: 00d0        lsls	r0, r2, #3
@   0x0800ec5e: 38d0        subs	r0, #208	@ 0xd0
@   0x0800ec60: 6809        ldr	r1, [r1, #0]
@   0x0800ec62: 4281        cmp	r1, r0
@   0x0800ec64: dd06        ble.n	0xec74
@   0x0800ec66: 2a1f        cmp	r2, #31
@   0x0800ec68: d904        bls.n	0xec74
@   0x0800ec6a: 1c10        adds	r0, r2, #0
@   0x0800ec6c: 3820        subs	r0, #32
@   0x0800ec6e: 0400        lsls	r0, r0, #16
@   0x0800ec70: 0c00        lsrs	r0, r0, #16
@   0x0800ec72: 4682        mov	sl, r0
@   0x0800ec74: 4917        ldr	r1, [pc, #92]	@ (0xecd4)
@   0x0800ec76: 1868        adds	r0, r5, r1
@   0x0800ec78: 6801        ldr	r1, [r0, #0]
@   0x0800ec7a: 2907        cmp	r1, #7
@   0x0800ec7c: dd0d        ble.n	0xec9a
@   0x0800ec7e: 4a14        ldr	r2, [pc, #80]	@ (0xecd0)
@   0x0800ec80: 18a8        adds	r0, r5, r2
@   0x0800ec82: 8b40        ldrh	r0, [r0, #26]
@   0x0800ec84: 00c0        lsls	r0, r0, #3
@   0x0800ec86: 38f8        subs	r0, #248	@ 0xf8
@   0x0800ec88: 4281        cmp	r1, r0
@   0x0800ec8a: dc06        bgt.n	0xec9a
@   0x0800ec8c: 1c08        adds	r0, r1, #0
@   0x0800ec8e: 3808        subs	r0, #8
@   0x0800ec90: 2800        cmp	r0, #0
@   0x0800ec92: da00        bge.n	0xec96
@   0x0800ec94: 1e48        subs	r0, r1, #1
@   0x0800ec96: 0340        lsls	r0, r0, #13
@   0x0800ec98: 0c07        lsrs	r7, r0, #16
@   0x0800ec9a: 4660        mov	r0, ip
@   0x0800ec9c: 1829        adds	r1, r5, r0
@   0x0800ec9e: 480d        ldr	r0, [pc, #52]	@ (0xecd4)
@   0x0800eca0: 182a        adds	r2, r5, r0
@   0x0800eca2: 6810        ldr	r0, [r2, #0]
@   0x0800eca4: 8288        strh	r0, [r1, #20]
@   0x0800eca6: 8b4b        ldrh	r3, [r1, #26]
@   0x0800eca8: 00d8        lsls	r0, r3, #3
@   0x0800ecaa: 38f8        subs	r0, #248	@ 0xf8
@   0x0800ecac: 6811        ldr	r1, [r2, #0]
@   0x0800ecae: 4281        cmp	r1, r0
@   0x0800ecb0: dd05        ble.n	0xecbe
@   0x0800ecb2: 2b1f        cmp	r3, #31
@   0x0800ecb4: d903        bls.n	0xecbe
@   0x0800ecb6: 1c18        adds	r0, r3, #0
@   0x0800ecb8: 3820        subs	r0, #32
@   0x0800ecba: 0400        lsls	r0, r0, #16
@   0x0800ecbc: 0c07        lsrs	r7, r0, #16
@   0x0800ecbe: 4649        mov	r1, r9
@   0x0800ecc0: 2901        cmp	r1, #1
@   0x0800ecc2: d01d        beq.n	0xed00
@   0x0800ecc4: 2901        cmp	r1, #1
@   0x0800ecc6: dc07        bgt.n	0xecd8
@   0x0800ecc8: 2900        cmp	r1, #0
@   0x0800ecca: d009        beq.n	0xece0
@   0x0800eccc: e033        b.n	0xed36
@   0x0800ecce: 0000        movs	r0, r0
@   0x0800ecd0: 60a0        str	r0, [r4, #8]
@   0x0800ecd2: 0300        lsls	r0, r0, #12
@   0x0800ecd4: 60ac        str	r4, [r5, #8]
@   0x0800ecd6: 0300        lsls	r0, r0, #12
@   0x0800ecd8: 464a        mov	r2, r9
@   0x0800ecda: 2a02        cmp	r2, #2
@   0x0800ecdc: d022        beq.n	0xed24
@   0x0800ecde: e02a        b.n	0xed36
@   0x0800ece0: 2680        movs	r6, #128	@ 0x80
@   0x0800ece2: 04b6        lsls	r6, r6, #18
@   0x0800ece4: 4c04        ldr	r4, [pc, #16]	@ (0xecf8)
@   0x0800ece6: 46a0        mov	r8, r4
@   0x0800ece8: 4661        mov	r1, ip
@   0x0800ecea: 8ac8        ldrh	r0, [r1, #22]
@   0x0800ecec: 4a03        ldr	r2, [pc, #12]	@ (0xecfc)
@   0x0800ecee: 8050        strh	r0, [r2, #2]
@   0x0800ecf0: 8a88        ldrh	r0, [r1, #20]
@   0x0800ecf2: 8010        strh	r0, [r2, #0]
@   0x0800ecf4: e01f        b.n	0xed36
@   0x0800ecf6: 0000        movs	r0, r0
@   0x0800ecf8: e000        b.n	0xecfc
@   0x0800ecfa: 0600        lsls	r0, r0, #24
@   0x0800ecfc: 3550        adds	r5, #80	@ 0x50
@   0x0800ecfe: 0300        lsls	r0, r0, #12
@   0x0800ed00: 4e04        ldr	r6, [pc, #16]	@ (0xed14)
@   0x0800ed02: 4c05        ldr	r4, [pc, #20]	@ (0xed18)
@   0x0800ed04: 46a0        mov	r8, r4
@   0x0800ed06: 4905        ldr	r1, [pc, #20]	@ (0xed1c)
@   0x0800ed08: 8ac8        ldrh	r0, [r1, #22]
@   0x0800ed0a: 4a05        ldr	r2, [pc, #20]	@ (0xed20)
@   0x0800ed0c: 80d0        strh	r0, [r2, #6]
@   0x0800ed0e: 8a88        ldrh	r0, [r1, #20]
@   0x0800ed10: 8090        strh	r0, [r2, #4]
@   0x0800ed12: e010        b.n	0xed36
@   0x0800ed14: 0000        movs	r0, r0
@   0x0800ed16: 0201        lsls	r1, r0, #8
@   0x0800ed18: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0800ed1c: 60c0        str	r0, [r0, #12]
@   0x0800ed1e: 0300        lsls	r0, r0, #12
@   0x0800ed20: 3550        adds	r5, #80	@ 0x50
@   0x0800ed22: 0300        lsls	r0, r0, #12
@   0x0800ed24: 4e33        ldr	r6, [pc, #204]	@ (0xedf4)
@   0x0800ed26: 4c34        ldr	r4, [pc, #208]	@ (0xedf8)
@   0x0800ed28: 46a0        mov	r8, r4
@   0x0800ed2a: 4934        ldr	r1, [pc, #208]	@ (0xedfc)
@   0x0800ed2c: 8ac8        ldrh	r0, [r1, #22]
@   0x0800ed2e: 4a34        ldr	r2, [pc, #208]	@ (0xee00)
@   0x0800ed30: 8150        strh	r0, [r2, #10]
@   0x0800ed32: 8a88        ldrh	r0, [r1, #20]
@   0x0800ed34: 8110        strh	r0, [r2, #8]
@   0x0800ed36: 4661        mov	r1, ip
@   0x0800ed38: 1868        adds	r0, r5, r1
@   0x0800ed3a: 8b41        ldrh	r1, [r0, #26]
@   0x0800ed3c: 4652        mov	r2, sl
@   0x0800ed3e: 434a        muls	r2, r1
@   0x0800ed40: 1c10        adds	r0, r2, #0
@   0x0800ed42: 0040        lsls	r0, r0, #1
@   0x0800ed44: 1836        adds	r6, r6, r0
@   0x0800ed46: 0078        lsls	r0, r7, #1
@   0x0800ed48: 1836        adds	r6, r6, r0
@   0x0800ed4a: 201f        movs	r0, #31
@   0x0800ed4c: 4652        mov	r2, sl
@   0x0800ed4e: 4002        ands	r2, r0
@   0x0800ed50: 4007        ands	r7, r0
@   0x0800ed52: 2020        movs	r0, #32
@   0x0800ed54: 1bc0        subs	r0, r0, r7
@   0x0800ed56: 0400        lsls	r0, r0, #16
@   0x0800ed58: 0c03        lsrs	r3, r0, #16
@   0x0800ed5a: 0190        lsls	r0, r2, #6
@   0x0800ed5c: 1824        adds	r4, r4, r0
@   0x0800ed5e: 0078        lsls	r0, r7, #1
@   0x0800ed60: 1824        adds	r4, r4, r0
@   0x0800ed62: 2000        movs	r0, #0
@   0x0800ed64: 2701        movs	r7, #1
@   0x0800ed66: 444f        add	r7, r9
@   0x0800ed68: 46ba        mov	sl, r7
@   0x0800ed6a: 2180        movs	r1, #128	@ 0x80
@   0x0800ed6c: 0109        lsls	r1, r1, #4
@   0x0800ed6e: 4441        add	r1, r8
@   0x0800ed70: 9101        str	r1, [sp, #4]
@   0x0800ed72: 4a24        ldr	r2, [pc, #144]	@ (0xee04)
@   0x0800ed74: 18ad        adds	r5, r5, r2
@   0x0800ed76: 46a9        mov	r9, r5
@   0x0800ed78: 1c19        adds	r1, r3, #0
@   0x0800ed7a: 2200        movs	r2, #0
@   0x0800ed7c: 1c45        adds	r5, r0, #1
@   0x0800ed7e: 9f01        ldr	r7, [sp, #4]
@   0x0800ed80: 42bc        cmp	r4, r7
@   0x0800ed82: d306        bcc.n	0xed92
@   0x0800ed84: 4f20        ldr	r7, [pc, #128]	@ (0xee08)
@   0x0800ed86: 19e0        adds	r0, r4, r7
@   0x0800ed88: 4644        mov	r4, r8
@   0x0800ed8a: 1b00        subs	r0, r0, r4
@   0x0800ed8c: 1040        asrs	r0, r0, #1
@   0x0800ed8e: 0040        lsls	r0, r0, #1
@   0x0800ed90: 1824        adds	r4, r4, r0
@   0x0800ed92: 2900        cmp	r1, #0
@   0x0800ed94: d105        bne.n	0xeda2
@   0x0800ed96: 3c40        subs	r4, #64	@ 0x40
@   0x0800ed98: 4544        cmp	r4, r8
@   0x0800ed9a: d202        bcs.n	0xeda2
@   0x0800ed9c: 24f8        movs	r4, #248	@ 0xf8
@   0x0800ed9e: 00e4        lsls	r4, r4, #3
@   0x0800eda0: 4444        add	r4, r8
@   0x0800eda2: 8830        ldrh	r0, [r6, #0]
@   0x0800eda4: 8020        strh	r0, [r4, #0]
@   0x0800eda6: 3402        adds	r4, #2
@   0x0800eda8: 3602        adds	r6, #2
@   0x0800edaa: 1e48        subs	r0, r1, #1
@   0x0800edac: 0400        lsls	r0, r0, #16
@   0x0800edae: 0c01        lsrs	r1, r0, #16
@   0x0800edb0: 1c50        adds	r0, r2, #1
@   0x0800edb2: 0400        lsls	r0, r0, #16
@   0x0800edb4: 0c02        lsrs	r2, r0, #16
@   0x0800edb6: 2a1f        cmp	r2, #31
@   0x0800edb8: d9e1        bls.n	0xed7e
@   0x0800edba: 464f        mov	r7, r9
@   0x0800edbc: 8b7f        ldrh	r7, [r7, #26]
@   0x0800edbe: 0078        lsls	r0, r7, #1
@   0x0800edc0: 3840        subs	r0, #64	@ 0x40
@   0x0800edc2: 1836        adds	r6, r6, r0
@   0x0800edc4: 2b20        cmp	r3, #32
@   0x0800edc6: d000        beq.n	0xedca
@   0x0800edc8: 3440        adds	r4, #64	@ 0x40
@   0x0800edca: 0428        lsls	r0, r5, #16
@   0x0800edcc: 0c00        lsrs	r0, r0, #16
@   0x0800edce: 281f        cmp	r0, #31
@   0x0800edd0: d9d2        bls.n	0xed78
@   0x0800edd2: 4651        mov	r1, sl
@   0x0800edd4: 0608        lsls	r0, r1, #24
@   0x0800edd6: 0e00        lsrs	r0, r0, #24
@   0x0800edd8: 4681        mov	r9, r0
@   0x0800edda: 9a00        ldr	r2, [sp, #0]
@   0x0800eddc: 4591        cmp	r9, r2
@   0x0800edde: d200        bcs.n	0xede2
@   0x0800ede0: e70d        b.n	0xebfe
@   0x0800ede2: b002        add	sp, #8
@   0x0800ede4: bc38        pop	{r3, r4, r5}
@   0x0800ede6: 4698        mov	r8, r3
@   0x0800ede8: 46a1        mov	r9, r4
@   0x0800edea: 46aa        mov	sl, r5
@   0x0800edec: bcf0        pop	{r4, r5, r6, r7}
@   0x0800edee: bc01        pop	{r0}
@   0x0800edf0: 4700        bx	r0
@   0x0800edf2: 0000        movs	r0, r0
@   0x0800edf4: 0000        movs	r0, r0
@   0x0800edf6: 0202        lsls	r2, r0, #8
@   0x0800edf8: f000        0600 	and.w	r6, r0, #0
@   0x0800edfc: 60e0        str	r0, [r4, #12]
@   0x0800edfe: 0300        lsls	r0, r0, #12
@   0x0800ee00: 3550        adds	r5, #80	@ 0x50
@   0x0800ee02: 0300        lsls	r0, r0, #12
@   0x0800ee04: 60a0        str	r0, [r4, #8]
@   0x0800ee06: 0300        lsls	r0, r0, #12
@   0x0800ee08: f800        ffff 	strb.w	pc, [r0, #255]!
@   0x0800ee0c: b510        push	{r4, lr}
@   0x0800ee0e: 0400        lsls	r0, r0, #16
@   0x0800ee10: 0c00        lsrs	r0, r0, #16
@   0x0800ee12: 0409        lsls	r1, r1, #16
@   0x0800ee14: 0c09        lsrs	r1, r1, #16
@   0x0800ee16: 4b05        ldr	r3, [pc, #20]	@ (0xee2c)
@   0x0800ee18: 24ba        movs	r4, #186	@ 0xba
@   0x0800ee1a: 0164        lsls	r4, r4, #5
@   0x0800ee1c: 1c22        adds	r2, r4, #0
@   0x0800ee1e: 4310        orrs	r0, r2
@   0x0800ee20: 8018        strh	r0, [r3, #0]
@   0x0800ee22: 4803        ldr	r0, [pc, #12]	@ (0xee30)
@   0x0800ee24: 8001        strh	r1, [r0, #0]
@   0x0800ee26: bc10        pop	{r4}
@   0x0800ee28: bc01        pop	{r0}
@   0x0800ee2a: 4700        bx	r0
@   0x0800ee2c: 0050        lsls	r0, r2, #1
@   0x0800ee2e: 0400        lsls	r0, r0, #16
@   0x0800ee30: 0052        lsls	r2, r2, #1
@   0x0800ee32: 0400        lsls	r0, r0, #16

        thumb_func_start BgScrollBlit
BgScrollBlit: @ 0x0800ebdc
        .incbin "frog_us_baserom.gba", 0xebdc, 0x258
        thumb_func_end BgScrollBlit
