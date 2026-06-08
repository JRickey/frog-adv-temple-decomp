@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08010a44, 0x08010dd8)  (916 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8010a44 --end 0x8010dd8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08010a44: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08010a46: 4657        mov	r7, sl
@   0x08010a48: 464e        mov	r6, r9
@   0x08010a4a: 4645        mov	r5, r8
@   0x08010a4c: b4e0        push	{r5, r6, r7}
@   0x08010a4e: b089        sub	sp, #36	@ 0x24
@   0x08010a50: 0600        lsls	r0, r0, #24
@   0x08010a52: 0e00        lsrs	r0, r0, #24
@   0x08010a54: 9003        str	r0, [sp, #12]
@   0x08010a56: 0609        lsls	r1, r1, #24
@   0x08010a58: 0e09        lsrs	r1, r1, #24
@   0x08010a5a: 9104        str	r1, [sp, #16]
@   0x08010a5c: 480f        ldr	r0, [pc, #60]	@ (0x10a9c)
@   0x08010a5e: 8cc1        ldrh	r1, [r0, #38]	@ 0x26
@   0x08010a60: 8d00        ldrh	r0, [r0, #40]	@ 0x28
@   0x08010a62: 4281        cmp	r1, r0
@   0x08010a64: d100        bne.n	0x10a68
@   0x08010a66: e159        b.n	0x10d1c
@   0x08010a68: 2600        movs	r6, #0
@   0x08010a6a: 9903        ldr	r1, [sp, #12]
@   0x08010a6c: 428e        cmp	r6, r1
@   0x08010a6e: d300        bcc.n	0x10a72
@   0x08010a70: e154        b.n	0x10d1c
@   0x08010a72: 480a        ldr	r0, [pc, #40]	@ (0x10a9c)
@   0x08010a74: 8cc1        ldrh	r1, [r0, #38]	@ 0x26
@   0x08010a76: 4131        asrs	r1, r6
@   0x08010a78: 2201        movs	r2, #1
@   0x08010a7a: 4011        ands	r1, r2
@   0x08010a7c: 8d00        ldrh	r0, [r0, #40]	@ 0x28
@   0x08010a7e: 4130        asrs	r0, r6
@   0x08010a80: 4010        ands	r0, r2
@   0x08010a82: 1c73        adds	r3, r6, #1
@   0x08010a84: 9307        str	r3, [sp, #28]
@   0x08010a86: 4281        cmp	r1, r0
@   0x08010a88: d100        bne.n	0x10a8c
@   0x08010a8a: e140        b.n	0x10d0e
@   0x08010a8c: 4804        ldr	r0, [pc, #16]	@ (0x10aa0)
@   0x08010a8e: 7a80        ldrb	r0, [r0, #10]
@   0x08010a90: 280d        cmp	r0, #13
@   0x08010a92: d107        bne.n	0x10aa4
@   0x08010a94: 2057        movs	r0, #87	@ 0x57
@   0x08010a96: f010        f8ef 	bl	0x20c78
@   0x08010a9a: e00e        b.n	0x10aba
@   0x08010a9c: 6110        str	r0, [r2, #16]
@   0x08010a9e: 0300        lsls	r0, r0, #12
@   0x08010aa0: 5330        strh	r0, [r6, r4]
@   0x08010aa2: 0300        lsls	r0, r0, #12
@   0x08010aa4: 2802        cmp	r0, #2
@   0x08010aa6: d003        beq.n	0x10ab0
@   0x08010aa8: 2019        movs	r0, #25
@   0x08010aaa: f010        f8e5 	bl	0x20c78
@   0x08010aae: e004        b.n	0x10aba
@   0x08010ab0: 2e04        cmp	r6, #4
@   0x08010ab2: d102        bne.n	0x10aba
@   0x08010ab4: 2019        movs	r0, #25
@   0x08010ab6: f010        f8df 	bl	0x20c78
@   0x08010aba: 4b0c        ldr	r3, [pc, #48]	@ (0x10aec)
@   0x08010abc: 7a99        ldrb	r1, [r3, #10]
@   0x08010abe: 3901        subs	r1, #1
@   0x08010ac0: 0088        lsls	r0, r1, #2
@   0x08010ac2: 1840        adds	r0, r0, r1
@   0x08010ac4: 0080        lsls	r0, r0, #2
@   0x08010ac6: 4c0a        ldr	r4, [pc, #40]	@ (0x10af0)
@   0x08010ac8: 1900        adds	r0, r0, r4
@   0x08010aca: 6801        ldr	r1, [r0, #0]
@   0x08010acc: 0072        lsls	r2, r6, #1
@   0x08010ace: 1990        adds	r0, r2, r6
@   0x08010ad0: 00c0        lsls	r0, r0, #3
@   0x08010ad2: 1840        adds	r0, r0, r1
@   0x08010ad4: 7a00        ldrb	r0, [r0, #8]
@   0x08010ad6: 0900        lsrs	r0, r0, #4
@   0x08010ad8: 2501        movs	r5, #1
@   0x08010ada: 4028        ands	r0, r5
@   0x08010adc: 4b05        ldr	r3, [pc, #20]	@ (0x10af4)
@   0x08010ade: 9208        str	r2, [sp, #32]
@   0x08010ae0: 2800        cmp	r0, #0
@   0x08010ae2: d00d        beq.n	0x10b00
@   0x08010ae4: 4804        ldr	r0, [pc, #16]	@ (0x10af8)
@   0x08010ae6: 4905        ldr	r1, [pc, #20]	@ (0x10afc)
@   0x08010ae8: 6148        str	r0, [r1, #20]
@   0x08010aea: e00d        b.n	0x10b08
@   0x08010aec: 5330        strh	r0, [r6, r4]
@   0x08010aee: 0300        lsls	r0, r0, #12
@   0x08010af0: 7eb4        ldrb	r4, [r6, #26]
@   0x08010af2: 0830        lsrs	r0, r6, #32
@   0x08010af4: 7eac        ldrb	r4, [r5, #26]
@   0x08010af6: 0830        lsrs	r0, r6, #32
@   0x08010af8: 0000        movs	r0, r0
@   0x08010afa: 0201        lsls	r1, r0, #8
@   0x08010afc: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010afe: 0300        lsls	r0, r0, #12
@   0x08010b00: 2080        movs	r0, #128	@ 0x80
@   0x08010b02: 0480        lsls	r0, r0, #18
@   0x08010b04: 4a12        ldr	r2, [pc, #72]	@ (0x10b50)
@   0x08010b06: 6150        str	r0, [r2, #20]
@   0x08010b08: 4c12        ldr	r4, [pc, #72]	@ (0x10b54)
@   0x08010b0a: 7aa1        ldrb	r1, [r4, #10]
@   0x08010b0c: 3901        subs	r1, #1
@   0x08010b0e: 0088        lsls	r0, r1, #2
@   0x08010b10: 1840        adds	r0, r0, r1
@   0x08010b12: 0080        lsls	r0, r0, #2
@   0x08010b14: 3308        adds	r3, #8
@   0x08010b16: 469c        mov	ip, r3
@   0x08010b18: 4460        add	r0, ip
@   0x08010b1a: 6802        ldr	r2, [r0, #0]
@   0x08010b1c: 9d08        ldr	r5, [sp, #32]
@   0x08010b1e: 19a8        adds	r0, r5, r6
@   0x08010b20: 00c4        lsls	r4, r0, #3
@   0x08010b22: 18a2        adds	r2, r4, r2
@   0x08010b24: 4b0c        ldr	r3, [pc, #48]	@ (0x10b58)
@   0x08010b26: 8b58        ldrh	r0, [r3, #26]
@   0x08010b28: 8855        ldrh	r5, [r2, #2]
@   0x08010b2a: 1c01        adds	r1, r0, #0
@   0x08010b2c: 4369        muls	r1, r5
@   0x08010b2e: 8812        ldrh	r2, [r2, #0]
@   0x08010b30: 1851        adds	r1, r2, r1
@   0x08010b32: 0049        lsls	r1, r1, #1
@   0x08010b34: 4a06        ldr	r2, [pc, #24]	@ (0x10b50)
@   0x08010b36: 6950        ldr	r0, [r2, #20]
@   0x08010b38: 1840        adds	r0, r0, r1
@   0x08010b3a: 6150        str	r0, [r2, #20]
@   0x08010b3c: 4d07        ldr	r5, [pc, #28]	@ (0x10b5c)
@   0x08010b3e: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08010b40: 4132        asrs	r2, r6
@   0x08010b42: 2701        movs	r7, #1
@   0x08010b44: 403a        ands	r2, r7
@   0x08010b46: 2a00        cmp	r2, #0
@   0x08010b48: d00a        beq.n	0x10b60
@   0x08010b4a: 2a01        cmp	r2, #1
@   0x08010b4c: d01e        beq.n	0x10b8c
@   0x08010b4e: e02d        b.n	0x10bac
@   0x08010b50: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010b52: 0300        lsls	r0, r0, #12
@   0x08010b54: 5330        strh	r0, [r6, r4]
@   0x08010b56: 0300        lsls	r0, r0, #12
@   0x08010b58: 60a0        str	r0, [r4, #8]
@   0x08010b5a: 0300        lsls	r0, r0, #12
@   0x08010b5c: 6110        str	r0, [r2, #16]
@   0x08010b5e: 0300        lsls	r0, r0, #12
@   0x08010b60: 4b09        ldr	r3, [pc, #36]	@ (0x10b88)
@   0x08010b62: 7a99        ldrb	r1, [r3, #10]
@   0x08010b64: 3901        subs	r1, #1
@   0x08010b66: 0088        lsls	r0, r1, #2
@   0x08010b68: 1840        adds	r0, r0, r1
@   0x08010b6a: 0080        lsls	r0, r0, #2
@   0x08010b6c: 4460        add	r0, ip
@   0x08010b6e: 6800        ldr	r0, [r0, #0]
@   0x08010b70: 1820        adds	r0, r4, r0
@   0x08010b72: 6900        ldr	r0, [r0, #16]
@   0x08010b74: 6800        ldr	r0, [r0, #0]
@   0x08010b76: 9005        str	r0, [sp, #20]
@   0x08010b78: 1c38        adds	r0, r7, #0
@   0x08010b7a: 40b0        lsls	r0, r6
@   0x08010b7c: 8d2c        ldrh	r4, [r5, #40]	@ 0x28
@   0x08010b7e: 4384        bics	r4, r0
@   0x08010b80: 1c20        adds	r0, r4, #0
@   0x08010b82: 8528        strh	r0, [r5, #40]	@ 0x28
@   0x08010b84: e012        b.n	0x10bac
@   0x08010b86: 0000        movs	r0, r0
@   0x08010b88: 5330        strh	r0, [r6, r4]
@   0x08010b8a: 0300        lsls	r0, r0, #12
@   0x08010b8c: 4848        ldr	r0, [pc, #288]	@ (0x10cb0)
@   0x08010b8e: 7a81        ldrb	r1, [r0, #10]
@   0x08010b90: 3901        subs	r1, #1
@   0x08010b92: 0088        lsls	r0, r1, #2
@   0x08010b94: 1840        adds	r0, r0, r1
@   0x08010b96: 0080        lsls	r0, r0, #2
@   0x08010b98: 4460        add	r0, ip
@   0x08010b9a: 6800        ldr	r0, [r0, #0]
@   0x08010b9c: 1820        adds	r0, r4, r0
@   0x08010b9e: 6900        ldr	r0, [r0, #16]
@   0x08010ba0: 6840        ldr	r0, [r0, #4]
@   0x08010ba2: 9005        str	r0, [sp, #20]
@   0x08010ba4: 40b2        lsls	r2, r6
@   0x08010ba6: 8d29        ldrh	r1, [r5, #40]	@ 0x28
@   0x08010ba8: 430a        orrs	r2, r1
@   0x08010baa: 852a        strh	r2, [r5, #40]	@ 0x28
@   0x08010bac: 9a05        ldr	r2, [sp, #20]
@   0x08010bae: 4b41        ldr	r3, [pc, #260]	@ (0x10cb4)
@   0x08010bb0: 60da        str	r2, [r3, #12]
@   0x08010bb2: 2200        movs	r2, #0
@   0x08010bb4: 4c3e        ldr	r4, [pc, #248]	@ (0x10cb0)
@   0x08010bb6: 7aa1        ldrb	r1, [r4, #10]
@   0x08010bb8: 3901        subs	r1, #1
@   0x08010bba: 0088        lsls	r0, r1, #2
@   0x08010bbc: 1840        adds	r0, r0, r1
@   0x08010bbe: 0080        lsls	r0, r0, #2
@   0x08010bc0: 4d3d        ldr	r5, [pc, #244]	@ (0x10cb8)
@   0x08010bc2: 1940        adds	r0, r0, r5
@   0x08010bc4: 6801        ldr	r1, [r0, #0]
@   0x08010bc6: 9b08        ldr	r3, [sp, #32]
@   0x08010bc8: 1998        adds	r0, r3, r6
@   0x08010bca: 00c0        lsls	r0, r0, #3
@   0x08010bcc: 1841        adds	r1, r0, r1
@   0x08010bce: 1c74        adds	r4, r6, #1
@   0x08010bd0: 9407        str	r4, [sp, #28]
@   0x08010bd2: 88c9        ldrh	r1, [r1, #6]
@   0x08010bd4: 428a        cmp	r2, r1
@   0x08010bd6: d251        bcs.n	0x10c7c
@   0x08010bd8: 4d35        ldr	r5, [pc, #212]	@ (0x10cb0)
@   0x08010bda: 46a8        mov	r8, r5
@   0x08010bdc: 4936        ldr	r1, [pc, #216]	@ (0x10cb8)
@   0x08010bde: 468c        mov	ip, r1
@   0x08010be0: 9306        str	r3, [sp, #24]
@   0x08010be2: 1c07        adds	r7, r0, #0
@   0x08010be4: 4b33        ldr	r3, [pc, #204]	@ (0x10cb4)
@   0x08010be6: 469a        mov	sl, r3
@   0x08010be8: 2400        movs	r4, #0
@   0x08010bea: 4645        mov	r5, r8
@   0x08010bec: 7aa8        ldrb	r0, [r5, #10]
@   0x08010bee: 3801        subs	r0, #1
@   0x08010bf0: 0081        lsls	r1, r0, #2
@   0x08010bf2: 1809        adds	r1, r1, r0
@   0x08010bf4: 0089        lsls	r1, r1, #2
@   0x08010bf6: 4461        add	r1, ip
@   0x08010bf8: 6808        ldr	r0, [r1, #0]
@   0x08010bfa: 1838        adds	r0, r7, r0
@   0x08010bfc: 3201        adds	r2, #1
@   0x08010bfe: 4691        mov	r9, r2
@   0x08010c00: 8880        ldrh	r0, [r0, #4]
@   0x08010c02: 4284        cmp	r4, r0
@   0x08010c04: d21a        bcs.n	0x10c3c
@   0x08010c06: 4b2b        ldr	r3, [pc, #172]	@ (0x10cb4)
@   0x08010c08: 9906        ldr	r1, [sp, #24]
@   0x08010c0a: 1988        adds	r0, r1, r6
@   0x08010c0c: 00c5        lsls	r5, r0, #3
@   0x08010c0e: 695a        ldr	r2, [r3, #20]
@   0x08010c10: 68d9        ldr	r1, [r3, #12]
@   0x08010c12: 8808        ldrh	r0, [r1, #0]
@   0x08010c14: 8010        strh	r0, [r2, #0]
@   0x08010c16: 3102        adds	r1, #2
@   0x08010c18: 60d9        str	r1, [r3, #12]
@   0x08010c1a: 3202        adds	r2, #2
@   0x08010c1c: 615a        str	r2, [r3, #20]
@   0x08010c1e: 1c60        adds	r0, r4, #1
@   0x08010c20: 0600        lsls	r0, r0, #24
@   0x08010c22: 0e04        lsrs	r4, r0, #24
@   0x08010c24: 4642        mov	r2, r8
@   0x08010c26: 7a91        ldrb	r1, [r2, #10]
@   0x08010c28: 3901        subs	r1, #1
@   0x08010c2a: 0088        lsls	r0, r1, #2
@   0x08010c2c: 1840        adds	r0, r0, r1
@   0x08010c2e: 0080        lsls	r0, r0, #2
@   0x08010c30: 4460        add	r0, ip
@   0x08010c32: 6800        ldr	r0, [r0, #0]
@   0x08010c34: 1828        adds	r0, r5, r0
@   0x08010c36: 8880        ldrh	r0, [r0, #4]
@   0x08010c38: 4284        cmp	r4, r0
@   0x08010c3a: d3e8        bcc.n	0x10c0e
@   0x08010c3c: 4643        mov	r3, r8
@   0x08010c3e: 7a99        ldrb	r1, [r3, #10]
@   0x08010c40: 3901        subs	r1, #1
@   0x08010c42: 0088        lsls	r0, r1, #2
@   0x08010c44: 1840        adds	r0, r0, r1
@   0x08010c46: 0080        lsls	r0, r0, #2
@   0x08010c48: 4460        add	r0, ip
@   0x08010c4a: 6800        ldr	r0, [r0, #0]
@   0x08010c4c: 1838        adds	r0, r7, r0
@   0x08010c4e: 4c1b        ldr	r4, [pc, #108]	@ (0x10cbc)
@   0x08010c50: 8b64        ldrh	r4, [r4, #26]
@   0x08010c52: 8880        ldrh	r0, [r0, #4]
@   0x08010c54: 1a21        subs	r1, r4, r0
@   0x08010c56: 0049        lsls	r1, r1, #1
@   0x08010c58: 4655        mov	r5, sl
@   0x08010c5a: 6968        ldr	r0, [r5, #20]
@   0x08010c5c: 1840        adds	r0, r0, r1
@   0x08010c5e: 6168        str	r0, [r5, #20]
@   0x08010c60: 4649        mov	r1, r9
@   0x08010c62: 0608        lsls	r0, r1, #24
@   0x08010c64: 0e02        lsrs	r2, r0, #24
@   0x08010c66: 7a99        ldrb	r1, [r3, #10]
@   0x08010c68: 3901        subs	r1, #1
@   0x08010c6a: 0088        lsls	r0, r1, #2
@   0x08010c6c: 1840        adds	r0, r0, r1
@   0x08010c6e: 0080        lsls	r0, r0, #2
@   0x08010c70: 4460        add	r0, ip
@   0x08010c72: 6800        ldr	r0, [r0, #0]
@   0x08010c74: 1838        adds	r0, r7, r0
@   0x08010c76: 88c0        ldrh	r0, [r0, #6]
@   0x08010c78: 4282        cmp	r2, r0
@   0x08010c7a: d3b5        bcc.n	0x10be8
@   0x08010c7c: 4a0c        ldr	r2, [pc, #48]	@ (0x10cb0)
@   0x08010c7e: 7a91        ldrb	r1, [r2, #10]
@   0x08010c80: 3901        subs	r1, #1
@   0x08010c82: 0088        lsls	r0, r1, #2
@   0x08010c84: 1840        adds	r0, r0, r1
@   0x08010c86: 0080        lsls	r0, r0, #2
@   0x08010c88: 4b0b        ldr	r3, [pc, #44]	@ (0x10cb8)
@   0x08010c8a: 18c0        adds	r0, r0, r3
@   0x08010c8c: 6801        ldr	r1, [r0, #0]
@   0x08010c8e: 9c08        ldr	r4, [sp, #32]
@   0x08010c90: 19a0        adds	r0, r4, r6
@   0x08010c92: 00c0        lsls	r0, r0, #3
@   0x08010c94: 1840        adds	r0, r0, r1
@   0x08010c96: 7a00        ldrb	r0, [r0, #8]
@   0x08010c98: 0900        lsrs	r0, r0, #4
@   0x08010c9a: 2501        movs	r5, #1
@   0x08010c9c: 4028        ands	r0, r5
@   0x08010c9e: 2800        cmp	r0, #0
@   0x08010ca0: d012        beq.n	0x10cc8
@   0x08010ca2: 4807        ldr	r0, [pc, #28]	@ (0x10cc0)
@   0x08010ca4: 4903        ldr	r1, [pc, #12]	@ (0x10cb4)
@   0x08010ca6: 60c8        str	r0, [r1, #12]
@   0x08010ca8: 4806        ldr	r0, [pc, #24]	@ (0x10cc4)
@   0x08010caa: 6148        str	r0, [r1, #20]
@   0x08010cac: e012        b.n	0x10cd4
@   0x08010cae: 0000        movs	r0, r0
@   0x08010cb0: 5330        strh	r0, [r6, r4]
@   0x08010cb2: 0300        lsls	r0, r0, #12
@   0x08010cb4: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010cb6: 0300        lsls	r0, r0, #12
@   0x08010cb8: 7eb4        ldrb	r4, [r6, #26]
@   0x08010cba: 0830        lsrs	r0, r6, #32
@   0x08010cbc: 60a0        str	r0, [r4, #8]
@   0x08010cbe: 0300        lsls	r0, r0, #12
@   0x08010cc0: 0000        movs	r0, r0
@   0x08010cc2: 0201        lsls	r1, r0, #8
@   0x08010cc4: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08010cc8: 2080        movs	r0, #128	@ 0x80
@   0x08010cca: 0480        lsls	r0, r0, #18
@   0x08010ccc: 4a3c        ldr	r2, [pc, #240]	@ (0x10dc0)
@   0x08010cce: 60d0        str	r0, [r2, #12]
@   0x08010cd0: 483c        ldr	r0, [pc, #240]	@ (0x10dc4)
@   0x08010cd2: 6150        str	r0, [r2, #20]
@   0x08010cd4: 4b3c        ldr	r3, [pc, #240]	@ (0x10dc8)
@   0x08010cd6: 7a99        ldrb	r1, [r3, #10]
@   0x08010cd8: 3901        subs	r1, #1
@   0x08010cda: 0088        lsls	r0, r1, #2
@   0x08010cdc: 1840        adds	r0, r0, r1
@   0x08010cde: 0080        lsls	r0, r0, #2
@   0x08010ce0: 4c3a        ldr	r4, [pc, #232]	@ (0x10dcc)
@   0x08010ce2: 1900        adds	r0, r0, r4
@   0x08010ce4: 6800        ldr	r0, [r0, #0]
@   0x08010ce6: 9d08        ldr	r5, [sp, #32]
@   0x08010ce8: 19ac        adds	r4, r5, r6
@   0x08010cea: 00e4        lsls	r4, r4, #3
@   0x08010cec: 1824        adds	r4, r4, r0
@   0x08010cee: 79a0        ldrb	r0, [r4, #6]
@   0x08010cf0: 7921        ldrb	r1, [r4, #4]
@   0x08010cf2: 8822        ldrh	r2, [r4, #0]
@   0x08010cf4: 8863        ldrh	r3, [r4, #2]
@   0x08010cf6: 7a24        ldrb	r4, [r4, #8]
@   0x08010cf8: 0924        lsrs	r4, r4, #4
@   0x08010cfa: 2501        movs	r5, #1
@   0x08010cfc: 402c        ands	r4, r5
@   0x08010cfe: 9400        str	r4, [sp, #0]
@   0x08010d00: 9c05        ldr	r4, [sp, #20]
@   0x08010d02: 9401        str	r4, [sp, #4]
@   0x08010d04: 4d2e        ldr	r5, [pc, #184]	@ (0x10dc0)
@   0x08010d06: 696c        ldr	r4, [r5, #20]
@   0x08010d08: 9402        str	r4, [sp, #8]
@   0x08010d0a: f7ff        faa7 	bl	0x1025c
@   0x08010d0e: 9907        ldr	r1, [sp, #28]
@   0x08010d10: 0608        lsls	r0, r1, #24
@   0x08010d12: 0e06        lsrs	r6, r0, #24
@   0x08010d14: 9a03        ldr	r2, [sp, #12]
@   0x08010d16: 4296        cmp	r6, r2
@   0x08010d18: d200        bcs.n	0x10d1c
@   0x08010d1a: e6aa        b.n	0x10a72
@   0x08010d1c: 492c        ldr	r1, [pc, #176]	@ (0x10dd0)
@   0x08010d1e: 312a        adds	r1, #42	@ 0x2a
@   0x08010d20: 482b        ldr	r0, [pc, #172]	@ (0x10dd0)
@   0x08010d22: 302b        adds	r0, #43	@ 0x2b
@   0x08010d24: 7809        ldrb	r1, [r1, #0]
@   0x08010d26: 7800        ldrb	r0, [r0, #0]
@   0x08010d28: 4281        cmp	r1, r0
@   0x08010d2a: d024        beq.n	0x10d76
@   0x08010d2c: 2600        movs	r6, #0
@   0x08010d2e: 9b04        ldr	r3, [sp, #16]
@   0x08010d30: 429e        cmp	r6, r3
@   0x08010d32: d220        bcs.n	0x10d76
@   0x08010d34: 4c24        ldr	r4, [pc, #144]	@ (0x10dc8)
@   0x08010d36: 4d27        ldr	r5, [pc, #156]	@ (0x10dd4)
@   0x08010d38: 2e00        cmp	r6, #0
@   0x08010d3a: d105        bne.n	0x10d48
@   0x08010d3c: 7aa0        ldrb	r0, [r4, #10]
@   0x08010d3e: 280b        cmp	r0, #11
@   0x08010d40: d005        beq.n	0x10d4e
@   0x08010d42: 200b        movs	r0, #11
@   0x08010d44: f010        f83e 	bl	0x20dc4
@   0x08010d48: 7aa1        ldrb	r1, [r4, #10]
@   0x08010d4a: 290b        cmp	r1, #11
@   0x08010d4c: d102        bne.n	0x10d54
@   0x08010d4e: 205f        movs	r0, #95	@ 0x5f
@   0x08010d50: f00f        ff92 	bl	0x20c78
@   0x08010d54: 7aa1        ldrb	r1, [r4, #10]
@   0x08010d56: 3901        subs	r1, #1
@   0x08010d58: 0088        lsls	r0, r1, #2
@   0x08010d5a: 1840        adds	r0, r0, r1
@   0x08010d5c: 0080        lsls	r0, r0, #2
@   0x08010d5e: 1940        adds	r0, r0, r5
@   0x08010d60: 6800        ldr	r0, [r0, #0]
@   0x08010d62: 1c31        adds	r1, r6, #0
@   0x08010d64: 2201        movs	r2, #1
@   0x08010d66: f000        f837 	bl	0x10dd8
@   0x08010d6a: 1c70        adds	r0, r6, #1
@   0x08010d6c: 0600        lsls	r0, r0, #24
@   0x08010d6e: 0e06        lsrs	r6, r0, #24
@   0x08010d70: 9a04        ldr	r2, [sp, #16]
@   0x08010d72: 4296        cmp	r6, r2
@   0x08010d74: d3e0        bcc.n	0x10d38
@   0x08010d76: 4912        ldr	r1, [pc, #72]	@ (0x10dc0)
@   0x08010d78: 7808        ldrb	r0, [r1, #0]
@   0x08010d7a: 2800        cmp	r0, #0
@   0x08010d7c: d018        beq.n	0x10db0
@   0x08010d7e: 7888        ldrb	r0, [r1, #2]
@   0x08010d80: 2800        cmp	r0, #0
@   0x08010d82: d015        beq.n	0x10db0
@   0x08010d84: 2600        movs	r6, #0
@   0x08010d86: 9b04        ldr	r3, [sp, #16]
@   0x08010d88: 429e        cmp	r6, r3
@   0x08010d8a: d211        bcs.n	0x10db0
@   0x08010d8c: 4c11        ldr	r4, [pc, #68]	@ (0x10dd4)
@   0x08010d8e: 480e        ldr	r0, [pc, #56]	@ (0x10dc8)
@   0x08010d90: 7a81        ldrb	r1, [r0, #10]
@   0x08010d92: 3901        subs	r1, #1
@   0x08010d94: 0088        lsls	r0, r1, #2
@   0x08010d96: 1840        adds	r0, r0, r1
@   0x08010d98: 0080        lsls	r0, r0, #2
@   0x08010d9a: 1900        adds	r0, r0, r4
@   0x08010d9c: 6800        ldr	r0, [r0, #0]
@   0x08010d9e: 1c31        adds	r1, r6, #0
@   0x08010da0: f000        f8e0 	bl	0x10f64
@   0x08010da4: 1c70        adds	r0, r6, #1
@   0x08010da6: 0600        lsls	r0, r0, #24
@   0x08010da8: 0e06        lsrs	r6, r0, #24
@   0x08010daa: 9d04        ldr	r5, [sp, #16]
@   0x08010dac: 42ae        cmp	r6, r5
@   0x08010dae: d3ee        bcc.n	0x10d8e
@   0x08010db0: b009        add	sp, #36	@ 0x24
@   0x08010db2: bc38        pop	{r3, r4, r5}
@   0x08010db4: 4698        mov	r8, r3
@   0x08010db6: 46a1        mov	r9, r4
@   0x08010db8: 46aa        mov	sl, r5
@   0x08010dba: bcf0        pop	{r4, r5, r6, r7}
@   0x08010dbc: bc01        pop	{r0}
@   0x08010dbe: 4700        bx	r0
@   0x08010dc0: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08010dc2: 0300        lsls	r0, r0, #12
@   0x08010dc4: e000        b.n	0x10dc8
@   0x08010dc6: 0600        lsls	r0, r0, #24
@   0x08010dc8: 5330        strh	r0, [r6, r4]
@   0x08010dca: 0300        lsls	r0, r0, #12
@   0x08010dcc: 7eb4        ldrb	r4, [r6, #26]
@   0x08010dce: 0830        lsrs	r0, r6, #32
@   0x08010dd0: 6110        str	r0, [r2, #16]
@   0x08010dd2: 0300        lsls	r0, r0, #12
@   0x08010dd4: 7ebc        ldrb	r4, [r7, #26]
@   0x08010dd6: 0830        lsrs	r0, r6, #32

        thumb_func_start Scroll_TickChannels
Scroll_TickChannels: @ 0x08010a44
        .incbin "frog_us_baserom.gba", 0x10a44, 0x394
        thumb_func_end Scroll_TickChannels
