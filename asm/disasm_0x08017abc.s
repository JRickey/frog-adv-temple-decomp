@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017abc, 0x08017bfc)  (320 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017abc --end 0x8017bfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017abc: b570        push	{r4, r5, r6, lr}
@   0x08017abe: 4646        mov	r6, r8
@   0x08017ac0: b440        push	{r6}
@   0x08017ac2: 481e        ldr	r0, [pc, #120]	@ (0x17b3c)
@   0x08017ac4: 2500        movs	r5, #0
@   0x08017ac6: 8005        strh	r5, [r0, #0]
@   0x08017ac8: 4c1d        ldr	r4, [pc, #116]	@ (0x17b40)
@   0x08017aca: 7025        strb	r5, [r4, #0]
@   0x08017acc: 70e5        strb	r5, [r4, #3]
@   0x08017ace: 7065        strb	r5, [r4, #1]
@   0x08017ad0: 70a5        strb	r5, [r4, #2]
@   0x08017ad2: 71e5        strb	r5, [r4, #7]
@   0x08017ad4: 7165        strb	r5, [r4, #5]
@   0x08017ad6: 71a5        strb	r5, [r4, #6]
@   0x08017ad8: 7125        strb	r5, [r4, #4]
@   0x08017ada: 481a        ldr	r0, [pc, #104]	@ (0x17b44)
@   0x08017adc: 4680        mov	r8, r0
@   0x08017ade: 7045        strb	r5, [r0, #1]
@   0x08017ae0: f7e8        ff0e 	bl	0x900
@   0x08017ae4: 60e0        str	r0, [r4, #12]
@   0x08017ae6: 20bf        movs	r0, #191	@ 0xbf
@   0x08017ae8: f7f8        fe00 	bl	0x106ec
@   0x08017aec: 4916        ldr	r1, [pc, #88]	@ (0x17b48)
@   0x08017aee: 4a17        ldr	r2, [pc, #92]	@ (0x17b4c)
@   0x08017af0: 1c10        adds	r0, r2, #0
@   0x08017af2: 8008        strh	r0, [r1, #0]
@   0x08017af4: 4e16        ldr	r6, [pc, #88]	@ (0x17b50)
@   0x08017af6: 6830        ldr	r0, [r6, #0]
@   0x08017af8: 4916        ldr	r1, [pc, #88]	@ (0x17b54)
@   0x08017afa: f015        fd37 	bl	0x2d56c
@   0x08017afe: 4916        ldr	r1, [pc, #88]	@ (0x17b58)
@   0x08017b00: 6870        ldr	r0, [r6, #4]
@   0x08017b02: 6008        str	r0, [r1, #0]
@   0x08017b04: 20a0        movs	r0, #160	@ 0xa0
@   0x08017b06: 04c0        lsls	r0, r0, #19
@   0x08017b08: 6048        str	r0, [r1, #4]
@   0x08017b0a: 4814        ldr	r0, [pc, #80]	@ (0x17b5c)
@   0x08017b0c: 6088        str	r0, [r1, #8]
@   0x08017b0e: 6888        ldr	r0, [r1, #8]
@   0x08017b10: 68b0        ldr	r0, [r6, #8]
@   0x08017b12: 6008        str	r0, [r1, #0]
@   0x08017b14: 4812        ldr	r0, [pc, #72]	@ (0x17b60)
@   0x08017b16: 6048        str	r0, [r1, #4]
@   0x08017b18: 4812        ldr	r0, [pc, #72]	@ (0x17b64)
@   0x08017b1a: 6088        str	r0, [r1, #8]
@   0x08017b1c: 6888        ldr	r0, [r1, #8]
@   0x08017b1e: 39d4        subs	r1, #212	@ 0xd4
@   0x08017b20: 2284        movs	r2, #132	@ 0x84
@   0x08017b22: 0112        lsls	r2, r2, #4
@   0x08017b24: 1c10        adds	r0, r2, #0
@   0x08017b26: 8008        strh	r0, [r1, #0]
@   0x08017b28: 7820        ldrb	r0, [r4, #0]
@   0x08017b2a: 3001        adds	r0, #1
@   0x08017b2c: 7020        strb	r0, [r4, #0]
@   0x08017b2e: 4640        mov	r0, r8
@   0x08017b30: 7005        strb	r5, [r0, #0]
@   0x08017b32: bc08        pop	{r3}
@   0x08017b34: 4698        mov	r8, r3
@   0x08017b36: bc70        pop	{r4, r5, r6}
@   0x08017b38: bc01        pop	{r0}
@   0x08017b3a: 4700        bx	r0
@   0x08017b3c: 5398        strh	r0, [r3, r6]
@   0x08017b3e: 0300        lsls	r0, r0, #12
@   0x08017b40: 3480        adds	r4, #128	@ 0x80
@   0x08017b42: 0300        lsls	r0, r0, #12
@   0x08017b44: 34a0        adds	r4, #160	@ 0xa0
@   0x08017b46: 0300        lsls	r0, r0, #12
@   0x08017b48: 000e        movs	r6, r1
@   0x08017b4a: 0400        lsls	r0, r0, #16
@   0x08017b4c: 1e88        subs	r0, r1, #2
@   0x08017b4e: 0000        movs	r0, r0
@   0x08017b50: 3550        adds	r5, #80	@ 0x50
@   0x08017b52: 080e        lsrs	r6, r1, #32
@   0x08017b54: 8000        strh	r0, [r0, #0]
@   0x08017b56: 0600        lsls	r0, r0, #24
@   0x08017b58: 00d4        lsls	r4, r2, #3
@   0x08017b5a: 0400        lsls	r0, r0, #16
@   0x08017b5c: 0100        lsls	r0, r0, #4
@   0x08017b5e: 8000        strh	r0, [r0, #0]
@   0x08017b60: f000        0600 	and.w	r6, r0, #0
@   0x08017b64: 0400        lsls	r0, r0, #16
@   0x08017b66: 8000        strh	r0, [r0, #0]
@   0x08017b68: b530        push	{r4, r5, lr}
@   0x08017b6a: 4d1d        ldr	r5, [pc, #116]	@ (0x17be0)
@   0x08017b6c: 2100        movs	r1, #0
@   0x08017b6e: 7169        strb	r1, [r5, #5]
@   0x08017b70: 481c        ldr	r0, [pc, #112]	@ (0x17be4)
@   0x08017b72: 3024        adds	r0, #36	@ 0x24
@   0x08017b74: 7001        strb	r1, [r0, #0]
@   0x08017b76: f7f8        fdcb 	bl	0x10710
@   0x08017b7a: 1c04        adds	r4, r0, #0
@   0x08017b7c: 2c00        cmp	r4, #0
@   0x08017b7e: d12c        bne.n	0x17bda
@   0x08017b80: f7e8        febe 	bl	0x900
@   0x08017b84: 68e9        ldr	r1, [r5, #12]
@   0x08017b86: 1a40        subs	r0, r0, r1
@   0x08017b88: 2877        cmp	r0, #119	@ 0x77
@   0x08017b8a: d926        bls.n	0x17bda
@   0x08017b8c: 4916        ldr	r1, [pc, #88]	@ (0x17be8)
@   0x08017b8e: 2001        movs	r0, #1
@   0x08017b90: 7048        strb	r0, [r1, #1]
@   0x08017b92: 7828        ldrb	r0, [r5, #0]
@   0x08017b94: 3001        adds	r0, #1
@   0x08017b96: 7028        strb	r0, [r5, #0]
@   0x08017b98: f7e8        feb2 	bl	0x900
@   0x08017b9c: 60e8        str	r0, [r5, #12]
@   0x08017b9e: 20bf        movs	r0, #191	@ 0xbf
@   0x08017ba0: f7f8        fd78 	bl	0x10694
@   0x08017ba4: 4911        ldr	r1, [pc, #68]	@ (0x17bec)
@   0x08017ba6: 700c        strb	r4, [r1, #0]
@   0x08017ba8: 704c        strb	r4, [r1, #1]
@   0x08017baa: 20f0        movs	r0, #240	@ 0xf0
@   0x08017bac: 7088        strb	r0, [r1, #2]
@   0x08017bae: 22a0        movs	r2, #160	@ 0xa0
@   0x08017bb0: 70ca        strb	r2, [r1, #3]
@   0x08017bb2: 490f        ldr	r1, [pc, #60]	@ (0x17bf0)
@   0x08017bb4: 700c        strb	r4, [r1, #0]
@   0x08017bb6: 704c        strb	r4, [r1, #1]
@   0x08017bb8: 2058        movs	r0, #88	@ 0x58
@   0x08017bba: 7088        strb	r0, [r1, #2]
@   0x08017bbc: 2010        movs	r0, #16
@   0x08017bbe: 70c8        strb	r0, [r1, #3]
@   0x08017bc0: 480c        ldr	r0, [pc, #48]	@ (0x17bf4)
@   0x08017bc2: 7004        strb	r4, [r0, #0]
@   0x08017bc4: 7044        strb	r4, [r0, #1]
@   0x08017bc6: 7082        strb	r2, [r0, #2]
@   0x08017bc8: 2150        movs	r1, #80	@ 0x50
@   0x08017bca: 70c1        strb	r1, [r0, #3]
@   0x08017bcc: 490a        ldr	r1, [pc, #40]	@ (0x17bf8)
@   0x08017bce: 700c        strb	r4, [r1, #0]
@   0x08017bd0: 704c        strb	r4, [r1, #1]
@   0x08017bd2: 2072        movs	r0, #114	@ 0x72
@   0x08017bd4: 7088        strb	r0, [r1, #2]
@   0x08017bd6: 2009        movs	r0, #9
@   0x08017bd8: 70c8        strb	r0, [r1, #3]
@   0x08017bda: bc30        pop	{r4, r5}
@   0x08017bdc: bc01        pop	{r0}
@   0x08017bde: 4700        bx	r0
@   0x08017be0: 3480        adds	r4, #128	@ 0x80
@   0x08017be2: 0300        lsls	r0, r0, #12
@   0x08017be4: 5330        strh	r0, [r6, r4]
@   0x08017be6: 0300        lsls	r0, r0, #12
@   0x08017be8: 34a0        adds	r4, #160	@ 0xa0
@   0x08017bea: 0300        lsls	r0, r0, #12
@   0x08017bec: 3470        adds	r4, #112	@ 0x70
@   0x08017bee: 0300        lsls	r0, r0, #12
@   0x08017bf0: 3478        adds	r4, #120	@ 0x78
@   0x08017bf2: 0300        lsls	r0, r0, #12
@   0x08017bf4: 3474        adds	r4, #116	@ 0x74
@   0x08017bf6: 0300        lsls	r0, r0, #12
@   0x08017bf8: 3498        adds	r4, #152	@ 0x98
@   0x08017bfa: 0300        lsls	r0, r0, #12

        .incbin "frog_us_baserom.gba", 0x17b68, 0x94
