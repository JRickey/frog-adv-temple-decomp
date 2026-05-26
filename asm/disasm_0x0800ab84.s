@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ab84, 0x0800af50)  (972 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ab84 --end 0x800af50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800ab84: b530        push	{r4, r5, lr}
@   0x0800ab86: 0600        lsls	r0, r0, #24
@   0x0800ab88: 0e00        lsrs	r0, r0, #24
@   0x0800ab8a: 2814        cmp	r0, #20
@   0x0800ab8c: d154        bne.n	0xac38
@   0x0800ab8e: 4807        ldr	r0, [pc, #28]	@ (0xabac)
@   0x0800ab90: 2208        movs	r2, #8
@   0x0800ab92: 5e81        ldrsh	r1, [r0, r2]
@   0x0800ab94: 230a        movs	r3, #10
@   0x0800ab96: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800ab98: 2013        movs	r0, #19
@   0x0800ab9a: f7ff        fe05 	bl	0xa7a8
@   0x0800ab9e: 0604        lsls	r4, r0, #24
@   0x0800aba0: 1622        asrs	r2, r4, #24
@   0x0800aba2: 2a00        cmp	r2, #0
@   0x0800aba4: d106        bne.n	0xabb4
@   0x0800aba6: 4802        ldr	r0, [pc, #8]	@ (0xabb0)
@   0x0800aba8: 0e22        lsrs	r2, r4, #24
@   0x0800abaa: e010        b.n	0xabce
@   0x0800abac: 35e0        adds	r5, #224	@ 0xe0
@   0x0800abae: 0300        lsls	r0, r0, #12
@   0x0800abb0: 6110        str	r0, [r2, #16]
@   0x0800abb2: 0300        lsls	r0, r0, #12
@   0x0800abb4: 4d08        ldr	r5, [pc, #32]	@ (0xabd8)
@   0x0800abb6: 3a01        subs	r2, #1
@   0x0800abb8: 0612        lsls	r2, r2, #24
@   0x0800abba: 0e12        lsrs	r2, r2, #24
@   0x0800abbc: 1c28        adds	r0, r5, #0
@   0x0800abbe: 2105        movs	r1, #5
@   0x0800abc0: f7fb        fdec 	bl	0x679c
@   0x0800abc4: 0600        lsls	r0, r0, #24
@   0x0800abc6: 2800        cmp	r0, #0
@   0x0800abc8: d008        beq.n	0xabdc
@   0x0800abca: 0e22        lsrs	r2, r4, #24
@   0x0800abcc: 1c28        adds	r0, r5, #0
@   0x0800abce: 2105        movs	r1, #5
@   0x0800abd0: f7fb        fd16 	bl	0x6600
@   0x0800abd4: e005        b.n	0xabe2
@   0x0800abd6: 0000        movs	r0, r0
@   0x0800abd8: 6110        str	r0, [r2, #16]
@   0x0800abda: 0300        lsls	r0, r0, #12
@   0x0800abdc: 2072        movs	r0, #114	@ 0x72
@   0x0800abde: f016        f84b 	bl	0x20c78
@   0x0800abe2: 4c17        ldr	r4, [pc, #92]	@ (0xac40)
@   0x0800abe4: 1c20        adds	r0, r4, #0
@   0x0800abe6: 2105        movs	r1, #5
@   0x0800abe8: 2200        movs	r2, #0
@   0x0800abea: f7fb        fdd7 	bl	0x679c
@   0x0800abee: 0600        lsls	r0, r0, #24
@   0x0800abf0: 2800        cmp	r0, #0
@   0x0800abf2: d021        beq.n	0xac38
@   0x0800abf4: 1c20        adds	r0, r4, #0
@   0x0800abf6: 2105        movs	r1, #5
@   0x0800abf8: 2201        movs	r2, #1
@   0x0800abfa: f7fb        fdcf 	bl	0x679c
@   0x0800abfe: 0600        lsls	r0, r0, #24
@   0x0800ac00: 2800        cmp	r0, #0
@   0x0800ac02: d019        beq.n	0xac38
@   0x0800ac04: 1c20        adds	r0, r4, #0
@   0x0800ac06: 2105        movs	r1, #5
@   0x0800ac08: 2202        movs	r2, #2
@   0x0800ac0a: f7fb        fdc7 	bl	0x679c
@   0x0800ac0e: 0600        lsls	r0, r0, #24
@   0x0800ac10: 2800        cmp	r0, #0
@   0x0800ac12: d011        beq.n	0xac38
@   0x0800ac14: 1c20        adds	r0, r4, #0
@   0x0800ac16: 2105        movs	r1, #5
@   0x0800ac18: 2203        movs	r2, #3
@   0x0800ac1a: f7fb        fdbf 	bl	0x679c
@   0x0800ac1e: 0600        lsls	r0, r0, #24
@   0x0800ac20: 2800        cmp	r0, #0
@   0x0800ac22: d009        beq.n	0xac38
@   0x0800ac24: 1c20        adds	r0, r4, #0
@   0x0800ac26: 2105        movs	r1, #5
@   0x0800ac28: 220f        movs	r2, #15
@   0x0800ac2a: f7fb        fce9 	bl	0x6600
@   0x0800ac2e: 1c20        adds	r0, r4, #0
@   0x0800ac30: 2108        movs	r1, #8
@   0x0800ac32: 2201        movs	r2, #1
@   0x0800ac34: f7fb        fd46 	bl	0x66c4
@   0x0800ac38: bc30        pop	{r4, r5}
@   0x0800ac3a: bc01        pop	{r0}
@   0x0800ac3c: 4700        bx	r0
@   0x0800ac3e: 0000        movs	r0, r0
@   0x0800ac40: 6110        str	r0, [r2, #16]
@   0x0800ac42: 0300        lsls	r0, r0, #12
@   0x0800ac44: b510        push	{r4, lr}
@   0x0800ac46: 0600        lsls	r0, r0, #24
@   0x0800ac48: 0e00        lsrs	r0, r0, #24
@   0x0800ac4a: 2814        cmp	r0, #20
@   0x0800ac4c: d147        bne.n	0xacde
@   0x0800ac4e: 4c06        ldr	r4, [pc, #24]	@ (0xac68)
@   0x0800ac50: 1c20        adds	r0, r4, #0
@   0x0800ac52: 2105        movs	r1, #5
@   0x0800ac54: 2200        movs	r2, #0
@   0x0800ac56: f7fb        fda1 	bl	0x679c
@   0x0800ac5a: 0600        lsls	r0, r0, #24
@   0x0800ac5c: 2800        cmp	r0, #0
@   0x0800ac5e: d105        bne.n	0xac6c
@   0x0800ac60: 1c20        adds	r0, r4, #0
@   0x0800ac62: 2105        movs	r1, #5
@   0x0800ac64: 2200        movs	r2, #0
@   0x0800ac66: e00c        b.n	0xac82
@   0x0800ac68: 6110        str	r0, [r2, #16]
@   0x0800ac6a: 0300        lsls	r0, r0, #12
@   0x0800ac6c: 1c20        adds	r0, r4, #0
@   0x0800ac6e: 2105        movs	r1, #5
@   0x0800ac70: 2201        movs	r2, #1
@   0x0800ac72: f7fb        fd93 	bl	0x679c
@   0x0800ac76: 0600        lsls	r0, r0, #24
@   0x0800ac78: 2800        cmp	r0, #0
@   0x0800ac7a: d10d        bne.n	0xac98
@   0x0800ac7c: 1c20        adds	r0, r4, #0
@   0x0800ac7e: 2105        movs	r1, #5
@   0x0800ac80: 2201        movs	r2, #1
@   0x0800ac82: f7fb        fcbd 	bl	0x6600
@   0x0800ac86: 2019        movs	r0, #25
@   0x0800ac88: f015        fff6 	bl	0x20c78
@   0x0800ac8c: 1c20        adds	r0, r4, #0
@   0x0800ac8e: 2108        movs	r1, #8
@   0x0800ac90: 2204        movs	r2, #4
@   0x0800ac92: f7fb        fcb5 	bl	0x6600
@   0x0800ac96: e014        b.n	0xacc2
@   0x0800ac98: 1c20        adds	r0, r4, #0
@   0x0800ac9a: 2105        movs	r1, #5
@   0x0800ac9c: 2202        movs	r2, #2
@   0x0800ac9e: f7fb        fd7d 	bl	0x679c
@   0x0800aca2: 0600        lsls	r0, r0, #24
@   0x0800aca4: 2800        cmp	r0, #0
@   0x0800aca6: d10c        bne.n	0xacc2
@   0x0800aca8: 1c20        adds	r0, r4, #0
@   0x0800acaa: 2105        movs	r1, #5
@   0x0800acac: 2202        movs	r2, #2
@   0x0800acae: f7fb        fca7 	bl	0x6600
@   0x0800acb2: 2019        movs	r0, #25
@   0x0800acb4: f015        ffe0 	bl	0x20c78
@   0x0800acb8: 1c20        adds	r0, r4, #0
@   0x0800acba: 2108        movs	r1, #8
@   0x0800acbc: 2204        movs	r2, #4
@   0x0800acbe: f7fb        fc9f 	bl	0x6600
@   0x0800acc2: 4c08        ldr	r4, [pc, #32]	@ (0xace4)
@   0x0800acc4: 8ce0        ldrh	r0, [r4, #38]	@ 0x26
@   0x0800acc6: 2807        cmp	r0, #7
@   0x0800acc8: d104        bne.n	0xacd4
@   0x0800acca: 1c20        adds	r0, r4, #0
@   0x0800accc: 2108        movs	r1, #8
@   0x0800acce: 2205        movs	r2, #5
@   0x0800acd0: f7fb        fc96 	bl	0x6600
@   0x0800acd4: 1c20        adds	r0, r4, #0
@   0x0800acd6: 2108        movs	r1, #8
@   0x0800acd8: 2202        movs	r2, #2
@   0x0800acda: f7fb        fc91 	bl	0x6600
@   0x0800acde: bc10        pop	{r4}
@   0x0800ace0: bc01        pop	{r0}
@   0x0800ace2: 4700        bx	r0
@   0x0800ace4: 6110        str	r0, [r2, #16]
@   0x0800ace6: 0300        lsls	r0, r0, #12
@   0x0800ace8: b570        push	{r4, r5, r6, lr}
@   0x0800acea: 0600        lsls	r0, r0, #24
@   0x0800acec: 0e06        lsrs	r6, r0, #24
@   0x0800acee: 2e14        cmp	r6, #20
@   0x0800acf0: d000        beq.n	0xacf4
@   0x0800acf2: e082        b.n	0xadfa
@   0x0800acf4: 484f        ldr	r0, [pc, #316]	@ (0xae34)
@   0x0800acf6: 2208        movs	r2, #8
@   0x0800acf8: 5e81        ldrsh	r1, [r0, r2]
@   0x0800acfa: 230a        movs	r3, #10
@   0x0800acfc: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800acfe: 2014        movs	r0, #20
@   0x0800ad00: f7ff        fd52 	bl	0xa7a8
@   0x0800ad04: 4d4c        ldr	r5, [pc, #304]	@ (0xae38)
@   0x0800ad06: 0600        lsls	r0, r0, #24
@   0x0800ad08: 0e04        lsrs	r4, r0, #24
@   0x0800ad0a: 1c28        adds	r0, r5, #0
@   0x0800ad0c: 2105        movs	r1, #5
@   0x0800ad0e: 1c22        adds	r2, r4, #0
@   0x0800ad10: f7fb        fd44 	bl	0x679c
@   0x0800ad14: 0600        lsls	r0, r0, #24
@   0x0800ad16: 2800        cmp	r0, #0
@   0x0800ad18: d107        bne.n	0xad2a
@   0x0800ad1a: 1c28        adds	r0, r5, #0
@   0x0800ad1c: 2105        movs	r1, #5
@   0x0800ad1e: 1c22        adds	r2, r4, #0
@   0x0800ad20: f7fb        fc6e 	bl	0x6600
@   0x0800ad24: 2019        movs	r0, #25
@   0x0800ad26: f015        ffa7 	bl	0x20c78
@   0x0800ad2a: 8ce9        ldrh	r1, [r5, #38]	@ 0x26
@   0x0800ad2c: 2001        movs	r0, #1
@   0x0800ad2e: 4008        ands	r0, r1
@   0x0800ad30: 2800        cmp	r0, #0
@   0x0800ad32: d013        beq.n	0xad5c
@   0x0800ad34: 2020        movs	r0, #32
@   0x0800ad36: 4008        ands	r0, r1
@   0x0800ad38: 2800        cmp	r0, #0
@   0x0800ad3a: d00f        beq.n	0xad5c
@   0x0800ad3c: 1c28        adds	r0, r5, #0
@   0x0800ad3e: 2108        movs	r1, #8
@   0x0800ad40: 2204        movs	r2, #4
@   0x0800ad42: f7fb        fd2b 	bl	0x679c
@   0x0800ad46: 0600        lsls	r0, r0, #24
@   0x0800ad48: 2800        cmp	r0, #0
@   0x0800ad4a: d107        bne.n	0xad5c
@   0x0800ad4c: 1c28        adds	r0, r5, #0
@   0x0800ad4e: 2108        movs	r1, #8
@   0x0800ad50: 2204        movs	r2, #4
@   0x0800ad52: f7fb        fc55 	bl	0x6600
@   0x0800ad56: 2034        movs	r0, #52	@ 0x34
@   0x0800ad58: f015        ff8e 	bl	0x20c78
@   0x0800ad5c: 4c36        ldr	r4, [pc, #216]	@ (0xae38)
@   0x0800ad5e: 2012        movs	r0, #18
@   0x0800ad60: 8ce1        ldrh	r1, [r4, #38]	@ 0x26
@   0x0800ad62: 4008        ands	r0, r1
@   0x0800ad64: 2812        cmp	r0, #18
@   0x0800ad66: d10f        bne.n	0xad88
@   0x0800ad68: 1c20        adds	r0, r4, #0
@   0x0800ad6a: 2108        movs	r1, #8
@   0x0800ad6c: 2205        movs	r2, #5
@   0x0800ad6e: f7fb        fd15 	bl	0x679c
@   0x0800ad72: 0600        lsls	r0, r0, #24
@   0x0800ad74: 2800        cmp	r0, #0
@   0x0800ad76: d107        bne.n	0xad88
@   0x0800ad78: 1c20        adds	r0, r4, #0
@   0x0800ad7a: 2108        movs	r1, #8
@   0x0800ad7c: 2205        movs	r2, #5
@   0x0800ad7e: f7fb        fc3f 	bl	0x6600
@   0x0800ad82: 2034        movs	r0, #52	@ 0x34
@   0x0800ad84: f015        ff78 	bl	0x20c78
@   0x0800ad88: 4c2b        ldr	r4, [pc, #172]	@ (0xae38)
@   0x0800ad8a: 2084        movs	r0, #132	@ 0x84
@   0x0800ad8c: 8ce2        ldrh	r2, [r4, #38]	@ 0x26
@   0x0800ad8e: 4010        ands	r0, r2
@   0x0800ad90: 2884        cmp	r0, #132	@ 0x84
@   0x0800ad92: d10f        bne.n	0xadb4
@   0x0800ad94: 1c20        adds	r0, r4, #0
@   0x0800ad96: 2108        movs	r1, #8
@   0x0800ad98: 2206        movs	r2, #6
@   0x0800ad9a: f7fb        fcff 	bl	0x679c
@   0x0800ad9e: 0600        lsls	r0, r0, #24
@   0x0800ada0: 2800        cmp	r0, #0
@   0x0800ada2: d107        bne.n	0xadb4
@   0x0800ada4: 1c20        adds	r0, r4, #0
@   0x0800ada6: 2108        movs	r1, #8
@   0x0800ada8: 2206        movs	r2, #6
@   0x0800adaa: f7fb        fc29 	bl	0x6600
@   0x0800adae: 2034        movs	r0, #52	@ 0x34
@   0x0800adb0: f015        ff62 	bl	0x20c78
@   0x0800adb4: 4c20        ldr	r4, [pc, #128]	@ (0xae38)
@   0x0800adb6: 2048        movs	r0, #72	@ 0x48
@   0x0800adb8: 8ce3        ldrh	r3, [r4, #38]	@ 0x26
@   0x0800adba: 4018        ands	r0, r3
@   0x0800adbc: 2848        cmp	r0, #72	@ 0x48
@   0x0800adbe: d10f        bne.n	0xade0
@   0x0800adc0: 1c20        adds	r0, r4, #0
@   0x0800adc2: 2108        movs	r1, #8
@   0x0800adc4: 2207        movs	r2, #7
@   0x0800adc6: f7fb        fce9 	bl	0x679c
@   0x0800adca: 0600        lsls	r0, r0, #24
@   0x0800adcc: 2800        cmp	r0, #0
@   0x0800adce: d107        bne.n	0xade0
@   0x0800add0: 1c20        adds	r0, r4, #0
@   0x0800add2: 2108        movs	r1, #8
@   0x0800add4: 2207        movs	r2, #7
@   0x0800add6: f7fb        fc13 	bl	0x6600
@   0x0800adda: 2034        movs	r0, #52	@ 0x34
@   0x0800addc: f015        ff4c 	bl	0x20c78
@   0x0800ade0: 4a15        ldr	r2, [pc, #84]	@ (0xae38)
@   0x0800ade2: 1c11        adds	r1, r2, #0
@   0x0800ade4: 312a        adds	r1, #42	@ 0x2a
@   0x0800ade6: 20f0        movs	r0, #240	@ 0xf0
@   0x0800ade8: 7809        ldrb	r1, [r1, #0]
@   0x0800adea: 4008        ands	r0, r1
@   0x0800adec: 28f0        cmp	r0, #240	@ 0xf0
@   0x0800adee: d104        bne.n	0xadfa
@   0x0800adf0: 1c10        adds	r0, r2, #0
@   0x0800adf2: 2108        movs	r1, #8
@   0x0800adf4: 2200        movs	r2, #0
@   0x0800adf6: f7fb        fc03 	bl	0x6600
@   0x0800adfa: 2e16        cmp	r6, #22
@   0x0800adfc: d117        bne.n	0xae2e
@   0x0800adfe: 480d        ldr	r0, [pc, #52]	@ (0xae34)
@   0x0800ae00: 2208        movs	r2, #8
@   0x0800ae02: 5e81        ldrsh	r1, [r0, r2]
@   0x0800ae04: 230a        movs	r3, #10
@   0x0800ae06: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800ae08: 2015        movs	r0, #21
@   0x0800ae0a: f7ff        fccd 	bl	0xa7a8
@   0x0800ae0e: 0600        lsls	r0, r0, #24
@   0x0800ae10: 1600        asrs	r0, r0, #24
@   0x0800ae12: f002        fdf3 	bl	0xd9fc
@   0x0800ae16: 4c08        ldr	r4, [pc, #32]	@ (0xae38)
@   0x0800ae18: 1c21        adds	r1, r4, #0
@   0x0800ae1a: 3133        adds	r1, #51	@ 0x33
@   0x0800ae1c: 7008        strb	r0, [r1, #0]
@   0x0800ae1e: 2046        movs	r0, #70	@ 0x46
@   0x0800ae20: f015        ff2a 	bl	0x20c78
@   0x0800ae24: 1c20        adds	r0, r4, #0
@   0x0800ae26: 2108        movs	r1, #8
@   0x0800ae28: 2201        movs	r2, #1
@   0x0800ae2a: f7fb        fbe9 	bl	0x6600
@   0x0800ae2e: bc70        pop	{r4, r5, r6}
@   0x0800ae30: bc01        pop	{r0}
@   0x0800ae32: 4700        bx	r0
@   0x0800ae34: 35e0        adds	r5, #224	@ 0xe0
@   0x0800ae36: 0300        lsls	r0, r0, #12
@   0x0800ae38: 6110        str	r0, [r2, #16]
@   0x0800ae3a: 0300        lsls	r0, r0, #12
@   0x0800ae3c: b570        push	{r4, r5, r6, lr}
@   0x0800ae3e: 0600        lsls	r0, r0, #24
@   0x0800ae40: 0e00        lsrs	r0, r0, #24
@   0x0800ae42: 2814        cmp	r0, #20
@   0x0800ae44: d000        beq.n	0xae48
@   0x0800ae46: e07d        b.n	0xaf44
@   0x0800ae48: 4811        ldr	r0, [pc, #68]	@ (0xae90)
@   0x0800ae4a: 2208        movs	r2, #8
@   0x0800ae4c: 5e81        ldrsh	r1, [r0, r2]
@   0x0800ae4e: 230a        movs	r3, #10
@   0x0800ae50: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800ae52: 2017        movs	r0, #23
@   0x0800ae54: f7ff        fca8 	bl	0xa7a8
@   0x0800ae58: 0606        lsls	r6, r0, #24
@   0x0800ae5a: 1634        asrs	r4, r6, #24
@   0x0800ae5c: 2001        movs	r0, #1
@   0x0800ae5e: 4240        negs	r0, r0
@   0x0800ae60: 4284        cmp	r4, r0
@   0x0800ae62: d06f        beq.n	0xaf44
@   0x0800ae64: 2c04        cmp	r4, #4
@   0x0800ae66: d149        bne.n	0xaefc
@   0x0800ae68: 4c0a        ldr	r4, [pc, #40]	@ (0xae94)
@   0x0800ae6a: 1c20        adds	r0, r4, #0
@   0x0800ae6c: 2105        movs	r1, #5
@   0x0800ae6e: 2204        movs	r2, #4
@   0x0800ae70: f7fb        fc94 	bl	0x679c
@   0x0800ae74: 0600        lsls	r0, r0, #24
@   0x0800ae76: 2800        cmp	r0, #0
@   0x0800ae78: d164        bne.n	0xaf44
@   0x0800ae7a: 1c20        adds	r0, r4, #0
@   0x0800ae7c: 2105        movs	r1, #5
@   0x0800ae7e: 2204        movs	r2, #4
@   0x0800ae80: f7fb        fbbe 	bl	0x6600
@   0x0800ae84: 3433        adds	r4, #51	@ 0x33
@   0x0800ae86: 7820        ldrb	r0, [r4, #0]
@   0x0800ae88: 280f        cmp	r0, #15
@   0x0800ae8a: d105        bne.n	0xae98
@   0x0800ae8c: 2200        movs	r2, #0
@   0x0800ae8e: e01e        b.n	0xaece
@   0x0800ae90: 35e0        adds	r5, #224	@ 0xe0
@   0x0800ae92: 0300        lsls	r0, r0, #12
@   0x0800ae94: 6110        str	r0, [r2, #16]
@   0x0800ae96: 0300        lsls	r0, r0, #12
@   0x0800ae98: 2004        movs	r0, #4
@   0x0800ae9a: f7f5        fc63 	bl	0x764
@   0x0800ae9e: 0600        lsls	r0, r0, #24
@   0x0800aea0: 0e02        lsrs	r2, r0, #24
@   0x0800aea2: 1600        asrs	r0, r0, #24
@   0x0800aea4: 7821        ldrb	r1, [r4, #0]
@   0x0800aea6: 4101        asrs	r1, r0
@   0x0800aea8: 1c08        adds	r0, r1, #0
@   0x0800aeaa: 2101        movs	r1, #1
@   0x0800aeac: 4008        ands	r0, r1
@   0x0800aeae: 2800        cmp	r0, #0
@   0x0800aeb0: d00d        beq.n	0xaece
@   0x0800aeb2: 1c25        adds	r5, r4, #0
@   0x0800aeb4: 2401        movs	r4, #1
@   0x0800aeb6: 2004        movs	r0, #4
@   0x0800aeb8: f7f5        fc54 	bl	0x764
@   0x0800aebc: 0600        lsls	r0, r0, #24
@   0x0800aebe: 0e02        lsrs	r2, r0, #24
@   0x0800aec0: 1600        asrs	r0, r0, #24
@   0x0800aec2: 782b        ldrb	r3, [r5, #0]
@   0x0800aec4: 4103        asrs	r3, r0
@   0x0800aec6: 1c18        adds	r0, r3, #0
@   0x0800aec8: 4020        ands	r0, r4
@   0x0800aeca: 2800        cmp	r0, #0
@   0x0800aecc: d1f3        bne.n	0xaeb6
@   0x0800aece: 4807        ldr	r0, [pc, #28]	@ (0xaeec)
@   0x0800aed0: 302b        adds	r0, #43	@ 0x2b
@   0x0800aed2: 7002        strb	r2, [r0, #0]
@   0x0800aed4: 4906        ldr	r1, [pc, #24]	@ (0xaef0)
@   0x0800aed6: 4807        ldr	r0, [pc, #28]	@ (0xaef4)
@   0x0800aed8: 180a        adds	r2, r1, r0
@   0x0800aeda: 4807        ldr	r0, [pc, #28]	@ (0xaef8)
@   0x0800aedc: 6800        ldr	r0, [r0, #0]
@   0x0800aede: 6010        str	r0, [r2, #0]
@   0x0800aee0: 22b7        movs	r2, #183	@ 0xb7
@   0x0800aee2: 0112        lsls	r2, r2, #4
@   0x0800aee4: 1889        adds	r1, r1, r2
@   0x0800aee6: 2001        movs	r0, #1
@   0x0800aee8: 8008        strh	r0, [r1, #0]
@   0x0800aeea: e02b        b.n	0xaf44
@   0x0800aeec: 6110        str	r0, [r2, #16]
@   0x0800aeee: 0300        lsls	r0, r0, #12
@   0x0800aef0: 3720        adds	r7, #32
@   0x0800aef2: 0300        lsls	r0, r0, #12
@   0x0800aef4: 0b8c        lsrs	r4, r1, #14
@   0x0800aef6: 0000        movs	r0, r0
@   0x0800aef8: 5330        strh	r0, [r6, r4]
@   0x0800aefa: 0300        lsls	r0, r0, #12
@   0x0800aefc: 4d13        ldr	r5, [pc, #76]	@ (0xaf4c)
@   0x0800aefe: 1c28        adds	r0, r5, #0
@   0x0800af00: 2105        movs	r1, #5
@   0x0800af02: 2204        movs	r2, #4
@   0x0800af04: f7fb        fc4a 	bl	0x679c
@   0x0800af08: 0600        lsls	r0, r0, #24
@   0x0800af0a: 2800        cmp	r0, #0
@   0x0800af0c: d01a        beq.n	0xaf44
@   0x0800af0e: 1c28        adds	r0, r5, #0
@   0x0800af10: 302b        adds	r0, #43	@ 0x2b
@   0x0800af12: 7800        ldrb	r0, [r0, #0]
@   0x0800af14: 4284        cmp	r4, r0
@   0x0800af16: d115        bne.n	0xaf44
@   0x0800af18: 0e32        lsrs	r2, r6, #24
@   0x0800af1a: 1c28        adds	r0, r5, #0
@   0x0800af1c: 2105        movs	r1, #5
@   0x0800af1e: f7fb        fb6f 	bl	0x6600
@   0x0800af22: 1c20        adds	r0, r4, #0
@   0x0800af24: 3008        adds	r0, #8
@   0x0800af26: 0600        lsls	r0, r0, #24
@   0x0800af28: 0e04        lsrs	r4, r0, #24
@   0x0800af2a: 1c28        adds	r0, r5, #0
@   0x0800af2c: 2105        movs	r1, #5
@   0x0800af2e: 1c22        adds	r2, r4, #0
@   0x0800af30: f7fb        fc34 	bl	0x679c
@   0x0800af34: 0600        lsls	r0, r0, #24
@   0x0800af36: 2800        cmp	r0, #0
@   0x0800af38: d104        bne.n	0xaf44
@   0x0800af3a: 1c28        adds	r0, r5, #0
@   0x0800af3c: 2105        movs	r1, #5
@   0x0800af3e: 1c22        adds	r2, r4, #0
@   0x0800af40: f7fb        fb5e 	bl	0x6600
@   0x0800af44: bc70        pop	{r4, r5, r6}
@   0x0800af46: bc01        pop	{r0}
@   0x0800af48: 4700        bx	r0
@   0x0800af4a: 0000        movs	r0, r0
@   0x0800af4c: 6110        str	r0, [r2, #16]
@   0x0800af4e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800AB84
sub_0800AB84: @ 0x0800ab84
        .incbin "frog_us_baserom.gba", 0xab84, 0x3cc
        thumb_func_end sub_0800AB84
