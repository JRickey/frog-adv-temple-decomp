@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027ac4, 0x08027c84)  (448 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027ac4 --end 0x8027c84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027ac4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08027ac6: 491a        ldr	r1, [pc, #104]	@ (0x27b30)
@   0x08027ac8: 481a        ldr	r0, [pc, #104]	@ (0x27b34)
@   0x08027aca: 180f        adds	r7, r1, r0
@   0x08027acc: 883a        ldrh	r2, [r7, #0]
@   0x08027ace: 2080        movs	r0, #128	@ 0x80
@   0x08027ad0: 0080        lsls	r0, r0, #2
@   0x08027ad2: 4010        ands	r0, r2
@   0x08027ad4: 0400        lsls	r0, r0, #16
@   0x08027ad6: 0c03        lsrs	r3, r0, #16
@   0x08027ad8: 1c0c        adds	r4, r1, #0
@   0x08027ada: 2b00        cmp	r3, #0
@   0x08027adc: d04a        beq.n	0x27b74
@   0x08027ade: 21ee        movs	r1, #238	@ 0xee
@   0x08027ae0: 0109        lsls	r1, r1, #4
@   0x08027ae2: 1864        adds	r4, r4, r1
@   0x08027ae4: 1c20        adds	r0, r4, #0
@   0x08027ae6: 2100        movs	r1, #0
@   0x08027ae8: 2200        movs	r2, #0
@   0x08027aea: 2300        movs	r3, #0
@   0x08027aec: f7e2        fd48 	bl	0xa580
@   0x08027af0: 4a11        ldr	r2, [pc, #68]	@ (0x27b38)
@   0x08027af2: 8a13        ldrh	r3, [r2, #16]
@   0x08027af4: 2002        movs	r0, #2
@   0x08027af6: 4018        ands	r0, r3
@   0x08027af8: 2800        cmp	r0, #0
@   0x08027afa: d02c        beq.n	0x27b56
@   0x08027afc: 7b55        ldrb	r5, [r2, #13]
@   0x08027afe: 2d44        cmp	r5, #68	@ 0x44
@   0x08027b00: d129        bne.n	0x27b56
@   0x08027b02: 480e        ldr	r0, [pc, #56]	@ (0x27b3c)
@   0x08027b04: 8839        ldrh	r1, [r7, #0]
@   0x08027b06: 4008        ands	r0, r1
@   0x08027b08: 2580        movs	r5, #128	@ 0x80
@   0x08027b0a: 016d        lsls	r5, r5, #5
@   0x08027b0c: 1c29        adds	r1, r5, #0
@   0x08027b0e: 4308        orrs	r0, r1
@   0x08027b10: 8038        strh	r0, [r7, #0]
@   0x08027b12: 2001        movs	r0, #1
@   0x08027b14: 4318        orrs	r0, r3
@   0x08027b16: 8210        strh	r0, [r2, #16]
@   0x08027b18: 4809        ldr	r0, [pc, #36]	@ (0x27b40)
@   0x08027b1a: 6900        ldr	r0, [r0, #16]
@   0x08027b1c: 2800        cmp	r0, #0
@   0x08027b1e: d111        bne.n	0x27b44
@   0x08027b20: 1c20        adds	r0, r4, #0
@   0x08027b22: 2104        movs	r1, #4
@   0x08027b24: 2200        movs	r2, #0
@   0x08027b26: 2301        movs	r3, #1
@   0x08027b28: f7e2        fd2a 	bl	0xa580
@   0x08027b2c: e013        b.n	0x27b56
@   0x08027b2e: 0000        movs	r0, r0
@   0x08027b30: 3720        adds	r7, #32
@   0x08027b32: 0300        lsls	r0, r0, #12
@   0x08027b34: 0f14        lsrs	r4, r2, #28
@   0x08027b36: 0000        movs	r0, r0
@   0x08027b38: 35e0        adds	r5, #224	@ 0xe0
@   0x08027b3a: 0300        lsls	r0, r0, #12
@   0x08027b3c: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08027b40: 6110        str	r0, [r2, #16]
@   0x08027b42: 0300        lsls	r0, r0, #12
@   0x08027b44: 2801        cmp	r0, #1
@   0x08027b46: d106        bne.n	0x27b56
@   0x08027b48: 2301        movs	r3, #1
@   0x08027b4a: 425b        negs	r3, r3
@   0x08027b4c: 1c20        adds	r0, r4, #0
@   0x08027b4e: 2104        movs	r1, #4
@   0x08027b50: 2200        movs	r2, #0
@   0x08027b52: f7e2        fd15 	bl	0xa580
@   0x08027b56: 4805        ldr	r0, [pc, #20]	@ (0x27b6c)
@   0x08027b58: 4905        ldr	r1, [pc, #20]	@ (0x27b70)
@   0x08027b5a: 1842        adds	r2, r0, r1
@   0x08027b5c: 2100        movs	r1, #0
@   0x08027b5e: 7011        strb	r1, [r2, #0]
@   0x08027b60: 22ee        movs	r2, #238	@ 0xee
@   0x08027b62: 0112        lsls	r2, r2, #4
@   0x08027b64: 1880        adds	r0, r0, r2
@   0x08027b66: f7dd        ff2d 	bl	0x59c4
@   0x08027b6a: e087        b.n	0x27c7c
@   0x08027b6c: 3720        adds	r7, #32
@   0x08027b6e: 0300        lsls	r0, r0, #12
@   0x08027b70: 0efa        lsrs	r2, r7, #27
@   0x08027b72: 0000        movs	r0, r0
@   0x08027b74: 4e12        ldr	r6, [pc, #72]	@ (0x27bc0)
@   0x08027b76: 8a35        ldrh	r5, [r6, #16]
@   0x08027b78: 2002        movs	r0, #2
@   0x08027b7a: 4028        ands	r0, r5
@   0x08027b7c: 2800        cmp	r0, #0
@   0x08027b7e: d068        beq.n	0x27c52
@   0x08027b80: 7b70        ldrb	r0, [r6, #13]
@   0x08027b82: 2844        cmp	r0, #68	@ 0x44
@   0x08027b84: d165        bne.n	0x27c52
@   0x08027b86: 480f        ldr	r0, [pc, #60]	@ (0x27bc4)
@   0x08027b88: 6900        ldr	r0, [r0, #16]
@   0x08027b8a: 2800        cmp	r0, #0
@   0x08027b8c: d12d        bne.n	0x27bea
@   0x08027b8e: 490e        ldr	r1, [pc, #56]	@ (0x27bc8)
@   0x08027b90: 1909        adds	r1, r1, r4
@   0x08027b92: 468c        mov	ip, r1
@   0x08027b94: 2000        movs	r0, #0
@   0x08027b96: 5e09        ldrsh	r1, [r1, r0]
@   0x08027b98: 468c        mov	ip, r1
@   0x08027b9a: 480c        ldr	r0, [pc, #48]	@ (0x27bcc)
@   0x08027b9c: 4584        cmp	ip, r0
@   0x08027b9e: dd1b        ble.n	0x27bd8
@   0x08027ba0: 2080        movs	r0, #128	@ 0x80
@   0x08027ba2: 0140        lsls	r0, r0, #5
@   0x08027ba4: 4010        ands	r0, r2
@   0x08027ba6: 2800        cmp	r0, #0
@   0x08027ba8: d006        beq.n	0x27bb8
@   0x08027baa: 8273        strh	r3, [r6, #18]
@   0x08027bac: 4808        ldr	r0, [pc, #32]	@ (0x27bd0)
@   0x08027bae: 4028        ands	r0, r5
@   0x08027bb0: 8230        strh	r0, [r6, #16]
@   0x08027bb2: 4808        ldr	r0, [pc, #32]	@ (0x27bd4)
@   0x08027bb4: 4010        ands	r0, r2
@   0x08027bb6: 8038        strh	r0, [r7, #0]
@   0x08027bb8: 21ee        movs	r1, #238	@ 0xee
@   0x08027bba: 0109        lsls	r1, r1, #4
@   0x08027bbc: 1864        adds	r4, r4, r1
@   0x08027bbe: e02f        b.n	0x27c20
@   0x08027bc0: 35e0        adds	r5, #224	@ 0xe0
@   0x08027bc2: 0300        lsls	r0, r0, #12
@   0x08027bc4: 6110        str	r0, [r2, #16]
@   0x08027bc6: 0300        lsls	r0, r0, #12
@   0x08027bc8: 0ee4        lsrs	r4, r4, #27
@   0x08027bca: 0000        movs	r0, r0
@   0x08027bcc: 01bb        lsls	r3, r7, #6
@   0x08027bce: 0000        movs	r0, r0
@   0x08027bd0: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08027bd4: efff        0000 	vext.8	d16, d15, d0, #0
@   0x08027bd8: 2044        movs	r0, #68	@ 0x44
@   0x08027bda: f7f9        f9af 	bl	0x20f3c
@   0x08027bde: 22ee        movs	r2, #238	@ 0xee
@   0x08027be0: 0112        lsls	r2, r2, #4
@   0x08027be2: 18a0        adds	r0, r4, r2
@   0x08027be4: f7dd        feee 	bl	0x59c4
@   0x08027be8: e048        b.n	0x27c7c
@   0x08027bea: 2801        cmp	r0, #1
@   0x08027bec: d146        bne.n	0x27c7c
@   0x08027bee: 4811        ldr	r0, [pc, #68]	@ (0x27c34)
@   0x08027bf0: 1900        adds	r0, r0, r4
@   0x08027bf2: 4684        mov	ip, r0
@   0x08027bf4: 2100        movs	r1, #0
@   0x08027bf6: 5e40        ldrsh	r0, [r0, r1]
@   0x08027bf8: 4684        mov	ip, r0
@   0x08027bfa: 20c5        movs	r0, #197	@ 0xc5
@   0x08027bfc: 0040        lsls	r0, r0, #1
@   0x08027bfe: 4584        cmp	ip, r0
@   0x08027c00: dc1e        bgt.n	0x27c40
@   0x08027c02: 2080        movs	r0, #128	@ 0x80
@   0x08027c04: 0140        lsls	r0, r0, #5
@   0x08027c06: 4010        ands	r0, r2
@   0x08027c08: 2800        cmp	r0, #0
@   0x08027c0a: d006        beq.n	0x27c1a
@   0x08027c0c: 8273        strh	r3, [r6, #18]
@   0x08027c0e: 480a        ldr	r0, [pc, #40]	@ (0x27c38)
@   0x08027c10: 4028        ands	r0, r5
@   0x08027c12: 8230        strh	r0, [r6, #16]
@   0x08027c14: 4809        ldr	r0, [pc, #36]	@ (0x27c3c)
@   0x08027c16: 4010        ands	r0, r2
@   0x08027c18: 8038        strh	r0, [r7, #0]
@   0x08027c1a: 22ee        movs	r2, #238	@ 0xee
@   0x08027c1c: 0112        lsls	r2, r2, #4
@   0x08027c1e: 18a4        adds	r4, r4, r2
@   0x08027c20: 1c20        adds	r0, r4, #0
@   0x08027c22: 2100        movs	r1, #0
@   0x08027c24: 2200        movs	r2, #0
@   0x08027c26: 2300        movs	r3, #0
@   0x08027c28: f7e2        fcaa 	bl	0xa580
@   0x08027c2c: 1c20        adds	r0, r4, #0
@   0x08027c2e: f7dd        fec9 	bl	0x59c4
@   0x08027c32: e023        b.n	0x27c7c
@   0x08027c34: 0ee4        lsrs	r4, r4, #27
@   0x08027c36: 0000        movs	r0, r0
@   0x08027c38: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08027c3c: efff        0000 	vext.8	d16, d15, d0, #0
@   0x08027c40: 2044        movs	r0, #68	@ 0x44
@   0x08027c42: f7f9        f97b 	bl	0x20f3c
@   0x08027c46: 25ee        movs	r5, #238	@ 0xee
@   0x08027c48: 012d        lsls	r5, r5, #4
@   0x08027c4a: 1960        adds	r0, r4, r5
@   0x08027c4c: f7dd        feba 	bl	0x59c4
@   0x08027c50: e014        b.n	0x27c7c
@   0x08027c52: 4807        ldr	r0, [pc, #28]	@ (0x27c70)
@   0x08027c54: 1821        adds	r1, r4, r0
@   0x08027c56: 2280        movs	r2, #128	@ 0x80
@   0x08027c58: 0092        lsls	r2, r2, #2
@   0x08027c5a: 1c10        adds	r0, r2, #0
@   0x08027c5c: 880d        ldrh	r5, [r1, #0]
@   0x08027c5e: 4328        orrs	r0, r5
@   0x08027c60: 8008        strh	r0, [r1, #0]
@   0x08027c62: 4904        ldr	r1, [pc, #16]	@ (0x27c74)
@   0x08027c64: 6908        ldr	r0, [r1, #16]
@   0x08027c66: 2801        cmp	r0, #1
@   0x08027c68: d106        bne.n	0x27c78
@   0x08027c6a: 2000        movs	r0, #0
@   0x08027c6c: e005        b.n	0x27c7a
@   0x08027c6e: 0000        movs	r0, r0
@   0x08027c70: 0f14        lsrs	r4, r2, #28
@   0x08027c72: 0000        movs	r0, r0
@   0x08027c74: 6110        str	r0, [r2, #16]
@   0x08027c76: 0300        lsls	r0, r0, #12
@   0x08027c78: 2001        movs	r0, #1
@   0x08027c7a: 6108        str	r0, [r1, #16]
@   0x08027c7c: bcf0        pop	{r4, r5, r6, r7}
@   0x08027c7e: bc01        pop	{r0}
@   0x08027c80: 4700        bx	r0

        thumb_func_start sub_08027AC4
sub_08027AC4: @ 0x08027ac4
        .incbin "baserom.gba", 0x27ac4, 0x1c0
        thumb_func_end sub_08027AC4
