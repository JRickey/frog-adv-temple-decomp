@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08030b34, 0x08030c4c)  (280 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8030b34 --end 0x8030c4c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030b34: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08030b36: 464f        mov	r7, r9
@   0x08030b38: 4646        mov	r6, r8
@   0x08030b3a: b4c0        push	{r6, r7}
@   0x08030b3c: 1c05        adds	r5, r0, #0
@   0x08030b3e: 4688        mov	r8, r1
@   0x08030b40: 680b        ldr	r3, [r1, #0]
@   0x08030b42: 2d03        cmp	r5, #3
@   0x08030b44: dd77        ble.n	0x30c36
@   0x08030b46: 3d04        subs	r5, #4
@   0x08030b48: 4826        ldr	r0, [pc, #152]	@ (0x30be4)
@   0x08030b4a: 4681        mov	r9, r0
@   0x08030b4c: 6802        ldr	r2, [r0, #0]
@   0x08030b4e: 1c10        adds	r0, r2, #0
@   0x08030b50: 30c8        adds	r0, #200	@ 0xc8
@   0x08030b52: 01a9        lsls	r1, r5, #6
@   0x08030b54: 6800        ldr	r0, [r0, #0]
@   0x08030b56: 1840        adds	r0, r0, r1
@   0x08030b58: 4684        mov	ip, r0
@   0x08030b5a: 1c11        adds	r1, r2, #0
@   0x08030b5c: 31c0        adds	r1, #192	@ 0xc0
@   0x08030b5e: 00e8        lsls	r0, r5, #3
@   0x08030b60: 1b40        subs	r0, r0, r5
@   0x08030b62: 0080        lsls	r0, r0, #2
@   0x08030b64: 6809        ldr	r1, [r1, #0]
@   0x08030b66: 180c        adds	r4, r1, r0
@   0x08030b68: 4660        mov	r0, ip
@   0x08030b6a: 6b81        ldr	r1, [r0, #56]	@ 0x38
@   0x08030b6c: 2780        movs	r7, #128	@ 0x80
@   0x08030b6e: 00ff        lsls	r7, r7, #3
@   0x08030b70: 1c0e        adds	r6, r1, #0
@   0x08030b72: 403e        ands	r6, r7
@   0x08030b74: 2e00        cmp	r6, #0
@   0x08030b76: d144        bne.n	0x30c02
@   0x08030b78: 481b        ldr	r0, [pc, #108]	@ (0x30be8)
@   0x08030b7a: 4001        ands	r1, r0
@   0x08030b7c: 4339        orrs	r1, r7
@   0x08030b7e: 4660        mov	r0, ip
@   0x08030b80: 6381        str	r1, [r0, #56]	@ 0x38
@   0x08030b82: 1c10        adds	r0, r2, #0
@   0x08030b84: 30c4        adds	r0, #196	@ 0xc4
@   0x08030b86: 6801        ldr	r1, [r0, #0]
@   0x08030b88: 00a8        lsls	r0, r5, #2
@   0x08030b8a: 1840        adds	r0, r0, r1
@   0x08030b8c: 6006        str	r6, [r0, #0]
@   0x08030b8e: 4661        mov	r1, ip
@   0x08030b90: 312c        adds	r1, #44	@ 0x2c
@   0x08030b92: 7898        ldrb	r0, [r3, #2]
@   0x08030b94: 7108        strb	r0, [r1, #4]
@   0x08030b96: 78d8        ldrb	r0, [r3, #3]
@   0x08030b98: 7148        strb	r0, [r1, #5]
@   0x08030b9a: 8898        ldrh	r0, [r3, #4]
@   0x08030b9c: 2200        movs	r2, #0
@   0x08030b9e: 8048        strh	r0, [r1, #2]
@   0x08030ba0: 785b        ldrb	r3, [r3, #1]
@   0x08030ba2: 0218        lsls	r0, r3, #8
@   0x08030ba4: 4663        mov	r3, ip
@   0x08030ba6: 8598        strh	r0, [r3, #44]	@ 0x2c
@   0x08030ba8: 4810        ldr	r0, [pc, #64]	@ (0x30bec)
@   0x08030baa: 6020        str	r0, [r4, #0]
@   0x08030bac: 7909        ldrb	r1, [r1, #4]
@   0x08030bae: 0609        lsls	r1, r1, #24
@   0x08030bb0: 1609        asrs	r1, r1, #24
@   0x08030bb2: 3110        adds	r1, #16
@   0x08030bb4: 1809        adds	r1, r1, r0
@   0x08030bb6: 60e1        str	r1, [r4, #12]
@   0x08030bb8: 6061        str	r1, [r4, #4]
@   0x08030bba: 6800        ldr	r0, [r0, #0]
@   0x08030bbc: 0840        lsrs	r0, r0, #1
@   0x08030bbe: 1808        adds	r0, r1, r0
@   0x08030bc0: 60a0        str	r0, [r4, #8]
@   0x08030bc2: 1a40        subs	r0, r0, r1
@   0x08030bc4: 6120        str	r0, [r4, #16]
@   0x08030bc6: 82e6        strh	r6, [r4, #22]
@   0x08030bc8: 76a2        strb	r2, [r4, #26]
@   0x08030bca: 4660        mov	r0, ip
@   0x08030bcc: 303d        adds	r0, #61	@ 0x3d
@   0x08030bce: 7800        ldrb	r0, [r0, #0]
@   0x08030bd0: 2800        cmp	r0, #0
@   0x08030bd2: d00d        beq.n	0x30bf0
@   0x08030bd4: 4649        mov	r1, r9
@   0x08030bd6: 6808        ldr	r0, [r1, #0]
@   0x08030bd8: 2387        movs	r3, #135	@ 0x87
@   0x08030bda: 005b        lsls	r3, r3, #1
@   0x08030bdc: 18c0        adds	r0, r0, r3
@   0x08030bde: 7800        ldrb	r0, [r0, #0]
@   0x08030be0: e007        b.n	0x30bf2
@   0x08030be2: 0000        movs	r0, r0
@   0x08030be4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030be6: 0300        lsls	r0, r0, #12
@   0x08030be8: e7ff        b.n	0x30bea
@   0x08030bea: ffff        da4c 	vtbx.8	d29, {d15-d17}, d12
@   0x08030bee: 083d        lsrs	r5, r7, #32
@   0x08030bf0: 2000        movs	r0, #0
@   0x08030bf2: 76e0        strb	r0, [r4, #27]
@   0x08030bf4: 1c28        adds	r0, r5, #0
@   0x08030bf6: f7fe        fbcf 	bl	0x2f398
@   0x08030bfa: 1c28        adds	r0, r5, #0
@   0x08030bfc: f7fe        ff30 	bl	0x2fa60
@   0x08030c00: e019        b.n	0x30c36
@   0x08030c02: 4661        mov	r1, ip
@   0x08030c04: 312c        adds	r1, #44	@ 0x2c
@   0x08030c06: 7898        ldrb	r0, [r3, #2]
@   0x08030c08: 7108        strb	r0, [r1, #4]
@   0x08030c0a: 78d8        ldrb	r0, [r3, #3]
@   0x08030c0c: 7148        strb	r0, [r1, #5]
@   0x08030c0e: 8898        ldrh	r0, [r3, #4]
@   0x08030c10: 8048        strh	r0, [r1, #2]
@   0x08030c12: 4660        mov	r0, ip
@   0x08030c14: 232c        movs	r3, #44	@ 0x2c
@   0x08030c16: 5ec2        ldrsh	r2, [r0, r3]
@   0x08030c18: 2005        movs	r0, #5
@   0x08030c1a: 5608        ldrsb	r0, [r1, r0]
@   0x08030c1c: 0200        lsls	r0, r0, #8
@   0x08030c1e: 4282        cmp	r2, r0
@   0x08030c20: dd02        ble.n	0x30c28
@   0x08030c22: 4661        mov	r1, ip
@   0x08030c24: 8588        strh	r0, [r1, #44]	@ 0x2c
@   0x08030c26: e006        b.n	0x30c36
@   0x08030c28: 2004        movs	r0, #4
@   0x08030c2a: 5608        ldrsb	r0, [r1, r0]
@   0x08030c2c: 0200        lsls	r0, r0, #8
@   0x08030c2e: 4282        cmp	r2, r0
@   0x08030c30: da01        bge.n	0x30c36
@   0x08030c32: 4663        mov	r3, ip
@   0x08030c34: 8598        strh	r0, [r3, #44]	@ 0x2c
@   0x08030c36: 4641        mov	r1, r8
@   0x08030c38: 6808        ldr	r0, [r1, #0]
@   0x08030c3a: 3006        adds	r0, #6
@   0x08030c3c: 6008        str	r0, [r1, #0]
@   0x08030c3e: 2001        movs	r0, #1
@   0x08030c40: bc18        pop	{r3, r4}
@   0x08030c42: 4698        mov	r8, r3
@   0x08030c44: 46a1        mov	r9, r4
@   0x08030c46: bcf0        pop	{r4, r5, r6, r7}
@   0x08030c48: bc02        pop	{r1}
@   0x08030c4a: 4708        bx	r1

        thumb_func_start sub_08030B34
sub_08030B34: @ 0x08030b34
        .incbin "baserom.gba", 0x30b34, 0x118
        thumb_func_end sub_08030B34
