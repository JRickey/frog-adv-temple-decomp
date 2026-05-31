@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015ad4, 0x08015c24)  (336 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015ad4 --end 0x8015c24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015ad4: b510        push	{r4, lr}
@   0x08015ad6: f001        fa93 	bl	0x17000
@   0x08015ada: f7ff        febf 	bl	0x1585c
@   0x08015ade: 4c03        ldr	r4, [pc, #12]	@ (0x15aec)
@   0x08015ae0: 79e0        ldrb	r0, [r4, #7]
@   0x08015ae2: 2800        cmp	r0, #0
@   0x08015ae4: d004        beq.n	0x15af0
@   0x08015ae6: 2801        cmp	r0, #1
@   0x08015ae8: d014        beq.n	0x15b14
@   0x08015aea: e015        b.n	0x15b18
@   0x08015aec: 3610        adds	r6, #16
@   0x08015aee: 0300        lsls	r0, r0, #12
@   0x08015af0: 4807        ldr	r0, [pc, #28]	@ (0x15b10)
@   0x08015af2: 21f0        movs	r1, #240	@ 0xf0
@   0x08015af4: 1c0a        adds	r2, r1, #0
@   0x08015af6: 8cc3        ldrh	r3, [r0, #38]	@ 0x26
@   0x08015af8: 401a        ands	r2, r3
@   0x08015afa: 8d00        ldrh	r0, [r0, #40]	@ 0x28
@   0x08015afc: 4001        ands	r1, r0
@   0x08015afe: 428a        cmp	r2, r1
@   0x08015b00: d00a        beq.n	0x15b18
@   0x08015b02: 2019        movs	r0, #25
@   0x08015b04: f00b        f8b8 	bl	0x20c78
@   0x08015b08: 2001        movs	r0, #1
@   0x08015b0a: 71e0        strb	r0, [r4, #7]
@   0x08015b0c: e004        b.n	0x15b18
@   0x08015b0e: 0000        movs	r0, r0
@   0x08015b10: 6110        str	r0, [r2, #16]
@   0x08015b12: 0300        lsls	r0, r0, #12
@   0x08015b14: f7ff        fd6c 	bl	0x155f0
@   0x08015b18: bc10        pop	{r4}
@   0x08015b1a: bc01        pop	{r0}
@   0x08015b1c: 4700        bx	r0
@   0x08015b1e: 0000        movs	r0, r0
@   0x08015b20: b500        push	{lr}
@   0x08015b22: 0600        lsls	r0, r0, #24
@   0x08015b24: 0e00        lsrs	r0, r0, #24
@   0x08015b26: 2801        cmp	r0, #1
@   0x08015b28: d00e        beq.n	0x15b48
@   0x08015b2a: 2801        cmp	r0, #1
@   0x08015b2c: dc02        bgt.n	0x15b34
@   0x08015b2e: 2800        cmp	r0, #0
@   0x08015b30: d003        beq.n	0x15b3a
@   0x08015b32: e013        b.n	0x15b5c
@   0x08015b34: 2802        cmp	r0, #2
@   0x08015b36: d00f        beq.n	0x15b58
@   0x08015b38: e010        b.n	0x15b5c
@   0x08015b3a: 2180        movs	r1, #128	@ 0x80
@   0x08015b3c: 0489        lsls	r1, r1, #18
@   0x08015b3e: 4a01        ldr	r2, [pc, #4]	@ (0x15b44)
@   0x08015b40: e00c        b.n	0x15b5c
@   0x08015b42: 0000        movs	r0, r0
@   0x08015b44: e000        b.n	0x15b48
@   0x08015b46: 0600        lsls	r0, r0, #24
@   0x08015b48: 4901        ldr	r1, [pc, #4]	@ (0x15b50)
@   0x08015b4a: 4a02        ldr	r2, [pc, #8]	@ (0x15b54)
@   0x08015b4c: e006        b.n	0x15b5c
@   0x08015b4e: 0000        movs	r0, r0
@   0x08015b50: 0000        movs	r0, r0
@   0x08015b52: 0201        lsls	r1, r0, #8
@   0x08015b54: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08015b58: 4902        ldr	r1, [pc, #8]	@ (0x15b64)
@   0x08015b5a: 4a03        ldr	r2, [pc, #12]	@ (0x15b68)
@   0x08015b5c: f7fa        fac2 	bl	0x100e4
@   0x08015b60: bc01        pop	{r0}
@   0x08015b62: 4700        bx	r0
@   0x08015b64: 0000        movs	r0, r0
@   0x08015b66: 0202        lsls	r2, r0, #8
@   0x08015b68: f000        0600 	and.w	r6, r0, #0
@   0x08015b6c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08015b6e: 464f        mov	r7, r9
@   0x08015b70: 4646        mov	r6, r8
@   0x08015b72: b4c0        push	{r6, r7}
@   0x08015b74: 9c07        ldr	r4, [sp, #28]
@   0x08015b76: 9d08        ldr	r5, [sp, #32]
@   0x08015b78: 46a8        mov	r8, r5
@   0x08015b7a: 0600        lsls	r0, r0, #24
@   0x08015b7c: 0e00        lsrs	r0, r0, #24
@   0x08015b7e: 1c07        adds	r7, r0, #0
@   0x08015b80: 0409        lsls	r1, r1, #16
@   0x08015b82: 0c09        lsrs	r1, r1, #16
@   0x08015b84: 0412        lsls	r2, r2, #16
@   0x08015b86: 0c12        lsrs	r2, r2, #16
@   0x08015b88: 4694        mov	ip, r2
@   0x08015b8a: 061b        lsls	r3, r3, #24
@   0x08015b8c: 0e1d        lsrs	r5, r3, #24
@   0x08015b8e: 0624        lsls	r4, r4, #24
@   0x08015b90: 0e24        lsrs	r4, r4, #24
@   0x08015b92: 2801        cmp	r0, #1
@   0x08015b94: d00a        beq.n	0x15bac
@   0x08015b96: 2801        cmp	r0, #1
@   0x08015b98: dc02        bgt.n	0x15ba0
@   0x08015b9a: 2800        cmp	r0, #0
@   0x08015b9c: d003        beq.n	0x15ba6
@   0x08015b9e: e00a        b.n	0x15bb6
@   0x08015ba0: 2f02        cmp	r7, #2
@   0x08015ba2: d007        beq.n	0x15bb4
@   0x08015ba4: e007        b.n	0x15bb6
@   0x08015ba6: 2680        movs	r6, #128	@ 0x80
@   0x08015ba8: 04b6        lsls	r6, r6, #18
@   0x08015baa: e004        b.n	0x15bb6
@   0x08015bac: 4e00        ldr	r6, [pc, #0]	@ (0x15bb0)
@   0x08015bae: e002        b.n	0x15bb6
@   0x08015bb0: 0000        movs	r0, r0
@   0x08015bb2: 0201        lsls	r1, r0, #8
@   0x08015bb4: 4e19        ldr	r6, [pc, #100]	@ (0x15c1c)
@   0x08015bb6: 0408        lsls	r0, r1, #16
@   0x08015bb8: 1402        asrs	r2, r0, #16
@   0x08015bba: 4667        mov	r7, ip
@   0x08015bbc: 0438        lsls	r0, r7, #16
@   0x08015bbe: 1400        asrs	r0, r0, #16
@   0x08015bc0: 4917        ldr	r1, [pc, #92]	@ (0x15c20)
@   0x08015bc2: 8b4b        ldrh	r3, [r1, #26]
@   0x08015bc4: 4358        muls	r0, r3
@   0x08015bc6: 1810        adds	r0, r2, r0
@   0x08015bc8: 0040        lsls	r0, r0, #1
@   0x08015bca: 1836        adds	r6, r6, r0
@   0x08015bcc: 4647        mov	r7, r8
@   0x08015bce: 68fb        ldr	r3, [r7, #12]
@   0x08015bd0: 2000        movs	r0, #0
@   0x08015bd2: 4689        mov	r9, r1
@   0x08015bd4: 42a0        cmp	r0, r4
@   0x08015bd6: d21a        bcs.n	0x15c0e
@   0x08015bd8: 2200        movs	r2, #0
@   0x08015bda: 1c41        adds	r1, r0, #1
@   0x08015bdc: 42aa        cmp	r2, r5
@   0x08015bde: d208        bcs.n	0x15bf2
@   0x08015be0: 8818        ldrh	r0, [r3, #0]
@   0x08015be2: 8030        strh	r0, [r6, #0]
@   0x08015be4: 3302        adds	r3, #2
@   0x08015be6: 3602        adds	r6, #2
@   0x08015be8: 1c50        adds	r0, r2, #1
@   0x08015bea: 0600        lsls	r0, r0, #24
@   0x08015bec: 0e02        lsrs	r2, r0, #24
@   0x08015bee: 42aa        cmp	r2, r5
@   0x08015bf0: d3f6        bcc.n	0x15be0
@   0x08015bf2: 464a        mov	r2, r9
@   0x08015bf4: 8b52        ldrh	r2, [r2, #26]
@   0x08015bf6: 1b50        subs	r0, r2, r5
@   0x08015bf8: 0040        lsls	r0, r0, #1
@   0x08015bfa: 1836        adds	r6, r6, r0
@   0x08015bfc: 4647        mov	r7, r8
@   0x08015bfe: 8e3f        ldrh	r7, [r7, #48]	@ 0x30
@   0x08015c00: 1b78        subs	r0, r7, r5
@   0x08015c02: 0040        lsls	r0, r0, #1
@   0x08015c04: 181b        adds	r3, r3, r0
@   0x08015c06: 0608        lsls	r0, r1, #24
@   0x08015c08: 0e00        lsrs	r0, r0, #24
@   0x08015c0a: 42a0        cmp	r0, r4
@   0x08015c0c: d3e4        bcc.n	0x15bd8
@   0x08015c0e: bc18        pop	{r3, r4}
@   0x08015c10: 4698        mov	r8, r3
@   0x08015c12: 46a1        mov	r9, r4
@   0x08015c14: bcf0        pop	{r4, r5, r6, r7}
@   0x08015c16: bc01        pop	{r0}
@   0x08015c18: 4700        bx	r0
@   0x08015c1a: 0000        movs	r0, r0
@   0x08015c1c: 0000        movs	r0, r0
@   0x08015c1e: 0202        lsls	r2, r0, #8
@   0x08015c20: 60a0        str	r0, [r4, #8]
@   0x08015c22: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08015AD4
sub_08015AD4: @ 0x08015ad4
        .incbin "frog_us_baserom.gba", 0x15ad4, 0x150
        thumb_func_end sub_08015AD4
