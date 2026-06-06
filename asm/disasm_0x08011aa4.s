@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011aa4, 0x08011e40)  (924 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011aa4 --end 0x8011e40 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011aa4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08011aa6: 4657        mov	r7, sl
@   0x08011aa8: 464e        mov	r6, r9
@   0x08011aaa: 4645        mov	r5, r8
@   0x08011aac: b4e0        push	{r5, r6, r7}
@   0x08011aae: b085        sub	sp, #20
@   0x08011ab0: 9003        str	r0, [sp, #12]
@   0x08011ab2: 2000        movs	r0, #0
@   0x08011ab4: 9004        str	r0, [sp, #16]
@   0x08011ab6: 4e7c        ldr	r6, [pc, #496]	@ (0x11ca8)
@   0x08011ab8: 7830        ldrb	r0, [r6, #0]
@   0x08011aba: 2800        cmp	r0, #0
@   0x08011abc: d100        bne.n	0x11ac0
@   0x08011abe: e140        b.n	0x11d42
@   0x08011ac0: 2008        movs	r0, #8
@   0x08011ac2: f00f        f97f 	bl	0x20dc4
@   0x08011ac6: 4f79        ldr	r7, [pc, #484]	@ (0x11cac)
@   0x08011ac8: 4d79        ldr	r5, [pc, #484]	@ (0x11cb0)
@   0x08011aca: 6838        ldr	r0, [r7, #0]
@   0x08011acc: 6869        ldr	r1, [r5, #4]
@   0x08011ace: 1a40        subs	r0, r0, r1
@   0x08011ad0: 7ae9        ldrb	r1, [r5, #11]
@   0x08011ad2: 4288        cmp	r0, r1
@   0x08011ad4: d33c        bcc.n	0x11b50
@   0x08011ad6: 4977        ldr	r1, [pc, #476]	@ (0x11cb4)
@   0x08011ad8: 7aaa        ldrb	r2, [r5, #10]
@   0x08011ada: 4b77        ldr	r3, [pc, #476]	@ (0x11cb8)
@   0x08011adc: 18c8        adds	r0, r1, r3
@   0x08011ade: 7002        strb	r2, [r0, #0]
@   0x08011ae0: 4b76        ldr	r3, [pc, #472]	@ (0x11cbc)
@   0x08011ae2: 9c04        ldr	r4, [sp, #16]
@   0x08011ae4: 9400        str	r4, [sp, #0]
@   0x08011ae6: 20d2        movs	r0, #210	@ 0xd2
@   0x08011ae8: 0140        lsls	r0, r0, #5
@   0x08011aea: 1809        adds	r1, r1, r0
@   0x08011aec: 9101        str	r1, [sp, #4]
@   0x08011aee: 6818        ldr	r0, [r3, #0]
@   0x08011af0: 6859        ldr	r1, [r3, #4]
@   0x08011af2: 689a        ldr	r2, [r3, #8]
@   0x08011af4: 68db        ldr	r3, [r3, #12]
@   0x08011af6: f004        f8e1 	bl	0x15cbc
@   0x08011afa: 4b71        ldr	r3, [pc, #452]	@ (0x11cc0)
@   0x08011afc: 2454        movs	r4, #84	@ 0x54
@   0x08011afe: 78b2        ldrb	r2, [r6, #2]
@   0x08011b00: 1c11        adds	r1, r2, #0
@   0x08011b02: 4361        muls	r1, r4
@   0x08011b04: 9803        ldr	r0, [sp, #12]
@   0x08011b06: 1809        adds	r1, r1, r0
@   0x08011b08: 7aa8        ldrb	r0, [r5, #10]
@   0x08011b0a: 1c42        adds	r2, r0, #1
@   0x08011b0c: 72aa        strb	r2, [r5, #10]
@   0x08011b0e: 0600        lsls	r0, r0, #24
@   0x08011b10: 6949        ldr	r1, [r1, #20]
@   0x08011b12: 0d80        lsrs	r0, r0, #22
@   0x08011b14: 1840        adds	r0, r0, r1
@   0x08011b16: 6800        ldr	r0, [r0, #0]
@   0x08011b18: 6018        str	r0, [r3, #0]
@   0x08011b1a: 78b1        ldrb	r1, [r6, #2]
@   0x08011b1c: 1c08        adds	r0, r1, #0
@   0x08011b1e: 4360        muls	r0, r4
@   0x08011b20: 9c03        ldr	r4, [sp, #12]
@   0x08011b22: 1900        adds	r0, r0, r4
@   0x08011b24: 6980        ldr	r0, [r0, #24]
@   0x08011b26: 6058        str	r0, [r3, #4]
@   0x08011b28: 202c        movs	r0, #44	@ 0x2c
@   0x08011b2a: 5e31        ldrsh	r1, [r6, r0]
@   0x08011b2c: 242e        movs	r4, #46	@ 0x2e
@   0x08011b2e: 5f28        ldrsh	r0, [r5, r4]
@   0x08011b30: 4348        muls	r0, r1
@   0x08011b32: 0100        lsls	r0, r0, #4
@   0x08011b34: 2180        movs	r1, #128	@ 0x80
@   0x08011b36: 0609        lsls	r1, r1, #24
@   0x08011b38: 4308        orrs	r0, r1
@   0x08011b3a: 6098        str	r0, [r3, #8]
@   0x08011b3c: 6898        ldr	r0, [r3, #8]
@   0x08011b3e: 0612        lsls	r2, r2, #24
@   0x08011b40: 0e12        lsrs	r2, r2, #24
@   0x08011b42: 2a07        cmp	r2, #7
@   0x08011b44: d902        bls.n	0x11b4c
@   0x08011b46: 466e        mov	r6, sp
@   0x08011b48: 7c36        ldrb	r6, [r6, #16]
@   0x08011b4a: 72ae        strb	r6, [r5, #10]
@   0x08011b4c: 6838        ldr	r0, [r7, #0]
@   0x08011b4e: 6068        str	r0, [r5, #4]
@   0x08011b50: 4b55        ldr	r3, [pc, #340]	@ (0x11ca8)
@   0x08011b52: 7a5f        ldrb	r7, [r3, #9]
@   0x08011b54: 2f01        cmp	r7, #1
@   0x08011b56: d000        beq.n	0x11b5a
@   0x08011b58: e0ed        b.n	0x11d36
@   0x08011b5a: 4855        ldr	r0, [pc, #340]	@ (0x11cb0)
@   0x08011b5c: 7a81        ldrb	r1, [r0, #10]
@   0x08011b5e: 4681        mov	r9, r0
@   0x08011b60: 2900        cmp	r1, #0
@   0x08011b62: d000        beq.n	0x11b66
@   0x08011b64: e0e7        b.n	0x11d36
@   0x08011b66: 6999        ldr	r1, [r3, #24]
@   0x08011b68: 6159        str	r1, [r3, #20]
@   0x08011b6a: 4a56        ldr	r2, [pc, #344]	@ (0x11cc4)
@   0x08011b6c: 1c04        adds	r4, r0, #0
@   0x08011b6e: 8e64        ldrh	r4, [r4, #50]	@ 0x32
@   0x08011b70: 8b55        ldrh	r5, [r2, #26]
@   0x08011b72: 1c20        adds	r0, r4, #0
@   0x08011b74: 4368        muls	r0, r5
@   0x08011b76: 0040        lsls	r0, r0, #1
@   0x08011b78: 1808        adds	r0, r1, r0
@   0x08011b7a: 6198        str	r0, [r3, #24]
@   0x08011b7c: 691e        ldr	r6, [r3, #16]
@   0x08011b7e: 46b0        mov	r8, r6
@   0x08011b80: 1c0d        adds	r5, r1, #0
@   0x08011b82: 272e        movs	r7, #46	@ 0x2e
@   0x08011b84: 5fd8        ldrsh	r0, [r3, r7]
@   0x08011b86: 1c13        adds	r3, r2, #0
@   0x08011b88: 464a        mov	r2, r9
@   0x08011b8a: 8e51        ldrh	r1, [r2, #50]	@ 0x32
@   0x08011b8c: 2800        cmp	r0, #0
@   0x08011b8e: d100        bne.n	0x11b92
@   0x08011b90: e0bc        b.n	0x11d0c
@   0x08011b92: 1c0e        adds	r6, r1, #0
@   0x08011b94: 8e12        ldrh	r2, [r2, #48]	@ 0x30
@   0x08011b96: 4644        mov	r4, r8
@   0x08011b98: 1c29        adds	r1, r5, #0
@   0x08011b9a: 2000        movs	r0, #0
@   0x08011b9c: 4d43        ldr	r5, [pc, #268]	@ (0x11cac)
@   0x08011b9e: 46a9        mov	r9, r5
@   0x08011ba0: 42b0        cmp	r0, r6
@   0x08011ba2: d215        bcs.n	0x11bd0
@   0x08011ba4: 1c1f        adds	r7, r3, #0
@   0x08011ba6: 2300        movs	r3, #0
@   0x08011ba8: 1c45        adds	r5, r0, #1
@   0x08011baa: 4293        cmp	r3, r2
@   0x08011bac: d208        bcs.n	0x11bc0
@   0x08011bae: 8820        ldrh	r0, [r4, #0]
@   0x08011bb0: 8008        strh	r0, [r1, #0]
@   0x08011bb2: 3402        adds	r4, #2
@   0x08011bb4: 3102        adds	r1, #2
@   0x08011bb6: 1c58        adds	r0, r3, #1
@   0x08011bb8: 0400        lsls	r0, r0, #16
@   0x08011bba: 0c03        lsrs	r3, r0, #16
@   0x08011bbc: 4293        cmp	r3, r2
@   0x08011bbe: d3f6        bcc.n	0x11bae
@   0x08011bc0: 8b7b        ldrh	r3, [r7, #26]
@   0x08011bc2: 1a98        subs	r0, r3, r2
@   0x08011bc4: 0040        lsls	r0, r0, #1
@   0x08011bc6: 1809        adds	r1, r1, r0
@   0x08011bc8: 0428        lsls	r0, r5, #16
@   0x08011bca: 0c00        lsrs	r0, r0, #16
@   0x08011bcc: 42b0        cmp	r0, r6
@   0x08011bce: d3ea        bcc.n	0x11ba6
@   0x08011bd0: 4e35        ldr	r6, [pc, #212]	@ (0x11ca8)
@   0x08011bd2: 8df0        ldrh	r0, [r6, #46]	@ 0x2e
@   0x08011bd4: 3801        subs	r0, #1
@   0x08011bd6: 85f0        strh	r0, [r6, #46]	@ 0x2e
@   0x08011bd8: 464c        mov	r4, r9
@   0x08011bda: 6820        ldr	r0, [r4, #0]
@   0x08011bdc: 6070        str	r0, [r6, #4]
@   0x08011bde: 4d3a        ldr	r5, [pc, #232]	@ (0x11cc8)
@   0x08011be0: 4f33        ldr	r7, [pc, #204]	@ (0x11cb0)
@   0x08011be2: 8e79        ldrh	r1, [r7, #50]	@ 0x32
@   0x08011be4: 0608        lsls	r0, r1, #24
@   0x08011be6: 0e00        lsrs	r0, r0, #24
@   0x08011be8: 8e3a        ldrh	r2, [r7, #48]	@ 0x30
@   0x08011bea: 0611        lsls	r1, r2, #24
@   0x08011bec: 0e09        lsrs	r1, r1, #24
@   0x08011bee: 8eb2        ldrh	r2, [r6, #52]	@ 0x34
@   0x08011bf0: 8ef3        ldrh	r3, [r6, #54]	@ 0x36
@   0x08011bf2: 2402        movs	r4, #2
@   0x08011bf4: 9400        str	r4, [sp, #0]
@   0x08011bf6: 4644        mov	r4, r8
@   0x08011bf8: 9401        str	r4, [sp, #4]
@   0x08011bfa: 9502        str	r5, [sp, #8]
@   0x08011bfc: f7fe        fb2e 	bl	0x1025c
@   0x08011c00: 7ab9        ldrb	r1, [r7, #10]
@   0x08011c02: 2900        cmp	r1, #0
@   0x08011c04: d11c        bne.n	0x11c40
@   0x08011c06: 4a2e        ldr	r2, [pc, #184]	@ (0x11cc0)
@   0x08011c08: 2354        movs	r3, #84	@ 0x54
@   0x08011c0a: 78b5        ldrb	r5, [r6, #2]
@   0x08011c0c: 1c28        adds	r0, r5, #0
@   0x08011c0e: 4358        muls	r0, r3
@   0x08011c10: 9c03        ldr	r4, [sp, #12]
@   0x08011c12: 1900        adds	r0, r0, r4
@   0x08011c14: 3101        adds	r1, #1
@   0x08011c16: 72b9        strb	r1, [r7, #10]
@   0x08011c18: 6940        ldr	r0, [r0, #20]
@   0x08011c1a: 6800        ldr	r0, [r0, #0]
@   0x08011c1c: 6010        str	r0, [r2, #0]
@   0x08011c1e: 78b5        ldrb	r5, [r6, #2]
@   0x08011c20: 1c28        adds	r0, r5, #0
@   0x08011c22: 4358        muls	r0, r3
@   0x08011c24: 1900        adds	r0, r0, r4
@   0x08011c26: 6980        ldr	r0, [r0, #24]
@   0x08011c28: 6050        str	r0, [r2, #4]
@   0x08011c2a: 202c        movs	r0, #44	@ 0x2c
@   0x08011c2c: 5e31        ldrsh	r1, [r6, r0]
@   0x08011c2e: 232e        movs	r3, #46	@ 0x2e
@   0x08011c30: 5ef8        ldrsh	r0, [r7, r3]
@   0x08011c32: 4348        muls	r0, r1
@   0x08011c34: 0100        lsls	r0, r0, #4
@   0x08011c36: 2180        movs	r1, #128	@ 0x80
@   0x08011c38: 0609        lsls	r1, r1, #24
@   0x08011c3a: 4308        orrs	r0, r1
@   0x08011c3c: 6090        str	r0, [r2, #8]
@   0x08011c3e: 6890        ldr	r0, [r2, #8]
@   0x08011c40: 693c        ldr	r4, [r7, #16]
@   0x08011c42: 46a0        mov	r8, r4
@   0x08011c44: 69b5        ldr	r5, [r6, #24]
@   0x08011c46: 212e        movs	r1, #46	@ 0x2e
@   0x08011c48: 5e70        ldrsh	r0, [r6, r1]
@   0x08011c4a: 2800        cmp	r0, #0
@   0x08011c4c: d140        bne.n	0x11cd0
@   0x08011c4e: 2201        movs	r2, #1
@   0x08011c50: 9204        str	r2, [sp, #16]
@   0x08011c52: 4a1e        ldr	r2, [pc, #120]	@ (0x11ccc)
@   0x08011c54: 78b3        ldrb	r3, [r6, #2]
@   0x08011c56: 0059        lsls	r1, r3, #1
@   0x08011c58: 18c9        adds	r1, r1, r3
@   0x08011c5a: 3102        adds	r1, #2
@   0x08011c5c: 00c8        lsls	r0, r1, #3
@   0x08011c5e: 1a40        subs	r0, r0, r1
@   0x08011c60: 0080        lsls	r0, r0, #2
@   0x08011c62: 3210        adds	r2, #16
@   0x08011c64: 1880        adds	r0, r0, r2
@   0x08011c66: 6800        ldr	r0, [r0, #0]
@   0x08011c68: 4680        mov	r8, r0
@   0x08011c6a: 8e7e        ldrh	r6, [r7, #50]	@ 0x32
@   0x08011c6c: 8e3c        ldrh	r4, [r7, #48]	@ 0x30
@   0x08011c6e: 4643        mov	r3, r8
@   0x08011c70: 1c29        adds	r1, r5, #0
@   0x08011c72: 2000        movs	r0, #0
@   0x08011c74: 46b9        mov	r9, r7
@   0x08011c76: 42b0        cmp	r0, r6
@   0x08011c78: d248        bcs.n	0x11d0c
@   0x08011c7a: 4f12        ldr	r7, [pc, #72]	@ (0x11cc4)
@   0x08011c7c: 2200        movs	r2, #0
@   0x08011c7e: 1c45        adds	r5, r0, #1
@   0x08011c80: 42a2        cmp	r2, r4
@   0x08011c82: d208        bcs.n	0x11c96
@   0x08011c84: 8818        ldrh	r0, [r3, #0]
@   0x08011c86: 8008        strh	r0, [r1, #0]
@   0x08011c88: 3302        adds	r3, #2
@   0x08011c8a: 3102        adds	r1, #2
@   0x08011c8c: 1c50        adds	r0, r2, #1
@   0x08011c8e: 0400        lsls	r0, r0, #16
@   0x08011c90: 0c02        lsrs	r2, r0, #16
@   0x08011c92: 42a2        cmp	r2, r4
@   0x08011c94: d3f6        bcc.n	0x11c84
@   0x08011c96: 8b7a        ldrh	r2, [r7, #26]
@   0x08011c98: 1b10        subs	r0, r2, r4
@   0x08011c9a: 0040        lsls	r0, r0, #1
@   0x08011c9c: 1809        adds	r1, r1, r0
@   0x08011c9e: 0428        lsls	r0, r5, #16
@   0x08011ca0: 0c00        lsrs	r0, r0, #16
@   0x08011ca2: 42b0        cmp	r0, r6
@   0x08011ca4: d3ea        bcc.n	0x11c7c
@   0x08011ca6: e031        b.n	0x11d0c
@   0x08011ca8: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08011caa: 0300        lsls	r0, r0, #12
@   0x08011cac: 5330        strh	r0, [r6, r4]
@   0x08011cae: 0300        lsls	r0, r0, #12
@   0x08011cb0: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08011cb2: 0300        lsls	r0, r0, #12
@   0x08011cb4: 3720        adds	r7, #32
@   0x08011cb6: 0300        lsls	r0, r0, #12
@   0x08011cb8: 1a5b        subs	r3, r3, r1
@   0x08011cba: 0000        movs	r0, r0
@   0x08011cbc: 6cd0        ldr	r0, [r2, #76]	@ 0x4c
@   0x08011cbe: 0830        lsrs	r0, r6, #32
@   0x08011cc0: 00d4        lsls	r4, r2, #3
@   0x08011cc2: 0400        lsls	r0, r0, #16
@   0x08011cc4: 60a0        str	r0, [r4, #8]
@   0x08011cc6: 0300        lsls	r0, r0, #12
@   0x08011cc8: f000        0600 	and.w	r6, r0, #0
@   0x08011ccc: 6d40        ldr	r0, [r0, #84]	@ 0x54
@   0x08011cce: 0830        lsrs	r0, r6, #32
@   0x08011cd0: 8e7e        ldrh	r6, [r7, #50]	@ 0x32
@   0x08011cd2: 8e3c        ldrh	r4, [r7, #48]	@ 0x30
@   0x08011cd4: 4643        mov	r3, r8
@   0x08011cd6: 1c29        adds	r1, r5, #0
@   0x08011cd8: 2000        movs	r0, #0
@   0x08011cda: 46b9        mov	r9, r7
@   0x08011cdc: 42b0        cmp	r0, r6
@   0x08011cde: d215        bcs.n	0x11d0c
@   0x08011ce0: 4f4c        ldr	r7, [pc, #304]	@ (0x11e14)
@   0x08011ce2: 2200        movs	r2, #0
@   0x08011ce4: 1c45        adds	r5, r0, #1
@   0x08011ce6: 42a2        cmp	r2, r4
@   0x08011ce8: d208        bcs.n	0x11cfc
@   0x08011cea: 8818        ldrh	r0, [r3, #0]
@   0x08011cec: 8008        strh	r0, [r1, #0]
@   0x08011cee: 3302        adds	r3, #2
@   0x08011cf0: 3102        adds	r1, #2
@   0x08011cf2: 1c50        adds	r0, r2, #1
@   0x08011cf4: 0400        lsls	r0, r0, #16
@   0x08011cf6: 0c02        lsrs	r2, r0, #16
@   0x08011cf8: 42a2        cmp	r2, r4
@   0x08011cfa: d3f6        bcc.n	0x11cea
@   0x08011cfc: 8b7a        ldrh	r2, [r7, #26]
@   0x08011cfe: 1b10        subs	r0, r2, r4
@   0x08011d00: 0040        lsls	r0, r0, #1
@   0x08011d02: 1809        adds	r1, r1, r0
@   0x08011d04: 0428        lsls	r0, r5, #16
@   0x08011d06: 0c00        lsrs	r0, r0, #16
@   0x08011d08: 42b0        cmp	r0, r6
@   0x08011d0a: d3ea        bcc.n	0x11ce2
@   0x08011d0c: 4b42        ldr	r3, [pc, #264]	@ (0x11e18)
@   0x08011d0e: 464c        mov	r4, r9
@   0x08011d10: 8e60        ldrh	r0, [r4, #50]	@ 0x32
@   0x08011d12: 8edd        ldrh	r5, [r3, #54]	@ 0x36
@   0x08011d14: 1941        adds	r1, r0, r5
@   0x08011d16: 86d9        strh	r1, [r3, #54]	@ 0x36
@   0x08011d18: 4d40        ldr	r5, [pc, #256]	@ (0x11e1c)
@   0x08011d1a: 0600        lsls	r0, r0, #24
@   0x08011d1c: 0e00        lsrs	r0, r0, #24
@   0x08011d1e: 8e26        ldrh	r6, [r4, #48]	@ 0x30
@   0x08011d20: 0631        lsls	r1, r6, #24
@   0x08011d22: 0e09        lsrs	r1, r1, #24
@   0x08011d24: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x08011d26: 8edb        ldrh	r3, [r3, #54]	@ 0x36
@   0x08011d28: 2402        movs	r4, #2
@   0x08011d2a: 9400        str	r4, [sp, #0]
@   0x08011d2c: 4647        mov	r7, r8
@   0x08011d2e: 9701        str	r7, [sp, #4]
@   0x08011d30: 9502        str	r5, [sp, #8]
@   0x08011d32: f7fe        fa93 	bl	0x1025c
@   0x08011d36: 4938        ldr	r1, [pc, #224]	@ (0x11e18)
@   0x08011d38: 222e        movs	r2, #46	@ 0x2e
@   0x08011d3a: 5e88        ldrsh	r0, [r1, r2]
@   0x08011d3c: 2800        cmp	r0, #0
@   0x08011d3e: d100        bne.n	0x11d42
@   0x08011d40: 7008        strb	r0, [r1, #0]
@   0x08011d42: 2300        movs	r3, #0
@   0x08011d44: 4698        mov	r8, r3
@   0x08011d46: 4c34        ldr	r4, [pc, #208]	@ (0x11e18)
@   0x08011d48: 46a1        mov	r9, r4
@   0x08011d4a: 4e35        ldr	r6, [pc, #212]	@ (0x11e20)
@   0x08011d4c: 464f        mov	r7, r9
@   0x08011d4e: 783d        ldrb	r5, [r7, #0]
@   0x08011d50: 2d00        cmp	r5, #0
@   0x08011d52: d14f        bne.n	0x11df4
@   0x08011d54: 4833        ldr	r0, [pc, #204]	@ (0x11e24)
@   0x08011d56: 302b        adds	r0, #43	@ 0x2b
@   0x08011d58: 7800        ldrb	r0, [r0, #0]
@   0x08011d5a: 4641        mov	r1, r8
@   0x08011d5c: 4108        asrs	r0, r1
@   0x08011d5e: 2101        movs	r1, #1
@   0x08011d60: 4008        ands	r0, r1
@   0x08011d62: 2800        cmp	r0, #0
@   0x08011d64: d046        beq.n	0x11df4
@   0x08011d66: 4a30        ldr	r2, [pc, #192]	@ (0x11e28)
@   0x08011d68: 4692        mov	sl, r2
@   0x08011d6a: 4c30        ldr	r4, [pc, #192]	@ (0x11e2c)
@   0x08011d6c: 6810        ldr	r0, [r2, #0]
@   0x08011d6e: 6861        ldr	r1, [r4, #4]
@   0x08011d70: 1a40        subs	r0, r0, r1
@   0x08011d72: 7ae3        ldrb	r3, [r4, #11]
@   0x08011d74: 4298        cmp	r0, r3
@   0x08011d76: d33d        bcc.n	0x11df4
@   0x08011d78: 7aa1        ldrb	r1, [r4, #10]
@   0x08011d7a: 4f2d        ldr	r7, [pc, #180]	@ (0x11e30)
@   0x08011d7c: 4a2d        ldr	r2, [pc, #180]	@ (0x11e34)
@   0x08011d7e: 18b8        adds	r0, r7, r2
@   0x08011d80: 7001        strb	r1, [r0, #0]
@   0x08011d82: 9500        str	r5, [sp, #0]
@   0x08011d84: 4b2c        ldr	r3, [pc, #176]	@ (0x11e38)
@   0x08011d86: 9301        str	r3, [sp, #4]
@   0x08011d88: 6830        ldr	r0, [r6, #0]
@   0x08011d8a: 6871        ldr	r1, [r6, #4]
@   0x08011d8c: 68b2        ldr	r2, [r6, #8]
@   0x08011d8e: 68f3        ldr	r3, [r6, #12]
@   0x08011d90: f003        ff94 	bl	0x15cbc
@   0x08011d94: 464f        mov	r7, r9
@   0x08011d96: 78bf        ldrb	r7, [r7, #2]
@   0x08011d98: 2054        movs	r0, #84	@ 0x54
@   0x08011d9a: 1c39        adds	r1, r7, #0
@   0x08011d9c: 4341        muls	r1, r0
@   0x08011d9e: 9a03        ldr	r2, [sp, #12]
@   0x08011da0: 1889        adds	r1, r1, r2
@   0x08011da2: 7aa0        ldrb	r0, [r4, #10]
@   0x08011da4: 1c42        adds	r2, r0, #1
@   0x08011da6: 72a2        strb	r2, [r4, #10]
@   0x08011da8: 0600        lsls	r0, r0, #24
@   0x08011daa: 6cc9        ldr	r1, [r1, #76]	@ 0x4c
@   0x08011dac: 0d80        lsrs	r0, r0, #22
@   0x08011dae: 1840        adds	r0, r0, r1
@   0x08011db0: 6800        ldr	r0, [r0, #0]
@   0x08011db2: 4b22        ldr	r3, [pc, #136]	@ (0x11e3c)
@   0x08011db4: 6018        str	r0, [r3, #0]
@   0x08011db6: 464f        mov	r7, r9
@   0x08011db8: 78bf        ldrb	r7, [r7, #2]
@   0x08011dba: 2154        movs	r1, #84	@ 0x54
@   0x08011dbc: 1c38        adds	r0, r7, #0
@   0x08011dbe: 4348        muls	r0, r1
@   0x08011dc0: 9b03        ldr	r3, [sp, #12]
@   0x08011dc2: 18c0        adds	r0, r0, r3
@   0x08011dc4: 6d00        ldr	r0, [r0, #80]	@ 0x50
@   0x08011dc6: 4f1d        ldr	r7, [pc, #116]	@ (0x11e3c)
@   0x08011dc8: 6078        str	r0, [r7, #4]
@   0x08011dca: 4648        mov	r0, r9
@   0x08011dcc: 232c        movs	r3, #44	@ 0x2c
@   0x08011dce: 5ec1        ldrsh	r1, [r0, r3]
@   0x08011dd0: 272e        movs	r7, #46	@ 0x2e
@   0x08011dd2: 5fe0        ldrsh	r0, [r4, r7]
@   0x08011dd4: 4348        muls	r0, r1
@   0x08011dd6: 0100        lsls	r0, r0, #4
@   0x08011dd8: 2180        movs	r1, #128	@ 0x80
@   0x08011dda: 0609        lsls	r1, r1, #24
@   0x08011ddc: 4308        orrs	r0, r1
@   0x08011dde: 4917        ldr	r1, [pc, #92]	@ (0x11e3c)
@   0x08011de0: 6088        str	r0, [r1, #8]
@   0x08011de2: 6888        ldr	r0, [r1, #8]
@   0x08011de4: 0612        lsls	r2, r2, #24
@   0x08011de6: 0e12        lsrs	r2, r2, #24
@   0x08011de8: 2a07        cmp	r2, #7
@   0x08011dea: d900        bls.n	0x11dee
@   0x08011dec: 72a5        strb	r5, [r4, #10]
@   0x08011dee: 4652        mov	r2, sl
@   0x08011df0: 6810        ldr	r0, [r2, #0]
@   0x08011df2: 6060        str	r0, [r4, #4]
@   0x08011df4: 4640        mov	r0, r8
@   0x08011df6: 3001        adds	r0, #1
@   0x08011df8: 0400        lsls	r0, r0, #16
@   0x08011dfa: 0c00        lsrs	r0, r0, #16
@   0x08011dfc: 4680        mov	r8, r0
@   0x08011dfe: 280f        cmp	r0, #15
@   0x08011e00: d9a4        bls.n	0x11d4c
@   0x08011e02: 9804        ldr	r0, [sp, #16]
@   0x08011e04: b005        add	sp, #20
@   0x08011e06: bc38        pop	{r3, r4, r5}
@   0x08011e08: 4698        mov	r8, r3
@   0x08011e0a: 46a1        mov	r9, r4
@   0x08011e0c: 46aa        mov	sl, r5
@   0x08011e0e: bcf0        pop	{r4, r5, r6, r7}
@   0x08011e10: bc02        pop	{r1}
@   0x08011e12: 4708        bx	r1
@   0x08011e14: 60a0        str	r0, [r4, #8]
@   0x08011e16: 0300        lsls	r0, r0, #12
@   0x08011e18: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08011e1a: 0300        lsls	r0, r0, #12
@   0x08011e1c: f000        0600 	and.w	r6, r0, #0
@   0x08011e20: 6cd0        ldr	r0, [r2, #76]	@ 0x4c
@   0x08011e22: 0830        lsrs	r0, r6, #32
@   0x08011e24: 6110        str	r0, [r2, #16]
@   0x08011e26: 0300        lsls	r0, r0, #12
@   0x08011e28: 5330        strh	r0, [r6, r4]
@   0x08011e2a: 0300        lsls	r0, r0, #12
@   0x08011e2c: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08011e2e: 0300        lsls	r0, r0, #12
@   0x08011e30: 3720        adds	r7, #32
@   0x08011e32: 0300        lsls	r0, r0, #12
@   0x08011e34: 1a5b        subs	r3, r3, r1
@   0x08011e36: 0000        movs	r0, r0
@   0x08011e38: 5160        str	r0, [r4, r5]
@   0x08011e3a: 0300        lsls	r0, r0, #12
@   0x08011e3c: 00d4        lsls	r4, r2, #3
@   0x08011e3e: 0400        lsls	r0, r0, #16

        thumb_func_start Selector_UpdateBlit
Selector_UpdateBlit: @ 0x08011aa4
        .incbin "frog_us_baserom.gba", 0x11aa4, 0x39c
        thumb_func_end Selector_UpdateBlit
