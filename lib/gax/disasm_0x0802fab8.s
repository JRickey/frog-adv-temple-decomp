@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802fab8, 0x08030158)  (1696 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802fab8 --end 0x8030158 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802fab8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802faba: 4657        mov	r7, sl
@   0x0802fabc: 464e        mov	r6, r9
@   0x0802fabe: 4645        mov	r5, r8
@   0x0802fac0: b4e0        push	{r5, r6, r7}
@   0x0802fac2: b085        sub	sp, #20
@   0x0802fac4: 1c07        adds	r7, r0, #0
@   0x0802fac6: 9100        str	r1, [sp, #0]
@   0x0802fac8: 78b8        ldrb	r0, [r7, #2]
@   0x0802faca: 2800        cmp	r0, #0
@   0x0802facc: d101        bne.n	0x2fad2
@   0x0802face: 2000        movs	r0, #0
@   0x0802fad0: e22e        b.n	0x2ff30
@   0x0802fad2: 4c15        ldr	r4, [pc, #84]	@ (0x2fb28)
@   0x0802fad4: 6820        ldr	r0, [r4, #0]
@   0x0802fad6: 30c4        adds	r0, #196	@ 0xc4
@   0x0802fad8: 6800        ldr	r0, [r0, #0]
@   0x0802fada: 78ba        ldrb	r2, [r7, #2]
@   0x0802fadc: 0091        lsls	r1, r2, #2
@   0x0802fade: f7fe        fc4f 	bl	0x2e380
@   0x0802fae2: 6820        ldr	r0, [r4, #0]
@   0x0802fae4: 30c0        adds	r0, #192	@ 0xc0
@   0x0802fae6: 6800        ldr	r0, [r0, #0]
@   0x0802fae8: 78bb        ldrb	r3, [r7, #2]
@   0x0802faea: 00d9        lsls	r1, r3, #3
@   0x0802faec: 1ac9        subs	r1, r1, r3
@   0x0802faee: 0089        lsls	r1, r1, #2
@   0x0802faf0: f7fe        fc46 	bl	0x2e380
@   0x0802faf4: 6820        ldr	r0, [r4, #0]
@   0x0802faf6: 30cc        adds	r0, #204	@ 0xcc
@   0x0802faf8: 6800        ldr	r0, [r0, #0]
@   0x0802fafa: 78ba        ldrb	r2, [r7, #2]
@   0x0802fafc: 0091        lsls	r1, r2, #2
@   0x0802fafe: f7fe        fc3f 	bl	0x2e380
@   0x0802fb02: 6820        ldr	r0, [r4, #0]
@   0x0802fb04: 30c8        adds	r0, #200	@ 0xc8
@   0x0802fb06: 6800        ldr	r0, [r0, #0]
@   0x0802fb08: 78bb        ldrb	r3, [r7, #2]
@   0x0802fb0a: 0199        lsls	r1, r3, #6
@   0x0802fb0c: f7fe        fc38 	bl	0x2e380
@   0x0802fb10: 6820        ldr	r0, [r4, #0]
@   0x0802fb12: 1c06        adds	r6, r0, #0
@   0x0802fb14: 36d0        adds	r6, #208	@ 0xd0
@   0x0802fb16: 2003        movs	r0, #3
@   0x0802fb18: 78f9        ldrb	r1, [r7, #3]
@   0x0802fb1a: 4008        ands	r0, r1
@   0x0802fb1c: 2803        cmp	r0, #3
@   0x0802fb1e: d109        bne.n	0x2fb34
@   0x0802fb20: 4c02        ldr	r4, [pc, #8]	@ (0x2fb2c)
@   0x0802fb22: 4b03        ldr	r3, [pc, #12]	@ (0x2fb30)
@   0x0802fb24: e01c        b.n	0x2fb60
@   0x0802fb26: 0000        movs	r0, r0
@   0x0802fb28: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802fb2a: 0300        lsls	r0, r0, #12
@   0x0802fb2c: 3520        adds	r5, #32
@   0x0802fb2e: 0803        lsrs	r3, r0, #32
@   0x0802fb30: 36ac        adds	r6, #172	@ 0xac
@   0x0802fb32: 0803        lsrs	r3, r0, #32
@   0x0802fb34: 2802        cmp	r0, #2
@   0x0802fb36: d107        bne.n	0x2fb48
@   0x0802fb38: 4c01        ldr	r4, [pc, #4]	@ (0x2fb40)
@   0x0802fb3a: 4b02        ldr	r3, [pc, #8]	@ (0x2fb44)
@   0x0802fb3c: e010        b.n	0x2fb60
@   0x0802fb3e: 0000        movs	r0, r0
@   0x0802fb40: 336c        adds	r3, #108	@ 0x6c
@   0x0802fb42: 0803        lsrs	r3, r0, #32
@   0x0802fb44: 3520        adds	r5, #32
@   0x0802fb46: 0803        lsrs	r3, r0, #32
@   0x0802fb48: 2801        cmp	r0, #1
@   0x0802fb4a: d107        bne.n	0x2fb5c
@   0x0802fb4c: 4c01        ldr	r4, [pc, #4]	@ (0x2fb54)
@   0x0802fb4e: 4b02        ldr	r3, [pc, #8]	@ (0x2fb58)
@   0x0802fb50: e006        b.n	0x2fb60
@   0x0802fb52: 0000        movs	r0, r0
@   0x0802fb54: 31e0        adds	r1, #224	@ 0xe0
@   0x0802fb56: 0803        lsrs	r3, r0, #32
@   0x0802fb58: 336c        adds	r3, #108	@ 0x6c
@   0x0802fb5a: 0803        lsrs	r3, r0, #32
@   0x0802fb5c: 4c05        ldr	r4, [pc, #20]	@ (0x2fb74)
@   0x0802fb5e: 4b06        ldr	r3, [pc, #24]	@ (0x2fb78)
@   0x0802fb60: 78f9        ldrb	r1, [r7, #3]
@   0x0802fb62: 2002        movs	r0, #2
@   0x0802fb64: 4008        ands	r0, r1
@   0x0802fb66: 2800        cmp	r0, #0
@   0x0802fb68: d10c        bne.n	0x2fb84
@   0x0802fb6a: 4a04        ldr	r2, [pc, #16]	@ (0x2fb7c)
@   0x0802fb6c: 4691        mov	r9, r2
@   0x0802fb6e: 4d04        ldr	r5, [pc, #16]	@ (0x2fb80)
@   0x0802fb70: e00b        b.n	0x2fb8a
@   0x0802fb72: 0000        movs	r0, r0
@   0x0802fb74: 3000        adds	r0, #0
@   0x0802fb76: 0803        lsrs	r3, r0, #32
@   0x0802fb78: 31e0        adds	r1, #224	@ 0xe0
@   0x0802fb7a: 0803        lsrs	r3, r0, #32
@   0x0802fb7c: 2e54        cmp	r6, #84	@ 0x54
@   0x0802fb7e: 0803        lsrs	r3, r0, #32
@   0x0802fb80: 2f68        cmp	r7, #104	@ 0x68
@   0x0802fb82: 0803        lsrs	r3, r0, #32
@   0x0802fb84: 4805        ldr	r0, [pc, #20]	@ (0x2fb9c)
@   0x0802fb86: 4681        mov	r9, r0
@   0x0802fb88: 4d05        ldr	r5, [pc, #20]	@ (0x2fba0)
@   0x0802fb8a: 2002        movs	r0, #2
@   0x0802fb8c: 4008        ands	r0, r1
@   0x0802fb8e: 2800        cmp	r0, #0
@   0x0802fb90: d00c        beq.n	0x2fbac
@   0x0802fb92: 4a04        ldr	r2, [pc, #16]	@ (0x2fba4)
@   0x0802fb94: 4692        mov	sl, r2
@   0x0802fb96: 4804        ldr	r0, [pc, #16]	@ (0x2fba8)
@   0x0802fb98: e017        b.n	0x2fbca
@   0x0802fb9a: 0000        movs	r0, r0
@   0x0802fb9c: 2f68        cmp	r7, #104	@ 0x68
@   0x0802fb9e: 0803        lsrs	r3, r0, #32
@   0x0802fba0: 3000        adds	r0, #0
@   0x0802fba2: 0803        lsrs	r3, r0, #32
@   0x0802fba4: 3800        subs	r0, #0
@   0x0802fba6: 0803        lsrs	r3, r0, #32
@   0x0802fba8: 38a4        subs	r0, #164	@ 0xa4
@   0x0802fbaa: 0803        lsrs	r3, r0, #32
@   0x0802fbac: 2004        movs	r0, #4
@   0x0802fbae: 4008        ands	r0, r1
@   0x0802fbb0: 2800        cmp	r0, #0
@   0x0802fbb2: d007        beq.n	0x2fbc4
@   0x0802fbb4: 4a01        ldr	r2, [pc, #4]	@ (0x2fbbc)
@   0x0802fbb6: 4692        mov	sl, r2
@   0x0802fbb8: 4801        ldr	r0, [pc, #4]	@ (0x2fbc0)
@   0x0802fbba: e006        b.n	0x2fbca
@   0x0802fbbc: 3750        adds	r7, #80	@ 0x50
@   0x0802fbbe: 0803        lsrs	r3, r0, #32
@   0x0802fbc0: 3800        subs	r0, #0
@   0x0802fbc2: 0803        lsrs	r3, r0, #32
@   0x0802fbc4: 4a18        ldr	r2, [pc, #96]	@ (0x2fc28)
@   0x0802fbc6: 4692        mov	sl, r2
@   0x0802fbc8: 4818        ldr	r0, [pc, #96]	@ (0x2fc2c)
@   0x0802fbca: 4684        mov	ip, r0
@   0x0802fbcc: 2008        movs	r0, #8
@   0x0802fbce: 4008        ands	r0, r1
@   0x0802fbd0: 2800        cmp	r0, #0
@   0x0802fbd2: d151        bne.n	0x2fc78
@   0x0802fbd4: 9900        ldr	r1, [sp, #0]
@   0x0802fbd6: 684a        ldr	r2, [r1, #4]
@   0x0802fbd8: 6032        str	r2, [r6, #0]
@   0x0802fbda: 1c21        adds	r1, r4, #0
@   0x0802fbdc: 1c30        adds	r0, r6, #0
@   0x0802fbde: 3021        adds	r0, #33	@ 0x21
@   0x0802fbe0: 9003        str	r0, [sp, #12]
@   0x0802fbe2: 3801        subs	r0, #1
@   0x0802fbe4: 9002        str	r0, [sp, #8]
@   0x0802fbe6: 2024        movs	r0, #36	@ 0x24
@   0x0802fbe8: 1980        adds	r0, r0, r6
@   0x0802fbea: 4680        mov	r8, r0
@   0x0802fbec: 1c30        adds	r0, r6, #0
@   0x0802fbee: 303f        adds	r0, #63	@ 0x3f
@   0x0802fbf0: 9004        str	r0, [sp, #16]
@   0x0802fbf2: 4299        cmp	r1, r3
@   0x0802fbf4: d203        bcs.n	0x2fbfe
@   0x0802fbf6: c901        ldmia	r1!, {r0}
@   0x0802fbf8: c201        stmia	r2!, {r0}
@   0x0802fbfa: 4299        cmp	r1, r3
@   0x0802fbfc: d3fb        bcc.n	0x2fbf6
@   0x0802fbfe: 60b2        str	r2, [r6, #8]
@   0x0802fc00: 4649        mov	r1, r9
@   0x0802fc02: 42a9        cmp	r1, r5
@   0x0802fc04: d203        bcs.n	0x2fc0e
@   0x0802fc06: c901        ldmia	r1!, {r0}
@   0x0802fc08: c201        stmia	r2!, {r0}
@   0x0802fc0a: 42a9        cmp	r1, r5
@   0x0802fc0c: d3fb        bcc.n	0x2fc06
@   0x0802fc0e: 78f9        ldrb	r1, [r7, #3]
@   0x0802fc10: 2002        movs	r0, #2
@   0x0802fc12: 4008        ands	r0, r1
@   0x0802fc14: 2800        cmp	r0, #0
@   0x0802fc16: d103        bne.n	0x2fc20
@   0x0802fc18: 2006        movs	r0, #6
@   0x0802fc1a: 4008        ands	r0, r1
@   0x0802fc1c: 2800        cmp	r0, #0
@   0x0802fc1e: d107        bne.n	0x2fc30
@   0x0802fc20: 6830        ldr	r0, [r6, #0]
@   0x0802fc22: 6070        str	r0, [r6, #4]
@   0x0802fc24: e01a        b.n	0x2fc5c
@   0x0802fc26: 0000        movs	r0, r0
@   0x0802fc28: 36ac        adds	r6, #172	@ 0xac
@   0x0802fc2a: 0803        lsrs	r3, r0, #32
@   0x0802fc2c: 3750        adds	r7, #80	@ 0x50
@   0x0802fc2e: 0803        lsrs	r3, r0, #32
@   0x0802fc30: 2001        movs	r0, #1
@   0x0802fc32: 4008        ands	r0, r1
@   0x0802fc34: 2800        cmp	r0, #0
@   0x0802fc36: d107        bne.n	0x2fc48
@   0x0802fc38: 4c01        ldr	r4, [pc, #4]	@ (0x2fc40)
@   0x0802fc3a: 4b02        ldr	r3, [pc, #8]	@ (0x2fc44)
@   0x0802fc3c: e006        b.n	0x2fc4c
@   0x0802fc3e: 0000        movs	r0, r0
@   0x0802fc40: 336c        adds	r3, #108	@ 0x6c
@   0x0802fc42: 0803        lsrs	r3, r0, #32
@   0x0802fc44: 3520        adds	r5, #32
@   0x0802fc46: 0803        lsrs	r3, r0, #32
@   0x0802fc48: 4c09        ldr	r4, [pc, #36]	@ (0x2fc70)
@   0x0802fc4a: 4b0a        ldr	r3, [pc, #40]	@ (0x2fc74)
@   0x0802fc4c: 6072        str	r2, [r6, #4]
@   0x0802fc4e: 1c21        adds	r1, r4, #0
@   0x0802fc50: 4299        cmp	r1, r3
@   0x0802fc52: d203        bcs.n	0x2fc5c
@   0x0802fc54: c901        ldmia	r1!, {r0}
@   0x0802fc56: c201        stmia	r2!, {r0}
@   0x0802fc58: 4299        cmp	r1, r3
@   0x0802fc5a: d3fb        bcc.n	0x2fc54
@   0x0802fc5c: 60f2        str	r2, [r6, #12]
@   0x0802fc5e: 4651        mov	r1, sl
@   0x0802fc60: 4561        cmp	r1, ip
@   0x0802fc62: d22c        bcs.n	0x2fcbe
@   0x0802fc64: c901        ldmia	r1!, {r0}
@   0x0802fc66: c201        stmia	r2!, {r0}
@   0x0802fc68: 4561        cmp	r1, ip
@   0x0802fc6a: d3fb        bcc.n	0x2fc64
@   0x0802fc6c: e027        b.n	0x2fcbe
@   0x0802fc6e: 0000        movs	r0, r0
@   0x0802fc70: 3520        adds	r5, #32
@   0x0802fc72: 0803        lsrs	r3, r0, #32
@   0x0802fc74: 36ac        adds	r6, #172	@ 0xac
@   0x0802fc76: 0803        lsrs	r3, r0, #32
@   0x0802fc78: 6034        str	r4, [r6, #0]
@   0x0802fc7a: 4649        mov	r1, r9
@   0x0802fc7c: 60b1        str	r1, [r6, #8]
@   0x0802fc7e: 78f9        ldrb	r1, [r7, #3]
@   0x0802fc80: 2002        movs	r0, #2
@   0x0802fc82: 4008        ands	r0, r1
@   0x0802fc84: 2800        cmp	r0, #0
@   0x0802fc86: d103        bne.n	0x2fc90
@   0x0802fc88: 2006        movs	r0, #6
@   0x0802fc8a: 4008        ands	r0, r1
@   0x0802fc8c: 2800        cmp	r0, #0
@   0x0802fc8e: d101        bne.n	0x2fc94
@   0x0802fc90: 6074        str	r4, [r6, #4]
@   0x0802fc92: e006        b.n	0x2fca2
@   0x0802fc94: 2001        movs	r0, #1
@   0x0802fc96: 4008        ands	r0, r1
@   0x0802fc98: 490f        ldr	r1, [pc, #60]	@ (0x2fcd8)
@   0x0802fc9a: 2800        cmp	r0, #0
@   0x0802fc9c: d100        bne.n	0x2fca0
@   0x0802fc9e: 490f        ldr	r1, [pc, #60]	@ (0x2fcdc)
@   0x0802fca0: 6071        str	r1, [r6, #4]
@   0x0802fca2: 4652        mov	r2, sl
@   0x0802fca4: 60f2        str	r2, [r6, #12]
@   0x0802fca6: 1c33        adds	r3, r6, #0
@   0x0802fca8: 3321        adds	r3, #33	@ 0x21
@   0x0802fcaa: 9303        str	r3, [sp, #12]
@   0x0802fcac: 1c30        adds	r0, r6, #0
@   0x0802fcae: 3020        adds	r0, #32
@   0x0802fcb0: 9002        str	r0, [sp, #8]
@   0x0802fcb2: 2124        movs	r1, #36	@ 0x24
@   0x0802fcb4: 1989        adds	r1, r1, r6
@   0x0802fcb6: 4688        mov	r8, r1
@   0x0802fcb8: 1c32        adds	r2, r6, #0
@   0x0802fcba: 323f        adds	r2, #63	@ 0x3f
@   0x0802fcbc: 9204        str	r2, [sp, #16]
@   0x0802fcbe: 9b00        ldr	r3, [sp, #0]
@   0x0802fcc0: 6899        ldr	r1, [r3, #8]
@   0x0802fcc2: 6131        str	r1, [r6, #16]
@   0x0802fcc4: 2002        movs	r0, #2
@   0x0802fcc6: 78fa        ldrb	r2, [r7, #3]
@   0x0802fcc8: 4010        ands	r0, r2
@   0x0802fcca: 2800        cmp	r0, #0
@   0x0802fccc: d108        bne.n	0x2fce0
@   0x0802fcce: 2380        movs	r3, #128	@ 0x80
@   0x0802fcd0: 009b        lsls	r3, r3, #2
@   0x0802fcd2: 18c9        adds	r1, r1, r3
@   0x0802fcd4: e007        b.n	0x2fce6
@   0x0802fcd6: 0000        movs	r0, r0
@   0x0802fcd8: 3520        adds	r5, #32
@   0x0802fcda: 0803        lsrs	r3, r0, #32
@   0x0802fcdc: 336c        adds	r3, #108	@ 0x6c
@   0x0802fcde: 0803        lsrs	r3, r0, #32
@   0x0802fce0: 2080        movs	r0, #128	@ 0x80
@   0x0802fce2: 0040        lsls	r0, r0, #1
@   0x0802fce4: 1809        adds	r1, r1, r0
@   0x0802fce6: 6171        str	r1, [r6, #20]
@   0x0802fce8: 2002        movs	r0, #2
@   0x0802fcea: 78fa        ldrb	r2, [r7, #3]
@   0x0802fcec: 4010        ands	r0, r2
@   0x0802fcee: 2800        cmp	r0, #0
@   0x0802fcf0: d001        beq.n	0x2fcf6
@   0x0802fcf2: 61b1        str	r1, [r6, #24]
@   0x0802fcf4: e003        b.n	0x2fcfe
@   0x0802fcf6: 23c0        movs	r3, #192	@ 0xc0
@   0x0802fcf8: 005b        lsls	r3, r3, #1
@   0x0802fcfa: 18c8        adds	r0, r1, r3
@   0x0802fcfc: 61b0        str	r0, [r6, #24]
@   0x0802fcfe: 69b1        ldr	r1, [r6, #24]
@   0x0802fd00: 20c0        movs	r0, #192	@ 0xc0
@   0x0802fd02: 0040        lsls	r0, r0, #1
@   0x0802fd04: 1809        adds	r1, r1, r0
@   0x0802fd06: 61f1        str	r1, [r6, #28]
@   0x0802fd08: 6930        ldr	r0, [r6, #16]
@   0x0802fd0a: 1a09        subs	r1, r1, r0
@   0x0802fd0c: f7fe        fb38 	bl	0x2e380
@   0x0802fd10: 491a        ldr	r1, [pc, #104]	@ (0x2fd7c)
@   0x0802fd12: 468a        mov	sl, r1
@   0x0802fd14: 680a        ldr	r2, [r1, #0]
@   0x0802fd16: 78b8        ldrb	r0, [r7, #2]
@   0x0802fd18: 2100        movs	r1, #0
@   0x0802fd1a: 7010        strb	r0, [r2, #0]
@   0x0802fd1c: 9a03        ldr	r2, [sp, #12]
@   0x0802fd1e: 7011        strb	r1, [r2, #0]
@   0x0802fd20: 8839        ldrh	r1, [r7, #0]
@   0x0802fd22: 2080        movs	r0, #128	@ 0x80
@   0x0802fd24: 0440        lsls	r0, r0, #17
@   0x0802fd26: f003        fff5 	bl	0x33d14
@   0x0802fd2a: 4681        mov	r9, r0
@   0x0802fd2c: 4814        ldr	r0, [pc, #80]	@ (0x2fd80)
@   0x0802fd2e: 464b        mov	r3, r9
@   0x0802fd30: 4003        ands	r3, r0
@   0x0802fd32: 4699        mov	r9, r3
@   0x0802fd34: 041c        lsls	r4, r3, #16
@   0x0802fd36: 1424        asrs	r4, r4, #16
@   0x0802fd38: 1c20        adds	r0, r4, #0
@   0x0802fd3a: f004        fd7d 	bl	0x34838
@   0x0802fd3e: 1c02        adds	r2, r0, #0
@   0x0802fd40: 2c00        cmp	r4, #0
@   0x0802fd42: da03        bge.n	0x2fd4c
@   0x0802fd44: 490f        ldr	r1, [pc, #60]	@ (0x2fd84)
@   0x0802fd46: f004        fac1 	bl	0x342cc
@   0x0802fd4a: 1c02        adds	r2, r0, #0
@   0x0802fd4c: 480e        ldr	r0, [pc, #56]	@ (0x2fd88)
@   0x0802fd4e: 1c11        adds	r1, r2, #0
@   0x0802fd50: f004        fb9e 	bl	0x34490
@   0x0802fd54: 1c05        adds	r5, r0, #0
@   0x0802fd56: 4650        mov	r0, sl
@   0x0802fd58: 6804        ldr	r4, [r0, #0]
@   0x0802fd5a: 1c28        adds	r0, r5, #0
@   0x0802fd5c: f004        f826 	bl	0x33dac
@   0x0802fd60: 8060        strh	r0, [r4, #2]
@   0x0802fd62: 480a        ldr	r0, [pc, #40]	@ (0x2fd8c)
@   0x0802fd64: 1c29        adds	r1, r5, #0
@   0x0802fd66: f004        fb93 	bl	0x34490
@   0x0802fd6a: f004        f81f 	bl	0x33dac
@   0x0802fd6e: 1c01        adds	r1, r0, #0
@   0x0802fd70: 4807        ldr	r0, [pc, #28]	@ (0x2fd90)
@   0x0802fd72: 4281        cmp	r1, r0
@   0x0802fd74: d80e        bhi.n	0x2fd94
@   0x0802fd76: 2400        movs	r4, #0
@   0x0802fd78: e028        b.n	0x2fdcc
@   0x0802fd7a: 0000        movs	r0, r0
@   0x0802fd7c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802fd7e: 0300        lsls	r0, r0, #12
@   0x0802fd80: ffc0        0000 	vaddl.u8	q8, d0, d0
@   0x0802fd84: 0000        movs	r0, r0
@   0x0802fd86: 4780        blx	r0
@   0x0802fd88: 0000        movs	r0, r0
@   0x0802fd8a: 4b80        ldr	r3, [pc, #512]	@ (0x2ff8c)
@   0x0802fd8c: a7e2        add	r7, pc, #904	@ (adr r7, 0x30118)
@   0x0802fd8e: 51ca        str	r2, [r1, r7]
@   0x0802fd90: 9aca        ldr	r2, [sp, #808]	@ 0x328
@   0x0802fd92: 003b        movs	r3, r7
@   0x0802fd94: 4802        ldr	r0, [pc, #8]	@ (0x2fda0)
@   0x0802fd96: 4281        cmp	r1, r0
@   0x0802fd98: d804        bhi.n	0x2fda4
@   0x0802fd9a: 2401        movs	r4, #1
@   0x0802fd9c: 0989        lsrs	r1, r1, #6
@   0x0802fd9e: e015        b.n	0x2fdcc
@   0x0802fda0: b280        uxth	r0, r0
@   0x0802fda2: 0ee6        lsrs	r6, r4, #27
@   0x0802fda4: 4802        ldr	r0, [pc, #8]	@ (0x2fdb0)
@   0x0802fda6: 4281        cmp	r1, r0
@   0x0802fda8: d804        bhi.n	0x2fdb4
@   0x0802fdaa: 2402        movs	r4, #2
@   0x0802fdac: 0a09        lsrs	r1, r1, #8
@   0x0802fdae: e00d        b.n	0x2fdcc
@   0x0802fdb0: ca00        ldmia	r2!, {}
@   0x0802fdb2: 3b9a        subs	r3, #154	@ 0x9a
@   0x0802fdb4: 4803        ldr	r0, [pc, #12]	@ (0x2fdc4)
@   0x0802fdb6: 4281        cmp	r1, r0
@   0x0802fdb8: d906        bls.n	0x2fdc8
@   0x0802fdba: 2101        movs	r1, #1
@   0x0802fdbc: 4249        negs	r1, r1
@   0x0802fdbe: 468a        mov	sl, r1
@   0x0802fdc0: e028        b.n	0x2fe14
@   0x0802fdc2: 0000        movs	r0, r0
@   0x0802fdc4: 2800        cmp	r0, #0
@   0x0802fdc6: ee6b        2403 	cdp	4, 6, cr2, cr11, cr3, {0}
@   0x0802fdca: 0a89        lsrs	r1, r1, #10
@   0x0802fdcc: 2900        cmp	r1, #0
@   0x0802fdce: db03        blt.n	0x2fdd8
@   0x0802fdd0: 1c08        adds	r0, r1, #0
@   0x0802fdd2: f004        fd31 	bl	0x34838
@   0x0802fdd6: e009        b.n	0x2fdec
@   0x0802fdd8: 2001        movs	r0, #1
@   0x0802fdda: 4008        ands	r0, r1
@   0x0802fddc: 0849        lsrs	r1, r1, #1
@   0x0802fdde: 4308        orrs	r0, r1
@   0x0802fde0: f004        fd2a 	bl	0x34838
@   0x0802fde4: 1c02        adds	r2, r0, #0
@   0x0802fde6: 1c11        adds	r1, r2, #0
@   0x0802fde8: f004        fa70 	bl	0x342cc
@   0x0802fdec: 1c02        adds	r2, r0, #0
@   0x0802fdee: 4930        ldr	r1, [pc, #192]	@ (0x2feb0)
@   0x0802fdf0: 1c10        adds	r0, r2, #0
@   0x0802fdf2: f004        fb4d 	bl	0x34490
@   0x0802fdf6: f004        fd4f 	bl	0x34898
@   0x0802fdfa: 2180        movs	r1, #128	@ 0x80
@   0x0802fdfc: 0249        lsls	r1, r1, #9
@   0x0802fdfe: 4288        cmp	r0, r1
@   0x0802fe00: d900        bls.n	0x2fe04
@   0x0802fe02: 1c08        adds	r0, r1, #0
@   0x0802fe04: 0424        lsls	r4, r4, #16
@   0x0802fe06: 46a2        mov	sl, r4
@   0x0802fe08: 1a08        subs	r0, r1, r0
@   0x0802fe0a: 492a        ldr	r1, [pc, #168]	@ (0x2feb4)
@   0x0802fe0c: 4008        ands	r0, r1
@   0x0802fe0e: 4652        mov	r2, sl
@   0x0802fe10: 4302        orrs	r2, r0
@   0x0802fe12: 4692        mov	sl, r2
@   0x0802fe14: 464b        mov	r3, r9
@   0x0802fe16: 0418        lsls	r0, r3, #16
@   0x0802fe18: 4240        negs	r0, r0
@   0x0802fe1a: 0c00        lsrs	r0, r0, #16
@   0x0802fe1c: 9001        str	r0, [sp, #4]
@   0x0802fe1e: 0058        lsls	r0, r3, #1
@   0x0802fe20: 4240        negs	r0, r0
@   0x0802fe22: 8470        strh	r0, [r6, #34]	@ 0x22
@   0x0802fe24: 2001        movs	r0, #1
@   0x0802fe26: 4681        mov	r9, r0
@   0x0802fe28: 464a        mov	r2, r9
@   0x0802fe2a: 9902        ldr	r1, [sp, #8]
@   0x0802fe2c: 700a        strb	r2, [r1, #0]
@   0x0802fe2e: 88b8        ldrh	r0, [r7, #4]
@   0x0802fe30: 2800        cmp	r0, #0
@   0x0802fe32: d047        beq.n	0x2fec4
@   0x0802fe34: 9b00        ldr	r3, [sp, #0]
@   0x0802fe36: 68d9        ldr	r1, [r3, #12]
@   0x0802fe38: 2006        movs	r0, #6
@   0x0802fe3a: 78fa        ldrb	r2, [r7, #3]
@   0x0802fe3c: 4010        ands	r0, r2
@   0x0802fe3e: 2480        movs	r4, #128	@ 0x80
@   0x0802fe40: 0064        lsls	r4, r4, #1
@   0x0802fe42: 2800        cmp	r0, #0
@   0x0802fe44: d000        beq.n	0x2fe48
@   0x0802fe46: 2480        movs	r4, #128	@ 0x80
@   0x0802fe48: 6271        str	r1, [r6, #36]	@ 0x24
@   0x0802fe4a: 0065        lsls	r5, r4, #1
@   0x0802fe4c: 1949        adds	r1, r1, r5
@   0x0802fe4e: 4643        mov	r3, r8
@   0x0802fe50: 6059        str	r1, [r3, #4]
@   0x0802fe52: 4819        ldr	r0, [pc, #100]	@ (0x2feb8)
@   0x0802fe54: 6800        ldr	r0, [r0, #0]
@   0x0802fe56: 88ba        ldrh	r2, [r7, #4]
@   0x0802fe58: 8843        ldrh	r3, [r0, #2]
@   0x0802fe5a: 1c11        adds	r1, r2, #0
@   0x0802fe5c: 4359        muls	r1, r3
@   0x0802fe5e: 1c08        adds	r0, r1, #0
@   0x0802fe60: 21fa        movs	r1, #250	@ 0xfa
@   0x0802fe62: 0249        lsls	r1, r1, #9
@   0x0802fe64: f004        f83e 	bl	0x33ee4
@   0x0802fe68: 1c01        adds	r1, r0, #0
@   0x0802fe6a: 2900        cmp	r1, #0
@   0x0802fe6c: d100        bne.n	0x2fe70
@   0x0802fe6e: 2101        movs	r1, #1
@   0x0802fe70: 29ff        cmp	r1, #255	@ 0xff
@   0x0802fe72: d900        bls.n	0x2fe76
@   0x0802fe74: 21ff        movs	r1, #255	@ 0xff
@   0x0802fe76: 4640        mov	r0, r8
@   0x0802fe78: 6842        ldr	r2, [r0, #4]
@   0x0802fe7a: 6082        str	r2, [r0, #8]
@   0x0802fe7c: 60c2        str	r2, [r0, #12]
@   0x0802fe7e: 1c10        adds	r0, r2, #0
@   0x0802fe80: 2901        cmp	r1, #1
@   0x0802fe82: d902        bls.n	0x2fe8a
@   0x0802fe84: 1940        adds	r0, r0, r5
@   0x0802fe86: 4643        mov	r3, r8
@   0x0802fe88: 60d8        str	r0, [r3, #12]
@   0x0802fe8a: 4361        muls	r1, r4
@   0x0802fe8c: 0049        lsls	r1, r1, #1
@   0x0802fe8e: 1851        adds	r1, r2, r1
@   0x0802fe90: 4640        mov	r0, r8
@   0x0802fe92: 6101        str	r1, [r0, #16]
@   0x0802fe94: 6a70        ldr	r0, [r6, #36]	@ 0x24
@   0x0802fe96: 1a09        subs	r1, r1, r0
@   0x0802fe98: f7fe        fa72 	bl	0x2e380
@   0x0802fe9c: 4807        ldr	r0, [pc, #28]	@ (0x2febc)
@   0x0802fe9e: 4641        mov	r1, r8
@   0x0802fea0: 8288        strh	r0, [r1, #20]
@   0x0802fea2: 4804        ldr	r0, [pc, #16]	@ (0x2feb4)
@   0x0802fea4: 82c8        strh	r0, [r1, #22]
@   0x0802fea6: 4806        ldr	r0, [pc, #24]	@ (0x2fec0)
@   0x0802fea8: 8308        strh	r0, [r1, #24]
@   0x0802feaa: 464a        mov	r2, r9
@   0x0802feac: 768a        strb	r2, [r1, #26]
@   0x0802feae: e00d        b.n	0x2fecc
@   0x0802feb0: 6b28        ldr	r0, [r5, #48]	@ 0x30
@   0x0802feb2: 426e        negs	r6, r5
@   0x0802feb4: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0802feb8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802feba: 0300        lsls	r0, r0, #12
@   0x0802febc: 7332        strb	r2, [r6, #12]
@   0x0802febe: 0000        movs	r0, r0
@   0x0802fec0: cccc        ldmia	r4!, {r2, r3, r6, r7}
@   0x0802fec2: 0000        movs	r0, r0
@   0x0802fec4: 4640        mov	r0, r8
@   0x0802fec6: 211c        movs	r1, #28
@   0x0802fec8: f7fe        fa5a 	bl	0x2e380
@   0x0802fecc: 78f8        ldrb	r0, [r7, #3]
@   0x0802fece: 9b04        ldr	r3, [sp, #16]
@   0x0802fed0: 7018        strb	r0, [r3, #0]
@   0x0802fed2: 4c1b        ldr	r4, [pc, #108]	@ (0x2ff40)
@   0x0802fed4: 4b1b        ldr	r3, [pc, #108]	@ (0x2ff44)
@   0x0802fed6: 2100        movs	r1, #0
@   0x0802fed8: 4a1b        ldr	r2, [pc, #108]	@ (0x2ff48)
@   0x0802feda: 2007        movs	r0, #7
@   0x0802fedc: 6019        str	r1, [r3, #0]
@   0x0802fede: 6011        str	r1, [r2, #0]
@   0x0802fee0: 3801        subs	r0, #1
@   0x0802fee2: 2800        cmp	r0, #0
@   0x0802fee4: dafa        bge.n	0x2fedc
@   0x0802fee6: 4919        ldr	r1, [pc, #100]	@ (0x2ff4c)
@   0x0802fee8: 6970        ldr	r0, [r6, #20]
@   0x0802feea: 6008        str	r0, [r1, #0]
@   0x0802feec: 3104        adds	r1, #4
@   0x0802feee: 4815        ldr	r0, [pc, #84]	@ (0x2ff44)
@   0x0802fef0: 6008        str	r0, [r1, #0]
@   0x0802fef2: 3024        adds	r0, #36	@ 0x24
@   0x0802fef4: 2304        movs	r3, #4
@   0x0802fef6: 8003        strh	r3, [r0, #0]
@   0x0802fef8: 3002        adds	r0, #2
@   0x0802fefa: 4915        ldr	r1, [pc, #84]	@ (0x2ff50)
@   0x0802fefc: 1c0a        adds	r2, r1, #0
@   0x0802fefe: 8002        strh	r2, [r0, #0]
@   0x0802ff00: 4914        ldr	r1, [pc, #80]	@ (0x2ff54)
@   0x0802ff02: 69b0        ldr	r0, [r6, #24]
@   0x0802ff04: 6008        str	r0, [r1, #0]
@   0x0802ff06: 3104        adds	r1, #4
@   0x0802ff08: 480f        ldr	r0, [pc, #60]	@ (0x2ff48)
@   0x0802ff0a: 6008        str	r0, [r1, #0]
@   0x0802ff0c: 302c        adds	r0, #44	@ 0x2c
@   0x0802ff0e: 8003        strh	r3, [r0, #0]
@   0x0802ff10: 3002        adds	r0, #2
@   0x0802ff12: 8002        strh	r2, [r0, #0]
@   0x0802ff14: 3138        adds	r1, #56	@ 0x38
@   0x0802ff16: 20c0        movs	r0, #192	@ 0xc0
@   0x0802ff18: 0400        lsls	r0, r0, #16
@   0x0802ff1a: 4652        mov	r2, sl
@   0x0802ff1c: 4302        orrs	r2, r0
@   0x0802ff1e: 600a        str	r2, [r1, #0]
@   0x0802ff20: 3904        subs	r1, #4
@   0x0802ff22: 2080        movs	r0, #128	@ 0x80
@   0x0802ff24: 0400        lsls	r0, r0, #16
@   0x0802ff26: 9b01        ldr	r3, [sp, #4]
@   0x0802ff28: 4318        orrs	r0, r3
@   0x0802ff2a: 6008        str	r0, [r1, #0]
@   0x0802ff2c: 6820        ldr	r0, [r4, #0]
@   0x0802ff2e: 8840        ldrh	r0, [r0, #2]
@   0x0802ff30: b005        add	sp, #20
@   0x0802ff32: bc38        pop	{r3, r4, r5}
@   0x0802ff34: 4698        mov	r8, r3
@   0x0802ff36: 46a1        mov	r9, r4
@   0x0802ff38: 46aa        mov	sl, r5
@   0x0802ff3a: bcf0        pop	{r4, r5, r6, r7}
@   0x0802ff3c: bc02        pop	{r1}
@   0x0802ff3e: 4708        bx	r1
@   0x0802ff40: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ff42: 0300        lsls	r0, r0, #12
@   0x0802ff44: 00a0        lsls	r0, r4, #2
@   0x0802ff46: 0400        lsls	r0, r0, #16
@   0x0802ff48: 00a4        lsls	r4, r4, #2
@   0x0802ff4a: 0400        lsls	r0, r0, #16
@   0x0802ff4c: 00bc        lsls	r4, r7, #2
@   0x0802ff4e: 0400        lsls	r0, r0, #16
@   0x0802ff50: b660        cpsie
@   0x0802ff52: 0000        movs	r0, r0
@   0x0802ff54: 00c8        lsls	r0, r1, #3
@   0x0802ff56: 0400        lsls	r0, r0, #16
@   0x0802ff58: b570        push	{r4, r5, r6, lr}
@   0x0802ff5a: 4819        ldr	r0, [pc, #100]	@ (0x2ffc0)
@   0x0802ff5c: 6804        ldr	r4, [r0, #0]
@   0x0802ff5e: 1c26        adds	r6, r4, #0
@   0x0802ff60: 36d0        adds	r6, #208	@ 0xd0
@   0x0802ff62: f7fe        fa59 	bl	0x2e418
@   0x0802ff66: 34f1        adds	r4, #241	@ 0xf1
@   0x0802ff68: 2500        movs	r5, #0
@   0x0802ff6a: 7025        strb	r5, [r4, #0]
@   0x0802ff6c: 4b15        ldr	r3, [pc, #84]	@ (0x2ffc4)
@   0x0802ff6e: 881a        ldrh	r2, [r3, #0]
@   0x0802ff70: 4915        ldr	r1, [pc, #84]	@ (0x2ffc8)
@   0x0802ff72: 1c08        adds	r0, r1, #0
@   0x0802ff74: 4010        ands	r0, r2
@   0x0802ff76: 8018        strh	r0, [r3, #0]
@   0x0802ff78: 4a14        ldr	r2, [pc, #80]	@ (0x2ffcc)
@   0x0802ff7a: 8810        ldrh	r0, [r2, #0]
@   0x0802ff7c: 4001        ands	r1, r0
@   0x0802ff7e: 8011        strh	r1, [r2, #0]
@   0x0802ff80: 4813        ldr	r0, [pc, #76]	@ (0x2ffd0)
@   0x0802ff82: 8005        strh	r5, [r0, #0]
@   0x0802ff84: 300c        adds	r0, #12
@   0x0802ff86: 8005        strh	r5, [r0, #0]
@   0x0802ff88: 4912        ldr	r1, [pc, #72]	@ (0x2ffd4)
@   0x0802ff8a: 2088        movs	r0, #136	@ 0x88
@   0x0802ff8c: 7008        strb	r0, [r1, #0]
@   0x0802ff8e: 3b66        subs	r3, #102	@ 0x66
@   0x0802ff90: 2100        movs	r1, #0
@   0x0802ff92: 3a5e        subs	r2, #94	@ 0x5e
@   0x0802ff94: 2007        movs	r0, #7
@   0x0802ff96: 6019        str	r1, [r3, #0]
@   0x0802ff98: 6011        str	r1, [r2, #0]
@   0x0802ff9a: 3801        subs	r0, #1
@   0x0802ff9c: 2800        cmp	r0, #0
@   0x0802ff9e: dafa        bge.n	0x2ff96
@   0x0802ffa0: f7fe        fa2a 	bl	0x2e3f8
@   0x0802ffa4: 6930        ldr	r0, [r6, #16]
@   0x0802ffa6: 69f1        ldr	r1, [r6, #28]
@   0x0802ffa8: 1a09        subs	r1, r1, r0
@   0x0802ffaa: f7fe        f9e9 	bl	0x2e380
@   0x0802ffae: 6a70        ldr	r0, [r6, #36]	@ 0x24
@   0x0802ffb0: 6b71        ldr	r1, [r6, #52]	@ 0x34
@   0x0802ffb2: 1a09        subs	r1, r1, r0
@   0x0802ffb4: f7fe        f9e4 	bl	0x2e380
@   0x0802ffb8: bc70        pop	{r4, r5, r6}
@   0x0802ffba: bc01        pop	{r0}
@   0x0802ffbc: 4700        bx	r0
@   0x0802ffbe: 0000        movs	r0, r0
@   0x0802ffc0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802ffc2: 0300        lsls	r0, r0, #12
@   0x0802ffc4: 0106        lsls	r6, r0, #4
@   0x0802ffc6: 0400        lsls	r0, r0, #16
@   0x0802ffc8: ff3f        0000 	vhadd.u<illegal width 64>	d0, d15, d0
@   0x0802ffcc: 0102        lsls	r2, r0, #4
@   0x0802ffce: 0400        lsls	r0, r0, #16
@   0x0802ffd0: 00c6        lsls	r6, r0, #3
@   0x0802ffd2: 0400        lsls	r0, r0, #16
@   0x0802ffd4: 0083        lsls	r3, r0, #2
@   0x0802ffd6: 0400        lsls	r0, r0, #16
@   0x0802ffd8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ffda: 4657        mov	r7, sl
@   0x0802ffdc: 464e        mov	r6, r9
@   0x0802ffde: 4645        mov	r5, r8
@   0x0802ffe0: b4e0        push	{r5, r6, r7}
@   0x0802ffe2: b085        sub	sp, #20
@   0x0802ffe4: 4e31        ldr	r6, [pc, #196]	@ (0x300ac)
@   0x0802ffe6: 6835        ldr	r5, [r6, #0]
@   0x0802ffe8: 7828        ldrb	r0, [r5, #0]
@   0x0802ffea: 2800        cmp	r0, #0
@   0x0802ffec: d100        bne.n	0x2fff0
@   0x0802ffee: e0aa        b.n	0x30146
@   0x0802fff0: 1c2f        adds	r7, r5, #0
@   0x0802fff2: 37d0        adds	r7, #208	@ 0xd0
@   0x0802fff4: 6838        ldr	r0, [r7, #0]
@   0x0802fff6: 9000        str	r0, [sp, #0]
@   0x0802fff8: 6879        ldr	r1, [r7, #4]
@   0x0802fffa: 9101        str	r1, [sp, #4]
@   0x0802fffc: 68ba        ldr	r2, [r7, #8]
@   0x0802fffe: 9202        str	r2, [sp, #8]
@   0x08030000: 68fb        ldr	r3, [r7, #12]
@   0x08030002: 9303        str	r3, [sp, #12]
@   0x08030004: 1c2a        adds	r2, r5, #0
@   0x08030006: 32f1        adds	r2, #241	@ 0xf1
@   0x08030008: 7811        ldrb	r1, [r2, #0]
@   0x0803000a: 2900        cmp	r1, #0
@   0x0803000c: d109        bne.n	0x30022
@   0x0803000e: 2001        movs	r0, #1
@   0x08030010: 7010        strb	r0, [r2, #0]
@   0x08030012: 4827        ldr	r0, [pc, #156]	@ (0x300b0)
@   0x08030014: 8001        strh	r1, [r0, #0]
@   0x08030016: 4927        ldr	r1, [pc, #156]	@ (0x300b4)
@   0x08030018: 20c1        movs	r0, #193	@ 0xc1
@   0x0803001a: 0400        lsls	r0, r0, #16
@   0x0803001c: 8c7a        ldrh	r2, [r7, #34]	@ 0x22
@   0x0803001e: 4310        orrs	r0, r2
@   0x08030020: 6008        str	r0, [r1, #0]
@   0x08030022: 1c2c        adds	r4, r5, #0
@   0x08030024: 34f0        adds	r4, #240	@ 0xf0
@   0x08030026: 7820        ldrb	r0, [r4, #0]
@   0x08030028: 3001        adds	r0, #1
@   0x0803002a: 7020        strb	r0, [r4, #0]
@   0x0803002c: 0600        lsls	r0, r0, #24
@   0x0803002e: 0e00        lsrs	r0, r0, #24
@   0x08030030: 2803        cmp	r0, #3
@   0x08030032: d101        bne.n	0x30038
@   0x08030034: 2000        movs	r0, #0
@   0x08030036: 7020        strb	r0, [r4, #0]
@   0x08030038: 7823        ldrb	r3, [r4, #0]
@   0x0803003a: 2b01        cmp	r3, #1
@   0x0803003c: d10f        bne.n	0x3005e
@   0x0803003e: 4b1e        ldr	r3, [pc, #120]	@ (0x300b8)
@   0x08030040: 491e        ldr	r1, [pc, #120]	@ (0x300bc)
@   0x08030042: 1c08        adds	r0, r1, #0
@   0x08030044: 8018        strh	r0, [r3, #0]
@   0x08030046: 4a1e        ldr	r2, [pc, #120]	@ (0x300c0)
@   0x08030048: 8010        strh	r0, [r2, #0]
@   0x0803004a: 491e        ldr	r1, [pc, #120]	@ (0x300c4)
@   0x0803004c: 6978        ldr	r0, [r7, #20]
@   0x0803004e: 6008        str	r0, [r1, #0]
@   0x08030050: 310c        adds	r1, #12
@   0x08030052: 69b8        ldr	r0, [r7, #24]
@   0x08030054: 6008        str	r0, [r1, #0]
@   0x08030056: 491c        ldr	r1, [pc, #112]	@ (0x300c8)
@   0x08030058: 1c08        adds	r0, r1, #0
@   0x0803005a: 8018        strh	r0, [r3, #0]
@   0x0803005c: 8010        strh	r0, [r2, #0]
@   0x0803005e: 2200        movs	r2, #0
@   0x08030060: 6830        ldr	r0, [r6, #0]
@   0x08030062: 2387        movs	r3, #135	@ 0x87
@   0x08030064: 005b        lsls	r3, r3, #1
@   0x08030066: 195b        adds	r3, r3, r5
@   0x08030068: 4699        mov	r9, r3
@   0x0803006a: 46a2        mov	sl, r4
@   0x0803006c: 7800        ldrb	r0, [r0, #0]
@   0x0803006e: 4282        cmp	r2, r0
@   0x08030070: da54        bge.n	0x3011c
@   0x08030072: 46b0        mov	r8, r6
@   0x08030074: 4641        mov	r1, r8
@   0x08030076: 6808        ldr	r0, [r1, #0]
@   0x08030078: 30c4        adds	r0, #196	@ 0xc4
@   0x0803007a: 6800        ldr	r0, [r0, #0]
@   0x0803007c: 0096        lsls	r6, r2, #2
@   0x0803007e: 1830        adds	r0, r6, r0
@   0x08030080: 6805        ldr	r5, [r0, #0]
@   0x08030082: 2d00        cmp	r5, #0
@   0x08030084: d044        beq.n	0x30110
@   0x08030086: 7eec        ldrb	r4, [r5, #27]
@   0x08030088: 2c00        cmp	r4, #0
@   0x0803008a: d11f        bne.n	0x300cc
@   0x0803008c: 6939        ldr	r1, [r7, #16]
@   0x0803008e: 1c28        adds	r0, r5, #0
@   0x08030090: 9204        str	r2, [sp, #16]
@   0x08030092: 9b00        ldr	r3, [sp, #0]
@   0x08030094: f003        fe26 	bl	0x33ce4
@   0x08030098: 9a04        ldr	r2, [sp, #16]
@   0x0803009a: 2800        cmp	r0, #0
@   0x0803009c: d026        beq.n	0x300ec
@   0x0803009e: 4641        mov	r1, r8
@   0x080300a0: 6808        ldr	r0, [r1, #0]
@   0x080300a2: 30c4        adds	r0, #196	@ 0xc4
@   0x080300a4: 6800        ldr	r0, [r0, #0]
@   0x080300a6: 1830        adds	r0, r6, r0
@   0x080300a8: 6004        str	r4, [r0, #0]
@   0x080300aa: e01f        b.n	0x300ec
@   0x080300ac: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080300ae: 0300        lsls	r0, r0, #12
@   0x080300b0: 0106        lsls	r6, r0, #4
@   0x080300b2: 0400        lsls	r0, r0, #16
@   0x080300b4: 0104        lsls	r4, r0, #4
@   0x080300b6: 0400        lsls	r0, r0, #16
@   0x080300b8: 00c6        lsls	r6, r0, #3
@   0x080300ba: 0400        lsls	r0, r0, #16
@   0x080300bc: 3660        adds	r6, #96	@ 0x60
@   0x080300be: 0000        movs	r0, r0
@   0x080300c0: 00d2        lsls	r2, r2, #3
@   0x080300c2: 0400        lsls	r0, r0, #16
@   0x080300c4: 00bc        lsls	r4, r7, #2
@   0x080300c6: 0400        lsls	r0, r0, #16
@   0x080300c8: b660        cpsie
@   0x080300ca: 0000        movs	r0, r0
@   0x080300cc: 6a79        ldr	r1, [r7, #36]	@ 0x24
@   0x080300ce: 1c28        adds	r0, r5, #0
@   0x080300d0: 9204        str	r2, [sp, #16]
@   0x080300d2: 9b01        ldr	r3, [sp, #4]
@   0x080300d4: f003        fe06 	bl	0x33ce4
@   0x080300d8: 9a04        ldr	r2, [sp, #16]
@   0x080300da: 2800        cmp	r0, #0
@   0x080300dc: d006        beq.n	0x300ec
@   0x080300de: 4641        mov	r1, r8
@   0x080300e0: 6808        ldr	r0, [r1, #0]
@   0x080300e2: 30c4        adds	r0, #196	@ 0xc4
@   0x080300e4: 6800        ldr	r0, [r0, #0]
@   0x080300e6: 1830        adds	r0, r6, r0
@   0x080300e8: 2100        movs	r1, #0
@   0x080300ea: 6001        str	r1, [r0, #0]
@   0x080300ec: 4643        mov	r3, r8
@   0x080300ee: 6818        ldr	r0, [r3, #0]
@   0x080300f0: 30c8        adds	r0, #200	@ 0xc8
@   0x080300f2: 6801        ldr	r1, [r0, #0]
@   0x080300f4: 0190        lsls	r0, r2, #6
@   0x080300f6: 1840        adds	r0, r0, r1
@   0x080300f8: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x080300fa: 2180        movs	r1, #128	@ 0x80
@   0x080300fc: 0289        lsls	r1, r1, #10
@   0x080300fe: 4008        ands	r0, r1
@   0x08030100: 2800        cmp	r0, #0
@   0x08030102: d005        beq.n	0x30110
@   0x08030104: 1c10        adds	r0, r2, #0
@   0x08030106: 1c29        adds	r1, r5, #0
@   0x08030108: 9204        str	r2, [sp, #16]
@   0x0803010a: f7fd        ff7f 	bl	0x2e00c
@   0x0803010e: 9a04        ldr	r2, [sp, #16]
@   0x08030110: 3201        adds	r2, #1
@   0x08030112: 4641        mov	r1, r8
@   0x08030114: 6808        ldr	r0, [r1, #0]
@   0x08030116: 7800        ldrb	r0, [r0, #0]
@   0x08030118: 4282        cmp	r2, r0
@   0x0803011a: dbab        blt.n	0x30074
@   0x0803011c: 464a        mov	r2, r9
@   0x0803011e: 7810        ldrb	r0, [r2, #0]
@   0x08030120: 2800        cmp	r0, #0
@   0x08030122: d005        beq.n	0x30130
@   0x08030124: 1c38        adds	r0, r7, #0
@   0x08030126: 3024        adds	r0, #36	@ 0x24
@   0x08030128: 6939        ldr	r1, [r7, #16]
@   0x0803012a: 9b03        ldr	r3, [sp, #12]
@   0x0803012c: f003        fdda 	bl	0x33ce4
@   0x08030130: 4651        mov	r1, sl
@   0x08030132: 7809        ldrb	r1, [r1, #0]
@   0x08030134: 01c8        lsls	r0, r1, #7
@   0x08030136: 6979        ldr	r1, [r7, #20]
@   0x08030138: 1809        adds	r1, r1, r0
@   0x0803013a: 69ba        ldr	r2, [r7, #24]
@   0x0803013c: 1812        adds	r2, r2, r0
@   0x0803013e: 6938        ldr	r0, [r7, #16]
@   0x08030140: 9b02        ldr	r3, [sp, #8]
@   0x08030142: f003        fdcf 	bl	0x33ce4
@   0x08030146: b005        add	sp, #20
@   0x08030148: bc38        pop	{r3, r4, r5}
@   0x0803014a: 4698        mov	r8, r3
@   0x0803014c: 46a1        mov	r9, r4
@   0x0803014e: 46aa        mov	sl, r5
@   0x08030150: bcf0        pop	{r4, r5, r6, r7}
@   0x08030152: bc01        pop	{r0}
@   0x08030154: 4700        bx	r0

        thumb_func_start sub_0802FAB8
sub_0802FAB8: @ 0x0802fab8
        .incbin "frog_us_baserom.gba", 0x2fab8, 0x4a0
        thumb_func_end sub_0802FAB8

        thumb_func_start SoundMixer_VBlankTick
SoundMixer_VBlankTick: @ 0x0802ff58
        .incbin "frog_us_baserom.gba", 0x2ff58, 0x200
        thumb_func_end SoundMixer_VBlankTick
