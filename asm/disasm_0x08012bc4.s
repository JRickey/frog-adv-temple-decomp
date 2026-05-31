@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012bc4, 0x08012cac)  (232 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012bc4 --end 0x8012cac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012bc4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08012bc6: 4657        mov	r7, sl
@   0x08012bc8: 464e        mov	r6, r9
@   0x08012bca: 4645        mov	r5, r8
@   0x08012bcc: b4e0        push	{r5, r6, r7}
@   0x08012bce: 9c08        ldr	r4, [sp, #32]
@   0x08012bd0: 9d0a        ldr	r5, [sp, #40]	@ 0x28
@   0x08012bd2: 0600        lsls	r0, r0, #24
@   0x08012bd4: 4684        mov	ip, r0
@   0x08012bd6: 0409        lsls	r1, r1, #16
@   0x08012bd8: 0c09        lsrs	r1, r1, #16
@   0x08012bda: 4689        mov	r9, r1
@   0x08012bdc: 0412        lsls	r2, r2, #16
@   0x08012bde: 0c12        lsrs	r2, r2, #16
@   0x08012be0: 061b        lsls	r3, r3, #24
@   0x08012be2: 0e1e        lsrs	r6, r3, #24
@   0x08012be4: 0624        lsls	r4, r4, #24
@   0x08012be6: 0e24        lsrs	r4, r4, #24
@   0x08012be8: 46a2        mov	sl, r4
@   0x08012bea: 062d        lsls	r5, r5, #24
@   0x08012bec: 0e2d        lsrs	r5, r5, #24
@   0x08012bee: 46a8        mov	r8, r5
@   0x08012bf0: 0f00        lsrs	r0, r0, #28
@   0x08012bf2: 2101        movs	r1, #1
@   0x08012bf4: 4008        ands	r0, r1
@   0x08012bf6: 2380        movs	r3, #128	@ 0x80
@   0x08012bf8: 049b        lsls	r3, r3, #18
@   0x08012bfa: 2800        cmp	r0, #0
@   0x08012bfc: d000        beq.n	0x12c00
@   0x08012bfe: 4b18        ldr	r3, [pc, #96]	@ (0x12c60)
@   0x08012c00: 4c18        ldr	r4, [pc, #96]	@ (0x12c64)
@   0x08012c02: 8b61        ldrh	r1, [r4, #26]
@   0x08012c04: 1c08        adds	r0, r1, #0
@   0x08012c06: 4350        muls	r0, r2
@   0x08012c08: 4448        add	r0, r9
@   0x08012c0a: 0040        lsls	r0, r0, #1
@   0x08012c0c: 181b        adds	r3, r3, r0
@   0x08012c0e: 4647        mov	r7, r8
@   0x08012c10: 00b8        lsls	r0, r7, #2
@   0x08012c12: 9909        ldr	r1, [sp, #36]	@ 0x24
@   0x08012c14: 1840        adds	r0, r0, r1
@   0x08012c16: 6802        ldr	r2, [r0, #0]
@   0x08012c18: 2000        movs	r0, #0
@   0x08012c1a: 4661        mov	r1, ip
@   0x08012c1c: 0f0d        lsrs	r5, r1, #28
@   0x08012c1e: 4550        cmp	r0, sl
@   0x08012c20: d216        bcs.n	0x12c50
@   0x08012c22: 46a4        mov	ip, r4
@   0x08012c24: 2100        movs	r1, #0
@   0x08012c26: 1c44        adds	r4, r0, #1
@   0x08012c28: 42b1        cmp	r1, r6
@   0x08012c2a: d208        bcs.n	0x12c3e
@   0x08012c2c: 8810        ldrh	r0, [r2, #0]
@   0x08012c2e: 8018        strh	r0, [r3, #0]
@   0x08012c30: 3202        adds	r2, #2
@   0x08012c32: 3302        adds	r3, #2
@   0x08012c34: 1c48        adds	r0, r1, #1
@   0x08012c36: 0600        lsls	r0, r0, #24
@   0x08012c38: 0e01        lsrs	r1, r0, #24
@   0x08012c3a: 42b1        cmp	r1, r6
@   0x08012c3c: d3f6        bcc.n	0x12c2c
@   0x08012c3e: 4667        mov	r7, ip
@   0x08012c40: 8b7f        ldrh	r7, [r7, #26]
@   0x08012c42: 1bb8        subs	r0, r7, r6
@   0x08012c44: 0040        lsls	r0, r0, #1
@   0x08012c46: 181b        adds	r3, r3, r0
@   0x08012c48: 0620        lsls	r0, r4, #24
@   0x08012c4a: 0e00        lsrs	r0, r0, #24
@   0x08012c4c: 4550        cmp	r0, sl
@   0x08012c4e: d3e9        bcc.n	0x12c24
@   0x08012c50: 2101        movs	r1, #1
@   0x08012c52: 1c28        adds	r0, r5, #0
@   0x08012c54: 4008        ands	r0, r1
@   0x08012c56: 2800        cmp	r0, #0
@   0x08012c58: d008        beq.n	0x12c6c
@   0x08012c5a: 4a01        ldr	r2, [pc, #4]	@ (0x12c60)
@   0x08012c5c: 4b02        ldr	r3, [pc, #8]	@ (0x12c68)
@   0x08012c5e: e008        b.n	0x12c72
@   0x08012c60: 0000        movs	r0, r0
@   0x08012c62: 0201        lsls	r1, r0, #8
@   0x08012c64: 60a0        str	r0, [r4, #8]
@   0x08012c66: 0300        lsls	r0, r0, #12
@   0x08012c68: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08012c6c: 2280        movs	r2, #128	@ 0x80
@   0x08012c6e: 0492        lsls	r2, r2, #18
@   0x08012c70: 4b0b        ldr	r3, [pc, #44]	@ (0x12ca0)
@   0x08012c72: 2001        movs	r0, #1
@   0x08012c74: 4005        ands	r5, r0
@   0x08012c76: 1c28        adds	r0, r5, #0
@   0x08012c78: 1c11        adds	r1, r2, #0
@   0x08012c7a: 1c1a        adds	r2, r3, #0
@   0x08012c7c: f7fd        fa32 	bl	0x100e4
@   0x08012c80: 4908        ldr	r1, [pc, #32]	@ (0x12ca4)
@   0x08012c82: 2000        movs	r0, #0
@   0x08012c84: 7288        strb	r0, [r1, #10]
@   0x08012c86: 4640        mov	r0, r8
@   0x08012c88: 2800        cmp	r0, #0
@   0x08012c8a: d102        bne.n	0x12c92
@   0x08012c8c: 4906        ldr	r1, [pc, #24]	@ (0x12ca8)
@   0x08012c8e: 2001        movs	r0, #1
@   0x08012c90: 7008        strb	r0, [r1, #0]
@   0x08012c92: bc38        pop	{r3, r4, r5}
@   0x08012c94: 4698        mov	r8, r3
@   0x08012c96: 46a1        mov	r9, r4
@   0x08012c98: 46aa        mov	sl, r5
@   0x08012c9a: bcf0        pop	{r4, r5, r6, r7}
@   0x08012c9c: bc01        pop	{r0}
@   0x08012c9e: 4700        bx	r0
@   0x08012ca0: e000        b.n	0x12ca4
@   0x08012ca2: 0600        lsls	r0, r0, #24
@   0x08012ca4: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08012ca6: 0300        lsls	r0, r0, #12
@   0x08012ca8: 3610        adds	r6, #16
@   0x08012caa: 0300        lsls	r0, r0, #12
