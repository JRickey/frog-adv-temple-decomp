@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801ea08, 0x0801f1e0)  (2008 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801ea08 --end 0x801f1e0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801ea08: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801ea0a: 4647        mov	r7, r8
@   0x0801ea0c: b480        push	{r7}
@   0x0801ea0e: b08e        sub	sp, #56	@ 0x38
@   0x0801ea10: a903        add	r1, sp, #12
@   0x0801ea12: 4813        ldr	r0, [pc, #76]	@ (0x1ea60)
@   0x0801ea14: c81c        ldmia	r0!, {r2, r3, r4}
@   0x0801ea16: c11c        stmia	r1!, {r2, r3, r4}
@   0x0801ea18: c81c        ldmia	r0!, {r2, r3, r4}
@   0x0801ea1a: c11c        stmia	r1!, {r2, r3, r4}
@   0x0801ea1c: c81c        ldmia	r0!, {r2, r3, r4}
@   0x0801ea1e: c11c        stmia	r1!, {r2, r3, r4}
@   0x0801ea20: 6800        ldr	r0, [r0, #0]
@   0x0801ea22: 6008        str	r0, [r1, #0]
@   0x0801ea24: 480f        ldr	r0, [pc, #60]	@ (0x1ea64)
@   0x0801ea26: 990d        ldr	r1, [sp, #52]	@ 0x34
@   0x0801ea28: 4001        ands	r1, r0
@   0x0801ea2a: 2006        movs	r0, #6
@   0x0801ea2c: 4301        orrs	r1, r0
@   0x0801ea2e: 4a0e        ldr	r2, [pc, #56]	@ (0x1ea68)
@   0x0801ea30: 4011        ands	r1, r2
@   0x0801ea32: 2380        movs	r3, #128	@ 0x80
@   0x0801ea34: 009b        lsls	r3, r3, #2
@   0x0801ea36: 4319        orrs	r1, r3
@   0x0801ea38: 480c        ldr	r0, [pc, #48]	@ (0x1ea6c)
@   0x0801ea3a: 4001        ands	r1, r0
@   0x0801ea3c: 2080        movs	r0, #128	@ 0x80
@   0x0801ea3e: 04c0        lsls	r0, r0, #19
@   0x0801ea40: 4301        orrs	r1, r0
@   0x0801ea42: 480b        ldr	r0, [pc, #44]	@ (0x1ea70)
@   0x0801ea44: 4001        ands	r1, r0
@   0x0801ea46: 2090        movs	r0, #144	@ 0x90
@   0x0801ea48: 0340        lsls	r0, r0, #13
@   0x0801ea4a: 4301        orrs	r1, r0
@   0x0801ea4c: 910d        str	r1, [sp, #52]	@ 0x34
@   0x0801ea4e: 4809        ldr	r0, [pc, #36]	@ (0x1ea74)
@   0x0801ea50: 7d00        ldrb	r0, [r0, #20]
@   0x0801ea52: 2801        cmp	r0, #1
@   0x0801ea54: d018        beq.n	0x1ea88
@   0x0801ea56: 2801        cmp	r0, #1
@   0x0801ea58: dc0e        bgt.n	0x1ea78
@   0x0801ea5a: 2800        cmp	r0, #0
@   0x0801ea5c: d011        beq.n	0x1ea82
@   0x0801ea5e: e020        b.n	0x1eaa2
@   0x0801ea60: e7d0        b.n	0x1ea04
@   0x0801ea62: 081b        lsrs	r3, r3, #32
@   0x0801ea64: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801ea68: 00ff        lsls	r7, r7, #3
@   0x0801ea6a: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801ea6e: 00ff        lsls	r7, r7, #3
@   0x0801ea70: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801ea74: 3480        adds	r4, #128	@ 0x80
@   0x0801ea76: 0300        lsls	r0, r0, #12
@   0x0801ea78: 2802        cmp	r0, #2
@   0x0801ea7a: d009        beq.n	0x1ea90
@   0x0801ea7c: 2803        cmp	r0, #3
@   0x0801ea7e: d00b        beq.n	0x1ea98
@   0x0801ea80: e00f        b.n	0x1eaa2
@   0x0801ea82: 4011        ands	r1, r2
@   0x0801ea84: 4319        orrs	r1, r3
@   0x0801ea86: e00b        b.n	0x1eaa0
@   0x0801ea88: 4011        ands	r1, r2
@   0x0801ea8a: 20c0        movs	r0, #192	@ 0xc0
@   0x0801ea8c: 00c0        lsls	r0, r0, #3
@   0x0801ea8e: e006        b.n	0x1ea9e
@   0x0801ea90: 4011        ands	r1, r2
@   0x0801ea92: 20a0        movs	r0, #160	@ 0xa0
@   0x0801ea94: 0100        lsls	r0, r0, #4
@   0x0801ea96: e002        b.n	0x1ea9e
@   0x0801ea98: 4011        ands	r1, r2
@   0x0801ea9a: 20e0        movs	r0, #224	@ 0xe0
@   0x0801ea9c: 0100        lsls	r0, r0, #4
@   0x0801ea9e: 4301        orrs	r1, r0
@   0x0801eaa0: 910d        str	r1, [sp, #52]	@ 0x34
@   0x0801eaa2: 4920        ldr	r1, [pc, #128]	@ (0x1eb24)
@   0x0801eaa4: 4a20        ldr	r2, [pc, #128]	@ (0x1eb28)
@   0x0801eaa6: 4f21        ldr	r7, [pc, #132]	@ (0x1eb2c)
@   0x0801eaa8: 683b        ldr	r3, [r7, #0]
@   0x0801eaaa: 0098        lsls	r0, r3, #2
@   0x0801eaac: 1880        adds	r0, r0, r2
@   0x0801eaae: 6800        ldr	r0, [r0, #0]
@   0x0801eab0: 6008        str	r0, [r1, #0]
@   0x0801eab2: 481f        ldr	r0, [pc, #124]	@ (0x1eb30)
@   0x0801eab4: 6048        str	r0, [r1, #4]
@   0x0801eab6: 481f        ldr	r0, [pc, #124]	@ (0x1eb34)
@   0x0801eab8: 6088        str	r0, [r1, #8]
@   0x0801eaba: 6888        ldr	r0, [r1, #8]
@   0x0801eabc: 2b03        cmp	r3, #3
@   0x0801eabe: d100        bne.n	0x1eac2
@   0x0801eac0: e08e        b.n	0x1ebe0
@   0x0801eac2: 481d        ldr	r0, [pc, #116]	@ (0x1eb38)
@   0x0801eac4: 4680        mov	r8, r0
@   0x0801eac6: 2505        movs	r5, #5
@   0x0801eac8: 9500        str	r5, [sp, #0]
@   0x0801eaca: 2602        movs	r6, #2
@   0x0801eacc: 9601        str	r6, [sp, #4]
@   0x0801eace: 2100        movs	r1, #0
@   0x0801ead0: 4c1a        ldr	r4, [pc, #104]	@ (0x1eb3c)
@   0x0801ead2: 7820        ldrb	r0, [r4, #0]
@   0x0801ead4: 2800        cmp	r0, #0
@   0x0801ead6: d100        bne.n	0x1eada
@   0x0801ead8: 2101        movs	r1, #1
@   0x0801eada: 9102        str	r1, [sp, #8]
@   0x0801eadc: 2001        movs	r0, #1
@   0x0801eade: 2112        movs	r1, #18
@   0x0801eae0: 2203        movs	r2, #3
@   0x0801eae2: 4643        mov	r3, r8
@   0x0801eae4: f7fe        fa5c 	bl	0x1cfa0
@   0x0801eae8: 9500        str	r5, [sp, #0]
@   0x0801eaea: 9601        str	r6, [sp, #4]
@   0x0801eaec: 7820        ldrb	r0, [r4, #0]
@   0x0801eaee: 9002        str	r0, [sp, #8]
@   0x0801eaf0: 2000        movs	r0, #0
@   0x0801eaf2: 2116        movs	r1, #22
@   0x0801eaf4: 2203        movs	r2, #3
@   0x0801eaf6: 4643        mov	r3, r8
@   0x0801eaf8: f7fe        fa52 	bl	0x1cfa0
@   0x0801eafc: 7820        ldrb	r0, [r4, #0]
@   0x0801eafe: 2800        cmp	r0, #0
@   0x0801eb00: d01e        beq.n	0x1eb40
@   0x0801eb02: 6838        ldr	r0, [r7, #0]
@   0x0801eb04: 00c0        lsls	r0, r0, #3
@   0x0801eb06: 4468        add	r0, sp
@   0x0801eb08: 300c        adds	r0, #12
@   0x0801eb0a: 6800        ldr	r0, [r0, #0]
@   0x0801eb0c: 21a0        movs	r1, #160	@ 0xa0
@   0x0801eb0e: 0049        lsls	r1, r1, #1
@   0x0801eb10: 9100        str	r1, [sp, #0]
@   0x0801eb12: 9501        str	r5, [sp, #4]
@   0x0801eb14: 9602        str	r6, [sp, #8]
@   0x0801eb16: 2103        movs	r1, #3
@   0x0801eb18: 2213        movs	r2, #19
@   0x0801eb1a: 2303        movs	r3, #3
@   0x0801eb1c: f7fd        f9ae 	bl	0x1be7c
@   0x0801eb20: e01f        b.n	0x1eb62
@   0x0801eb22: 0000        movs	r0, r0
@   0x0801eb24: 00d4        lsls	r4, r2, #3
@   0x0801eb26: 0400        lsls	r0, r0, #16
@   0x0801eb28: 8f84        ldrh	r4, [r0, #60]	@ 0x3c
@   0x0801eb2a: 0830        lsrs	r0, r6, #32
@   0x0801eb2c: 34b0        adds	r4, #176	@ 0xb0
@   0x0801eb2e: 0300        lsls	r0, r0, #12
@   0x0801eb30: f000        0600 	and.w	r6, r0, #0
@   0x0801eb34: 0400        lsls	r0, r0, #16
@   0x0801eb36: 8000        strh	r0, [r0, #0]
@   0x0801eb38: 013d        lsls	r5, r7, #4
@   0x0801eb3a: 0000        movs	r0, r0
@   0x0801eb3c: 34b4        adds	r4, #180	@ 0xb4
@   0x0801eb3e: 0300        lsls	r0, r0, #12
@   0x0801eb40: 6838        ldr	r0, [r7, #0]
@   0x0801eb42: 0040        lsls	r0, r0, #1
@   0x0801eb44: 3001        adds	r0, #1
@   0x0801eb46: 0080        lsls	r0, r0, #2
@   0x0801eb48: 4468        add	r0, sp
@   0x0801eb4a: 300c        adds	r0, #12
@   0x0801eb4c: 6800        ldr	r0, [r0, #0]
@   0x0801eb4e: 21a0        movs	r1, #160	@ 0xa0
@   0x0801eb50: 0049        lsls	r1, r1, #1
@   0x0801eb52: 9100        str	r1, [sp, #0]
@   0x0801eb54: 9501        str	r5, [sp, #4]
@   0x0801eb56: 9602        str	r6, [sp, #8]
@   0x0801eb58: 2103        movs	r1, #3
@   0x0801eb5a: 2213        movs	r2, #19
@   0x0801eb5c: 2303        movs	r3, #3
@   0x0801eb5e: f7fd        f98d 	bl	0x1be7c
@   0x0801eb62: 4f11        ldr	r7, [pc, #68]	@ (0x1eba8)
@   0x0801eb64: 2505        movs	r5, #5
@   0x0801eb66: 9500        str	r5, [sp, #0]
@   0x0801eb68: 2602        movs	r6, #2
@   0x0801eb6a: 9601        str	r6, [sp, #4]
@   0x0801eb6c: 2100        movs	r1, #0
@   0x0801eb6e: 4c0f        ldr	r4, [pc, #60]	@ (0x1ebac)
@   0x0801eb70: 7860        ldrb	r0, [r4, #1]
@   0x0801eb72: 2800        cmp	r0, #0
@   0x0801eb74: d100        bne.n	0x1eb78
@   0x0801eb76: 2101        movs	r1, #1
@   0x0801eb78: 9102        str	r1, [sp, #8]
@   0x0801eb7a: 2001        movs	r0, #1
@   0x0801eb7c: 2112        movs	r1, #18
@   0x0801eb7e: 2207        movs	r2, #7
@   0x0801eb80: 1c3b        adds	r3, r7, #0
@   0x0801eb82: f7fe        fa0d 	bl	0x1cfa0
@   0x0801eb86: 9500        str	r5, [sp, #0]
@   0x0801eb88: 9601        str	r6, [sp, #4]
@   0x0801eb8a: 7860        ldrb	r0, [r4, #1]
@   0x0801eb8c: 9002        str	r0, [sp, #8]
@   0x0801eb8e: 2000        movs	r0, #0
@   0x0801eb90: 2116        movs	r1, #22
@   0x0801eb92: 2207        movs	r2, #7
@   0x0801eb94: 1c3b        adds	r3, r7, #0
@   0x0801eb96: f7fe        fa03 	bl	0x1cfa0
@   0x0801eb9a: 7860        ldrb	r0, [r4, #1]
@   0x0801eb9c: 2800        cmp	r0, #0
@   0x0801eb9e: d009        beq.n	0x1ebb4
@   0x0801eba0: 4803        ldr	r0, [pc, #12]	@ (0x1ebb0)
@   0x0801eba2: 6800        ldr	r0, [r0, #0]
@   0x0801eba4: 00c0        lsls	r0, r0, #3
@   0x0801eba6: e00a        b.n	0x1ebbe
@   0x0801eba8: 013d        lsls	r5, r7, #4
@   0x0801ebaa: 0000        movs	r0, r0
@   0x0801ebac: 34b4        adds	r4, #180	@ 0xb4
@   0x0801ebae: 0300        lsls	r0, r0, #12
@   0x0801ebb0: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ebb2: 0300        lsls	r0, r0, #12
@   0x0801ebb4: 4809        ldr	r0, [pc, #36]	@ (0x1ebdc)
@   0x0801ebb6: 6800        ldr	r0, [r0, #0]
@   0x0801ebb8: 0040        lsls	r0, r0, #1
@   0x0801ebba: 3001        adds	r0, #1
@   0x0801ebbc: 0080        lsls	r0, r0, #2
@   0x0801ebbe: 4468        add	r0, sp
@   0x0801ebc0: 300c        adds	r0, #12
@   0x0801ebc2: 6800        ldr	r0, [r0, #0]
@   0x0801ebc4: 21a0        movs	r1, #160	@ 0xa0
@   0x0801ebc6: 0049        lsls	r1, r1, #1
@   0x0801ebc8: 9100        str	r1, [sp, #0]
@   0x0801ebca: 9501        str	r5, [sp, #4]
@   0x0801ebcc: 9602        str	r6, [sp, #8]
@   0x0801ebce: 2103        movs	r1, #3
@   0x0801ebd0: 2213        movs	r2, #19
@   0x0801ebd2: 2307        movs	r3, #7
@   0x0801ebd4: f7fd        f952 	bl	0x1be7c
@   0x0801ebd8: e0c6        b.n	0x1ed68
@   0x0801ebda: 0000        movs	r0, r0
@   0x0801ebdc: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ebde: 0300        lsls	r0, r0, #12
@   0x0801ebe0: 4a1d        ldr	r2, [pc, #116]	@ (0x1ec58)
@   0x0801ebe2: 4690        mov	r8, r2
@   0x0801ebe4: 2505        movs	r5, #5
@   0x0801ebe6: 9500        str	r5, [sp, #0]
@   0x0801ebe8: 2602        movs	r6, #2
@   0x0801ebea: 9601        str	r6, [sp, #4]
@   0x0801ebec: 2100        movs	r1, #0
@   0x0801ebee: 4c1b        ldr	r4, [pc, #108]	@ (0x1ec5c)
@   0x0801ebf0: 7820        ldrb	r0, [r4, #0]
@   0x0801ebf2: 2800        cmp	r0, #0
@   0x0801ebf4: d100        bne.n	0x1ebf8
@   0x0801ebf6: 2101        movs	r1, #1
@   0x0801ebf8: 9102        str	r1, [sp, #8]
@   0x0801ebfa: 2001        movs	r0, #1
@   0x0801ebfc: 2112        movs	r1, #18
@   0x0801ebfe: 2203        movs	r2, #3
@   0x0801ec00: 4643        mov	r3, r8
@   0x0801ec02: f7fe        f9cd 	bl	0x1cfa0
@   0x0801ec06: 9500        str	r5, [sp, #0]
@   0x0801ec08: 9601        str	r6, [sp, #4]
@   0x0801ec0a: 7820        ldrb	r0, [r4, #0]
@   0x0801ec0c: 9002        str	r0, [sp, #8]
@   0x0801ec0e: 2000        movs	r0, #0
@   0x0801ec10: 2115        movs	r1, #21
@   0x0801ec12: 2203        movs	r2, #3
@   0x0801ec14: 4643        mov	r3, r8
@   0x0801ec16: f7fe        f9c3 	bl	0x1cfa0
@   0x0801ec1a: 7820        ldrb	r0, [r4, #0]
@   0x0801ec1c: 2800        cmp	r0, #0
@   0x0801ec1e: d121        bne.n	0x1ec64
@   0x0801ec20: 6838        ldr	r0, [r7, #0]
@   0x0801ec22: 0040        lsls	r0, r0, #1
@   0x0801ec24: 3001        adds	r0, #1
@   0x0801ec26: 0080        lsls	r0, r0, #2
@   0x0801ec28: 4468        add	r0, sp
@   0x0801ec2a: 300c        adds	r0, #12
@   0x0801ec2c: 6800        ldr	r0, [r0, #0]
@   0x0801ec2e: 24a0        movs	r4, #160	@ 0xa0
@   0x0801ec30: 0064        lsls	r4, r4, #1
@   0x0801ec32: 9400        str	r4, [sp, #0]
@   0x0801ec34: 9501        str	r5, [sp, #4]
@   0x0801ec36: 9602        str	r6, [sp, #8]
@   0x0801ec38: 2103        movs	r1, #3
@   0x0801ec3a: 2213        movs	r2, #19
@   0x0801ec3c: 2303        movs	r3, #3
@   0x0801ec3e: f7fd        f91d 	bl	0x1be7c
@   0x0801ec42: 4807        ldr	r0, [pc, #28]	@ (0x1ec60)
@   0x0801ec44: 9400        str	r4, [sp, #0]
@   0x0801ec46: 9501        str	r5, [sp, #4]
@   0x0801ec48: 9602        str	r6, [sp, #8]
@   0x0801ec4a: 2103        movs	r1, #3
@   0x0801ec4c: 2214        movs	r2, #20
@   0x0801ec4e: 2301        movs	r3, #1
@   0x0801ec50: f7fd        f914 	bl	0x1be7c
@   0x0801ec54: e01e        b.n	0x1ec94
@   0x0801ec56: 0000        movs	r0, r0
@   0x0801ec58: 013d        lsls	r5, r7, #4
@   0x0801ec5a: 0000        movs	r0, r0
@   0x0801ec5c: 34b4        adds	r4, #180	@ 0xb4
@   0x0801ec5e: 0300        lsls	r0, r0, #12
@   0x0801ec60: e7f8        b.n	0x1ec54
@   0x0801ec62: 081b        lsrs	r3, r3, #32
@   0x0801ec64: 6838        ldr	r0, [r7, #0]
@   0x0801ec66: 00c0        lsls	r0, r0, #3
@   0x0801ec68: 4468        add	r0, sp
@   0x0801ec6a: 300c        adds	r0, #12
@   0x0801ec6c: 6800        ldr	r0, [r0, #0]
@   0x0801ec6e: 24a0        movs	r4, #160	@ 0xa0
@   0x0801ec70: 0064        lsls	r4, r4, #1
@   0x0801ec72: 9400        str	r4, [sp, #0]
@   0x0801ec74: 9501        str	r5, [sp, #4]
@   0x0801ec76: 9602        str	r6, [sp, #8]
@   0x0801ec78: 2103        movs	r1, #3
@   0x0801ec7a: 2213        movs	r2, #19
@   0x0801ec7c: 2303        movs	r3, #3
@   0x0801ec7e: f7fd        f8fd 	bl	0x1be7c
@   0x0801ec82: 4822        ldr	r0, [pc, #136]	@ (0x1ed0c)
@   0x0801ec84: 9400        str	r4, [sp, #0]
@   0x0801ec86: 9501        str	r5, [sp, #4]
@   0x0801ec88: 9602        str	r6, [sp, #8]
@   0x0801ec8a: 2103        movs	r1, #3
@   0x0801ec8c: 2214        movs	r2, #20
@   0x0801ec8e: 2302        movs	r3, #2
@   0x0801ec90: f7fd        f8f4 	bl	0x1be7c
@   0x0801ec94: 4f1e        ldr	r7, [pc, #120]	@ (0x1ed10)
@   0x0801ec96: 2505        movs	r5, #5
@   0x0801ec98: 9500        str	r5, [sp, #0]
@   0x0801ec9a: 2602        movs	r6, #2
@   0x0801ec9c: 9601        str	r6, [sp, #4]
@   0x0801ec9e: 2100        movs	r1, #0
@   0x0801eca0: 4c1c        ldr	r4, [pc, #112]	@ (0x1ed14)
@   0x0801eca2: 7860        ldrb	r0, [r4, #1]
@   0x0801eca4: 2800        cmp	r0, #0
@   0x0801eca6: d100        bne.n	0x1ecaa
@   0x0801eca8: 2101        movs	r1, #1
@   0x0801ecaa: 9102        str	r1, [sp, #8]
@   0x0801ecac: 2001        movs	r0, #1
@   0x0801ecae: 2118        movs	r1, #24
@   0x0801ecb0: 2207        movs	r2, #7
@   0x0801ecb2: 1c3b        adds	r3, r7, #0
@   0x0801ecb4: f7fe        f974 	bl	0x1cfa0
@   0x0801ecb8: 9500        str	r5, [sp, #0]
@   0x0801ecba: 9601        str	r6, [sp, #4]
@   0x0801ecbc: 7860        ldrb	r0, [r4, #1]
@   0x0801ecbe: 9002        str	r0, [sp, #8]
@   0x0801ecc0: 2000        movs	r0, #0
@   0x0801ecc2: 211b        movs	r1, #27
@   0x0801ecc4: 2207        movs	r2, #7
@   0x0801ecc6: 1c3b        adds	r3, r7, #0
@   0x0801ecc8: f7fe        f96a 	bl	0x1cfa0
@   0x0801eccc: 7860        ldrb	r0, [r4, #1]
@   0x0801ecce: 2800        cmp	r0, #0
@   0x0801ecd0: d126        bne.n	0x1ed20
@   0x0801ecd2: 4811        ldr	r0, [pc, #68]	@ (0x1ed18)
@   0x0801ecd4: 6800        ldr	r0, [r0, #0]
@   0x0801ecd6: 0040        lsls	r0, r0, #1
@   0x0801ecd8: 3001        adds	r0, #1
@   0x0801ecda: 0080        lsls	r0, r0, #2
@   0x0801ecdc: 4468        add	r0, sp
@   0x0801ecde: 300c        adds	r0, #12
@   0x0801ece0: 6800        ldr	r0, [r0, #0]
@   0x0801ece2: 24a0        movs	r4, #160	@ 0xa0
@   0x0801ece4: 0064        lsls	r4, r4, #1
@   0x0801ece6: 9400        str	r4, [sp, #0]
@   0x0801ece8: 9501        str	r5, [sp, #4]
@   0x0801ecea: 9602        str	r6, [sp, #8]
@   0x0801ecec: 2103        movs	r1, #3
@   0x0801ecee: 2219        movs	r2, #25
@   0x0801ecf0: 2307        movs	r3, #7
@   0x0801ecf2: f7fd        f8c3 	bl	0x1be7c
@   0x0801ecf6: 4809        ldr	r0, [pc, #36]	@ (0x1ed1c)
@   0x0801ecf8: 9400        str	r4, [sp, #0]
@   0x0801ecfa: 9501        str	r5, [sp, #4]
@   0x0801ecfc: 9602        str	r6, [sp, #8]
@   0x0801ecfe: 2103        movs	r1, #3
@   0x0801ed00: 221a        movs	r2, #26
@   0x0801ed02: 2305        movs	r3, #5
@   0x0801ed04: f7fd        f8ba 	bl	0x1be7c
@   0x0801ed08: e023        b.n	0x1ed52
@   0x0801ed0a: 0000        movs	r0, r0
@   0x0801ed0c: e7fc        b.n	0x1ed08
@   0x0801ed0e: 081b        lsrs	r3, r3, #32
@   0x0801ed10: 013d        lsls	r5, r7, #4
@   0x0801ed12: 0000        movs	r0, r0
@   0x0801ed14: 34b4        adds	r4, #180	@ 0xb4
@   0x0801ed16: 0300        lsls	r0, r0, #12
@   0x0801ed18: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ed1a: 0300        lsls	r0, r0, #12
@   0x0801ed1c: e7f8        b.n	0x1ed10
@   0x0801ed1e: 081b        lsrs	r3, r3, #32
@   0x0801ed20: 481b        ldr	r0, [pc, #108]	@ (0x1ed90)
@   0x0801ed22: 6800        ldr	r0, [r0, #0]
@   0x0801ed24: 00c0        lsls	r0, r0, #3
@   0x0801ed26: 4468        add	r0, sp
@   0x0801ed28: 300c        adds	r0, #12
@   0x0801ed2a: 6800        ldr	r0, [r0, #0]
@   0x0801ed2c: 24a0        movs	r4, #160	@ 0xa0
@   0x0801ed2e: 0064        lsls	r4, r4, #1
@   0x0801ed30: 9400        str	r4, [sp, #0]
@   0x0801ed32: 9501        str	r5, [sp, #4]
@   0x0801ed34: 9602        str	r6, [sp, #8]
@   0x0801ed36: 2103        movs	r1, #3
@   0x0801ed38: 2219        movs	r2, #25
@   0x0801ed3a: 2307        movs	r3, #7
@   0x0801ed3c: f7fd        f89e 	bl	0x1be7c
@   0x0801ed40: 4814        ldr	r0, [pc, #80]	@ (0x1ed94)
@   0x0801ed42: 9400        str	r4, [sp, #0]
@   0x0801ed44: 9501        str	r5, [sp, #4]
@   0x0801ed46: 9602        str	r6, [sp, #8]
@   0x0801ed48: 2103        movs	r1, #3
@   0x0801ed4a: 221a        movs	r2, #26
@   0x0801ed4c: 2306        movs	r3, #6
@   0x0801ed4e: f7fd        f895 	bl	0x1be7c
@   0x0801ed52: 4911        ldr	r1, [pc, #68]	@ (0x1ed98)
@   0x0801ed54: 980d        ldr	r0, [sp, #52]	@ 0x34
@   0x0801ed56: 4008        ands	r0, r1
@   0x0801ed58: 21d0        movs	r1, #208	@ 0xd0
@   0x0801ed5a: 0349        lsls	r1, r1, #13
@   0x0801ed5c: 4308        orrs	r0, r1
@   0x0801ed5e: 490f        ldr	r1, [pc, #60]	@ (0x1ed9c)
@   0x0801ed60: 4008        ands	r0, r1
@   0x0801ed62: 2102        movs	r1, #2
@   0x0801ed64: 4308        orrs	r0, r1
@   0x0801ed66: 900d        str	r0, [sp, #52]	@ 0x34
@   0x0801ed68: 230b        movs	r3, #11
@   0x0801ed6a: 4698        mov	r8, r3
@   0x0801ed6c: 480c        ldr	r0, [pc, #48]	@ (0x1eda0)
@   0x0801ed6e: 7880        ldrb	r0, [r0, #2]
@   0x0801ed70: 2803        cmp	r0, #3
@   0x0801ed72: d119        bne.n	0x1eda8
@   0x0801ed74: 4b0b        ldr	r3, [pc, #44]	@ (0x1eda4)
@   0x0801ed76: 2005        movs	r0, #5
@   0x0801ed78: 9000        str	r0, [sp, #0]
@   0x0801ed7a: 2002        movs	r0, #2
@   0x0801ed7c: 9001        str	r0, [sp, #4]
@   0x0801ed7e: 2000        movs	r0, #0
@   0x0801ed80: 9002        str	r0, [sp, #8]
@   0x0801ed82: 2001        movs	r0, #1
@   0x0801ed84: 2112        movs	r1, #18
@   0x0801ed86: 220b        movs	r2, #11
@   0x0801ed88: f7fe        f90a 	bl	0x1cfa0
@   0x0801ed8c: e017        b.n	0x1edbe
@   0x0801ed8e: 0000        movs	r0, r0
@   0x0801ed90: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ed92: 0300        lsls	r0, r0, #12
@   0x0801ed94: e7fc        b.n	0x1ed90
@   0x0801ed96: 081b        lsrs	r3, r3, #32
@   0x0801ed98: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801ed9c: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801eda0: 34b4        adds	r4, #180	@ 0xb4
@   0x0801eda2: 0300        lsls	r0, r0, #12
@   0x0801eda4: 013d        lsls	r5, r7, #4
@   0x0801eda6: 0000        movs	r0, r0
@   0x0801eda8: 4b0d        ldr	r3, [pc, #52]	@ (0x1ede0)
@   0x0801edaa: 2005        movs	r0, #5
@   0x0801edac: 9000        str	r0, [sp, #0]
@   0x0801edae: 2002        movs	r0, #2
@   0x0801edb0: 9001        str	r0, [sp, #4]
@   0x0801edb2: 2001        movs	r0, #1
@   0x0801edb4: 9002        str	r0, [sp, #8]
@   0x0801edb6: 2112        movs	r1, #18
@   0x0801edb8: 220b        movs	r2, #11
@   0x0801edba: f7fe        f8f1 	bl	0x1cfa0
@   0x0801edbe: 4809        ldr	r0, [pc, #36]	@ (0x1ede4)
@   0x0801edc0: 7880        ldrb	r0, [r0, #2]
@   0x0801edc2: 2809        cmp	r0, #9
@   0x0801edc4: d110        bne.n	0x1ede8
@   0x0801edc6: 4b06        ldr	r3, [pc, #24]	@ (0x1ede0)
@   0x0801edc8: 2005        movs	r0, #5
@   0x0801edca: 9000        str	r0, [sp, #0]
@   0x0801edcc: 2002        movs	r0, #2
@   0x0801edce: 9001        str	r0, [sp, #4]
@   0x0801edd0: 2000        movs	r0, #0
@   0x0801edd2: 9002        str	r0, [sp, #8]
@   0x0801edd4: 2116        movs	r1, #22
@   0x0801edd6: 4642        mov	r2, r8
@   0x0801edd8: f7fe        f8e2 	bl	0x1cfa0
@   0x0801eddc: e010        b.n	0x1ee00
@   0x0801edde: 0000        movs	r0, r0
@   0x0801ede0: 013d        lsls	r5, r7, #4
@   0x0801ede2: 0000        movs	r0, r0
@   0x0801ede4: 34b4        adds	r4, #180	@ 0xb4
@   0x0801ede6: 0300        lsls	r0, r0, #12
@   0x0801ede8: 4b14        ldr	r3, [pc, #80]	@ (0x1ee3c)
@   0x0801edea: 2005        movs	r0, #5
@   0x0801edec: 9000        str	r0, [sp, #0]
@   0x0801edee: 2002        movs	r0, #2
@   0x0801edf0: 9001        str	r0, [sp, #4]
@   0x0801edf2: 2001        movs	r0, #1
@   0x0801edf4: 9002        str	r0, [sp, #8]
@   0x0801edf6: 2000        movs	r0, #0
@   0x0801edf8: 2116        movs	r1, #22
@   0x0801edfa: 4642        mov	r2, r8
@   0x0801edfc: f7fe        f8d0 	bl	0x1cfa0
@   0x0801ee00: 4c0f        ldr	r4, [pc, #60]	@ (0x1ee40)
@   0x0801ee02: 78a0        ldrb	r0, [r4, #2]
@   0x0801ee04: 23a0        movs	r3, #160	@ 0xa0
@   0x0801ee06: 005b        lsls	r3, r3, #1
@   0x0801ee08: 2505        movs	r5, #5
@   0x0801ee0a: 9500        str	r5, [sp, #0]
@   0x0801ee0c: 2602        movs	r6, #2
@   0x0801ee0e: 9601        str	r6, [sp, #4]
@   0x0801ee10: 2700        movs	r7, #0
@   0x0801ee12: 9702        str	r7, [sp, #8]
@   0x0801ee14: 2114        movs	r1, #20
@   0x0801ee16: 4642        mov	r2, r8
@   0x0801ee18: f7fd        fa4c 	bl	0x1c2b4
@   0x0801ee1c: 200f        movs	r0, #15
@   0x0801ee1e: 4680        mov	r8, r0
@   0x0801ee20: 78e4        ldrb	r4, [r4, #3]
@   0x0801ee22: 2c03        cmp	r4, #3
@   0x0801ee24: d10e        bne.n	0x1ee44
@   0x0801ee26: 4b05        ldr	r3, [pc, #20]	@ (0x1ee3c)
@   0x0801ee28: 9500        str	r5, [sp, #0]
@   0x0801ee2a: 9601        str	r6, [sp, #4]
@   0x0801ee2c: 9702        str	r7, [sp, #8]
@   0x0801ee2e: 2001        movs	r0, #1
@   0x0801ee30: 2112        movs	r1, #18
@   0x0801ee32: 220f        movs	r2, #15
@   0x0801ee34: f7fe        f8b4 	bl	0x1cfa0
@   0x0801ee38: e00d        b.n	0x1ee56
@   0x0801ee3a: 0000        movs	r0, r0
@   0x0801ee3c: 013d        lsls	r5, r7, #4
@   0x0801ee3e: 0000        movs	r0, r0
@   0x0801ee40: 34b4        adds	r4, #180	@ 0xb4
@   0x0801ee42: 0300        lsls	r0, r0, #12
@   0x0801ee44: 4b0c        ldr	r3, [pc, #48]	@ (0x1ee78)
@   0x0801ee46: 9500        str	r5, [sp, #0]
@   0x0801ee48: 9601        str	r6, [sp, #4]
@   0x0801ee4a: 2001        movs	r0, #1
@   0x0801ee4c: 9002        str	r0, [sp, #8]
@   0x0801ee4e: 2112        movs	r1, #18
@   0x0801ee50: 220f        movs	r2, #15
@   0x0801ee52: f7fe        f8a5 	bl	0x1cfa0
@   0x0801ee56: 4809        ldr	r0, [pc, #36]	@ (0x1ee7c)
@   0x0801ee58: 78c0        ldrb	r0, [r0, #3]
@   0x0801ee5a: 2809        cmp	r0, #9
@   0x0801ee5c: d110        bne.n	0x1ee80
@   0x0801ee5e: 4b06        ldr	r3, [pc, #24]	@ (0x1ee78)
@   0x0801ee60: 2005        movs	r0, #5
@   0x0801ee62: 9000        str	r0, [sp, #0]
@   0x0801ee64: 2002        movs	r0, #2
@   0x0801ee66: 9001        str	r0, [sp, #4]
@   0x0801ee68: 2000        movs	r0, #0
@   0x0801ee6a: 9002        str	r0, [sp, #8]
@   0x0801ee6c: 2116        movs	r1, #22
@   0x0801ee6e: 4642        mov	r2, r8
@   0x0801ee70: f7fe        f896 	bl	0x1cfa0
@   0x0801ee74: e010        b.n	0x1ee98
@   0x0801ee76: 0000        movs	r0, r0
@   0x0801ee78: 013d        lsls	r5, r7, #4
@   0x0801ee7a: 0000        movs	r0, r0
@   0x0801ee7c: 34b4        adds	r4, #180	@ 0xb4
@   0x0801ee7e: 0300        lsls	r0, r0, #12
@   0x0801ee80: 4b12        ldr	r3, [pc, #72]	@ (0x1eecc)
@   0x0801ee82: 2005        movs	r0, #5
@   0x0801ee84: 9000        str	r0, [sp, #0]
@   0x0801ee86: 2002        movs	r0, #2
@   0x0801ee88: 9001        str	r0, [sp, #4]
@   0x0801ee8a: 2001        movs	r0, #1
@   0x0801ee8c: 9002        str	r0, [sp, #8]
@   0x0801ee8e: 2000        movs	r0, #0
@   0x0801ee90: 2116        movs	r1, #22
@   0x0801ee92: 4642        mov	r2, r8
@   0x0801ee94: f7fe        f884 	bl	0x1cfa0
@   0x0801ee98: 480d        ldr	r0, [pc, #52]	@ (0x1eed0)
@   0x0801ee9a: 78c0        ldrb	r0, [r0, #3]
@   0x0801ee9c: 23a0        movs	r3, #160	@ 0xa0
@   0x0801ee9e: 005b        lsls	r3, r3, #1
@   0x0801eea0: 2105        movs	r1, #5
@   0x0801eea2: 9100        str	r1, [sp, #0]
@   0x0801eea4: 2102        movs	r1, #2
@   0x0801eea6: 9101        str	r1, [sp, #4]
@   0x0801eea8: 2100        movs	r1, #0
@   0x0801eeaa: 9102        str	r1, [sp, #8]
@   0x0801eeac: 2114        movs	r1, #20
@   0x0801eeae: 4642        mov	r2, r8
@   0x0801eeb0: f7fd        fa00 	bl	0x1c2b4
@   0x0801eeb4: a80d        add	r0, sp, #52	@ 0x34
@   0x0801eeb6: 2105        movs	r1, #5
@   0x0801eeb8: 2204        movs	r2, #4
@   0x0801eeba: 2302        movs	r3, #2
@   0x0801eebc: f7f9        fb0e 	bl	0x184dc
@   0x0801eec0: b00e        add	sp, #56	@ 0x38
@   0x0801eec2: bc08        pop	{r3}
@   0x0801eec4: 4698        mov	r8, r3
@   0x0801eec6: bcf0        pop	{r4, r5, r6, r7}
@   0x0801eec8: bc01        pop	{r0}
@   0x0801eeca: 4700        bx	r0
@   0x0801eecc: 013d        lsls	r5, r7, #4
@   0x0801eece: 0000        movs	r0, r0
@   0x0801eed0: 34b4        adds	r4, #180	@ 0xb4
@   0x0801eed2: 0300        lsls	r0, r0, #12
@   0x0801eed4: b530        push	{r4, r5, lr}
@   0x0801eed6: b088        sub	sp, #32
@   0x0801eed8: 2100        movs	r1, #0
@   0x0801eeda: 9104        str	r1, [sp, #16]
@   0x0801eedc: 4815        ldr	r0, [pc, #84]	@ (0x1ef34)
@   0x0801eede: 9005        str	r0, [sp, #20]
@   0x0801eee0: 4a15        ldr	r2, [pc, #84]	@ (0x1ef38)
@   0x0801eee2: 4816        ldr	r0, [pc, #88]	@ (0x1ef3c)
@   0x0801eee4: 6800        ldr	r0, [r0, #0]
@   0x0801eee6: 0080        lsls	r0, r0, #2
@   0x0801eee8: 1880        adds	r0, r0, r2
@   0x0801eeea: 6800        ldr	r0, [r0, #0]
@   0x0801eeec: 9006        str	r0, [sp, #24]
@   0x0801eeee: 9107        str	r1, [sp, #28]
@   0x0801eef0: 4813        ldr	r0, [pc, #76]	@ (0x1ef40)
@   0x0801eef2: 7501        strb	r1, [r0, #20]
@   0x0801eef4: 4c13        ldr	r4, [pc, #76]	@ (0x1ef44)
@   0x0801eef6: 68a0        ldr	r0, [r4, #8]
@   0x0801eef8: 2800        cmp	r0, #0
@   0x0801eefa: d135        bne.n	0x1ef68
@   0x0801eefc: f7f9        faa6 	bl	0x1844c
@   0x0801ef00: 4911        ldr	r1, [pc, #68]	@ (0x1ef48)
@   0x0801ef02: 4812        ldr	r0, [pc, #72]	@ (0x1ef4c)
@   0x0801ef04: 6008        str	r0, [r1, #0]
@   0x0801ef06: 20a0        movs	r0, #160	@ 0xa0
@   0x0801ef08: 04c0        lsls	r0, r0, #19
@   0x0801ef0a: 6048        str	r0, [r1, #4]
@   0x0801ef0c: 4810        ldr	r0, [pc, #64]	@ (0x1ef50)
@   0x0801ef0e: 6088        str	r0, [r1, #8]
@   0x0801ef10: 6888        ldr	r0, [r1, #8]
@   0x0801ef12: 4810        ldr	r0, [pc, #64]	@ (0x1ef54)
@   0x0801ef14: 6008        str	r0, [r1, #0]
@   0x0801ef16: 20c0        movs	r0, #192	@ 0xc0
@   0x0801ef18: 04c0        lsls	r0, r0, #19
@   0x0801ef1a: 6048        str	r0, [r1, #4]
@   0x0801ef1c: 480e        ldr	r0, [pc, #56]	@ (0x1ef58)
@   0x0801ef1e: 6088        str	r0, [r1, #8]
@   0x0801ef20: 6888        ldr	r0, [r1, #8]
@   0x0801ef22: 480e        ldr	r0, [pc, #56]	@ (0x1ef5c)
@   0x0801ef24: 6008        str	r0, [r1, #0]
@   0x0801ef26: 480e        ldr	r0, [pc, #56]	@ (0x1ef60)
@   0x0801ef28: 6048        str	r0, [r1, #4]
@   0x0801ef2a: 480e        ldr	r0, [pc, #56]	@ (0x1ef64)
@   0x0801ef2c: 6088        str	r0, [r1, #8]
@   0x0801ef2e: 6888        ldr	r0, [r1, #8]
@   0x0801ef30: e036        b.n	0x1efa0
@   0x0801ef32: 0000        movs	r0, r0
@   0x0801ef34: 8b98        ldrh	r0, [r3, #28]
@   0x0801ef36: 081d        lsrs	r5, r3, #32
@   0x0801ef38: 8ef4        ldrh	r4, [r6, #54]	@ 0x36
@   0x0801ef3a: 0830        lsrs	r0, r6, #32
@   0x0801ef3c: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ef3e: 0300        lsls	r0, r0, #12
@   0x0801ef40: 3480        adds	r4, #128	@ 0x80
@   0x0801ef42: 0300        lsls	r0, r0, #12
@   0x0801ef44: 34a0        adds	r4, #160	@ 0xa0
@   0x0801ef46: 0300        lsls	r0, r0, #12
@   0x0801ef48: 00d4        lsls	r4, r2, #3
@   0x0801ef4a: 0400        lsls	r0, r0, #16
@   0x0801ef4c: ab98        add	r3, sp, #608	@ 0x260
@   0x0801ef4e: 081d        lsrs	r5, r3, #32
@   0x0801ef50: 0100        lsls	r0, r0, #4
@   0x0801ef52: 8000        strh	r0, [r0, #0]
@   0x0801ef54: ad98        add	r5, sp, #608	@ 0x260
@   0x0801ef56: 081d        lsrs	r5, r3, #32
@   0x0801ef58: 4000        ands	r0, r0
@   0x0801ef5a: 8000        strh	r0, [r0, #0]
@   0x0801ef5c: 4418        add	r0, r3
@   0x0801ef5e: 081e        lsrs	r6, r3, #32
@   0x0801ef60: e000        b.n	0x1ef64
@   0x0801ef62: 0600        lsls	r0, r0, #24
@   0x0801ef64: 0400        lsls	r0, r0, #16
@   0x0801ef66: 8000        strh	r0, [r0, #0]
@   0x0801ef68: 200e        movs	r0, #14
@   0x0801ef6a: f7f9        fe4f 	bl	0x18c0c
@   0x0801ef6e: 2200        movs	r2, #0
@   0x0801ef70: 68a0        ldr	r0, [r4, #8]
@   0x0801ef72: 2800        cmp	r0, #0
@   0x0801ef74: d100        bne.n	0x1ef78
@   0x0801ef76: 2201        movs	r2, #1
@   0x0801ef78: 2002        movs	r0, #2
@   0x0801ef7a: 9003        str	r0, [sp, #12]
@   0x0801ef7c: 4669        mov	r1, sp
@   0x0801ef7e: a805        add	r0, sp, #20
@   0x0801ef80: c838        ldmia	r0!, {r3, r4, r5}
@   0x0801ef82: c138        stmia	r1!, {r3, r4, r5}
@   0x0801ef84: 9b04        ldr	r3, [sp, #16]
@   0x0801ef86: 1c10        adds	r0, r2, #0
@   0x0801ef88: 211d        movs	r1, #29
@   0x0801ef8a: 2206        movs	r2, #6
@   0x0801ef8c: f7f9        fc84 	bl	0x18898
@   0x0801ef90: 2280        movs	r2, #128	@ 0x80
@   0x0801ef92: 04d2        lsls	r2, r2, #19
@   0x0801ef94: 8810        ldrh	r0, [r2, #0]
@   0x0801ef96: 2380        movs	r3, #128	@ 0x80
@   0x0801ef98: 011b        lsls	r3, r3, #4
@   0x0801ef9a: 1c19        adds	r1, r3, #0
@   0x0801ef9c: 4308        orrs	r0, r1
@   0x0801ef9e: 8010        strh	r0, [r2, #0]
@   0x0801efa0: 2280        movs	r2, #128	@ 0x80
@   0x0801efa2: 04d2        lsls	r2, r2, #19
@   0x0801efa4: 8810        ldrh	r0, [r2, #0]
@   0x0801efa6: 2480        movs	r4, #128	@ 0x80
@   0x0801efa8: 00a4        lsls	r4, r4, #2
@   0x0801efaa: 1c21        adds	r1, r4, #0
@   0x0801efac: 4308        orrs	r0, r1
@   0x0801efae: 8010        strh	r0, [r2, #0]
@   0x0801efb0: 4913        ldr	r1, [pc, #76]	@ (0x1f000)
@   0x0801efb2: 4814        ldr	r0, [pc, #80]	@ (0x1f004)
@   0x0801efb4: 6008        str	r0, [r1, #0]
@   0x0801efb6: 4814        ldr	r0, [pc, #80]	@ (0x1f008)
@   0x0801efb8: 6048        str	r0, [r1, #4]
@   0x0801efba: 4814        ldr	r0, [pc, #80]	@ (0x1f00c)
@   0x0801efbc: 6088        str	r0, [r1, #8]
@   0x0801efbe: 6888        ldr	r0, [r1, #8]
@   0x0801efc0: f000        f90e 	bl	0x1f1e0
@   0x0801efc4: 4c12        ldr	r4, [pc, #72]	@ (0x1f010)
@   0x0801efc6: 68a0        ldr	r0, [r4, #8]
@   0x0801efc8: 2800        cmp	r0, #0
@   0x0801efca: d00f        beq.n	0x1efec
@   0x0801efcc: 4911        ldr	r1, [pc, #68]	@ (0x1f014)
@   0x0801efce: 4812        ldr	r0, [pc, #72]	@ (0x1f018)
@   0x0801efd0: 6800        ldr	r0, [r0, #0]
@   0x0801efd2: 0080        lsls	r0, r0, #2
@   0x0801efd4: 1840        adds	r0, r0, r1
@   0x0801efd6: 6800        ldr	r0, [r0, #0]
@   0x0801efd8: 68c2        ldr	r2, [r0, #12]
@   0x0801efda: 2000        movs	r0, #0
@   0x0801efdc: 9000        str	r0, [sp, #0]
@   0x0801efde: 2001        movs	r0, #1
@   0x0801efe0: 9001        str	r0, [sp, #4]
@   0x0801efe2: 2000        movs	r0, #0
@   0x0801efe4: 2106        movs	r1, #6
@   0x0801efe6: 231c        movs	r3, #28
@   0x0801efe8: f7fd        fc8a 	bl	0x1c900
@   0x0801efec: 480b        ldr	r0, [pc, #44]	@ (0x1f01c)
@   0x0801efee: 2100        movs	r1, #0
@   0x0801eff0: 8001        strh	r1, [r0, #0]
@   0x0801eff2: 7860        ldrb	r0, [r4, #1]
@   0x0801eff4: 3001        adds	r0, #1
@   0x0801eff6: 7060        strb	r0, [r4, #1]
@   0x0801eff8: b008        add	sp, #32
@   0x0801effa: bc30        pop	{r4, r5}
@   0x0801effc: bc01        pop	{r0}
@   0x0801effe: 4700        bx	r0
@   0x0801f000: 00d4        lsls	r4, r2, #3
@   0x0801f002: 0400        lsls	r0, r0, #16
@   0x0801f004: 8b98        ldrh	r0, [r3, #28]
@   0x0801f006: 081d        lsrs	r5, r3, #32
@   0x0801f008: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801f00c: 0400        lsls	r0, r0, #16
@   0x0801f00e: 8000        strh	r0, [r0, #0]
@   0x0801f010: 34a0        adds	r4, #160	@ 0xa0
@   0x0801f012: 0300        lsls	r0, r0, #12
@   0x0801f014: 8110        strh	r0, [r2, #8]
@   0x0801f016: 0830        lsrs	r0, r6, #32
@   0x0801f018: 34b0        adds	r4, #176	@ 0xb0
@   0x0801f01a: 0300        lsls	r0, r0, #12
@   0x0801f01c: 5398        strh	r0, [r3, r6]
@   0x0801f01e: 0300        lsls	r0, r0, #12
@   0x0801f020: b530        push	{r4, r5, lr}
@   0x0801f022: b082        sub	sp, #8
@   0x0801f024: f7e1        fa4e 	bl	0x4c4
@   0x0801f028: 4904        ldr	r1, [pc, #16]	@ (0x1f03c)
@   0x0801f02a: 8008        strh	r0, [r1, #0]
@   0x0801f02c: 8808        ldrh	r0, [r1, #0]
@   0x0801f02e: 2802        cmp	r0, #2
@   0x0801f030: d01b        beq.n	0x1f06a
@   0x0801f032: 2802        cmp	r0, #2
@   0x0801f034: dc04        bgt.n	0x1f040
@   0x0801f036: 2801        cmp	r0, #1
@   0x0801f038: d007        beq.n	0x1f04a
@   0x0801f03a: e093        b.n	0x1f164
@   0x0801f03c: 5398        strh	r0, [r3, r6]
@   0x0801f03e: 0300        lsls	r0, r0, #12
@   0x0801f040: 2810        cmp	r0, #16
@   0x0801f042: d021        beq.n	0x1f088
@   0x0801f044: 2840        cmp	r0, #64	@ 0x40
@   0x0801f046: d01f        beq.n	0x1f088
@   0x0801f048: e08c        b.n	0x1f164
@   0x0801f04a: 2002        movs	r0, #2
@   0x0801f04c: f001        fe14 	bl	0x20c78
@   0x0801f050: 4903        ldr	r1, [pc, #12]	@ (0x1f060)
@   0x0801f052: 7d08        ldrb	r0, [r1, #20]
@   0x0801f054: 2800        cmp	r0, #0
@   0x0801f056: d105        bne.n	0x1f064
@   0x0801f058: 2003        movs	r0, #3
@   0x0801f05a: 7508        strb	r0, [r1, #20]
@   0x0801f05c: e082        b.n	0x1f164
@   0x0801f05e: 0000        movs	r0, r0
@   0x0801f060: 3480        adds	r4, #128	@ 0x80
@   0x0801f062: 0300        lsls	r0, r0, #12
@   0x0801f064: 3801        subs	r0, #1
@   0x0801f066: 7508        strb	r0, [r1, #20]
@   0x0801f068: e07c        b.n	0x1f164
@   0x0801f06a: 2002        movs	r0, #2
@   0x0801f06c: f001        fe04 	bl	0x20c78
@   0x0801f070: 4804        ldr	r0, [pc, #16]	@ (0x1f084)
@   0x0801f072: 7d01        ldrb	r1, [r0, #20]
@   0x0801f074: 3101        adds	r1, #1
@   0x0801f076: 7501        strb	r1, [r0, #20]
@   0x0801f078: 2103        movs	r1, #3
@   0x0801f07a: 7d02        ldrb	r2, [r0, #20]
@   0x0801f07c: 4011        ands	r1, r2
@   0x0801f07e: 7501        strb	r1, [r0, #20]
@   0x0801f080: e070        b.n	0x1f164
@   0x0801f082: 0000        movs	r0, r0
@   0x0801f084: 3480        adds	r4, #128	@ 0x80
@   0x0801f086: 0300        lsls	r0, r0, #12
@   0x0801f088: 2001        movs	r0, #1
@   0x0801f08a: f001        fdf5 	bl	0x20c78
@   0x0801f08e: 4813        ldr	r0, [pc, #76]	@ (0x1f0dc)
@   0x0801f090: 4c13        ldr	r4, [pc, #76]	@ (0x1f0e0)
@   0x0801f092: 7800        ldrb	r0, [r0, #0]
@   0x0801f094: 7d21        ldrb	r1, [r4, #20]
@   0x0801f096: 4108        asrs	r0, r1
@   0x0801f098: 2101        movs	r1, #1
@   0x0801f09a: 4008        ands	r0, r1
@   0x0801f09c: 2800        cmp	r0, #0
@   0x0801f09e: d061        beq.n	0x1f164
@   0x0801f0a0: 4810        ldr	r0, [pc, #64]	@ (0x1f0e4)
@   0x0801f0a2: 9901        ldr	r1, [sp, #4]
@   0x0801f0a4: 4001        ands	r1, r0
@   0x0801f0a6: 2003        movs	r0, #3
@   0x0801f0a8: 4301        orrs	r1, r0
@   0x0801f0aa: 4a0f        ldr	r2, [pc, #60]	@ (0x1f0e8)
@   0x0801f0ac: 4011        ands	r1, r2
@   0x0801f0ae: 2380        movs	r3, #128	@ 0x80
@   0x0801f0b0: 00db        lsls	r3, r3, #3
@   0x0801f0b2: 4319        orrs	r1, r3
@   0x0801f0b4: 480d        ldr	r0, [pc, #52]	@ (0x1f0ec)
@   0x0801f0b6: 4001        ands	r1, r0
@   0x0801f0b8: 20c0        movs	r0, #192	@ 0xc0
@   0x0801f0ba: 0480        lsls	r0, r0, #18
@   0x0801f0bc: 4301        orrs	r1, r0
@   0x0801f0be: 480c        ldr	r0, [pc, #48]	@ (0x1f0f0)
@   0x0801f0c0: 4001        ands	r1, r0
@   0x0801f0c2: 20c0        movs	r0, #192	@ 0xc0
@   0x0801f0c4: 0340        lsls	r0, r0, #13
@   0x0801f0c6: 4301        orrs	r1, r0
@   0x0801f0c8: 9101        str	r1, [sp, #4]
@   0x0801f0ca: 7d20        ldrb	r0, [r4, #20]
@   0x0801f0cc: 2801        cmp	r0, #1
@   0x0801f0ce: d019        beq.n	0x1f104
@   0x0801f0d0: 2801        cmp	r0, #1
@   0x0801f0d2: dc0f        bgt.n	0x1f0f4
@   0x0801f0d4: 2800        cmp	r0, #0
@   0x0801f0d6: d012        beq.n	0x1f0fe
@   0x0801f0d8: e021        b.n	0x1f11e
@   0x0801f0da: 0000        movs	r0, r0
@   0x0801f0dc: 3500        adds	r5, #0
@   0x0801f0de: 0300        lsls	r0, r0, #12
@   0x0801f0e0: 3480        adds	r4, #128	@ 0x80
@   0x0801f0e2: 0300        lsls	r0, r0, #12
@   0x0801f0e4: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801f0e8: 00ff        lsls	r7, r7, #3
@   0x0801f0ea: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801f0ee: 00ff        lsls	r7, r7, #3
@   0x0801f0f0: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801f0f4: 2802        cmp	r0, #2
@   0x0801f0f6: d009        beq.n	0x1f10c
@   0x0801f0f8: 2803        cmp	r0, #3
@   0x0801f0fa: d00b        beq.n	0x1f114
@   0x0801f0fc: e00f        b.n	0x1f11e
@   0x0801f0fe: 4011        ands	r1, r2
@   0x0801f100: 4319        orrs	r1, r3
@   0x0801f102: e00b        b.n	0x1f11c
@   0x0801f104: 4011        ands	r1, r2
@   0x0801f106: 2080        movs	r0, #128	@ 0x80
@   0x0801f108: 0100        lsls	r0, r0, #4
@   0x0801f10a: e006        b.n	0x1f11a
@   0x0801f10c: 4011        ands	r1, r2
@   0x0801f10e: 20c0        movs	r0, #192	@ 0xc0
@   0x0801f110: 0100        lsls	r0, r0, #4
@   0x0801f112: e002        b.n	0x1f11a
@   0x0801f114: 4011        ands	r1, r2
@   0x0801f116: 2080        movs	r0, #128	@ 0x80
@   0x0801f118: 0140        lsls	r0, r0, #5
@   0x0801f11a: 4301        orrs	r1, r0
@   0x0801f11c: 9101        str	r1, [sp, #4]
@   0x0801f11e: 200a        movs	r0, #10
@   0x0801f120: 9000        str	r0, [sp, #0]
@   0x0801f122: a801        add	r0, sp, #4
@   0x0801f124: 2104        movs	r1, #4
@   0x0801f126: 2205        movs	r2, #5
@   0x0801f128: 2302        movs	r3, #2
@   0x0801f12a: f7fa        fb83 	bl	0x19834
@   0x0801f12e: 4917        ldr	r1, [pc, #92]	@ (0x1f18c)
@   0x0801f130: 2001        movs	r0, #1
@   0x0801f132: 6088        str	r0, [r1, #8]
@   0x0801f134: 4d16        ldr	r5, [pc, #88]	@ (0x1f190)
@   0x0801f136: 4c17        ldr	r4, [pc, #92]	@ (0x1f194)
@   0x0801f138: 7d21        ldrb	r1, [r4, #20]
@   0x0801f13a: 1c28        adds	r0, r5, #0
@   0x0801f13c: 3038        adds	r0, #56	@ 0x38
@   0x0801f13e: 7001        strb	r1, [r0, #0]
@   0x0801f140: 2001        movs	r0, #1
@   0x0801f142: 211d        movs	r1, #29
@   0x0801f144: 2206        movs	r2, #6
@   0x0801f146: 2302        movs	r3, #2
@   0x0801f148: f7f9        fa7e 	bl	0x18648
@   0x0801f14c: 7d20        ldrb	r0, [r4, #20]
@   0x0801f14e: f7f8        fadf 	bl	0x17710
@   0x0801f152: 4911        ldr	r1, [pc, #68]	@ (0x1f198)
@   0x0801f154: 201d        movs	r0, #29
@   0x0801f156: 7248        strb	r0, [r1, #9]
@   0x0801f158: 4910        ldr	r1, [pc, #64]	@ (0x1f19c)
@   0x0801f15a: 2002        movs	r0, #2
@   0x0801f15c: 7008        strb	r0, [r1, #0]
@   0x0801f15e: 4810        ldr	r0, [pc, #64]	@ (0x1f1a0)
@   0x0801f160: 78c0        ldrb	r0, [r0, #3]
@   0x0801f162: 70a8        strb	r0, [r5, #2]
@   0x0801f164: 480f        ldr	r0, [pc, #60]	@ (0x1f1a4)
@   0x0801f166: 8800        ldrh	r0, [r0, #0]
@   0x0801f168: 2820        cmp	r0, #32
@   0x0801f16a: d11d        bne.n	0x1f1a8
@   0x0801f16c: 2000        movs	r0, #0
@   0x0801f16e: f001        fd83 	bl	0x20c78
@   0x0801f172: 4c06        ldr	r4, [pc, #24]	@ (0x1f18c)
@   0x0801f174: 2000        movs	r0, #0
@   0x0801f176: 60a0        str	r0, [r4, #8]
@   0x0801f178: 211c        movs	r1, #28
@   0x0801f17a: 2206        movs	r2, #6
@   0x0801f17c: 2302        movs	r3, #2
@   0x0801f17e: f7f9        fa63 	bl	0x18648
@   0x0801f182: 7860        ldrb	r0, [r4, #1]
@   0x0801f184: 3001        adds	r0, #1
@   0x0801f186: 7060        strb	r0, [r4, #1]
@   0x0801f188: e01e        b.n	0x1f1c8
@   0x0801f18a: 0000        movs	r0, r0
@   0x0801f18c: 34a0        adds	r4, #160	@ 0xa0
@   0x0801f18e: 0300        lsls	r0, r0, #12
@   0x0801f190: 3500        adds	r5, #0
@   0x0801f192: 0300        lsls	r0, r0, #12
@   0x0801f194: 3480        adds	r4, #128	@ 0x80
@   0x0801f196: 0300        lsls	r0, r0, #12
@   0x0801f198: 5330        strh	r0, [r6, r4]
@   0x0801f19a: 0300        lsls	r0, r0, #12
@   0x0801f19c: 3540        adds	r5, #64	@ 0x40
@   0x0801f19e: 0300        lsls	r0, r0, #12
@   0x0801f1a0: 34b4        adds	r4, #180	@ 0xb4
@   0x0801f1a2: 0300        lsls	r0, r0, #12
@   0x0801f1a4: 5398        strh	r0, [r3, r6]
@   0x0801f1a6: 0300        lsls	r0, r0, #12
@   0x0801f1a8: 2800        cmp	r0, #0
@   0x0801f1aa: d006        beq.n	0x1f1ba
@   0x0801f1ac: 2810        cmp	r0, #16
@   0x0801f1ae: d004        beq.n	0x1f1ba
@   0x0801f1b0: 2840        cmp	r0, #64	@ 0x40
@   0x0801f1b2: d002        beq.n	0x1f1ba
@   0x0801f1b4: f000        f814 	bl	0x1f1e0
@   0x0801f1b8: e006        b.n	0x1f1c8
@   0x0801f1ba: 4b07        ldr	r3, [pc, #28]	@ (0x1f1d8)
@   0x0801f1bc: 6818        ldr	r0, [r3, #0]
@   0x0801f1be: 6859        ldr	r1, [r3, #4]
@   0x0801f1c0: 689a        ldr	r2, [r3, #8]
@   0x0801f1c2: 68db        ldr	r3, [r3, #12]
@   0x0801f1c4: f7f9        f9fc 	bl	0x185c0
@   0x0801f1c8: 4904        ldr	r1, [pc, #16]	@ (0x1f1dc)
@   0x0801f1ca: 2000        movs	r0, #0
@   0x0801f1cc: 8008        strh	r0, [r1, #0]
@   0x0801f1ce: b002        add	sp, #8
@   0x0801f1d0: bc30        pop	{r4, r5}
@   0x0801f1d2: bc01        pop	{r0}
@   0x0801f1d4: 4700        bx	r0
@   0x0801f1d6: 0000        movs	r0, r0
@   0x0801f1d8: 8100        strh	r0, [r0, #8]
@   0x0801f1da: 0830        lsrs	r0, r6, #32
@   0x0801f1dc: 5398        strh	r0, [r3, r6]
@   0x0801f1de: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801EA08
sub_0801EA08: @ 0x0801ea08
        .incbin "frog_us_baserom.gba", 0x1ea08, 0x7d8
        thumb_func_end sub_0801EA08
