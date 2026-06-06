@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015d84, 0x08015ea4)  (288 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015d84 --end 0x8015ea4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_08015D84
sub_08015D84: @ 0x08015d84
        .incbin "frog_us_baserom.gba", 0x15d84, 0x120
        thumb_func_end sub_08015D84
