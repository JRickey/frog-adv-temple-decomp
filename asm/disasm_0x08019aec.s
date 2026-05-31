@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019aec, 0x08019db4)  (712 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019aec --end 0x8019db4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019aec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08019aee: 4657        mov	r7, sl
@   0x08019af0: 464e        mov	r6, r9
@   0x08019af2: 4645        mov	r5, r8
@   0x08019af4: b4e0        push	{r5, r6, r7}
@   0x08019af6: 0600        lsls	r0, r0, #24
@   0x08019af8: 0e02        lsrs	r2, r0, #24
@   0x08019afa: 2300        movs	r3, #0
@   0x08019afc: 469a        mov	sl, r3
@   0x08019afe: 489b        ldr	r0, [pc, #620]	@ (0x19d6c)
@   0x08019b00: 7a04        ldrb	r4, [r0, #8]
@   0x08019b02: 45a2        cmp	sl, r4
@   0x08019b04: d21a        bcs.n	0x19b3c
@   0x08019b06: 489a        ldr	r0, [pc, #616]	@ (0x19d70)
@   0x08019b08: 6801        ldr	r1, [r0, #0]
@   0x08019b0a: 0048        lsls	r0, r1, #1
@   0x08019b0c: 1840        adds	r0, r0, r1
@   0x08019b0e: 00c0        lsls	r0, r0, #3
@   0x08019b10: 4998        ldr	r1, [pc, #608]	@ (0x19d74)
@   0x08019b12: 1840        adds	r0, r0, r1
@   0x08019b14: 6801        ldr	r1, [r0, #0]
@   0x08019b16: 0090        lsls	r0, r2, #2
@   0x08019b18: 1840        adds	r0, r0, r1
@   0x08019b1a: 6805        ldr	r5, [r0, #0]
@   0x08019b1c: 4e96        ldr	r6, [pc, #600]	@ (0x19d78)
@   0x08019b1e: 4651        mov	r1, sl
@   0x08019b20: 1c48        adds	r0, r1, #1
@   0x08019b22: 0600        lsls	r0, r0, #24
@   0x08019b24: 0e00        lsrs	r0, r0, #24
@   0x08019b26: 4682        mov	sl, r0
@   0x08019b28: 0049        lsls	r1, r1, #1
@   0x08019b2a: 1949        adds	r1, r1, r5
@   0x08019b2c: 8809        ldrh	r1, [r1, #0]
@   0x08019b2e: 42b1        cmp	r1, r6
@   0x08019b30: d102        bne.n	0x19b38
@   0x08019b32: 1c58        adds	r0, r3, #1
@   0x08019b34: 0600        lsls	r0, r0, #24
@   0x08019b36: 0e03        lsrs	r3, r0, #24
@   0x08019b38: 42a3        cmp	r3, r4
@   0x08019b3a: d3f0        bcc.n	0x19b1e
@   0x08019b3c: 2600        movs	r6, #0
@   0x08019b3e: 488c        ldr	r0, [pc, #560]	@ (0x19d70)
@   0x08019b40: 6801        ldr	r1, [r0, #0]
@   0x08019b42: 0048        lsls	r0, r1, #1
@   0x08019b44: 1840        adds	r0, r0, r1
@   0x08019b46: 00c0        lsls	r0, r0, #3
@   0x08019b48: 498a        ldr	r1, [pc, #552]	@ (0x19d74)
@   0x08019b4a: 1840        adds	r0, r0, r1
@   0x08019b4c: 6800        ldr	r0, [r0, #0]
@   0x08019b4e: 0093        lsls	r3, r2, #2
@   0x08019b50: 1818        adds	r0, r3, r0
@   0x08019b52: 6800        ldr	r0, [r0, #0]
@   0x08019b54: 4652        mov	r2, sl
@   0x08019b56: 0051        lsls	r1, r2, #1
@   0x08019b58: 1808        adds	r0, r1, r0
@   0x08019b5a: 8800        ldrh	r0, [r0, #0]
@   0x08019b5c: 3002        adds	r0, #2
@   0x08019b5e: 0400        lsls	r0, r0, #16
@   0x08019b60: 0c00        lsrs	r0, r0, #16
@   0x08019b62: 4699        mov	r9, r3
@   0x08019b64: 1c0a        adds	r2, r1, #0
@   0x08019b66: 2801        cmp	r0, #1
@   0x08019b68: d800        bhi.n	0x19b6c
@   0x08019b6a: e0e6        b.n	0x19d3a
@   0x08019b6c: 4f80        ldr	r7, [pc, #512]	@ (0x19d70)
@   0x08019b6e: 4881        ldr	r0, [pc, #516]	@ (0x19d74)
@   0x08019b70: 3004        adds	r0, #4
@   0x08019b72: 4680        mov	r8, r0
@   0x08019b74: 6839        ldr	r1, [r7, #0]
@   0x08019b76: 0048        lsls	r0, r1, #1
@   0x08019b78: 1840        adds	r0, r0, r1
@   0x08019b7a: 00c0        lsls	r0, r0, #3
@   0x08019b7c: 497d        ldr	r1, [pc, #500]	@ (0x19d74)
@   0x08019b7e: 1840        adds	r0, r0, r1
@   0x08019b80: 6802        ldr	r2, [r0, #0]
@   0x08019b82: 189a        adds	r2, r3, r2
@   0x08019b84: 4651        mov	r1, sl
@   0x08019b86: 1c48        adds	r0, r1, #1
@   0x08019b88: 0600        lsls	r0, r0, #24
@   0x08019b8a: 0e00        lsrs	r0, r0, #24
@   0x08019b8c: 4682        mov	sl, r0
@   0x08019b8e: 6810        ldr	r0, [r2, #0]
@   0x08019b90: 0049        lsls	r1, r1, #1
@   0x08019b92: 1809        adds	r1, r1, r0
@   0x08019b94: 2500        movs	r5, #0
@   0x08019b96: 0070        lsls	r0, r6, #1
@   0x08019b98: 1c72        adds	r2, r6, #1
@   0x08019b9a: 4694        mov	ip, r2
@   0x08019b9c: 8809        ldrh	r1, [r1, #0]
@   0x08019b9e: 01cc        lsls	r4, r1, #7
@   0x08019ba0: 1980        adds	r0, r0, r6
@   0x08019ba2: 0106        lsls	r6, r0, #4
@   0x08019ba4: 6839        ldr	r1, [r7, #0]
@   0x08019ba6: 0048        lsls	r0, r1, #1
@   0x08019ba8: 1840        adds	r0, r0, r1
@   0x08019baa: 00c0        lsls	r0, r0, #3
@   0x08019bac: 4440        add	r0, r8
@   0x08019bae: 6800        ldr	r0, [r0, #0]
@   0x08019bb0: 00aa        lsls	r2, r5, #2
@   0x08019bb2: 1820        adds	r0, r4, r0
@   0x08019bb4: 1810        adds	r0, r2, r0
@   0x08019bb6: 6800        ldr	r0, [r0, #0]
@   0x08019bb8: 0200        lsls	r0, r0, #8
@   0x08019bba: 4970        ldr	r1, [pc, #448]	@ (0x19d7c)
@   0x08019bbc: 1853        adds	r3, r2, r1
@   0x08019bbe: 18f3        adds	r3, r6, r3
@   0x08019bc0: 6018        str	r0, [r3, #0]
@   0x08019bc2: 6839        ldr	r1, [r7, #0]
@   0x08019bc4: 0048        lsls	r0, r1, #1
@   0x08019bc6: 1840        adds	r0, r0, r1
@   0x08019bc8: 00c0        lsls	r0, r0, #3
@   0x08019bca: 4440        add	r0, r8
@   0x08019bcc: 6800        ldr	r0, [r0, #0]
@   0x08019bce: 1820        adds	r0, r4, r0
@   0x08019bd0: 1810        adds	r0, r2, r0
@   0x08019bd2: 3001        adds	r0, #1
@   0x08019bd4: 6800        ldr	r0, [r0, #0]
@   0x08019bd6: 6198        str	r0, [r3, #24]
@   0x08019bd8: 6839        ldr	r1, [r7, #0]
@   0x08019bda: 0048        lsls	r0, r1, #1
@   0x08019bdc: 1840        adds	r0, r0, r1
@   0x08019bde: 00c0        lsls	r0, r0, #3
@   0x08019be0: 4440        add	r0, r8
@   0x08019be2: 6800        ldr	r0, [r0, #0]
@   0x08019be4: 1820        adds	r0, r4, r0
@   0x08019be6: 1810        adds	r0, r2, r0
@   0x08019be8: 3002        adds	r0, #2
@   0x08019bea: 6800        ldr	r0, [r0, #0]
@   0x08019bec: 0200        lsls	r0, r0, #8
@   0x08019bee: 4964        ldr	r1, [pc, #400]	@ (0x19d80)
@   0x08019bf0: 1853        adds	r3, r2, r1
@   0x08019bf2: 18f3        adds	r3, r6, r3
@   0x08019bf4: 6018        str	r0, [r3, #0]
@   0x08019bf6: 6839        ldr	r1, [r7, #0]
@   0x08019bf8: 0048        lsls	r0, r1, #1
@   0x08019bfa: 1840        adds	r0, r0, r1
@   0x08019bfc: 00c0        lsls	r0, r0, #3
@   0x08019bfe: 4440        add	r0, r8
@   0x08019c00: 6800        ldr	r0, [r0, #0]
@   0x08019c02: 1820        adds	r0, r4, r0
@   0x08019c04: 1812        adds	r2, r2, r0
@   0x08019c06: 3203        adds	r2, #3
@   0x08019c08: 6810        ldr	r0, [r2, #0]
@   0x08019c0a: 6198        str	r0, [r3, #24]
@   0x08019c0c: 1c68        adds	r0, r5, #1
@   0x08019c0e: 0600        lsls	r0, r0, #24
@   0x08019c10: 0e05        lsrs	r5, r0, #24
@   0x08019c12: 2d07        cmp	r5, #7
@   0x08019c14: d9c6        bls.n	0x19ba4
@   0x08019c16: 4662        mov	r2, ip
@   0x08019c18: 0610        lsls	r0, r2, #24
@   0x08019c1a: 0e06        lsrs	r6, r0, #24
@   0x08019c1c: 4854        ldr	r0, [pc, #336]	@ (0x19d70)
@   0x08019c1e: 6801        ldr	r1, [r0, #0]
@   0x08019c20: 0048        lsls	r0, r1, #1
@   0x08019c22: 1840        adds	r0, r0, r1
@   0x08019c24: 00c0        lsls	r0, r0, #3
@   0x08019c26: 4953        ldr	r1, [pc, #332]	@ (0x19d74)
@   0x08019c28: 1840        adds	r0, r0, r1
@   0x08019c2a: 6800        ldr	r0, [r0, #0]
@   0x08019c2c: 464b        mov	r3, r9
@   0x08019c2e: 4448        add	r0, r9
@   0x08019c30: 6800        ldr	r0, [r0, #0]
@   0x08019c32: 4652        mov	r2, sl
@   0x08019c34: 0051        lsls	r1, r2, #1
@   0x08019c36: 1808        adds	r0, r1, r0
@   0x08019c38: 8800        ldrh	r0, [r0, #0]
@   0x08019c3a: 3002        adds	r0, #2
@   0x08019c3c: 0400        lsls	r0, r0, #16
@   0x08019c3e: 0c00        lsrs	r0, r0, #16
@   0x08019c40: 1c0a        adds	r2, r1, #0
@   0x08019c42: 2801        cmp	r0, #1
@   0x08019c44: d896        bhi.n	0x19b74
@   0x08019c46: 2600        movs	r6, #0
@   0x08019c48: 4849        ldr	r0, [pc, #292]	@ (0x19d70)
@   0x08019c4a: 6801        ldr	r1, [r0, #0]
@   0x08019c4c: 0048        lsls	r0, r1, #1
@   0x08019c4e: 1840        adds	r0, r0, r1
@   0x08019c50: 00c0        lsls	r0, r0, #3
@   0x08019c52: 4948        ldr	r1, [pc, #288]	@ (0x19d74)
@   0x08019c54: 1840        adds	r0, r0, r1
@   0x08019c56: 6800        ldr	r0, [r0, #0]
@   0x08019c58: 4448        add	r0, r9
@   0x08019c5a: 6800        ldr	r0, [r0, #0]
@   0x08019c5c: 1810        adds	r0, r2, r0
@   0x08019c5e: 8800        ldrh	r0, [r0, #0]
@   0x08019c60: 3002        adds	r0, #2
@   0x08019c62: 0400        lsls	r0, r0, #16
@   0x08019c64: 0c00        lsrs	r0, r0, #16
@   0x08019c66: 2801        cmp	r0, #1
@   0x08019c68: d967        bls.n	0x19d3a
@   0x08019c6a: 4f41        ldr	r7, [pc, #260]	@ (0x19d70)
@   0x08019c6c: 3104        adds	r1, #4
@   0x08019c6e: 4688        mov	r8, r1
@   0x08019c70: 6839        ldr	r1, [r7, #0]
@   0x08019c72: 0048        lsls	r0, r1, #1
@   0x08019c74: 1840        adds	r0, r0, r1
@   0x08019c76: 00c0        lsls	r0, r0, #3
@   0x08019c78: 4a3e        ldr	r2, [pc, #248]	@ (0x19d74)
@   0x08019c7a: 1880        adds	r0, r0, r2
@   0x08019c7c: 6802        ldr	r2, [r0, #0]
@   0x08019c7e: 189a        adds	r2, r3, r2
@   0x08019c80: 4651        mov	r1, sl
@   0x08019c82: 1c48        adds	r0, r1, #1
@   0x08019c84: 0600        lsls	r0, r0, #24
@   0x08019c86: 0e00        lsrs	r0, r0, #24
@   0x08019c88: 4682        mov	sl, r0
@   0x08019c8a: 6810        ldr	r0, [r2, #0]
@   0x08019c8c: 0049        lsls	r1, r1, #1
@   0x08019c8e: 1809        adds	r1, r1, r0
@   0x08019c90: 2500        movs	r5, #0
@   0x08019c92: 0070        lsls	r0, r6, #1
@   0x08019c94: 1c72        adds	r2, r6, #1
@   0x08019c96: 4694        mov	ip, r2
@   0x08019c98: 8809        ldrh	r1, [r1, #0]
@   0x08019c9a: 01cc        lsls	r4, r1, #7
@   0x08019c9c: 1980        adds	r0, r0, r6
@   0x08019c9e: 0106        lsls	r6, r0, #4
@   0x08019ca0: 6839        ldr	r1, [r7, #0]
@   0x08019ca2: 0048        lsls	r0, r1, #1
@   0x08019ca4: 1840        adds	r0, r0, r1
@   0x08019ca6: 00c0        lsls	r0, r0, #3
@   0x08019ca8: 4440        add	r0, r8
@   0x08019caa: 6800        ldr	r0, [r0, #0]
@   0x08019cac: 1820        adds	r0, r4, r0
@   0x08019cae: 6800        ldr	r0, [r0, #0]
@   0x08019cb0: 0200        lsls	r0, r0, #8
@   0x08019cb2: 00ab        lsls	r3, r5, #2
@   0x08019cb4: 4933        ldr	r1, [pc, #204]	@ (0x19d84)
@   0x08019cb6: 185a        adds	r2, r3, r1
@   0x08019cb8: 18b2        adds	r2, r6, r2
@   0x08019cba: 6010        str	r0, [r2, #0]
@   0x08019cbc: 6839        ldr	r1, [r7, #0]
@   0x08019cbe: 0048        lsls	r0, r1, #1
@   0x08019cc0: 1840        adds	r0, r0, r1
@   0x08019cc2: 00c0        lsls	r0, r0, #3
@   0x08019cc4: 4440        add	r0, r8
@   0x08019cc6: 6800        ldr	r0, [r0, #0]
@   0x08019cc8: 1820        adds	r0, r4, r0
@   0x08019cca: 3001        adds	r0, #1
@   0x08019ccc: 6800        ldr	r0, [r0, #0]
@   0x08019cce: 6190        str	r0, [r2, #24]
@   0x08019cd0: 6839        ldr	r1, [r7, #0]
@   0x08019cd2: 0048        lsls	r0, r1, #1
@   0x08019cd4: 1840        adds	r0, r0, r1
@   0x08019cd6: 00c0        lsls	r0, r0, #3
@   0x08019cd8: 4440        add	r0, r8
@   0x08019cda: 6800        ldr	r0, [r0, #0]
@   0x08019cdc: 1820        adds	r0, r4, r0
@   0x08019cde: 3002        adds	r0, #2
@   0x08019ce0: 6800        ldr	r0, [r0, #0]
@   0x08019ce2: 0200        lsls	r0, r0, #8
@   0x08019ce4: 4a28        ldr	r2, [pc, #160]	@ (0x19d88)
@   0x08019ce6: 189b        adds	r3, r3, r2
@   0x08019ce8: 18f3        adds	r3, r6, r3
@   0x08019cea: 6018        str	r0, [r3, #0]
@   0x08019cec: 6839        ldr	r1, [r7, #0]
@   0x08019cee: 0048        lsls	r0, r1, #1
@   0x08019cf0: 1840        adds	r0, r0, r1
@   0x08019cf2: 00c0        lsls	r0, r0, #3
@   0x08019cf4: 4440        add	r0, r8
@   0x08019cf6: 6800        ldr	r0, [r0, #0]
@   0x08019cf8: 1820        adds	r0, r4, r0
@   0x08019cfa: 3003        adds	r0, #3
@   0x08019cfc: 6800        ldr	r0, [r0, #0]
@   0x08019cfe: 6198        str	r0, [r3, #24]
@   0x08019d00: 1c68        adds	r0, r5, #1
@   0x08019d02: 0600        lsls	r0, r0, #24
@   0x08019d04: 0e05        lsrs	r5, r0, #24
@   0x08019d06: 2d07        cmp	r5, #7
@   0x08019d08: d9ca        bls.n	0x19ca0
@   0x08019d0a: 4661        mov	r1, ip
@   0x08019d0c: 0608        lsls	r0, r1, #24
@   0x08019d0e: 0e06        lsrs	r6, r0, #24
@   0x08019d10: 4a17        ldr	r2, [pc, #92]	@ (0x19d70)
@   0x08019d12: 6811        ldr	r1, [r2, #0]
@   0x08019d14: 0048        lsls	r0, r1, #1
@   0x08019d16: 1840        adds	r0, r0, r1
@   0x08019d18: 00c0        lsls	r0, r0, #3
@   0x08019d1a: 4916        ldr	r1, [pc, #88]	@ (0x19d74)
@   0x08019d1c: 1840        adds	r0, r0, r1
@   0x08019d1e: 6800        ldr	r0, [r0, #0]
@   0x08019d20: 464b        mov	r3, r9
@   0x08019d22: 4448        add	r0, r9
@   0x08019d24: 6800        ldr	r0, [r0, #0]
@   0x08019d26: 4652        mov	r2, sl
@   0x08019d28: 0051        lsls	r1, r2, #1
@   0x08019d2a: 1808        adds	r0, r1, r0
@   0x08019d2c: 8800        ldrh	r0, [r0, #0]
@   0x08019d2e: 3002        adds	r0, #2
@   0x08019d30: 0400        lsls	r0, r0, #16
@   0x08019d32: 0c00        lsrs	r0, r0, #16
@   0x08019d34: 1c0a        adds	r2, r1, #0
@   0x08019d36: 2801        cmp	r0, #1
@   0x08019d38: d89a        bhi.n	0x19c70
@   0x08019d3a: 480d        ldr	r0, [pc, #52]	@ (0x19d70)
@   0x08019d3c: 6801        ldr	r1, [r0, #0]
@   0x08019d3e: 0048        lsls	r0, r1, #1
@   0x08019d40: 1840        adds	r0, r0, r1
@   0x08019d42: 00c0        lsls	r0, r0, #3
@   0x08019d44: 490b        ldr	r1, [pc, #44]	@ (0x19d74)
@   0x08019d46: 1840        adds	r0, r0, r1
@   0x08019d48: 6800        ldr	r0, [r0, #0]
@   0x08019d4a: 4448        add	r0, r9
@   0x08019d4c: 6800        ldr	r0, [r0, #0]
@   0x08019d4e: 1810        adds	r0, r2, r0
@   0x08019d50: 490e        ldr	r1, [pc, #56]	@ (0x19d8c)
@   0x08019d52: 8800        ldrh	r0, [r0, #0]
@   0x08019d54: 4288        cmp	r0, r1
@   0x08019d56: d102        bne.n	0x19d5e
@   0x08019d58: 20ff        movs	r0, #255	@ 0xff
@   0x08019d5a: 4a04        ldr	r2, [pc, #16]	@ (0x19d6c)
@   0x08019d5c: 7210        strb	r0, [r2, #8]
@   0x08019d5e: bc38        pop	{r3, r4, r5}
@   0x08019d60: 4698        mov	r8, r3
@   0x08019d62: 46a1        mov	r9, r4
@   0x08019d64: 46aa        mov	sl, r5
@   0x08019d66: bcf0        pop	{r4, r5, r6, r7}
@   0x08019d68: bc01        pop	{r0}
@   0x08019d6a: 4700        bx	r0
@   0x08019d6c: 6440        str	r0, [r0, #68]	@ 0x44
@   0x08019d6e: 0300        lsls	r0, r0, #12
@   0x08019d70: 34b0        adds	r4, #176	@ 0xb0
@   0x08019d72: 0300        lsls	r0, r0, #12
@   0x08019d74: 1254        asrs	r4, r2, #9
@   0x08019d76: 080c        lsrs	r4, r1, #32
@   0x08019d78: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08019d7c: d420        bmi.n	0x19dc0
@   0x08019d7e: 0600        lsls	r0, r0, #24
@   0x08019d80: d820        bhi.n	0x19dc4
@   0x08019d82: 0600        lsls	r0, r0, #24
@   0x08019d84: dc20        bgt.n	0x19dc8
@   0x08019d86: 0600        lsls	r0, r0, #24
@   0x08019d88: e020        b.n	0x19dcc
@   0x08019d8a: 0600        lsls	r0, r0, #24
@   0x08019d8c: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08019d90: 4904        ldr	r1, [pc, #16]	@ (0x19da4)
@   0x08019d92: 4a05        ldr	r2, [pc, #20]	@ (0x19da8)
@   0x08019d94: 1c10        adds	r0, r2, #0
@   0x08019d96: 8008        strh	r0, [r1, #0]
@   0x08019d98: 3102        adds	r1, #2
@   0x08019d9a: 4a04        ldr	r2, [pc, #16]	@ (0x19dac)
@   0x08019d9c: 1c10        adds	r0, r2, #0
@   0x08019d9e: 8008        strh	r0, [r1, #0]
@   0x08019da0: 4770        bx	lr
@   0x08019da2: 0000        movs	r0, r0
@   0x08019da4: 0050        lsls	r0, r2, #1
@   0x08019da6: 0400        lsls	r0, r0, #16
@   0x08019da8: 1142        asrs	r2, r0, #5
@   0x08019daa: 0000        movs	r0, r0
@   0x08019dac: 050b        lsls	r3, r1, #20
@   0x08019dae: 0000        movs	r0, r0
@   0x08019db0: 4770        bx	lr

        thumb_func_start sub_08019AEC
sub_08019AEC: @ 0x08019aec
        .incbin "frog_us_baserom.gba", 0x19aec, 0x2c8
        thumb_func_end sub_08019AEC
