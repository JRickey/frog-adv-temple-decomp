@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801f970, 0x0801fd0c)  (924 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801f970 --end 0x801fd0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801f970: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801f972: 4657        mov	r7, sl
@   0x0801f974: 464e        mov	r6, r9
@   0x0801f976: 4645        mov	r5, r8
@   0x0801f978: b4e0        push	{r5, r6, r7}
@   0x0801f97a: b085        sub	sp, #20
@   0x0801f97c: 0600        lsls	r0, r0, #24
@   0x0801f97e: 0e06        lsrs	r6, r0, #24
@   0x0801f980: 490e        ldr	r1, [pc, #56]	@ (0x1f9bc)
@   0x0801f982: 2000        movs	r0, #0
@   0x0801f984: 8008        strh	r0, [r1, #0]
@   0x0801f986: 2500        movs	r5, #0
@   0x0801f988: 2000        movs	r0, #0
@   0x0801f98a: 9003        str	r0, [sp, #12]
@   0x0801f98c: 2100        movs	r1, #0
@   0x0801f98e: 9104        str	r1, [sp, #16]
@   0x0801f990: a801        add	r0, sp, #4
@   0x0801f992: 2141        movs	r1, #65	@ 0x41
@   0x0801f994: 7001        strb	r1, [r0, #0]
@   0x0801f996: 7041        strb	r1, [r0, #1]
@   0x0801f998: 7081        strb	r1, [r0, #2]
@   0x0801f99a: 0230        lsls	r0, r6, #8
@   0x0801f99c: 4a08        ldr	r2, [pc, #32]	@ (0x1f9c0)
@   0x0801f99e: 1881        adds	r1, r0, r2
@   0x0801f9a0: 8809        ldrh	r1, [r1, #0]
@   0x0801f9a2: 4688        mov	r8, r1
@   0x0801f9a4: 4b07        ldr	r3, [pc, #28]	@ (0x1f9c4)
@   0x0801f9a6: 18c0        adds	r0, r0, r3
@   0x0801f9a8: 8807        ldrh	r7, [r0, #0]
@   0x0801f9aa: 2000        movs	r0, #0
@   0x0801f9ac: 4682        mov	sl, r0
@   0x0801f9ae: 4681        mov	r9, r0
@   0x0801f9b0: 1c30        adds	r0, r6, #0
@   0x0801f9b2: a901        add	r1, sp, #4
@   0x0801f9b4: f000        fca0 	bl	0x202f8
@   0x0801f9b8: e0e7        b.n	0x1fb8a
@   0x0801f9ba: 0000        movs	r0, r0
@   0x0801f9bc: 5398        strh	r0, [r3, r6]
@   0x0801f9be: 0300        lsls	r0, r0, #12
@   0x0801f9c0: f106        0600 	add.w	r6, r6, #0
@   0x0801f9c4: f146        0600 	adc.w	r6, r6, #0
@   0x0801f9c8: 4804        ldr	r0, [pc, #16]	@ (0x1f9dc)
@   0x0801f9ca: 8800        ldrh	r0, [r0, #0]
@   0x0801f9cc: 3801        subs	r0, #1
@   0x0801f9ce: 281f        cmp	r0, #31
@   0x0801f9d0: d87b        bhi.n	0x1faca
@   0x0801f9d2: 0080        lsls	r0, r0, #2
@   0x0801f9d4: 4902        ldr	r1, [pc, #8]	@ (0x1f9e0)
@   0x0801f9d6: 1840        adds	r0, r0, r1
@   0x0801f9d8: 6800        ldr	r0, [r0, #0]
@   0x0801f9da: 4687        mov	pc, r0
@   0x0801f9dc: 5398        strh	r0, [r3, r6]
@   0x0801f9de: 0300        lsls	r0, r0, #12
@   0x0801f9e0: f9e4        0801 	vld1.32	{d16[0]}, [r4], r1
@   0x0801f9e4: fa64        0801 			@ <UNDEFINED> instruction: 0xfa640801
@   0x0801f9e8: fa88        0801 			@ <UNDEFINED> instruction: 0xfa880801
@   0x0801f9ec: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801f9f0: faac        0801 			@ <UNDEFINED> instruction: 0xfaac0801
@   0x0801f9f4: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801f9f8: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801f9fc: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa00: faba        0801 			@ <UNDEFINED> instruction: 0xfaba0801
@   0x0801fa04: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa08: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa0c: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa10: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa14: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa18: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa1c: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa20: faba        0801 			@ <UNDEFINED> instruction: 0xfaba0801
@   0x0801fa24: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa28: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa2c: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa30: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa34: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa38: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa3c: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa40: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa44: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa48: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa4c: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa50: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa54: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa58: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa5c: faca        0801 			@ <UNDEFINED> instruction: 0xfaca0801
@   0x0801fa60: faac        0801 			@ <UNDEFINED> instruction: 0xfaac0801
@   0x0801fa64: 2002        movs	r0, #2
@   0x0801fa66: f001        f907 	bl	0x20c78
@   0x0801fa6a: 466a        mov	r2, sp
@   0x0801fa6c: 1952        adds	r2, r2, r5
@   0x0801fa6e: 3204        adds	r2, #4
@   0x0801fa70: 7810        ldrb	r0, [r2, #0]
@   0x0801fa72: 1c01        adds	r1, r0, #0
@   0x0801fa74: 2941        cmp	r1, #65	@ 0x41
@   0x0801fa76: d902        bls.n	0x1fa7e
@   0x0801fa78: 3801        subs	r0, #1
@   0x0801fa7a: 7010        strb	r0, [r2, #0]
@   0x0801fa7c: e025        b.n	0x1faca
@   0x0801fa7e: 2941        cmp	r1, #65	@ 0x41
@   0x0801fa80: d123        bne.n	0x1faca
@   0x0801fa82: 205a        movs	r0, #90	@ 0x5a
@   0x0801fa84: 7010        strb	r0, [r2, #0]
@   0x0801fa86: e020        b.n	0x1faca
@   0x0801fa88: 2002        movs	r0, #2
@   0x0801fa8a: f001        f8f5 	bl	0x20c78
@   0x0801fa8e: 466a        mov	r2, sp
@   0x0801fa90: 1952        adds	r2, r2, r5
@   0x0801fa92: 3204        adds	r2, #4
@   0x0801fa94: 7810        ldrb	r0, [r2, #0]
@   0x0801fa96: 1c01        adds	r1, r0, #0
@   0x0801fa98: 2959        cmp	r1, #89	@ 0x59
@   0x0801fa9a: d802        bhi.n	0x1faa2
@   0x0801fa9c: 3001        adds	r0, #1
@   0x0801fa9e: 7010        strb	r0, [r2, #0]
@   0x0801faa0: e013        b.n	0x1faca
@   0x0801faa2: 295a        cmp	r1, #90	@ 0x5a
@   0x0801faa4: d111        bne.n	0x1faca
@   0x0801faa6: 2041        movs	r0, #65	@ 0x41
@   0x0801faa8: 7010        strb	r0, [r2, #0]
@   0x0801faaa: e00e        b.n	0x1faca
@   0x0801faac: 2002        movs	r0, #2
@   0x0801faae: f001        f8e3 	bl	0x20c78
@   0x0801fab2: 2d00        cmp	r5, #0
@   0x0801fab4: d009        beq.n	0x1faca
@   0x0801fab6: 1e68        subs	r0, r5, #1
@   0x0801fab8: e005        b.n	0x1fac6
@   0x0801faba: 2002        movs	r0, #2
@   0x0801fabc: f001        f8dc 	bl	0x20c78
@   0x0801fac0: 2d02        cmp	r5, #2
@   0x0801fac2: d002        beq.n	0x1faca
@   0x0801fac4: 1c68        adds	r0, r5, #1
@   0x0801fac6: 0600        lsls	r0, r0, #24
@   0x0801fac8: 0e05        lsrs	r5, r0, #24
@   0x0801faca: 480d        ldr	r0, [pc, #52]	@ (0x1fb00)
@   0x0801facc: 8800        ldrh	r0, [r0, #0]
@   0x0801face: 2800        cmp	r0, #0
@   0x0801fad0: d01a        beq.n	0x1fb08
@   0x0801fad2: 1c30        adds	r0, r6, #0
@   0x0801fad4: a901        add	r1, sp, #4
@   0x0801fad6: f000        fc0f 	bl	0x202f8
@   0x0801fada: 0230        lsls	r0, r6, #8
@   0x0801fadc: 4909        ldr	r1, [pc, #36]	@ (0x1fb04)
@   0x0801fade: 1840        adds	r0, r0, r1
@   0x0801fae0: 0069        lsls	r1, r5, #1
@   0x0801fae2: 1841        adds	r1, r0, r1
@   0x0801fae4: 2283        movs	r2, #131	@ 0x83
@   0x0801fae6: 0052        lsls	r2, r2, #1
@   0x0801fae8: 1888        adds	r0, r1, r2
@   0x0801faea: 8800        ldrh	r0, [r0, #0]
@   0x0801faec: 4680        mov	r8, r0
@   0x0801faee: 23a3        movs	r3, #163	@ 0xa3
@   0x0801faf0: 005b        lsls	r3, r3, #1
@   0x0801faf2: 18c8        adds	r0, r1, r3
@   0x0801faf4: 8807        ldrh	r7, [r0, #0]
@   0x0801faf6: 2000        movs	r0, #0
@   0x0801faf8: 4682        mov	sl, r0
@   0x0801fafa: 4681        mov	r9, r0
@   0x0801fafc: e026        b.n	0x1fb4c
@   0x0801fafe: 0000        movs	r0, r0
@   0x0801fb00: 5398        strh	r0, [r3, r6]
@   0x0801fb02: 0300        lsls	r0, r0, #12
@   0x0801fb04: f000        0600 	and.w	r6, r0, #0
@   0x0801fb08: 481a        ldr	r0, [pc, #104]	@ (0x1fb74)
@   0x0801fb0a: 6802        ldr	r2, [r0, #0]
@   0x0801fb0c: 9903        ldr	r1, [sp, #12]
@   0x0801fb0e: 1a50        subs	r0, r2, r1
@   0x0801fb10: 2805        cmp	r0, #5
@   0x0801fb12: d91b        bls.n	0x1fb4c
@   0x0801fb14: 2000        movs	r0, #0
@   0x0801fb16: 4653        mov	r3, sl
@   0x0801fb18: 2b00        cmp	r3, #0
@   0x0801fb1a: d100        bne.n	0x1fb1e
@   0x0801fb1c: 4640        mov	r0, r8
@   0x0801fb1e: 4682        mov	sl, r0
@   0x0801fb20: 0230        lsls	r0, r6, #8
@   0x0801fb22: 4915        ldr	r1, [pc, #84]	@ (0x1fb78)
@   0x0801fb24: 1840        adds	r0, r0, r1
@   0x0801fb26: 0069        lsls	r1, r5, #1
@   0x0801fb28: 1841        adds	r1, r0, r1
@   0x0801fb2a: 2383        movs	r3, #131	@ 0x83
@   0x0801fb2c: 005b        lsls	r3, r3, #1
@   0x0801fb2e: 18c8        adds	r0, r1, r3
@   0x0801fb30: 4653        mov	r3, sl
@   0x0801fb32: 8003        strh	r3, [r0, #0]
@   0x0801fb34: 2000        movs	r0, #0
@   0x0801fb36: 464b        mov	r3, r9
@   0x0801fb38: 2b00        cmp	r3, #0
@   0x0801fb3a: d100        bne.n	0x1fb3e
@   0x0801fb3c: 1c38        adds	r0, r7, #0
@   0x0801fb3e: 4681        mov	r9, r0
@   0x0801fb40: 23a3        movs	r3, #163	@ 0xa3
@   0x0801fb42: 005b        lsls	r3, r3, #1
@   0x0801fb44: 18c8        adds	r0, r1, r3
@   0x0801fb46: 4649        mov	r1, r9
@   0x0801fb48: 8001        strh	r1, [r0, #0]
@   0x0801fb4a: 9203        str	r2, [sp, #12]
@   0x0801fb4c: 4c09        ldr	r4, [pc, #36]	@ (0x1fb74)
@   0x0801fb4e: 6820        ldr	r0, [r4, #0]
@   0x0801fb50: 9a04        ldr	r2, [sp, #16]
@   0x0801fb52: 1a80        subs	r0, r0, r2
@   0x0801fb54: 2803        cmp	r0, #3
@   0x0801fb56: d915        bls.n	0x1fb84
@   0x0801fb58: f7e0        fcb4 	bl	0x4c4
@   0x0801fb5c: 4907        ldr	r1, [pc, #28]	@ (0x1fb7c)
@   0x0801fb5e: 8008        strh	r0, [r1, #0]
@   0x0801fb60: 6824        ldr	r4, [r4, #0]
@   0x0801fb62: 9404        str	r4, [sp, #16]
@   0x0801fb64: 4b06        ldr	r3, [pc, #24]	@ (0x1fb80)
@   0x0801fb66: 6818        ldr	r0, [r3, #0]
@   0x0801fb68: 6859        ldr	r1, [r3, #4]
@   0x0801fb6a: 689a        ldr	r2, [r3, #8]
@   0x0801fb6c: 68db        ldr	r3, [r3, #12]
@   0x0801fb6e: f7f8        fd27 	bl	0x185c0
@   0x0801fb72: e00a        b.n	0x1fb8a
@   0x0801fb74: 5330        strh	r0, [r6, r4]
@   0x0801fb76: 0300        lsls	r0, r0, #12
@   0x0801fb78: f000        0600 	and.w	r6, r0, #0
@   0x0801fb7c: 5398        strh	r0, [r3, r6]
@   0x0801fb7e: 0300        lsls	r0, r0, #12
@   0x0801fb80: 8100        strh	r0, [r0, #8]
@   0x0801fb82: 0830        lsrs	r0, r6, #32
@   0x0801fb84: 4920        ldr	r1, [pc, #128]	@ (0x1fc08)
@   0x0801fb86: 2000        movs	r0, #0
@   0x0801fb88: 8008        strh	r0, [r1, #0]
@   0x0801fb8a: 481f        ldr	r0, [pc, #124]	@ (0x1fc08)
@   0x0801fb8c: 8801        ldrh	r1, [r0, #0]
@   0x0801fb8e: 1c04        adds	r4, r0, #0
@   0x0801fb90: 2920        cmp	r1, #32
@   0x0801fb92: d101        bne.n	0x1fb98
@   0x0801fb94: 2d00        cmp	r5, #0
@   0x0801fb96: d005        beq.n	0x1fba4
@   0x0801fb98: 2910        cmp	r1, #16
@   0x0801fb9a: d000        beq.n	0x1fb9e
@   0x0801fb9c: e714        b.n	0x1f9c8
@   0x0801fb9e: 2d02        cmp	r5, #2
@   0x0801fba0: d000        beq.n	0x1fba4
@   0x0801fba2: e711        b.n	0x1f9c8
@   0x0801fba4: 8820        ldrh	r0, [r4, #0]
@   0x0801fba6: 2810        cmp	r0, #16
@   0x0801fba8: d000        beq.n	0x1fbac
@   0x0801fbaa: e09f        b.n	0x1fcec
@   0x0801fbac: 2001        movs	r0, #1
@   0x0801fbae: f001        f863 	bl	0x20c78
@   0x0801fbb2: 0230        lsls	r0, r6, #8
@   0x0801fbb4: 4b15        ldr	r3, [pc, #84]	@ (0x1fc0c)
@   0x0801fbb6: 18c0        adds	r0, r0, r3
@   0x0801fbb8: 0069        lsls	r1, r5, #1
@   0x0801fbba: 1841        adds	r1, r0, r1
@   0x0801fbbc: 2283        movs	r2, #131	@ 0x83
@   0x0801fbbe: 0052        lsls	r2, r2, #1
@   0x0801fbc0: 1888        adds	r0, r1, r2
@   0x0801fbc2: 4643        mov	r3, r8
@   0x0801fbc4: 8003        strh	r3, [r0, #0]
@   0x0801fbc6: 3240        adds	r2, #64	@ 0x40
@   0x0801fbc8: 1888        adds	r0, r1, r2
@   0x0801fbca: 8007        strh	r7, [r0, #0]
@   0x0801fbcc: 4810        ldr	r0, [pc, #64]	@ (0x1fc10)
@   0x0801fbce: 9902        ldr	r1, [sp, #8]
@   0x0801fbd0: 4001        ands	r1, r0
@   0x0801fbd2: 2003        movs	r0, #3
@   0x0801fbd4: 4301        orrs	r1, r0
@   0x0801fbd6: 4a0f        ldr	r2, [pc, #60]	@ (0x1fc14)
@   0x0801fbd8: 4011        ands	r1, r2
@   0x0801fbda: 2380        movs	r3, #128	@ 0x80
@   0x0801fbdc: 00db        lsls	r3, r3, #3
@   0x0801fbde: 4319        orrs	r1, r3
@   0x0801fbe0: 480d        ldr	r0, [pc, #52]	@ (0x1fc18)
@   0x0801fbe2: 4001        ands	r1, r0
@   0x0801fbe4: 20c0        movs	r0, #192	@ 0xc0
@   0x0801fbe6: 0480        lsls	r0, r0, #18
@   0x0801fbe8: 4301        orrs	r1, r0
@   0x0801fbea: 480c        ldr	r0, [pc, #48]	@ (0x1fc1c)
@   0x0801fbec: 4001        ands	r1, r0
@   0x0801fbee: 20c0        movs	r0, #192	@ 0xc0
@   0x0801fbf0: 0340        lsls	r0, r0, #13
@   0x0801fbf2: 4301        orrs	r1, r0
@   0x0801fbf4: 9102        str	r1, [sp, #8]
@   0x0801fbf6: 480a        ldr	r0, [pc, #40]	@ (0x1fc20)
@   0x0801fbf8: 7d00        ldrb	r0, [r0, #20]
@   0x0801fbfa: 2801        cmp	r0, #1
@   0x0801fbfc: d01a        beq.n	0x1fc34
@   0x0801fbfe: 2801        cmp	r0, #1
@   0x0801fc00: dc10        bgt.n	0x1fc24
@   0x0801fc02: 2800        cmp	r0, #0
@   0x0801fc04: d013        beq.n	0x1fc2e
@   0x0801fc06: e022        b.n	0x1fc4e
@   0x0801fc08: 5398        strh	r0, [r3, r6]
@   0x0801fc0a: 0300        lsls	r0, r0, #12
@   0x0801fc0c: f000        0600 	and.w	r6, r0, #0
@   0x0801fc10: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801fc14: 00ff        lsls	r7, r7, #3
@   0x0801fc16: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801fc1a: 00ff        lsls	r7, r7, #3
@   0x0801fc1c: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801fc20: 3480        adds	r4, #128	@ 0x80
@   0x0801fc22: 0300        lsls	r0, r0, #12
@   0x0801fc24: 2802        cmp	r0, #2
@   0x0801fc26: d009        beq.n	0x1fc3c
@   0x0801fc28: 2803        cmp	r0, #3
@   0x0801fc2a: d00b        beq.n	0x1fc44
@   0x0801fc2c: e00f        b.n	0x1fc4e
@   0x0801fc2e: 4011        ands	r1, r2
@   0x0801fc30: 4319        orrs	r1, r3
@   0x0801fc32: e00b        b.n	0x1fc4c
@   0x0801fc34: 4011        ands	r1, r2
@   0x0801fc36: 2080        movs	r0, #128	@ 0x80
@   0x0801fc38: 0100        lsls	r0, r0, #4
@   0x0801fc3a: e006        b.n	0x1fc4a
@   0x0801fc3c: 4011        ands	r1, r2
@   0x0801fc3e: 20c0        movs	r0, #192	@ 0xc0
@   0x0801fc40: 0100        lsls	r0, r0, #4
@   0x0801fc42: e002        b.n	0x1fc4a
@   0x0801fc44: 4011        ands	r1, r2
@   0x0801fc46: 2080        movs	r0, #128	@ 0x80
@   0x0801fc48: 0140        lsls	r0, r0, #5
@   0x0801fc4a: 4301        orrs	r1, r0
@   0x0801fc4c: 9102        str	r1, [sp, #8]
@   0x0801fc4e: a802        add	r0, sp, #8
@   0x0801fc50: 210a        movs	r1, #10
@   0x0801fc52: 9100        str	r1, [sp, #0]
@   0x0801fc54: 2104        movs	r1, #4
@   0x0801fc56: 2205        movs	r2, #5
@   0x0801fc58: 2302        movs	r3, #2
@   0x0801fc5a: f7f9        fe25 	bl	0x198a8
@   0x0801fc5e: 491a        ldr	r1, [pc, #104]	@ (0x1fcc8)
@   0x0801fc60: 2001        movs	r0, #1
@   0x0801fc62: 6088        str	r0, [r1, #8]
@   0x0801fc64: 211d        movs	r1, #29
@   0x0801fc66: 2206        movs	r2, #6
@   0x0801fc68: 2302        movs	r3, #2
@   0x0801fc6a: f7f8        fced 	bl	0x18648
@   0x0801fc6e: 4917        ldr	r1, [pc, #92]	@ (0x1fccc)
@   0x0801fc70: 2400        movs	r4, #0
@   0x0801fc72: 60cc        str	r4, [r1, #12]
@   0x0801fc74: 728c        strb	r4, [r1, #10]
@   0x0801fc76: 201d        movs	r0, #29
@   0x0801fc78: 7248        strb	r0, [r1, #9]
@   0x0801fc7a: 4815        ldr	r0, [pc, #84]	@ (0x1fcd0)
@   0x0801fc7c: 7004        strb	r4, [r0, #0]
@   0x0801fc7e: 4a15        ldr	r2, [pc, #84]	@ (0x1fcd4)
@   0x0801fc80: 4915        ldr	r1, [pc, #84]	@ (0x1fcd8)
@   0x0801fc82: 78c8        ldrb	r0, [r1, #3]
@   0x0801fc84: 7090        strb	r0, [r2, #2]
@   0x0801fc86: 4d15        ldr	r5, [pc, #84]	@ (0x1fcdc)
@   0x0801fc88: 7888        ldrb	r0, [r1, #2]
@   0x0801fc8a: 7028        strb	r0, [r5, #0]
@   0x0801fc8c: 2000        movs	r0, #0
@   0x0801fc8e: 806c        strh	r4, [r5, #2]
@   0x0801fc90: 7128        strb	r0, [r5, #4]
@   0x0801fc92: a801        add	r0, sp, #4
@   0x0801fc94: 7801        ldrb	r1, [r0, #0]
@   0x0801fc96: 1c28        adds	r0, r5, #0
@   0x0801fc98: 3020        adds	r0, #32
@   0x0801fc9a: 7001        strb	r1, [r0, #0]
@   0x0801fc9c: a801        add	r0, sp, #4
@   0x0801fc9e: 7840        ldrb	r0, [r0, #1]
@   0x0801fca0: 1c29        adds	r1, r5, #0
@   0x0801fca2: 3121        adds	r1, #33	@ 0x21
@   0x0801fca4: 7008        strb	r0, [r1, #0]
@   0x0801fca6: a801        add	r0, sp, #4
@   0x0801fca8: 7880        ldrb	r0, [r0, #2]
@   0x0801fcaa: 3101        adds	r1, #1
@   0x0801fcac: 7008        strb	r0, [r1, #0]
@   0x0801fcae: 480c        ldr	r0, [pc, #48]	@ (0x1fce0)
@   0x0801fcb0: 7d00        ldrb	r0, [r0, #20]
@   0x0801fcb2: a901        add	r1, sp, #4
@   0x0801fcb4: f7f7        fc5a 	bl	0x1756c
@   0x0801fcb8: 480a        ldr	r0, [pc, #40]	@ (0x1fce4)
@   0x0801fcba: 8684        strh	r4, [r0, #52]	@ 0x34
@   0x0801fcbc: 822c        strh	r4, [r5, #16]
@   0x0801fcbe: 480a        ldr	r0, [pc, #40]	@ (0x1fce8)
@   0x0801fcc0: 8004        strh	r4, [r0, #0]
@   0x0801fcc2: 2001        movs	r0, #1
@   0x0801fcc4: e01a        b.n	0x1fcfc
@   0x0801fcc6: 0000        movs	r0, r0
@   0x0801fcc8: 34a0        adds	r4, #160	@ 0xa0
@   0x0801fcca: 0300        lsls	r0, r0, #12
@   0x0801fccc: 5330        strh	r0, [r6, r4]
@   0x0801fcce: 0300        lsls	r0, r0, #12
@   0x0801fcd0: 3540        adds	r5, #64	@ 0x40
@   0x0801fcd2: 0300        lsls	r0, r0, #12
@   0x0801fcd4: 3500        adds	r5, #0
@   0x0801fcd6: 0300        lsls	r0, r0, #12
@   0x0801fcd8: 34b4        adds	r4, #180	@ 0xb4
@   0x0801fcda: 0300        lsls	r0, r0, #12
@   0x0801fcdc: 35e0        adds	r5, #224	@ 0xe0
@   0x0801fcde: 0300        lsls	r0, r0, #12
@   0x0801fce0: 3480        adds	r4, #128	@ 0x80
@   0x0801fce2: 0300        lsls	r0, r0, #12
@   0x0801fce4: 3720        adds	r7, #32
@   0x0801fce6: 0300        lsls	r0, r0, #12
@   0x0801fce8: 5398        strh	r0, [r3, r6]
@   0x0801fcea: 0300        lsls	r0, r0, #12
@   0x0801fcec: 2820        cmp	r0, #32
@   0x0801fcee: d102        bne.n	0x1fcf6
@   0x0801fcf0: 2000        movs	r0, #0
@   0x0801fcf2: f000        ffc1 	bl	0x20c78
@   0x0801fcf6: 2000        movs	r0, #0
@   0x0801fcf8: 8020        strh	r0, [r4, #0]
@   0x0801fcfa: 2000        movs	r0, #0
@   0x0801fcfc: b005        add	sp, #20
@   0x0801fcfe: bc38        pop	{r3, r4, r5}
@   0x0801fd00: 4698        mov	r8, r3
@   0x0801fd02: 46a1        mov	r9, r4
@   0x0801fd04: 46aa        mov	sl, r5
@   0x0801fd06: bcf0        pop	{r4, r5, r6, r7}
@   0x0801fd08: bc02        pop	{r1}
@   0x0801fd0a: 4708        bx	r1

        thumb_func_start SaveSlot_UpdateScreen
SaveSlot_UpdateScreen: @ 0x0801f970
        .incbin "frog_us_baserom.gba", 0x1f970, 0x39c
        thumb_func_end SaveSlot_UpdateScreen
