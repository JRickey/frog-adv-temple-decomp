@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013ba4, 0x08013c60)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013ba4 --end 0x8013c60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013ba4: b570        push	{r4, r5, r6, lr}
@   0x08013ba6: b084        sub	sp, #16
@   0x08013ba8: 4825        ldr	r0, [pc, #148]	@ (0x13c40)
@   0x08013baa: 1c03        adds	r3, r0, #0
@   0x08013bac: 3340        adds	r3, #64	@ 0x40
@   0x08013bae: 781a        ldrb	r2, [r3, #0]
@   0x08013bb0: 2001        movs	r0, #1
@   0x08013bb2: 4010        ands	r0, r2
@   0x08013bb4: 2800        cmp	r0, #0
@   0x08013bb6: d00d        beq.n	0x13bd4
@   0x08013bb8: 4922        ldr	r1, [pc, #136]	@ (0x13c44)
@   0x08013bba: 4c23        ldr	r4, [pc, #140]	@ (0x13c48)
@   0x08013bbc: 1c20        adds	r0, r4, #0
@   0x08013bbe: 8008        strh	r0, [r1, #0]
@   0x08013bc0: 3102        adds	r1, #2
@   0x08013bc2: 4d22        ldr	r5, [pc, #136]	@ (0x13c4c)
@   0x08013bc4: 1c28        adds	r0, r5, #0
@   0x08013bc6: 8008        strh	r0, [r1, #0]
@   0x08013bc8: 20fe        movs	r0, #254	@ 0xfe
@   0x08013bca: 4010        ands	r0, r2
@   0x08013bcc: 7018        strb	r0, [r3, #0]
@   0x08013bce: 2002        movs	r0, #2
@   0x08013bd0: f7fb        f960 	bl	0xee94
@   0x08013bd4: f7ff        f86a 	bl	0x12cac
@   0x08013bd8: 481d        ldr	r0, [pc, #116]	@ (0x13c50)
@   0x08013bda: 7882        ldrb	r2, [r0, #2]
@   0x08013bdc: 4c1d        ldr	r4, [pc, #116]	@ (0x13c54)
@   0x08013bde: 4669        mov	r1, sp
@   0x08013be0: c868        ldmia	r0!, {r3, r5, r6}
@   0x08013be2: c168        stmia	r1!, {r3, r5, r6}
@   0x08013be4: 6800        ldr	r0, [r0, #0]
@   0x08013be6: 6008        str	r0, [r1, #0]
@   0x08013be8: 4d1b        ldr	r5, [pc, #108]	@ (0x13c58)
@   0x08013bea: 682b        ldr	r3, [r5, #0]
@   0x08013bec: 6861        ldr	r1, [r4, #4]
@   0x08013bee: 1a58        subs	r0, r3, r1
@   0x08013bf0: 4290        cmp	r0, r2
@   0x08013bf2: d201        bcs.n	0x13bf8
@   0x08013bf4: 428b        cmp	r3, r1
@   0x08013bf6: d11c        bne.n	0x13c32
@   0x08013bf8: 7aa0        ldrb	r0, [r4, #10]
@   0x08013bfa: 1c41        adds	r1, r0, #1
@   0x08013bfc: 72a1        strb	r1, [r4, #10]
@   0x08013bfe: 0600        lsls	r0, r0, #24
@   0x08013c00: 9901        ldr	r1, [sp, #4]
@   0x08013c02: 0d80        lsrs	r0, r0, #22
@   0x08013c04: 1840        adds	r0, r0, r1
@   0x08013c06: 6800        ldr	r0, [r0, #0]
@   0x08013c08: 4a14        ldr	r2, [pc, #80]	@ (0x13c5c)
@   0x08013c0a: 6010        str	r0, [r2, #0]
@   0x08013c0c: 9802        ldr	r0, [sp, #8]
@   0x08013c0e: 6050        str	r0, [r2, #4]
@   0x08013c10: 4668        mov	r0, sp
@   0x08013c12: 8980        ldrh	r0, [r0, #12]
@   0x08013c14: 0840        lsrs	r0, r0, #1
@   0x08013c16: 2180        movs	r1, #128	@ 0x80
@   0x08013c18: 0609        lsls	r1, r1, #24
@   0x08013c1a: 4308        orrs	r0, r1
@   0x08013c1c: 6090        str	r0, [r2, #8]
@   0x08013c1e: 6890        ldr	r0, [r2, #8]
@   0x08013c20: 4668        mov	r0, sp
@   0x08013c22: 7aa6        ldrb	r6, [r4, #10]
@   0x08013c24: 8800        ldrh	r0, [r0, #0]
@   0x08013c26: 4286        cmp	r6, r0
@   0x08013c28: d301        bcc.n	0x13c2e
@   0x08013c2a: 2000        movs	r0, #0
@   0x08013c2c: 72a0        strb	r0, [r4, #10]
@   0x08013c2e: 6828        ldr	r0, [r5, #0]
@   0x08013c30: 6060        str	r0, [r4, #4]
@   0x08013c32: f003        f9e5 	bl	0x17000
@   0x08013c36: b004        add	sp, #16
@   0x08013c38: bc70        pop	{r4, r5, r6}
@   0x08013c3a: bc01        pop	{r0}
@   0x08013c3c: 4700        bx	r0
@   0x08013c3e: 0000        movs	r0, r0
@   0x08013c40: 60a0        str	r0, [r4, #8]
@   0x08013c42: 0300        lsls	r0, r0, #12
@   0x08013c44: 0050        lsls	r0, r2, #1
@   0x08013c46: 0400        lsls	r0, r0, #16
@   0x08013c48: 1744        asrs	r4, r0, #29
@   0x08013c4a: 0000        movs	r0, r0
@   0x08013c4c: 030d        lsls	r5, r1, #12
@   0x08013c4e: 0000        movs	r0, r0
@   0x08013c50: 7220        strb	r0, [r4, #8]
@   0x08013c52: 0830        lsrs	r0, r6, #32
@   0x08013c54: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08013c56: 0300        lsls	r0, r0, #12
@   0x08013c58: 5330        strh	r0, [r6, r4]
@   0x08013c5a: 0300        lsls	r0, r0, #12
@   0x08013c5c: 00d4        lsls	r4, r2, #3
@   0x08013c5e: 0400        lsls	r0, r0, #16
