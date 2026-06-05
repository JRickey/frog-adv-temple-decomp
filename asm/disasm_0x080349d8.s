@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080349d8, 0x08034b20)  (328 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80349d8 --end 0x8034b20 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080349d8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080349da: b082        sub	sp, #8
@   0x080349dc: 1c01        adds	r1, r0, #0
@   0x080349de: 68cc        ldr	r4, [r1, #12]
@   0x080349e0: 690d        ldr	r5, [r1, #16]
@   0x080349e2: 684f        ldr	r7, [r1, #4]
@   0x080349e4: 2600        movs	r6, #0
@   0x080349e6: 2200        movs	r2, #0
@   0x080349e8: 6808        ldr	r0, [r1, #0]
@   0x080349ea: 2801        cmp	r0, #1
@   0x080349ec: d800        bhi.n	0x349f0
@   0x080349ee: 2201        movs	r2, #1
@   0x080349f0: 2a00        cmp	r2, #0
@   0x080349f2: d00d        beq.n	0x34a10
@   0x080349f4: 4e03        ldr	r6, [pc, #12]	@ (0x34a04)
@   0x080349f6: 4a04        ldr	r2, [pc, #16]	@ (0x34a08)
@   0x080349f8: 4b04        ldr	r3, [pc, #16]	@ (0x34a0c)
@   0x080349fa: 1c20        adds	r0, r4, #0
@   0x080349fc: 1c29        adds	r1, r5, #0
@   0x080349fe: 4319        orrs	r1, r3
@   0x08034a00: e062        b.n	0x34ac8
@   0x08034a02: 0000        movs	r0, r0
@   0x08034a04: 07ff        lsls	r7, r7, #31
@   0x08034a0e: 0008        movs	r0, r1
@   0x08034a10: 2200        movs	r2, #0
@   0x08034a12: 2804        cmp	r0, #4
@   0x08034a14: d100        bne.n	0x34a18
@   0x08034a16: 2201        movs	r2, #1
@   0x08034a18: 2a00        cmp	r2, #0
@   0x08034a1a: d123        bne.n	0x34a64
@   0x08034a1c: 2200        movs	r2, #0
@   0x08034a1e: 2802        cmp	r0, #2
@   0x08034a20: d100        bne.n	0x34a24
@   0x08034a22: 2201        movs	r2, #1
@   0x08034a24: 2a00        cmp	r2, #0
@   0x08034a26: d002        beq.n	0x34a2e
@   0x08034a28: 2400        movs	r4, #0
@   0x08034a2a: 2500        movs	r5, #0
@   0x08034a2c: e04e        b.n	0x34acc
@   0x08034a2e: 1c28        adds	r0, r5, #0
@   0x08034a30: 4320        orrs	r0, r4
@   0x08034a32: 2800        cmp	r0, #0
@   0x08034a34: d04a        beq.n	0x34acc
@   0x08034a36: 688a        ldr	r2, [r1, #8]
@   0x08034a38: 4804        ldr	r0, [pc, #16]	@ (0x34a4c)
@   0x08034a3a: 4282        cmp	r2, r0
@   0x08034a3c: da0f        bge.n	0x34a5e
@   0x08034a3e: 1a82        subs	r2, r0, r2
@   0x08034a40: 2a38        cmp	r2, #56	@ 0x38
@   0x08034a42: dd05        ble.n	0x34a50
@   0x08034a44: 2400        movs	r4, #0
@   0x08034a46: 2500        movs	r5, #0
@   0x08034a48: e039        b.n	0x34abe
@   0x08034a4a: 0000        movs	r0, r0
@   0x08034a4c: fc02        ffff 			@ <UNDEFINED> instruction: 0xfc02ffff
@   0x08034a50: 1c29        adds	r1, r5, #0
@   0x08034a52: 1c20        adds	r0, r4, #0
@   0x08034a54: f7ff        f9c4 	bl	0x33de0
@   0x08034a58: 1c0d        adds	r5, r1, #0
@   0x08034a5a: 1c04        adds	r4, r0, #0
@   0x08034a5c: e02f        b.n	0x34abe
@   0x08034a5e: 4803        ldr	r0, [pc, #12]	@ (0x34a6c)
@   0x08034a60: 4282        cmp	r2, r0
@   0x08034a62: dd07        ble.n	0x34a74
@   0x08034a64: 4e02        ldr	r6, [pc, #8]	@ (0x34a70)
@   0x08034a66: 2400        movs	r4, #0
@   0x08034a68: 2500        movs	r5, #0
@   0x08034a6a: e02f        b.n	0x34acc
@   0x08034a6c: 03ff        lsls	r7, r7, #15
@   0x08034a6e: 0000        movs	r0, r0
@   0x08034a70: 07ff        lsls	r7, r7, #31
@   0x08034a72: 0000        movs	r0, r0
@   0x08034a74: 4809        ldr	r0, [pc, #36]	@ (0x34a9c)
@   0x08034a76: 1816        adds	r6, r2, r0
@   0x08034a78: 20ff        movs	r0, #255	@ 0xff
@   0x08034a7a: 1c21        adds	r1, r4, #0
@   0x08034a7c: 4001        ands	r1, r0
@   0x08034a7e: 2200        movs	r2, #0
@   0x08034a80: 2980        cmp	r1, #128	@ 0x80
@   0x08034a82: d10d        bne.n	0x34aa0
@   0x08034a84: 2a00        cmp	r2, #0
@   0x08034a86: d10b        bne.n	0x34aa0
@   0x08034a88: 3001        adds	r0, #1
@   0x08034a8a: 1c21        adds	r1, r4, #0
@   0x08034a8c: 4001        ands	r1, r0
@   0x08034a8e: 1c10        adds	r0, r2, #0
@   0x08034a90: 4308        orrs	r0, r1
@   0x08034a92: 2800        cmp	r0, #0
@   0x08034a94: d008        beq.n	0x34aa8
@   0x08034a96: 2080        movs	r0, #128	@ 0x80
@   0x08034a98: 2100        movs	r1, #0
@   0x08034a9a: e003        b.n	0x34aa4
@   0x08034a9c: 03ff        lsls	r7, r7, #15
@   0x08034a9e: 0000        movs	r0, r0
@   0x08034aa0: 207f        movs	r0, #127	@ 0x7f
@   0x08034aa2: 2100        movs	r1, #0
@   0x08034aa4: 1824        adds	r4, r4, r0
@   0x08034aa6: 414d        adcs	r5, r1
@   0x08034aa8: 4818        ldr	r0, [pc, #96]	@ (0x34b0c)
@   0x08034aaa: 4285        cmp	r5, r0
@   0x08034aac: d907        bls.n	0x34abe
@   0x08034aae: 07eb        lsls	r3, r5, #31
@   0x08034ab0: 0862        lsrs	r2, r4, #1
@   0x08034ab2: 1c18        adds	r0, r3, #0
@   0x08034ab4: 4310        orrs	r0, r2
@   0x08034ab6: 0869        lsrs	r1, r5, #1
@   0x08034ab8: 1c0d        adds	r5, r1, #0
@   0x08034aba: 1c04        adds	r4, r0, #0
@   0x08034abc: 3601        adds	r6, #1
@   0x08034abe: 062b        lsls	r3, r5, #24
@   0x08034ac0: 0a22        lsrs	r2, r4, #8
@   0x08034ac2: 1c18        adds	r0, r3, #0
@   0x08034ac4: 4310        orrs	r0, r2
@   0x08034ac6: 0a29        lsrs	r1, r5, #8
@   0x08034ac8: 1c0d        adds	r5, r1, #0
@   0x08034aca: 1c04        adds	r4, r0, #0
@   0x08034acc: 9400        str	r4, [sp, #0]
@   0x08034ace: 4a10        ldr	r2, [pc, #64]	@ (0x34b10)
@   0x08034ad0: 402a        ands	r2, r5
@   0x08034ad2: 9801        ldr	r0, [sp, #4]
@   0x08034ad4: 490f        ldr	r1, [pc, #60]	@ (0x34b14)
@   0x08034ad6: 4008        ands	r0, r1
@   0x08034ad8: 4310        orrs	r0, r2
@   0x08034ada: 9001        str	r0, [sp, #4]
@   0x08034adc: 466a        mov	r2, sp
@   0x08034ade: 490e        ldr	r1, [pc, #56]	@ (0x34b18)
@   0x08034ae0: 1c08        adds	r0, r1, #0
@   0x08034ae2: 4006        ands	r6, r0
@   0x08034ae4: 0131        lsls	r1, r6, #4
@   0x08034ae6: 480d        ldr	r0, [pc, #52]	@ (0x34b1c)
@   0x08034ae8: 88d3        ldrh	r3, [r2, #6]
@   0x08034aea: 4018        ands	r0, r3
@   0x08034aec: 4308        orrs	r0, r1
@   0x08034aee: 80d0        strh	r0, [r2, #6]
@   0x08034af0: 01f9        lsls	r1, r7, #7
@   0x08034af2: 207f        movs	r0, #127	@ 0x7f
@   0x08034af4: 79d3        ldrb	r3, [r2, #7]
@   0x08034af6: 4018        ands	r0, r3
@   0x08034af8: 4308        orrs	r0, r1
@   0x08034afa: 71d0        strb	r0, [r2, #7]
@   0x08034afc: 9900        ldr	r1, [sp, #0]
@   0x08034afe: 9801        ldr	r0, [sp, #4]
@   0x08034b00: 9000        str	r0, [sp, #0]
@   0x08034b02: 9101        str	r1, [sp, #4]
@   0x08034b04: 9800        ldr	r0, [sp, #0]
@   0x08034b06: 9901        ldr	r1, [sp, #4]
@   0x08034b08: b002        add	sp, #8
@   0x08034b0a: bdf0        pop	{r4, r5, r6, r7, pc}
@   0x08034b0c: ffff        1fff 			@ <UNDEFINED> instruction: 0xffff1fff
@   0x08034b10: ffff        000f 	vaddl.u<illegal width 64>	q8, d15, d15
@   0x08034b14: 0000        movs	r0, r0
@   0x08034b16: fff0        07ff 	vqshl.u64	q8, <illegal reg q15.5>, #48	@ 0x30
@   0x08034b1a: 0000        movs	r0, r0
@   0x08034b1c: 800f        strh	r7, [r1, #0]
@   0x08034b1e: ffff        vsli.64	<illegal reg q13.5>, q8, #63	@ 0x3f

        thumb_func_start sub_080349D8
sub_080349D8: @ 0x080349d8
        .incbin "frog_us_baserom.gba", 0x349d8, 0x148
        thumb_func_end sub_080349D8
