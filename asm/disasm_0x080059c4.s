@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080059c4, 0x08005d10)  (844 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80059c4 --end 0x8005d10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080059c4: b530        push	{r4, r5, lr}
@   0x080059c6: 1c05        adds	r5, r0, #0
@   0x080059c8: 4868        ldr	r0, [pc, #416]	@ (0x5b6c)
@   0x080059ca: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x080059cc: 4008        ands	r0, r1
@   0x080059ce: 2400        movs	r4, #0
@   0x080059d0: 4967        ldr	r1, [pc, #412]	@ (0x5b70)
@   0x080059d2: 4008        ands	r0, r1
@   0x080059d4: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x080059d6: 2102        movs	r1, #2
@   0x080059d8: 4001        ands	r1, r0
@   0x080059da: 2900        cmp	r1, #0
@   0x080059dc: d100        bne.n	0x59e0
@   0x080059de: e0cd        b.n	0x5b7c
@   0x080059e0: 76ec        strb	r4, [r5, #27]
@   0x080059e2: 4c64        ldr	r4, [pc, #400]	@ (0x5b74)
@   0x080059e4: 782a        ldrb	r2, [r5, #0]
@   0x080059e6: 00d0        lsls	r0, r2, #3
@   0x080059e8: 3404        adds	r4, #4
@   0x080059ea: 1900        adds	r0, r0, r4
@   0x080059ec: 6801        ldr	r1, [r0, #0]
@   0x080059ee: 7eaa        ldrb	r2, [r5, #26]
@   0x080059f0: 0050        lsls	r0, r2, #1
@   0x080059f2: 1880        adds	r0, r0, r2
@   0x080059f4: 0080        lsls	r0, r0, #2
@   0x080059f6: 1840        adds	r0, r0, r1
@   0x080059f8: 7a00        ldrb	r0, [r0, #8]
@   0x080059fa: 7728        strb	r0, [r5, #28]
@   0x080059fc: 7829        ldrb	r1, [r5, #0]
@   0x080059fe: 00c8        lsls	r0, r1, #3
@   0x08005a00: 1900        adds	r0, r0, r4
@   0x08005a02: 6801        ldr	r1, [r0, #0]
@   0x08005a04: 0050        lsls	r0, r2, #1
@   0x08005a06: 1880        adds	r0, r0, r2
@   0x08005a08: 0080        lsls	r0, r0, #2
@   0x08005a0a: 1840        adds	r0, r0, r1
@   0x08005a0c: 6800        ldr	r0, [r0, #0]
@   0x08005a0e: 7a00        ldrb	r0, [r0, #8]
@   0x08005a10: 7768        strb	r0, [r5, #29]
@   0x08005a12: 7829        ldrb	r1, [r5, #0]
@   0x08005a14: 00c8        lsls	r0, r1, #3
@   0x08005a16: 1900        adds	r0, r0, r4
@   0x08005a18: 6800        ldr	r0, [r0, #0]
@   0x08005a1a: 0051        lsls	r1, r2, #1
@   0x08005a1c: 1889        adds	r1, r1, r2
@   0x08005a1e: 0089        lsls	r1, r1, #2
@   0x08005a20: 1809        adds	r1, r1, r0
@   0x08005a22: 7a48        ldrb	r0, [r1, #9]
@   0x08005a24: 7a89        ldrb	r1, [r1, #10]
@   0x08005a26: f000        fa57 	bl	0x5ed8
@   0x08005a2a: 7668        strb	r0, [r5, #25]
@   0x08005a2c: 7829        ldrb	r1, [r5, #0]
@   0x08005a2e: 00c8        lsls	r0, r1, #3
@   0x08005a30: 1900        adds	r0, r0, r4
@   0x08005a32: 6800        ldr	r0, [r0, #0]
@   0x08005a34: 7eaa        ldrb	r2, [r5, #26]
@   0x08005a36: 0051        lsls	r1, r2, #1
@   0x08005a38: 1889        adds	r1, r1, r2
@   0x08005a3a: 0089        lsls	r1, r1, #2
@   0x08005a3c: 1809        adds	r1, r1, r0
@   0x08005a3e: 7a48        ldrb	r0, [r1, #9]
@   0x08005a40: 7a89        ldrb	r1, [r1, #10]
@   0x08005a42: f000        fa85 	bl	0x5f50
@   0x08005a46: 7628        strb	r0, [r5, #24]
@   0x08005a48: 7829        ldrb	r1, [r5, #0]
@   0x08005a4a: 00c8        lsls	r0, r1, #3
@   0x08005a4c: 1900        adds	r0, r0, r4
@   0x08005a4e: 6801        ldr	r1, [r0, #0]
@   0x08005a50: 7eaa        ldrb	r2, [r5, #26]
@   0x08005a52: 0050        lsls	r0, r2, #1
@   0x08005a54: 1880        adds	r0, r0, r2
@   0x08005a56: 0080        lsls	r0, r0, #2
@   0x08005a58: 1840        adds	r0, r0, r1
@   0x08005a5a: 6801        ldr	r1, [r0, #0]
@   0x08005a5c: 7eea        ldrb	r2, [r5, #27]
@   0x08005a5e: 0110        lsls	r0, r2, #4
@   0x08005a60: 1840        adds	r0, r0, r1
@   0x08005a62: 7a40        ldrb	r0, [r0, #9]
@   0x08005a64: 7068        strb	r0, [r5, #1]
@   0x08005a66: 7829        ldrb	r1, [r5, #0]
@   0x08005a68: 00c8        lsls	r0, r1, #3
@   0x08005a6a: 1900        adds	r0, r0, r4
@   0x08005a6c: 6801        ldr	r1, [r0, #0]
@   0x08005a6e: 7eaa        ldrb	r2, [r5, #26]
@   0x08005a70: 0050        lsls	r0, r2, #1
@   0x08005a72: 1880        adds	r0, r0, r2
@   0x08005a74: 0080        lsls	r0, r0, #2
@   0x08005a76: 1840        adds	r0, r0, r1
@   0x08005a78: 6801        ldr	r1, [r0, #0]
@   0x08005a7a: 7eea        ldrb	r2, [r5, #27]
@   0x08005a7c: 0110        lsls	r0, r2, #4
@   0x08005a7e: 1840        adds	r0, r0, r1
@   0x08005a80: 7800        ldrb	r0, [r0, #0]
@   0x08005a82: 0600        lsls	r0, r0, #24
@   0x08005a84: 1600        asrs	r0, r0, #24
@   0x08005a86: 8869        ldrh	r1, [r5, #2]
@   0x08005a88: 1808        adds	r0, r1, r0
@   0x08005a8a: 8068        strh	r0, [r5, #2]
@   0x08005a8c: 782a        ldrb	r2, [r5, #0]
@   0x08005a8e: 00d0        lsls	r0, r2, #3
@   0x08005a90: 1900        adds	r0, r0, r4
@   0x08005a92: 6801        ldr	r1, [r0, #0]
@   0x08005a94: 7eaa        ldrb	r2, [r5, #26]
@   0x08005a96: 0050        lsls	r0, r2, #1
@   0x08005a98: 1880        adds	r0, r0, r2
@   0x08005a9a: 0080        lsls	r0, r0, #2
@   0x08005a9c: 1840        adds	r0, r0, r1
@   0x08005a9e: 6801        ldr	r1, [r0, #0]
@   0x08005aa0: 7eea        ldrb	r2, [r5, #27]
@   0x08005aa2: 0110        lsls	r0, r2, #4
@   0x08005aa4: 1840        adds	r0, r0, r1
@   0x08005aa6: 7840        ldrb	r0, [r0, #1]
@   0x08005aa8: 0600        lsls	r0, r0, #24
@   0x08005aaa: 1600        asrs	r0, r0, #24
@   0x08005aac: 88a9        ldrh	r1, [r5, #4]
@   0x08005aae: 1808        adds	r0, r1, r0
@   0x08005ab0: 80a8        strh	r0, [r5, #4]
@   0x08005ab2: 782a        ldrb	r2, [r5, #0]
@   0x08005ab4: 00d0        lsls	r0, r2, #3
@   0x08005ab6: 1900        adds	r0, r0, r4
@   0x08005ab8: 6801        ldr	r1, [r0, #0]
@   0x08005aba: 7eaa        ldrb	r2, [r5, #26]
@   0x08005abc: 0050        lsls	r0, r2, #1
@   0x08005abe: 1880        adds	r0, r0, r2
@   0x08005ac0: 0080        lsls	r0, r0, #2
@   0x08005ac2: 1840        adds	r0, r0, r1
@   0x08005ac4: 6801        ldr	r1, [r0, #0]
@   0x08005ac6: 7eea        ldrb	r2, [r5, #27]
@   0x08005ac8: 0110        lsls	r0, r2, #4
@   0x08005aca: 1840        adds	r0, r0, r1
@   0x08005acc: 8940        ldrh	r0, [r0, #10]
@   0x08005ace: 84a8        strh	r0, [r5, #36]	@ 0x24
@   0x08005ad0: 7829        ldrb	r1, [r5, #0]
@   0x08005ad2: 00c8        lsls	r0, r1, #3
@   0x08005ad4: 1900        adds	r0, r0, r4
@   0x08005ad6: 6801        ldr	r1, [r0, #0]
@   0x08005ad8: 7eaa        ldrb	r2, [r5, #26]
@   0x08005ada: 0050        lsls	r0, r2, #1
@   0x08005adc: 1880        adds	r0, r0, r2
@   0x08005ade: 0080        lsls	r0, r0, #2
@   0x08005ae0: 1840        adds	r0, r0, r1
@   0x08005ae2: 6801        ldr	r1, [r0, #0]
@   0x08005ae4: 7eea        ldrb	r2, [r5, #27]
@   0x08005ae6: 0110        lsls	r0, r2, #4
@   0x08005ae8: 1840        adds	r0, r0, r1
@   0x08005aea: 8980        ldrh	r0, [r0, #12]
@   0x08005aec: 84e8        strh	r0, [r5, #38]	@ 0x26
@   0x08005aee: 7829        ldrb	r1, [r5, #0]
@   0x08005af0: 00c8        lsls	r0, r1, #3
@   0x08005af2: 1900        adds	r0, r0, r4
@   0x08005af4: 6801        ldr	r1, [r0, #0]
@   0x08005af6: 7eaa        ldrb	r2, [r5, #26]
@   0x08005af8: 0050        lsls	r0, r2, #1
@   0x08005afa: 1880        adds	r0, r0, r2
@   0x08005afc: 0080        lsls	r0, r0, #2
@   0x08005afe: 1840        adds	r0, r0, r1
@   0x08005b00: 6801        ldr	r1, [r0, #0]
@   0x08005b02: 7eea        ldrb	r2, [r5, #27]
@   0x08005b04: 0110        lsls	r0, r2, #4
@   0x08005b06: 1840        adds	r0, r0, r1
@   0x08005b08: 7b81        ldrb	r1, [r0, #14]
@   0x08005b0a: 1c28        adds	r0, r5, #0
@   0x08005b0c: 3028        adds	r0, #40	@ 0x28
@   0x08005b0e: 7001        strb	r1, [r0, #0]
@   0x08005b10: 7829        ldrb	r1, [r5, #0]
@   0x08005b12: 00c8        lsls	r0, r1, #3
@   0x08005b14: 1900        adds	r0, r0, r4
@   0x08005b16: 6801        ldr	r1, [r0, #0]
@   0x08005b18: 7eaa        ldrb	r2, [r5, #26]
@   0x08005b1a: 0050        lsls	r0, r2, #1
@   0x08005b1c: 1880        adds	r0, r0, r2
@   0x08005b1e: 0080        lsls	r0, r0, #2
@   0x08005b20: 1840        adds	r0, r0, r1
@   0x08005b22: 6801        ldr	r1, [r0, #0]
@   0x08005b24: 7eea        ldrb	r2, [r5, #27]
@   0x08005b26: 0110        lsls	r0, r2, #4
@   0x08005b28: 1840        adds	r0, r0, r1
@   0x08005b2a: 7bc0        ldrb	r0, [r0, #15]
@   0x08005b2c: 1c29        adds	r1, r5, #0
@   0x08005b2e: 3129        adds	r1, #41	@ 0x29
@   0x08005b30: 7008        strb	r0, [r1, #0]
@   0x08005b32: 7829        ldrb	r1, [r5, #0]
@   0x08005b34: 00c8        lsls	r0, r1, #3
@   0x08005b36: 1900        adds	r0, r0, r4
@   0x08005b38: 6801        ldr	r1, [r0, #0]
@   0x08005b3a: 7eaa        ldrb	r2, [r5, #26]
@   0x08005b3c: 0050        lsls	r0, r2, #1
@   0x08005b3e: 1880        adds	r0, r0, r2
@   0x08005b40: 0080        lsls	r0, r0, #2
@   0x08005b42: 1840        adds	r0, r0, r1
@   0x08005b44: 6801        ldr	r1, [r0, #0]
@   0x08005b46: 7eea        ldrb	r2, [r5, #27]
@   0x08005b48: 0110        lsls	r0, r2, #4
@   0x08005b4a: 1840        adds	r0, r0, r1
@   0x08005b4c: 7a00        ldrb	r0, [r0, #8]
@   0x08005b4e: 7768        strb	r0, [r5, #29]
@   0x08005b50: 2180        movs	r1, #128	@ 0x80
@   0x08005b52: 0049        lsls	r1, r1, #1
@   0x08005b54: 1c08        adds	r0, r1, #0
@   0x08005b56: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x08005b58: 4310        orrs	r0, r2
@   0x08005b5a: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005b5c: f7fa        fed0 	bl	0x900
@   0x08005b60: 6228        str	r0, [r5, #32]
@   0x08005b62: 4805        ldr	r0, [pc, #20]	@ (0x5b78)
@   0x08005b64: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08005b66: 4008        ands	r0, r1
@   0x08005b68: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005b6a: e0cb        b.n	0x5d04
@   0x08005b6c: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x08005b70: 7fff        ldrb	r7, [r7, #31]
@   0x08005b72: 0000        movs	r0, r0
@   0x08005b74: 8ad8        ldrh	r0, [r3, #22]
@   0x08005b76: 082f        lsrs	r7, r5, #32
@   0x08005b78: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x08005b7c: f7fa        fec0 	bl	0x900
@   0x08005b80: 6a29        ldr	r1, [r5, #32]
@   0x08005b82: 1a40        subs	r0, r0, r1
@   0x08005b84: 7f6a        ldrb	r2, [r5, #29]
@   0x08005b86: 4290        cmp	r0, r2
@   0x08005b88: d200        bcs.n	0x5b8c
@   0x08005b8a: e0bb        b.n	0x5d04
@   0x08005b8c: 7ee8        ldrb	r0, [r5, #27]
@   0x08005b8e: 3001        adds	r0, #1
@   0x08005b90: 76e8        strb	r0, [r5, #27]
@   0x08005b92: 7f29        ldrb	r1, [r5, #28]
@   0x08005b94: 0600        lsls	r0, r0, #24
@   0x08005b96: 0e00        lsrs	r0, r0, #24
@   0x08005b98: 4288        cmp	r0, r1
@   0x08005b9a: d108        bne.n	0x5bae
@   0x08005b9c: 1e48        subs	r0, r1, #1
@   0x08005b9e: 76e8        strb	r0, [r5, #27]
@   0x08005ba0: 2180        movs	r1, #128	@ 0x80
@   0x08005ba2: 0209        lsls	r1, r1, #8
@   0x08005ba4: 1c08        adds	r0, r1, #0
@   0x08005ba6: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x08005ba8: 4310        orrs	r0, r2
@   0x08005baa: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005bac: e0aa        b.n	0x5d04
@   0x08005bae: 4c57        ldr	r4, [pc, #348]	@ (0x5d0c)
@   0x08005bb0: 7829        ldrb	r1, [r5, #0]
@   0x08005bb2: 00c8        lsls	r0, r1, #3
@   0x08005bb4: 3404        adds	r4, #4
@   0x08005bb6: 1900        adds	r0, r0, r4
@   0x08005bb8: 6800        ldr	r0, [r0, #0]
@   0x08005bba: 7eaa        ldrb	r2, [r5, #26]
@   0x08005bbc: 0051        lsls	r1, r2, #1
@   0x08005bbe: 1889        adds	r1, r1, r2
@   0x08005bc0: 0089        lsls	r1, r1, #2
@   0x08005bc2: 1809        adds	r1, r1, r0
@   0x08005bc4: 7a48        ldrb	r0, [r1, #9]
@   0x08005bc6: 7a89        ldrb	r1, [r1, #10]
@   0x08005bc8: f000        f986 	bl	0x5ed8
@   0x08005bcc: 7668        strb	r0, [r5, #25]
@   0x08005bce: 7829        ldrb	r1, [r5, #0]
@   0x08005bd0: 00c8        lsls	r0, r1, #3
@   0x08005bd2: 1900        adds	r0, r0, r4
@   0x08005bd4: 6800        ldr	r0, [r0, #0]
@   0x08005bd6: 7eaa        ldrb	r2, [r5, #26]
@   0x08005bd8: 0051        lsls	r1, r2, #1
@   0x08005bda: 1889        adds	r1, r1, r2
@   0x08005bdc: 0089        lsls	r1, r1, #2
@   0x08005bde: 1809        adds	r1, r1, r0
@   0x08005be0: 7a48        ldrb	r0, [r1, #9]
@   0x08005be2: 7a89        ldrb	r1, [r1, #10]
@   0x08005be4: f000        f9b4 	bl	0x5f50
@   0x08005be8: 7628        strb	r0, [r5, #24]
@   0x08005bea: 7829        ldrb	r1, [r5, #0]
@   0x08005bec: 00c8        lsls	r0, r1, #3
@   0x08005bee: 1900        adds	r0, r0, r4
@   0x08005bf0: 6801        ldr	r1, [r0, #0]
@   0x08005bf2: 7eaa        ldrb	r2, [r5, #26]
@   0x08005bf4: 0050        lsls	r0, r2, #1
@   0x08005bf6: 1880        adds	r0, r0, r2
@   0x08005bf8: 0080        lsls	r0, r0, #2
@   0x08005bfa: 1840        adds	r0, r0, r1
@   0x08005bfc: 6801        ldr	r1, [r0, #0]
@   0x08005bfe: 7eea        ldrb	r2, [r5, #27]
@   0x08005c00: 0110        lsls	r0, r2, #4
@   0x08005c02: 1840        adds	r0, r0, r1
@   0x08005c04: 7a40        ldrb	r0, [r0, #9]
@   0x08005c06: 7068        strb	r0, [r5, #1]
@   0x08005c08: 7829        ldrb	r1, [r5, #0]
@   0x08005c0a: 00c8        lsls	r0, r1, #3
@   0x08005c0c: 1900        adds	r0, r0, r4
@   0x08005c0e: 6801        ldr	r1, [r0, #0]
@   0x08005c10: 7eaa        ldrb	r2, [r5, #26]
@   0x08005c12: 0050        lsls	r0, r2, #1
@   0x08005c14: 1880        adds	r0, r0, r2
@   0x08005c16: 0080        lsls	r0, r0, #2
@   0x08005c18: 1840        adds	r0, r0, r1
@   0x08005c1a: 6801        ldr	r1, [r0, #0]
@   0x08005c1c: 7eea        ldrb	r2, [r5, #27]
@   0x08005c1e: 0110        lsls	r0, r2, #4
@   0x08005c20: 1840        adds	r0, r0, r1
@   0x08005c22: 7800        ldrb	r0, [r0, #0]
@   0x08005c24: 0600        lsls	r0, r0, #24
@   0x08005c26: 1600        asrs	r0, r0, #24
@   0x08005c28: 8869        ldrh	r1, [r5, #2]
@   0x08005c2a: 1808        adds	r0, r1, r0
@   0x08005c2c: 8068        strh	r0, [r5, #2]
@   0x08005c2e: 782a        ldrb	r2, [r5, #0]
@   0x08005c30: 00d0        lsls	r0, r2, #3
@   0x08005c32: 1900        adds	r0, r0, r4
@   0x08005c34: 6801        ldr	r1, [r0, #0]
@   0x08005c36: 7eaa        ldrb	r2, [r5, #26]
@   0x08005c38: 0050        lsls	r0, r2, #1
@   0x08005c3a: 1880        adds	r0, r0, r2
@   0x08005c3c: 0080        lsls	r0, r0, #2
@   0x08005c3e: 1840        adds	r0, r0, r1
@   0x08005c40: 6801        ldr	r1, [r0, #0]
@   0x08005c42: 7eea        ldrb	r2, [r5, #27]
@   0x08005c44: 0110        lsls	r0, r2, #4
@   0x08005c46: 1840        adds	r0, r0, r1
@   0x08005c48: 7840        ldrb	r0, [r0, #1]
@   0x08005c4a: 0600        lsls	r0, r0, #24
@   0x08005c4c: 1600        asrs	r0, r0, #24
@   0x08005c4e: 88a9        ldrh	r1, [r5, #4]
@   0x08005c50: 1808        adds	r0, r1, r0
@   0x08005c52: 80a8        strh	r0, [r5, #4]
@   0x08005c54: 782a        ldrb	r2, [r5, #0]
@   0x08005c56: 00d0        lsls	r0, r2, #3
@   0x08005c58: 1900        adds	r0, r0, r4
@   0x08005c5a: 6801        ldr	r1, [r0, #0]
@   0x08005c5c: 7eaa        ldrb	r2, [r5, #26]
@   0x08005c5e: 0050        lsls	r0, r2, #1
@   0x08005c60: 1880        adds	r0, r0, r2
@   0x08005c62: 0080        lsls	r0, r0, #2
@   0x08005c64: 1840        adds	r0, r0, r1
@   0x08005c66: 6801        ldr	r1, [r0, #0]
@   0x08005c68: 7eea        ldrb	r2, [r5, #27]
@   0x08005c6a: 0110        lsls	r0, r2, #4
@   0x08005c6c: 1840        adds	r0, r0, r1
@   0x08005c6e: 8940        ldrh	r0, [r0, #10]
@   0x08005c70: 84a8        strh	r0, [r5, #36]	@ 0x24
@   0x08005c72: 7829        ldrb	r1, [r5, #0]
@   0x08005c74: 00c8        lsls	r0, r1, #3
@   0x08005c76: 1900        adds	r0, r0, r4
@   0x08005c78: 6801        ldr	r1, [r0, #0]
@   0x08005c7a: 7eaa        ldrb	r2, [r5, #26]
@   0x08005c7c: 0050        lsls	r0, r2, #1
@   0x08005c7e: 1880        adds	r0, r0, r2
@   0x08005c80: 0080        lsls	r0, r0, #2
@   0x08005c82: 1840        adds	r0, r0, r1
@   0x08005c84: 6801        ldr	r1, [r0, #0]
@   0x08005c86: 7eea        ldrb	r2, [r5, #27]
@   0x08005c88: 0110        lsls	r0, r2, #4
@   0x08005c8a: 1840        adds	r0, r0, r1
@   0x08005c8c: 8980        ldrh	r0, [r0, #12]
@   0x08005c8e: 84e8        strh	r0, [r5, #38]	@ 0x26
@   0x08005c90: 7829        ldrb	r1, [r5, #0]
@   0x08005c92: 00c8        lsls	r0, r1, #3
@   0x08005c94: 1900        adds	r0, r0, r4
@   0x08005c96: 6801        ldr	r1, [r0, #0]
@   0x08005c98: 7eaa        ldrb	r2, [r5, #26]
@   0x08005c9a: 0050        lsls	r0, r2, #1
@   0x08005c9c: 1880        adds	r0, r0, r2
@   0x08005c9e: 0080        lsls	r0, r0, #2
@   0x08005ca0: 1840        adds	r0, r0, r1
@   0x08005ca2: 6801        ldr	r1, [r0, #0]
@   0x08005ca4: 7eea        ldrb	r2, [r5, #27]
@   0x08005ca6: 0110        lsls	r0, r2, #4
@   0x08005ca8: 1840        adds	r0, r0, r1
@   0x08005caa: 7b81        ldrb	r1, [r0, #14]
@   0x08005cac: 1c28        adds	r0, r5, #0
@   0x08005cae: 3028        adds	r0, #40	@ 0x28
@   0x08005cb0: 7001        strb	r1, [r0, #0]
@   0x08005cb2: 7829        ldrb	r1, [r5, #0]
@   0x08005cb4: 00c8        lsls	r0, r1, #3
@   0x08005cb6: 1900        adds	r0, r0, r4
@   0x08005cb8: 6801        ldr	r1, [r0, #0]
@   0x08005cba: 7eaa        ldrb	r2, [r5, #26]
@   0x08005cbc: 0050        lsls	r0, r2, #1
@   0x08005cbe: 1880        adds	r0, r0, r2
@   0x08005cc0: 0080        lsls	r0, r0, #2
@   0x08005cc2: 1840        adds	r0, r0, r1
@   0x08005cc4: 6801        ldr	r1, [r0, #0]
@   0x08005cc6: 7eea        ldrb	r2, [r5, #27]
@   0x08005cc8: 0110        lsls	r0, r2, #4
@   0x08005cca: 1840        adds	r0, r0, r1
@   0x08005ccc: 7bc0        ldrb	r0, [r0, #15]
@   0x08005cce: 1c29        adds	r1, r5, #0
@   0x08005cd0: 3129        adds	r1, #41	@ 0x29
@   0x08005cd2: 7008        strb	r0, [r1, #0]
@   0x08005cd4: 7829        ldrb	r1, [r5, #0]
@   0x08005cd6: 00c8        lsls	r0, r1, #3
@   0x08005cd8: 1900        adds	r0, r0, r4
@   0x08005cda: 6801        ldr	r1, [r0, #0]
@   0x08005cdc: 7eaa        ldrb	r2, [r5, #26]
@   0x08005cde: 0050        lsls	r0, r2, #1
@   0x08005ce0: 1880        adds	r0, r0, r2
@   0x08005ce2: 0080        lsls	r0, r0, #2
@   0x08005ce4: 1840        adds	r0, r0, r1
@   0x08005ce6: 6801        ldr	r1, [r0, #0]
@   0x08005ce8: 7eea        ldrb	r2, [r5, #27]
@   0x08005cea: 0110        lsls	r0, r2, #4
@   0x08005cec: 1840        adds	r0, r0, r1
@   0x08005cee: 7a00        ldrb	r0, [r0, #8]
@   0x08005cf0: 7768        strb	r0, [r5, #29]
@   0x08005cf2: 2180        movs	r1, #128	@ 0x80
@   0x08005cf4: 0049        lsls	r1, r1, #1
@   0x08005cf6: 1c08        adds	r0, r1, #0
@   0x08005cf8: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x08005cfa: 4310        orrs	r0, r2
@   0x08005cfc: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08005cfe: f7fa        fdff 	bl	0x900
@   0x08005d02: 6228        str	r0, [r5, #32]
@   0x08005d04: bc30        pop	{r4, r5}
@   0x08005d06: bc01        pop	{r0}
@   0x08005d08: 4700        bx	r0
@   0x08005d0a: 0000        movs	r0, r0
@   0x08005d0c: 8ad8        ldrh	r0, [r3, #22]
@   0x08005d0e: 082f        lsrs	r7, r5, #32

        thumb_func_start Entity_Update
Entity_Update: @ 0x080059c4
        .incbin "frog_us_baserom.gba", 0x59c4, 0x34c
        thumb_func_end Entity_Update
