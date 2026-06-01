@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015cbc, 0x08015ea8)  (492 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015cbc --end 0x8015ea8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015cbc: b570        push	{r4, r5, r6, lr}
@   0x08015cbe: b084        sub	sp, #16
@   0x08015cc0: 9000        str	r0, [sp, #0]
@   0x08015cc2: 9101        str	r1, [sp, #4]
@   0x08015cc4: 9202        str	r2, [sp, #8]
@   0x08015cc6: 9303        str	r3, [sp, #12]
@   0x08015cc8: 9908        ldr	r1, [sp, #32]
@   0x08015cca: 9c09        ldr	r4, [sp, #36]	@ 0x24
@   0x08015ccc: 0609        lsls	r1, r1, #24
@   0x08015cce: 0e09        lsrs	r1, r1, #24
@   0x08015cd0: 2500        movs	r5, #0
@   0x08015cd2: 4e15        ldr	r6, [pc, #84]	@ (0x15d28)
@   0x08015cd4: 6833        ldr	r3, [r6, #0]
@   0x08015cd6: 6a22        ldr	r2, [r4, #32]
@   0x08015cd8: 1a98        subs	r0, r3, r2
@   0x08015cda: 4288        cmp	r0, r1
@   0x08015cdc: d201        bcs.n	0x15ce2
@   0x08015cde: 4293        cmp	r3, r2
@   0x08015ce0: d11c        bne.n	0x15d1c
@   0x08015ce2: 4a12        ldr	r2, [pc, #72]	@ (0x15d2c)
@   0x08015ce4: 7ee0        ldrb	r0, [r4, #27]
@   0x08015ce6: 1c41        adds	r1, r0, #1
@   0x08015ce8: 76e1        strb	r1, [r4, #27]
@   0x08015cea: 0600        lsls	r0, r0, #24
@   0x08015cec: 9901        ldr	r1, [sp, #4]
@   0x08015cee: 0d80        lsrs	r0, r0, #22
@   0x08015cf0: 1840        adds	r0, r0, r1
@   0x08015cf2: 6800        ldr	r0, [r0, #0]
@   0x08015cf4: 6010        str	r0, [r2, #0]
@   0x08015cf6: 9802        ldr	r0, [sp, #8]
@   0x08015cf8: 6050        str	r0, [r2, #4]
@   0x08015cfa: 4668        mov	r0, sp
@   0x08015cfc: 8980        ldrh	r0, [r0, #12]
@   0x08015cfe: 0840        lsrs	r0, r0, #1
@   0x08015d00: 2180        movs	r1, #128	@ 0x80
@   0x08015d02: 0609        lsls	r1, r1, #24
@   0x08015d04: 4308        orrs	r0, r1
@   0x08015d06: 6090        str	r0, [r2, #8]
@   0x08015d08: 6890        ldr	r0, [r2, #8]
@   0x08015d0a: 4668        mov	r0, sp
@   0x08015d0c: 7ee1        ldrb	r1, [r4, #27]
@   0x08015d0e: 8800        ldrh	r0, [r0, #0]
@   0x08015d10: 4281        cmp	r1, r0
@   0x08015d12: d301        bcc.n	0x15d18
@   0x08015d14: 76e5        strb	r5, [r4, #27]
@   0x08015d16: 2501        movs	r5, #1
@   0x08015d18: 6830        ldr	r0, [r6, #0]
@   0x08015d1a: 6220        str	r0, [r4, #32]
@   0x08015d1c: 1c28        adds	r0, r5, #0
@   0x08015d1e: b004        add	sp, #16
@   0x08015d20: bc70        pop	{r4, r5, r6}
@   0x08015d22: bc02        pop	{r1}
@   0x08015d24: 4708        bx	r1
@   0x08015d26: 0000        movs	r0, r0
@   0x08015d28: 5330        strh	r0, [r6, r4]
@   0x08015d2a: 0300        lsls	r0, r0, #12
@   0x08015d2c: 00d4        lsls	r4, r2, #3
@   0x08015d2e: 0400        lsls	r0, r0, #16
@   0x08015d30: 4a06        ldr	r2, [pc, #24]	@ (0x15d4c)
@   0x08015d32: 2300        movs	r3, #0
@   0x08015d34: 2000        movs	r0, #0
@   0x08015d36: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08015d38: 4905        ldr	r1, [pc, #20]	@ (0x15d50)
@   0x08015d3a: 20c0        movs	r0, #192	@ 0xc0
@   0x08015d3c: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x08015d3e: 72d3        strb	r3, [r2, #11]
@   0x08015d40: 2004        movs	r0, #4
@   0x08015d42: 72c8        strb	r0, [r1, #11]
@   0x08015d44: 7253        strb	r3, [r2, #9]
@   0x08015d46: 2002        movs	r0, #2
@   0x08015d48: 7248        strb	r0, [r1, #9]
@   0x08015d4a: 4770        bx	lr
@   0x08015d4c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08015d4e: 0300        lsls	r0, r0, #12
@   0x08015d50: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08015d52: 0300        lsls	r0, r0, #12
@   0x08015d54: 4a09        ldr	r2, [pc, #36]	@ (0x15d7c)
@   0x08015d56: 8811        ldrh	r1, [r2, #0]
@   0x08015d58: 4b09        ldr	r3, [pc, #36]	@ (0x15d80)
@   0x08015d5a: 1c18        adds	r0, r3, #0
@   0x08015d5c: 4008        ands	r0, r1
@   0x08015d5e: 8010        strh	r0, [r2, #0]
@   0x08015d60: 8810        ldrh	r0, [r2, #0]
@   0x08015d62: 2101        movs	r1, #1
@   0x08015d64: 4308        orrs	r0, r1
@   0x08015d66: 8010        strh	r0, [r2, #0]
@   0x08015d68: 3202        adds	r2, #2
@   0x08015d6a: 8810        ldrh	r0, [r2, #0]
@   0x08015d6c: 4003        ands	r3, r0
@   0x08015d6e: 8013        strh	r3, [r2, #0]
@   0x08015d70: 8810        ldrh	r0, [r2, #0]
@   0x08015d72: 2102        movs	r1, #2
@   0x08015d74: 4308        orrs	r0, r1
@   0x08015d76: 8010        strh	r0, [r2, #0]
@   0x08015d78: 4770        bx	lr
@   0x08015d7a: 0000        movs	r0, r0
@   0x08015d7c: 000a        movs	r2, r1
@   0x08015d7e: 0400        lsls	r0, r0, #16
@   0x08015d80: fffc        0000 	vrev64.<illegal width 64>	d16, d0
@   0x08015d84: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08015d86: 1c05        adds	r5, r0, #0
@   0x08015d88: 1c0c        adds	r4, r1, #0
@   0x08015d8a: 4809        ldr	r0, [pc, #36]	@ (0x15db0)
@   0x08015d8c: 21b7        movs	r1, #183	@ 0xb7
@   0x08015d8e: 0109        lsls	r1, r1, #4
@   0x08015d90: 1843        adds	r3, r0, r1
@   0x08015d92: 2100        movs	r1, #0
@   0x08015d94: 5e5a        ldrsh	r2, [r3, r1]
@   0x08015d96: 4907        ldr	r1, [pc, #28]	@ (0x15db4)
@   0x08015d98: 1c07        adds	r7, r0, #0
@   0x08015d9a: 1c0e        adds	r6, r1, #0
@   0x08015d9c: 7af0        ldrb	r0, [r6, #11]
@   0x08015d9e: 4282        cmp	r2, r0
@   0x08015da0: d01d        beq.n	0x15dde
@   0x08015da2: 1c10        adds	r0, r2, #0
@   0x08015da4: 2800        cmp	r0, #0
@   0x08015da6: d109        bne.n	0x15dbc
@   0x08015da8: 4903        ldr	r1, [pc, #12]	@ (0x15db8)
@   0x08015daa: 600d        str	r5, [r1, #0]
@   0x08015dac: e008        b.n	0x15dc0
@   0x08015dae: 0000        movs	r0, r0
@   0x08015db0: 3720        adds	r7, #32
@   0x08015db2: 0300        lsls	r0, r0, #12
@   0x08015db4: 3610        adds	r6, #16
@   0x08015db6: 0300        lsls	r0, r0, #12
@   0x08015db8: 00d4        lsls	r4, r2, #3
@   0x08015dba: 0400        lsls	r0, r0, #16
@   0x08015dbc: 4909        ldr	r1, [pc, #36]	@ (0x15de4)
@   0x08015dbe: 600c        str	r4, [r1, #0]
@   0x08015dc0: 4809        ldr	r0, [pc, #36]	@ (0x15de8)
@   0x08015dc2: 6048        str	r0, [r1, #4]
@   0x08015dc4: 4809        ldr	r0, [pc, #36]	@ (0x15dec)
@   0x08015dc6: 6088        str	r0, [r1, #8]
@   0x08015dc8: 6888        ldr	r0, [r1, #8]
@   0x08015dca: 21b7        movs	r1, #183	@ 0xb7
@   0x08015dcc: 0109        lsls	r1, r1, #4
@   0x08015dce: 1878        adds	r0, r7, r1
@   0x08015dd0: 8800        ldrh	r0, [r0, #0]
@   0x08015dd2: 72f0        strb	r0, [r6, #11]
@   0x08015dd4: 4904        ldr	r1, [pc, #16]	@ (0x15de8)
@   0x08015dd6: 4a06        ldr	r2, [pc, #24]	@ (0x15df0)
@   0x08015dd8: 2001        movs	r0, #1
@   0x08015dda: f7fa        f983 	bl	0x100e4
@   0x08015dde: bcf0        pop	{r4, r5, r6, r7}
@   0x08015de0: bc01        pop	{r0}
@   0x08015de2: 4700        bx	r0
@   0x08015de4: 00d4        lsls	r4, r2, #3
@   0x08015de6: 0400        lsls	r0, r0, #16
@   0x08015de8: 0000        movs	r0, r0
@   0x08015dea: 0201        lsls	r1, r0, #8
@   0x08015dec: 8000        strh	r0, [r0, #0]
@   0x08015dee: 8000        strh	r0, [r0, #0]
@   0x08015df0: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08015df4: b570        push	{r4, r5, r6, lr}
@   0x08015df6: 1c16        adds	r6, r2, #0
@   0x08015df8: 0600        lsls	r0, r0, #24
@   0x08015dfa: 0e00        lsrs	r0, r0, #24
@   0x08015dfc: 0609        lsls	r1, r1, #24
@   0x08015dfe: 0e0d        lsrs	r5, r1, #24
@   0x08015e00: 4911        ldr	r1, [pc, #68]	@ (0x15e48)
@   0x08015e02: 4c12        ldr	r4, [pc, #72]	@ (0x15e4c)
@   0x08015e04: 22d3        movs	r2, #211	@ 0xd3
@   0x08015e06: 0152        lsls	r2, r2, #5
@   0x08015e08: 18a3        adds	r3, r4, r2
@   0x08015e0a: 680a        ldr	r2, [r1, #0]
@   0x08015e0c: 6819        ldr	r1, [r3, #0]
@   0x08015e0e: 1a51        subs	r1, r2, r1
@   0x08015e10: 4281        cmp	r1, r0
@   0x08015e12: d315        bcc.n	0x15e40
@   0x08015e14: 601a        str	r2, [r3, #0]
@   0x08015e16: 480e        ldr	r0, [pc, #56]	@ (0x15e50)
@   0x08015e18: 1823        adds	r3, r4, r0
@   0x08015e1a: 781a        ldrb	r2, [r3, #0]
@   0x08015e1c: 42aa        cmp	r2, r5
@   0x08015e1e: d301        bcc.n	0x15e24
@   0x08015e20: 2000        movs	r0, #0
@   0x08015e22: 7018        strb	r0, [r3, #0]
@   0x08015e24: 4a0b        ldr	r2, [pc, #44]	@ (0x15e54)
@   0x08015e26: 7818        ldrb	r0, [r3, #0]
@   0x08015e28: 1c41        adds	r1, r0, #1
@   0x08015e2a: 7019        strb	r1, [r3, #0]
@   0x08015e2c: 0600        lsls	r0, r0, #24
@   0x08015e2e: 0d80        lsrs	r0, r0, #22
@   0x08015e30: 1980        adds	r0, r0, r6
@   0x08015e32: 6800        ldr	r0, [r0, #0]
@   0x08015e34: 6010        str	r0, [r2, #0]
@   0x08015e36: 4808        ldr	r0, [pc, #32]	@ (0x15e58)
@   0x08015e38: 6050        str	r0, [r2, #4]
@   0x08015e3a: 4808        ldr	r0, [pc, #32]	@ (0x15e5c)
@   0x08015e3c: 6090        str	r0, [r2, #8]
@   0x08015e3e: 6890        ldr	r0, [r2, #8]
@   0x08015e40: bc70        pop	{r4, r5, r6}
@   0x08015e42: bc01        pop	{r0}
@   0x08015e44: 4700        bx	r0
@   0x08015e46: 0000        movs	r0, r0
@   0x08015e48: 5330        strh	r0, [r6, r4]
@   0x08015e4a: 0300        lsls	r0, r0, #12
@   0x08015e4c: 3720        adds	r7, #32
@   0x08015e4e: 0300        lsls	r0, r0, #12
@   0x08015e50: 1a5b        subs	r3, r3, r1
@   0x08015e52: 0000        movs	r0, r0
@   0x08015e54: 00d4        lsls	r4, r2, #3
@   0x08015e56: 0400        lsls	r0, r0, #16
@   0x08015e58: 0140        lsls	r0, r0, #5
@   0x08015e5a: 0500        lsls	r0, r0, #20
@   0x08015e5c: 0020        movs	r0, r4
@   0x08015e5e: 8000        strh	r0, [r0, #0]
@   0x08015e60: b510        push	{r4, lr}
@   0x08015e62: 4c03        ldr	r4, [pc, #12]	@ (0x15e70)
@   0x08015e64: 79e0        ldrb	r0, [r4, #7]
@   0x08015e66: 2800        cmp	r0, #0
@   0x08015e68: d004        beq.n	0x15e74
@   0x08015e6a: 2801        cmp	r0, #1
@   0x08015e6c: d014        beq.n	0x15e98
@   0x08015e6e: e015        b.n	0x15e9c
@   0x08015e70: 3610        adds	r6, #16
@   0x08015e72: 0300        lsls	r0, r0, #12
@   0x08015e74: 4807        ldr	r0, [pc, #28]	@ (0x15e94)
@   0x08015e76: 21f0        movs	r1, #240	@ 0xf0
@   0x08015e78: 1c0a        adds	r2, r1, #0
@   0x08015e7a: 8cc3        ldrh	r3, [r0, #38]	@ 0x26
@   0x08015e7c: 401a        ands	r2, r3
@   0x08015e7e: 8d00        ldrh	r0, [r0, #40]	@ 0x28
@   0x08015e80: 4001        ands	r1, r0
@   0x08015e82: 428a        cmp	r2, r1
@   0x08015e84: d00a        beq.n	0x15e9c
@   0x08015e86: 2019        movs	r0, #25
@   0x08015e88: f00a        fef6 	bl	0x20c78
@   0x08015e8c: 2001        movs	r0, #1
@   0x08015e8e: 71e0        strb	r0, [r4, #7]
@   0x08015e90: e004        b.n	0x15e9c
@   0x08015e92: 0000        movs	r0, r0
@   0x08015e94: 6110        str	r0, [r2, #16]
@   0x08015e96: 0300        lsls	r0, r0, #12
@   0x08015e98: f7ff        fbaa 	bl	0x155f0
@   0x08015e9c: bc10        pop	{r4}
@   0x08015e9e: bc01        pop	{r0}
@   0x08015ea0: 4700        bx	r0
@   0x08015ea2: 0000        movs	r0, r0
@   0x08015ea4: 4770        bx	lr

        thumb_func_start sub_08015CBC
sub_08015CBC: @ 0x08015cbc
        .incbin "frog_us_baserom.gba", 0x15cbc, 0x1ec
        thumb_func_end sub_08015CBC
