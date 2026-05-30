@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005d10, 0x08005ed8)  (456 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005d10 --end 0x8005ed8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005d10: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08005d12: 4657        mov	r7, sl
@   0x08005d14: 464e        mov	r6, r9
@   0x08005d16: 4645        mov	r5, r8
@   0x08005d18: b4e0        push	{r5, r6, r7}
@   0x08005d1a: b086        sub	sp, #24
@   0x08005d1c: 1c04        adds	r4, r0, #0
@   0x08005d1e: 9104        str	r1, [sp, #16]
@   0x08005d20: 4832        ldr	r0, [pc, #200]	@ (0x5dec)
@   0x08005d22: 1c21        adds	r1, r4, #0
@   0x08005d24: 9a04        ldr	r2, [sp, #16]
@   0x08005d26: f000        fd83 	bl	0x6830
@   0x08005d2a: 17c1        asrs	r1, r0, #31
@   0x08005d2c: 4308        orrs	r0, r1
@   0x08005d2e: 2800        cmp	r0, #0
@   0x08005d30: d100        bne.n	0x5d34
@   0x08005d32: e0c5        b.n	0x5ec0
@   0x08005d34: 482e        ldr	r0, [pc, #184]	@ (0x5df0)
@   0x08005d36: 6800        ldr	r0, [r0, #0]
@   0x08005d38: 4682        mov	sl, r0
@   0x08005d3a: 46a1        mov	r9, r4
@   0x08005d3c: 9804        ldr	r0, [sp, #16]
@   0x08005d3e: 4581        cmp	r9, r0
@   0x08005d40: dd00        ble.n	0x5d44
@   0x08005d42: e0bd        b.n	0x5ec0
@   0x08005d44: 00e0        lsls	r0, r4, #3
@   0x08005d46: 1b00        subs	r0, r0, r4
@   0x08005d48: 00c0        lsls	r0, r0, #3
@   0x08005d4a: 4680        mov	r8, r0
@   0x08005d4c: 3028        adds	r0, #40	@ 0x28
@   0x08005d4e: 4929        ldr	r1, [pc, #164]	@ (0x5df4)
@   0x08005d50: 1840        adds	r0, r0, r1
@   0x08005d52: 9005        str	r0, [sp, #20]
@   0x08005d54: 1c0d        adds	r5, r1, #0
@   0x08005d56: 4445        add	r5, r8
@   0x08005d58: 466e        mov	r6, sp
@   0x08005d5a: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x08005d5c: 2002        movs	r0, #2
@   0x08005d5e: 4010        ands	r0, r2
@   0x08005d60: 2800        cmp	r0, #0
@   0x08005d62: d04d        beq.n	0x5e00
@   0x08005d64: 782a        ldrb	r2, [r5, #0]
@   0x08005d66: 00d1        lsls	r1, r2, #3
@   0x08005d68: 4b23        ldr	r3, [pc, #140]	@ (0x5df8)
@   0x08005d6a: 18c9        adds	r1, r1, r3
@   0x08005d6c: 7eac        ldrb	r4, [r5, #26]
@   0x08005d6e: 0060        lsls	r0, r4, #1
@   0x08005d70: 1900        adds	r0, r0, r4
@   0x08005d72: 0080        lsls	r0, r0, #2
@   0x08005d74: 6809        ldr	r1, [r1, #0]
@   0x08005d76: 180c        adds	r4, r1, r0
@   0x08005d78: 4669        mov	r1, sp
@   0x08005d7a: 6820        ldr	r0, [r4, #0]
@   0x08005d7c: c88c        ldmia	r0!, {r2, r3, r7}
@   0x08005d7e: c18c        stmia	r1!, {r2, r3, r7}
@   0x08005d80: 6800        ldr	r0, [r0, #0]
@   0x08005d82: 6008        str	r0, [r1, #0]
@   0x08005d84: 7a20        ldrb	r0, [r4, #8]
@   0x08005d86: 7728        strb	r0, [r5, #28]
@   0x08005d88: 7a60        ldrb	r0, [r4, #9]
@   0x08005d8a: 7aa1        ldrb	r1, [r4, #10]
@   0x08005d8c: f000        f8a4 	bl	0x5ed8
@   0x08005d90: 7668        strb	r0, [r5, #25]
@   0x08005d92: 7a60        ldrb	r0, [r4, #9]
@   0x08005d94: 7aa1        ldrb	r1, [r4, #10]
@   0x08005d96: f000        f8db 	bl	0x5f50
@   0x08005d9a: 7628        strb	r0, [r5, #24]
@   0x08005d9c: 2400        movs	r4, #0
@   0x08005d9e: 76ec        strb	r4, [r5, #27]
@   0x08005da0: 7a70        ldrb	r0, [r6, #9]
@   0x08005da2: 7068        strb	r0, [r5, #1]
@   0x08005da4: 2000        movs	r0, #0
@   0x08005da6: 5630        ldrsb	r0, [r6, r0]
@   0x08005da8: 886f        ldrh	r7, [r5, #2]
@   0x08005daa: 1838        adds	r0, r7, r0
@   0x08005dac: 8068        strh	r0, [r5, #2]
@   0x08005dae: 2001        movs	r0, #1
@   0x08005db0: 5630        ldrsb	r0, [r6, r0]
@   0x08005db2: 88a9        ldrh	r1, [r5, #4]
@   0x08005db4: 1808        adds	r0, r1, r0
@   0x08005db6: 80a8        strh	r0, [r5, #4]
@   0x08005db8: 8970        ldrh	r0, [r6, #10]
@   0x08005dba: 84a8        strh	r0, [r5, #36]	@ 0x24
@   0x08005dbc: 89b0        ldrh	r0, [r6, #12]
@   0x08005dbe: 84e8        strh	r0, [r5, #38]	@ 0x26
@   0x08005dc0: 7bb0        ldrb	r0, [r6, #14]
@   0x08005dc2: 9a05        ldr	r2, [sp, #20]
@   0x08005dc4: 7010        strb	r0, [r2, #0]
@   0x08005dc6: 7bf0        ldrb	r0, [r6, #15]
@   0x08005dc8: 7050        strb	r0, [r2, #1]
@   0x08005dca: 7a30        ldrb	r0, [r6, #8]
@   0x08005dcc: 7768        strb	r0, [r5, #29]
@   0x08005dce: 4809        ldr	r0, [pc, #36]	@ (0x5df4)
@   0x08005dd0: 3020        adds	r0, #32
@   0x08005dd2: 4440        add	r0, r8
@   0x08005dd4: 4653        mov	r3, sl
@   0x08005dd6: 6003        str	r3, [r0, #0]
@   0x08005dd8: 2480        movs	r4, #128	@ 0x80
@   0x08005dda: 0064        lsls	r4, r4, #1
@   0x08005ddc: 1c20        adds	r0, r4, #0
@   0x08005dde: 8eaf        ldrh	r7, [r5, #52]	@ 0x34
@   0x08005de0: 4338        orrs	r0, r7
@   0x08005de2: 4a06        ldr	r2, [pc, #24]	@ (0x5dfc)
@   0x08005de4: 1c11        adds	r1, r2, #0
@   0x08005de6: 4008        ands	r0, r1
@   0x08005de8: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005dea: e05d        b.n	0x5ea8
@   0x08005dec: 6110        str	r0, [r2, #16]
@   0x08005dee: 0300        lsls	r0, r0, #12
@   0x08005df0: 5330        strh	r0, [r6, r4]
@   0x08005df2: 0300        lsls	r0, r0, #12
@   0x08005df4: 3720        adds	r7, #32
@   0x08005df6: 0300        lsls	r0, r0, #12
@   0x08005df8: 8adc        ldrh	r4, [r3, #22]
@   0x08005dfa: 082f        lsrs	r7, r5, #32
@   0x08005dfc: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x08005e00: 4806        ldr	r0, [pc, #24]	@ (0x5e1c)
@   0x08005e02: 3020        adds	r0, #32
@   0x08005e04: 4440        add	r0, r8
@   0x08005e06: 6800        ldr	r0, [r0, #0]
@   0x08005e08: 4653        mov	r3, sl
@   0x08005e0a: 1a18        subs	r0, r3, r0
@   0x08005e0c: 7f6c        ldrb	r4, [r5, #29]
@   0x08005e0e: 42a0        cmp	r0, r4
@   0x08005e10: d208        bcs.n	0x5e24
@   0x08005e12: 4f03        ldr	r7, [pc, #12]	@ (0x5e20)
@   0x08005e14: 1c38        adds	r0, r7, #0
@   0x08005e16: 4010        ands	r0, r2
@   0x08005e18: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005e1a: e045        b.n	0x5ea8
@   0x08005e1c: 3720        adds	r7, #32
@   0x08005e1e: 0300        lsls	r0, r0, #12
@   0x08005e20: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x08005e24: 7ee9        ldrb	r1, [r5, #27]
@   0x08005e26: 3101        adds	r1, #1
@   0x08005e28: 0608        lsls	r0, r1, #24
@   0x08005e2a: 0e03        lsrs	r3, r0, #24
@   0x08005e2c: 7f28        ldrb	r0, [r5, #28]
@   0x08005e2e: 4283        cmp	r3, r0
@   0x08005e30: d104        bne.n	0x5e3c
@   0x08005e32: 2180        movs	r1, #128	@ 0x80
@   0x08005e34: 0209        lsls	r1, r1, #8
@   0x08005e36: 1c08        adds	r0, r1, #0
@   0x08005e38: 4310        orrs	r0, r2
@   0x08005e3a: e02f        b.n	0x5e9c
@   0x08005e3c: 76e9        strb	r1, [r5, #27]
@   0x08005e3e: 782a        ldrb	r2, [r5, #0]
@   0x08005e40: 00d1        lsls	r1, r2, #3
@   0x08005e42: 4c23        ldr	r4, [pc, #140]	@ (0x5ed0)
@   0x08005e44: 1909        adds	r1, r1, r4
@   0x08005e46: 7eaf        ldrb	r7, [r5, #26]
@   0x08005e48: 0078        lsls	r0, r7, #1
@   0x08005e4a: 1c3a        adds	r2, r7, #0
@   0x08005e4c: 1880        adds	r0, r0, r2
@   0x08005e4e: 0080        lsls	r0, r0, #2
@   0x08005e50: 6809        ldr	r1, [r1, #0]
@   0x08005e52: 180c        adds	r4, r1, r0
@   0x08005e54: 6822        ldr	r2, [r4, #0]
@   0x08005e56: 0118        lsls	r0, r3, #4
@   0x08005e58: 4669        mov	r1, sp
@   0x08005e5a: 1880        adds	r0, r0, r2
@   0x08005e5c: c898        ldmia	r0!, {r3, r4, r7}
@   0x08005e5e: c198        stmia	r1!, {r3, r4, r7}
@   0x08005e60: 6800        ldr	r0, [r0, #0]
@   0x08005e62: 6008        str	r0, [r1, #0]
@   0x08005e64: 7a70        ldrb	r0, [r6, #9]
@   0x08005e66: 7068        strb	r0, [r5, #1]
@   0x08005e68: 2000        movs	r0, #0
@   0x08005e6a: 5630        ldrsb	r0, [r6, r0]
@   0x08005e6c: 8869        ldrh	r1, [r5, #2]
@   0x08005e6e: 1808        adds	r0, r1, r0
@   0x08005e70: 8068        strh	r0, [r5, #2]
@   0x08005e72: 2001        movs	r0, #1
@   0x08005e74: 5630        ldrsb	r0, [r6, r0]
@   0x08005e76: 88aa        ldrh	r2, [r5, #4]
@   0x08005e78: 1810        adds	r0, r2, r0
@   0x08005e7a: 80a8        strh	r0, [r5, #4]
@   0x08005e7c: 8970        ldrh	r0, [r6, #10]
@   0x08005e7e: 84a8        strh	r0, [r5, #36]	@ 0x24
@   0x08005e80: 89b0        ldrh	r0, [r6, #12]
@   0x08005e82: 84e8        strh	r0, [r5, #38]	@ 0x26
@   0x08005e84: 7bb0        ldrb	r0, [r6, #14]
@   0x08005e86: 9b05        ldr	r3, [sp, #20]
@   0x08005e88: 7018        strb	r0, [r3, #0]
@   0x08005e8a: 7bf0        ldrb	r0, [r6, #15]
@   0x08005e8c: 7058        strb	r0, [r3, #1]
@   0x08005e8e: 7a30        ldrb	r0, [r6, #8]
@   0x08005e90: 7768        strb	r0, [r5, #29]
@   0x08005e92: 2480        movs	r4, #128	@ 0x80
@   0x08005e94: 0064        lsls	r4, r4, #1
@   0x08005e96: 1c20        adds	r0, r4, #0
@   0x08005e98: 8eaf        ldrh	r7, [r5, #52]	@ 0x34
@   0x08005e9a: 4338        orrs	r0, r7
@   0x08005e9c: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005e9e: 480d        ldr	r0, [pc, #52]	@ (0x5ed4)
@   0x08005ea0: 3020        adds	r0, #32
@   0x08005ea2: 4440        add	r0, r8
@   0x08005ea4: 4651        mov	r1, sl
@   0x08005ea6: 6001        str	r1, [r0, #0]
@   0x08005ea8: 2238        movs	r2, #56	@ 0x38
@   0x08005eaa: 4490        add	r8, r2
@   0x08005eac: 9b05        ldr	r3, [sp, #20]
@   0x08005eae: 3338        adds	r3, #56	@ 0x38
@   0x08005eb0: 9305        str	r3, [sp, #20]
@   0x08005eb2: 3538        adds	r5, #56	@ 0x38
@   0x08005eb4: 2401        movs	r4, #1
@   0x08005eb6: 44a1        add	r9, r4
@   0x08005eb8: 9f04        ldr	r7, [sp, #16]
@   0x08005eba: 45b9        cmp	r9, r7
@   0x08005ebc: dc00        bgt.n	0x5ec0
@   0x08005ebe: e74c        b.n	0x5d5a
@   0x08005ec0: b006        add	sp, #24
@   0x08005ec2: bc38        pop	{r3, r4, r5}
@   0x08005ec4: 4698        mov	r8, r3
@   0x08005ec6: 46a1        mov	r9, r4
@   0x08005ec8: 46aa        mov	sl, r5
@   0x08005eca: bcf0        pop	{r4, r5, r6, r7}
@   0x08005ecc: bc01        pop	{r0}
@   0x08005ece: 4700        bx	r0
@   0x08005ed0: 8adc        ldrh	r4, [r3, #22]
@   0x08005ed2: 082f        lsrs	r7, r5, #32
@   0x08005ed4: 3720        adds	r7, #32
@   0x08005ed6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08005D10
sub_08005D10: @ 0x08005d10
        .incbin "frog_us_baserom.gba", 0x5d10, 0x1c8
        thumb_func_end sub_08005D10
