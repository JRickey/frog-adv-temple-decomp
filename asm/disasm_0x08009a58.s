@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009a58, 0x08009c14)  (444 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009a58 --end 0x8009c14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009a58: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08009a5a: 4657        mov	r7, sl
@   0x08009a5c: 464e        mov	r6, r9
@   0x08009a5e: 4645        mov	r5, r8
@   0x08009a60: b4e0        push	{r5, r6, r7}
@   0x08009a62: b083        sub	sp, #12
@   0x08009a64: 483c        ldr	r0, [pc, #240]	@ (0x9b58)
@   0x08009a66: 8981        ldrh	r1, [r0, #12]
@   0x08009a68: 9100        str	r1, [sp, #0]
@   0x08009a6a: 8a00        ldrh	r0, [r0, #16]
@   0x08009a6c: 9001        str	r0, [sp, #4]
@   0x08009a6e: 4a3b        ldr	r2, [pc, #236]	@ (0x9b5c)
@   0x08009a70: 1c13        adds	r3, r2, #0
@   0x08009a72: 3331        adds	r3, #49	@ 0x31
@   0x08009a74: 2000        movs	r0, #0
@   0x08009a76: 7018        strb	r0, [r3, #0]
@   0x08009a78: 2000        movs	r0, #0
@   0x08009a7a: 2100        movs	r1, #0
@   0x08009a7c: 6150        str	r0, [r2, #20]
@   0x08009a7e: 6191        str	r1, [r2, #24]
@   0x08009a80: 61d0        str	r0, [r2, #28]
@   0x08009a82: 6211        str	r1, [r2, #32]
@   0x08009a84: 2400        movs	r4, #0
@   0x08009a86: 46a0        mov	r8, r4
@   0x08009a88: 3230        adds	r2, #48	@ 0x30
@   0x08009a8a: 7810        ldrb	r0, [r2, #0]
@   0x08009a8c: 4580        cmp	r8, r0
@   0x08009a8e: da7b        bge.n	0x9b88
@   0x08009a90: 4699        mov	r9, r3
@   0x08009a92: 2100        movs	r1, #0
@   0x08009a94: 9102        str	r1, [sp, #8]
@   0x08009a96: 4832        ldr	r0, [pc, #200]	@ (0x9b60)
@   0x08009a98: 9a02        ldr	r2, [sp, #8]
@   0x08009a9a: 1815        adds	r5, r2, r0
@   0x08009a9c: 2008        movs	r0, #8
@   0x08009a9e: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x08009aa0: 4018        ands	r0, r3
@   0x08009aa2: 2800        cmp	r0, #0
@   0x08009aa4: d167        bne.n	0x9b76
@   0x08009aa6: 4640        mov	r0, r8
@   0x08009aa8: f003        fabe 	bl	0xd028
@   0x08009aac: 2800        cmp	r0, #0
@   0x08009aae: d05d        beq.n	0x9b6c
@   0x08009ab0: 7e2c        ldrb	r4, [r5, #24]
@   0x08009ab2: 0862        lsrs	r2, r4, #1
@   0x08009ab4: 88a9        ldrh	r1, [r5, #4]
@   0x08009ab6: 2002        movs	r0, #2
@   0x08009ab8: 5e2f        ldrsh	r7, [r5, r0]
@   0x08009aba: 9b00        ldr	r3, [sp, #0]
@   0x08009abc: 0418        lsls	r0, r3, #16
@   0x08009abe: 1406        asrs	r6, r0, #16
@   0x08009ac0: 1bb8        subs	r0, r7, r6
@   0x08009ac2: 7e6c        ldrb	r4, [r5, #25]
@   0x08009ac4: 0863        lsrs	r3, r4, #1
@   0x08009ac6: 1ac0        subs	r0, r0, r3
@   0x08009ac8: 2400        movs	r4, #0
@   0x08009aca: 46a2        mov	sl, r4
@   0x08009acc: 8128        strh	r0, [r5, #8]
@   0x08009ace: 0409        lsls	r1, r1, #16
@   0x08009ad0: 1409        asrs	r1, r1, #16
@   0x08009ad2: 468c        mov	ip, r1
@   0x08009ad4: 9901        ldr	r1, [sp, #4]
@   0x08009ad6: 0408        lsls	r0, r1, #16
@   0x08009ad8: 1404        asrs	r4, r0, #16
@   0x08009ada: 4661        mov	r1, ip
@   0x08009adc: 1b08        subs	r0, r1, r4
@   0x08009ade: 1a80        subs	r0, r0, r2
@   0x08009ae0: 8168        strh	r0, [r5, #10]
@   0x08009ae2: 18f8        adds	r0, r7, r3
@   0x08009ae4: 42b0        cmp	r0, r6
@   0x08009ae6: db31        blt.n	0x9b4c
@   0x08009ae8: 1af9        subs	r1, r7, r3
@   0x08009aea: 1c30        adds	r0, r6, #0
@   0x08009aec: 30f0        adds	r0, #240	@ 0xf0
@   0x08009aee: 4281        cmp	r1, r0
@   0x08009af0: dc2c        bgt.n	0x9b4c
@   0x08009af2: 4663        mov	r3, ip
@   0x08009af4: 1898        adds	r0, r3, r2
@   0x08009af6: 42a0        cmp	r0, r4
@   0x08009af8: db28        blt.n	0x9b4c
@   0x08009afa: 1a99        subs	r1, r3, r2
@   0x08009afc: 1c20        adds	r0, r4, #0
@   0x08009afe: 30a0        adds	r0, #160	@ 0xa0
@   0x08009b00: 4281        cmp	r1, r0
@   0x08009b02: dc23        bgt.n	0x9b4c
@   0x08009b04: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08009b06: 2201        movs	r2, #1
@   0x08009b08: 2001        movs	r0, #1
@   0x08009b0a: 4008        ands	r0, r1
@   0x08009b0c: 2800        cmp	r0, #0
@   0x08009b0e: d105        bne.n	0x9b1c
@   0x08009b10: 2480        movs	r4, #128	@ 0x80
@   0x08009b12: 0064        lsls	r4, r4, #1
@   0x08009b14: 1c20        adds	r0, r4, #0
@   0x08009b16: 4308        orrs	r0, r1
@   0x08009b18: 4310        orrs	r0, r2
@   0x08009b1a: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08009b1c: 4649        mov	r1, r9
@   0x08009b1e: 7809        ldrb	r1, [r1, #0]
@   0x08009b20: 00c8        lsls	r0, r1, #3
@   0x08009b22: 4a10        ldr	r2, [pc, #64]	@ (0x9b64)
@   0x08009b24: 1880        adds	r0, r0, r2
@   0x08009b26: 4643        mov	r3, r8
@   0x08009b28: 7003        strb	r3, [r0, #0]
@   0x08009b2a: 464c        mov	r4, r9
@   0x08009b2c: 7824        ldrb	r4, [r4, #0]
@   0x08009b2e: 00e0        lsls	r0, r4, #3
@   0x08009b30: 1880        adds	r0, r0, r2
@   0x08009b32: 8ce9        ldrh	r1, [r5, #38]	@ 0x26
@   0x08009b34: 4461        add	r1, ip
@   0x08009b36: 8041        strh	r1, [r0, #2]
@   0x08009b38: 4649        mov	r1, r9
@   0x08009b3a: 7809        ldrb	r1, [r1, #0]
@   0x08009b3c: 00c8        lsls	r0, r1, #3
@   0x08009b3e: 1880        adds	r0, r0, r2
@   0x08009b40: 4909        ldr	r1, [pc, #36]	@ (0x9b68)
@   0x08009b42: 8081        strh	r1, [r0, #4]
@   0x08009b44: 464a        mov	r2, r9
@   0x08009b46: 7810        ldrb	r0, [r2, #0]
@   0x08009b48: 3001        adds	r0, #1
@   0x08009b4a: 7010        strb	r0, [r2, #0]
@   0x08009b4c: 4803        ldr	r0, [pc, #12]	@ (0x9b5c)
@   0x08009b4e: 4641        mov	r1, r8
@   0x08009b50: f7fc        ff0c 	bl	0x696c
@   0x08009b54: e00f        b.n	0x9b76
@   0x08009b56: 0000        movs	r0, r0
@   0x08009b58: 60a0        str	r0, [r4, #8]
@   0x08009b5a: 0300        lsls	r0, r0, #12
@   0x08009b5c: 6110        str	r0, [r2, #16]
@   0x08009b5e: 0300        lsls	r0, r0, #12
@   0x08009b60: 3720        adds	r7, #32
@   0x08009b62: 0300        lsls	r0, r0, #12
@   0x08009b64: 6160        str	r0, [r4, #20]
@   0x08009b66: 0300        lsls	r0, r0, #12
@   0x08009b68: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08009b6c: 4b0a        ldr	r3, [pc, #40]	@ (0x9b98)
@   0x08009b6e: 1c18        adds	r0, r3, #0
@   0x08009b70: 8eac        ldrh	r4, [r5, #52]	@ 0x34
@   0x08009b72: 4020        ands	r0, r4
@   0x08009b74: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08009b76: 9802        ldr	r0, [sp, #8]
@   0x08009b78: 3038        adds	r0, #56	@ 0x38
@   0x08009b7a: 9002        str	r0, [sp, #8]
@   0x08009b7c: 2101        movs	r1, #1
@   0x08009b7e: 4488        add	r8, r1
@   0x08009b80: 4a06        ldr	r2, [pc, #24]	@ (0x9b9c)
@   0x08009b82: 7812        ldrb	r2, [r2, #0]
@   0x08009b84: 4590        cmp	r8, r2
@   0x08009b86: db86        blt.n	0x9a96
@   0x08009b88: b003        add	sp, #12
@   0x08009b8a: bc38        pop	{r3, r4, r5}
@   0x08009b8c: 4698        mov	r8, r3
@   0x08009b8e: 46a1        mov	r9, r4
@   0x08009b90: 46aa        mov	sl, r5
@   0x08009b92: bcf0        pop	{r4, r5, r6, r7}
@   0x08009b94: bc01        pop	{r0}
@   0x08009b96: 4700        bx	r0
@   0x08009b98: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08009b9c: 6140        str	r0, [r0, #20]
@   0x08009b9e: 0300        lsls	r0, r0, #12
@   0x08009ba0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08009ba2: 2600        movs	r6, #0
@   0x08009ba4: 4813        ldr	r0, [pc, #76]	@ (0x9bf4)
@   0x08009ba6: 7a80        ldrb	r0, [r0, #10]
@   0x08009ba8: 2801        cmp	r0, #1
@   0x08009baa: d11e        bne.n	0x9bea
@   0x08009bac: 4812        ldr	r0, [pc, #72]	@ (0x9bf8)
@   0x08009bae: 3032        adds	r0, #50	@ 0x32
@   0x08009bb0: 7800        ldrb	r0, [r0, #0]
@   0x08009bb2: 2801        cmp	r0, #1
@   0x08009bb4: d119        bne.n	0x9bea
@   0x08009bb6: 2200        movs	r2, #0
@   0x08009bb8: 4c10        ldr	r4, [pc, #64]	@ (0x9bfc)
@   0x08009bba: 4b11        ldr	r3, [pc, #68]	@ (0x9c00)
@   0x08009bbc: 469c        mov	ip, r3
@   0x08009bbe: 2008        movs	r0, #8
@   0x08009bc0: 5e25        ldrsh	r5, [r4, r0]
@   0x08009bc2: 0091        lsls	r1, r2, #2
@   0x08009bc4: 4667        mov	r7, ip
@   0x08009bc6: 19c8        adds	r0, r1, r7
@   0x08009bc8: 2700        movs	r7, #0
@   0x08009bca: 5fc0        ldrsh	r0, [r0, r7]
@   0x08009bcc: 3201        adds	r2, #1
@   0x08009bce: 4285        cmp	r5, r0
@   0x08009bd0: d107        bne.n	0x9be2
@   0x08009bd2: 1c98        adds	r0, r3, #2
@   0x08009bd4: 1808        adds	r0, r1, r0
@   0x08009bd6: 8961        ldrh	r1, [r4, #10]
@   0x08009bd8: 8800        ldrh	r0, [r0, #0]
@   0x08009bda: 4281        cmp	r1, r0
@   0x08009bdc: d101        bne.n	0x9be2
@   0x08009bde: 0610        lsls	r0, r2, #24
@   0x08009be0: 0e06        lsrs	r6, r0, #24
@   0x08009be2: 0610        lsls	r0, r2, #24
@   0x08009be4: 0e02        lsrs	r2, r0, #24
@   0x08009be6: 2a04        cmp	r2, #4
@   0x08009be8: d9eb        bls.n	0x9bc2
@   0x08009bea: 0634        lsls	r4, r6, #24
@   0x08009bec: 2c00        cmp	r4, #0
@   0x08009bee: d109        bne.n	0x9c04
@   0x08009bf0: 2000        movs	r0, #0
@   0x08009bf2: e00b        b.n	0x9c0c
@   0x08009bf4: 5330        strh	r0, [r6, r4]
@   0x08009bf6: 0300        lsls	r0, r0, #12
@   0x08009bf8: 6110        str	r0, [r2, #16]
@   0x08009bfa: 0300        lsls	r0, r0, #12
@   0x08009bfc: 35e0        adds	r5, #224	@ 0xe0
@   0x08009bfe: 0300        lsls	r0, r0, #12
@   0x08009c00: 9cf4        ldr	r4, [sp, #976]	@ 0x3d0
@   0x08009c02: 082f        lsrs	r7, r5, #32
@   0x08009c04: 2008        movs	r0, #8
@   0x08009c06: f017        f837 	bl	0x20c78
@   0x08009c0a: 0e20        lsrs	r0, r4, #24
@   0x08009c0c: bcf0        pop	{r4, r5, r6, r7}
@   0x08009c0e: bc02        pop	{r1}
@   0x08009c10: 4708        bx	r1

        thumb_func_start sub_08009A58
sub_08009A58: @ 0x08009a58
        .incbin "frog_us_baserom.gba", 0x9a58, 0x1bc
        thumb_func_end sub_08009A58
