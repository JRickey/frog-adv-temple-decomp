@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800ace8, 0x0800af50)  (596 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800ace8 --end 0x800af50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_0800ACE8
sub_0800ACE8: @ 0x0800ace8
        .incbin "frog_us_baserom.gba", 0xace8, 0x154
        thumb_func_end sub_0800ACE8

        thumb_func_start sub_0800AE3C
sub_0800AE3C: @ 0x0800ae3c
        .incbin "frog_us_baserom.gba", 0xae3c, 0x114
        thumb_func_end sub_0800AE3C
