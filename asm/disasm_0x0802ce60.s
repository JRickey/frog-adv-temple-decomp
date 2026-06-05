@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ce60, 0x0802d170)  (784 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ce60 --end 0x802d170 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ce60: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802ce62: 4657        mov	r7, sl
@   0x0802ce64: 464e        mov	r6, r9
@   0x0802ce66: 4645        mov	r5, r8
@   0x0802ce68: b4e0        push	{r5, r6, r7}
@   0x0802ce6a: b085        sub	sp, #20
@   0x0802ce6c: 4d30        ldr	r5, [pc, #192]	@ (0x2cf30)
@   0x0802ce6e: 4831        ldr	r0, [pc, #196]	@ (0x2cf34)
@   0x0802ce70: 1940        adds	r0, r0, r5
@   0x0802ce72: 4681        mov	r9, r0
@   0x0802ce74: 8807        ldrh	r7, [r0, #0]
@   0x0802ce76: 4930        ldr	r1, [pc, #192]	@ (0x2cf38)
@   0x0802ce78: 1949        adds	r1, r1, r5
@   0x0802ce7a: 468a        mov	sl, r1
@   0x0802ce7c: 880a        ldrh	r2, [r1, #0]
@   0x0802ce7e: 4690        mov	r8, r2
@   0x0802ce80: 4e2e        ldr	r6, [pc, #184]	@ (0x2cf3c)
@   0x0802ce82: 1c30        adds	r0, r6, #0
@   0x0802ce84: 2102        movs	r1, #2
@   0x0802ce86: f7d9        fd71 	bl	0x696c
@   0x0802ce8a: 1c30        adds	r0, r6, #0
@   0x0802ce8c: 2108        movs	r1, #8
@   0x0802ce8e: 2201        movs	r2, #1
@   0x0802ce90: f7d9        fc84 	bl	0x679c
@   0x0802ce94: 0600        lsls	r0, r0, #24
@   0x0802ce96: 2800        cmp	r0, #0
@   0x0802ce98: d01e        beq.n	0x2ced8
@   0x0802ce9a: 1c30        adds	r0, r6, #0
@   0x0802ce9c: 2108        movs	r1, #8
@   0x0802ce9e: 2201        movs	r2, #1
@   0x0802cea0: f7d9        fc10 	bl	0x66c4
@   0x0802cea4: 1c30        adds	r0, r6, #0
@   0x0802cea6: 2108        movs	r1, #8
@   0x0802cea8: 2200        movs	r2, #0
@   0x0802ceaa: f7d9        fba9 	bl	0x6600
@   0x0802ceae: 4c24        ldr	r4, [pc, #144]	@ (0x2cf40)
@   0x0802ceb0: 2041        movs	r0, #65	@ 0x41
@   0x0802ceb2: 9000        str	r0, [sp, #0]
@   0x0802ceb4: 2001        movs	r0, #1
@   0x0802ceb6: 9001        str	r0, [sp, #4]
@   0x0802ceb8: 2003        movs	r0, #3
@   0x0802ceba: 9002        str	r0, [sp, #8]
@   0x0802cebc: 2002        movs	r0, #2
@   0x0802cebe: 9003        str	r0, [sp, #12]
@   0x0802cec0: 1c21        adds	r1, r4, #0
@   0x0802cec2: 2210        movs	r2, #16
@   0x0802cec4: 2359        movs	r3, #89	@ 0x59
@   0x0802cec6: f7f4        f8eb 	bl	0x210a0
@   0x0802ceca: 8920        ldrh	r0, [r4, #8]
@   0x0802cecc: 464b        mov	r3, r9
@   0x0802cece: 8018        strh	r0, [r3, #0]
@   0x0802ced0: 8960        ldrh	r0, [r4, #10]
@   0x0802ced2: 303a        adds	r0, #58	@ 0x3a
@   0x0802ced4: 4651        mov	r1, sl
@   0x0802ced6: 8008        strh	r0, [r1, #0]
@   0x0802ced8: 1c30        adds	r0, r6, #0
@   0x0802ceda: 2108        movs	r1, #8
@   0x0802cedc: 2200        movs	r2, #0
@   0x0802cede: f7d9        fc5d 	bl	0x679c
@   0x0802cee2: 0600        lsls	r0, r0, #24
@   0x0802cee4: 2800        cmp	r0, #0
@   0x0802cee6: d100        bne.n	0x2ceea
@   0x0802cee8: e12e        b.n	0x2d148
@   0x0802ceea: 2002        movs	r0, #2
@   0x0802ceec: f7f4        f826 	bl	0x20f3c
@   0x0802cef0: 2202        movs	r2, #2
@   0x0802cef2: 5ea8        ldrsh	r0, [r5, r2]
@   0x0802cef4: 2118        movs	r1, #24
@   0x0802cef6: f006        ff0d 	bl	0x33d14
@   0x0802cefa: 0400        lsls	r0, r0, #16
@   0x0802cefc: 0c00        lsrs	r0, r0, #16
@   0x0802cefe: 4911        ldr	r1, [pc, #68]	@ (0x2cf44)
@   0x0802cf00: 9c04        ldr	r4, [sp, #16]
@   0x0802cf02: 400c        ands	r4, r1
@   0x0802cf04: 4304        orrs	r4, r0
@   0x0802cf06: 9404        str	r4, [sp, #16]
@   0x0802cf08: 2304        movs	r3, #4
@   0x0802cf0a: 5ee8        ldrsh	r0, [r5, r3]
@   0x0802cf0c: 300e        adds	r0, #14
@   0x0802cf0e: 2118        movs	r1, #24
@   0x0802cf10: f006        ff00 	bl	0x33d14
@   0x0802cf14: 0400        lsls	r0, r0, #16
@   0x0802cf16: 490c        ldr	r1, [pc, #48]	@ (0x2cf48)
@   0x0802cf18: 400c        ands	r4, r1
@   0x0802cf1a: 4304        orrs	r4, r0
@   0x0802cf1c: 9404        str	r4, [sp, #16]
@   0x0802cf1e: 7ea8        ldrb	r0, [r5, #26]
@   0x0802cf20: 2804        cmp	r0, #4
@   0x0802cf22: d900        bls.n	0x2cf26
@   0x0802cf24: e0f9        b.n	0x2d11a
@   0x0802cf26: 0080        lsls	r0, r0, #2
@   0x0802cf28: 4908        ldr	r1, [pc, #32]	@ (0x2cf4c)
@   0x0802cf2a: 1840        adds	r0, r0, r1
@   0x0802cf2c: 6800        ldr	r0, [r0, #0]
@   0x0802cf2e: 4687        mov	pc, r0
@   0x0802cf30: 3790        adds	r7, #144	@ 0x90
@   0x0802cf32: 0300        lsls	r0, r0, #12
@   0x0802cf34: 0a82        lsrs	r2, r0, #10
@   0x0802cf36: 0000        movs	r0, r0
@   0x0802cf38: 0a84        lsrs	r4, r0, #10
@   0x0802cf3a: 0000        movs	r0, r0
@   0x0802cf3c: 6110        str	r0, [r2, #16]
@   0x0802cf3e: 0300        lsls	r0, r0, #12
@   0x0802cf40: 813c        strh	r4, [r7, #8]
@   0x0802cf42: 0831        lsrs	r1, r6, #32
@   0x0802cf44: 0000        movs	r0, r0
@   0x0802cf46: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0802cf4a: 0000        movs	r0, r0
@   0x0802cf4c: cf50        ldmia	r7!, {r4, r6}
@   0x0802cf4e: 0802        lsrs	r2, r0, #32
@   0x0802cf50: cf64        ldmia	r7!, {r2, r5, r6}
@   0x0802cf52: 0802        lsrs	r2, r0, #32
@   0x0802cf54: cf84        ldmia	r7, {r2, r7}
@   0x0802cf56: 0802        lsrs	r2, r0, #32
@   0x0802cf58: d004        beq.n	0x2cf64
@   0x0802cf5a: 0802        lsrs	r2, r0, #32
@   0x0802cf5c: d046        beq.n	0x2cfec
@   0x0802cf5e: 0802        lsrs	r2, r0, #32
@   0x0802cf60: d08e        beq.n	0x2ce80
@   0x0802cf62: 0802        lsrs	r2, r0, #32
@   0x0802cf64: 2080        movs	r0, #128	@ 0x80
@   0x0802cf66: 0200        lsls	r0, r0, #8
@   0x0802cf68: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802cf6a: 4008        ands	r0, r1
@   0x0802cf6c: 2800        cmp	r0, #0
@   0x0802cf6e: d100        bne.n	0x2cf72
@   0x0802cf70: e0ea        b.n	0x2d148
@   0x0802cf72: 4803        ldr	r0, [pc, #12]	@ (0x2cf80)
@   0x0802cf74: 2108        movs	r1, #8
@   0x0802cf76: 2202        movs	r2, #2
@   0x0802cf78: f7d9        fb42 	bl	0x6600
@   0x0802cf7c: e0cd        b.n	0x2d11a
@   0x0802cf7e: 0000        movs	r0, r0
@   0x0802cf80: 6110        str	r0, [r2, #16]
@   0x0802cf82: 0300        lsls	r0, r0, #12
@   0x0802cf84: a804        add	r0, sp, #16
@   0x0802cf86: 4a08        ldr	r2, [pc, #32]	@ (0x2cfa8)
@   0x0802cf88: 2302        movs	r3, #2
@   0x0802cf8a: 5ec1        ldrsh	r1, [r0, r3]
@   0x0802cf8c: 00c8        lsls	r0, r1, #3
@   0x0802cf8e: 1a40        subs	r0, r0, r1
@   0x0802cf90: 0040        lsls	r0, r0, #1
@   0x0802cf92: a904        add	r1, sp, #16
@   0x0802cf94: 2300        movs	r3, #0
@   0x0802cf96: 5ec9        ldrsh	r1, [r1, r3]
@   0x0802cf98: 1840        adds	r0, r0, r1
@   0x0802cf9a: 1880        adds	r0, r0, r2
@   0x0802cf9c: 7800        ldrb	r0, [r0, #0]
@   0x0802cf9e: 2800        cmp	r0, #0
@   0x0802cfa0: d104        bne.n	0x2cfac
@   0x0802cfa2: 2001        movs	r0, #1
@   0x0802cfa4: e003        b.n	0x2cfae
@   0x0802cfa6: 0000        movs	r0, r0
@   0x0802cfa8: 3610        adds	r6, #16
@   0x0802cfaa: 0300        lsls	r0, r0, #12
@   0x0802cfac: 2000        movs	r0, #0
@   0x0802cfae: 2800        cmp	r0, #0
@   0x0802cfb0: d01c        beq.n	0x2cfec
@   0x0802cfb2: 2000        movs	r0, #0
@   0x0802cfb4: 76a8        strb	r0, [r5, #26]
@   0x0802cfb6: 1c28        adds	r0, r5, #0
@   0x0802cfb8: 2100        movs	r1, #0
@   0x0802cfba: 2200        movs	r2, #0
@   0x0802cfbc: 2300        movs	r3, #0
@   0x0802cfbe: f7dd        fadf 	bl	0xa580
@   0x0802cfc2: 2002        movs	r0, #2
@   0x0802cfc4: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802cfc6: 4308        orrs	r0, r1
@   0x0802cfc8: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802cfca: 4c07        ldr	r4, [pc, #28]	@ (0x2cfe8)
@   0x0802cfcc: 6920        ldr	r0, [r4, #16]
@   0x0802cfce: 3801        subs	r0, #1
@   0x0802cfd0: 6120        str	r0, [r4, #16]
@   0x0802cfd2: 1c20        adds	r0, r4, #0
@   0x0802cfd4: 2108        movs	r1, #8
@   0x0802cfd6: 2203        movs	r2, #3
@   0x0802cfd8: f7d9        fb12 	bl	0x6600
@   0x0802cfdc: 6920        ldr	r0, [r4, #16]
@   0x0802cfde: 2800        cmp	r0, #0
@   0x0802cfe0: d100        bne.n	0x2cfe4
@   0x0802cfe2: e082        b.n	0x2d0ea
@   0x0802cfe4: e088        b.n	0x2d0f8
@   0x0802cfe6: 0000        movs	r0, r0
@   0x0802cfe8: 6110        str	r0, [r2, #16]
@   0x0802cfea: 0300        lsls	r0, r0, #12
@   0x0802cfec: 886a        ldrh	r2, [r5, #2]
@   0x0802cfee: 42ba        cmp	r2, r7
@   0x0802cff0: d000        beq.n	0x2cff4
@   0x0802cff2: e092        b.n	0x2d11a
@   0x0802cff4: 4643        mov	r3, r8
@   0x0802cff6: 0419        lsls	r1, r3, #16
@   0x0802cff8: 88aa        ldrh	r2, [r5, #4]
@   0x0802cffa: 0410        lsls	r0, r2, #16
@   0x0802cffc: 4288        cmp	r0, r1
@   0x0802cffe: dd00        ble.n	0x2d002
@   0x0802d000: e08b        b.n	0x2d11a
@   0x0802d002: e03e        b.n	0x2d082
@   0x0802d004: a804        add	r0, sp, #16
@   0x0802d006: 4a08        ldr	r2, [pc, #32]	@ (0x2d028)
@   0x0802d008: 2302        movs	r3, #2
@   0x0802d00a: 5ec1        ldrsh	r1, [r0, r3]
@   0x0802d00c: 00c8        lsls	r0, r1, #3
@   0x0802d00e: 1a40        subs	r0, r0, r1
@   0x0802d010: 0040        lsls	r0, r0, #1
@   0x0802d012: a904        add	r1, sp, #16
@   0x0802d014: 2300        movs	r3, #0
@   0x0802d016: 5ec9        ldrsh	r1, [r1, r3]
@   0x0802d018: 1840        adds	r0, r0, r1
@   0x0802d01a: 1880        adds	r0, r0, r2
@   0x0802d01c: 7800        ldrb	r0, [r0, #0]
@   0x0802d01e: 2800        cmp	r0, #0
@   0x0802d020: d104        bne.n	0x2d02c
@   0x0802d022: 2001        movs	r0, #1
@   0x0802d024: e003        b.n	0x2d02e
@   0x0802d026: 0000        movs	r0, r0
@   0x0802d028: 3610        adds	r6, #16
@   0x0802d02a: 0300        lsls	r0, r0, #12
@   0x0802d02c: 2000        movs	r0, #0
@   0x0802d02e: 2800        cmp	r0, #0
@   0x0802d030: d1bf        bne.n	0x2cfb2
@   0x0802d032: 886a        ldrh	r2, [r5, #2]
@   0x0802d034: 42ba        cmp	r2, r7
@   0x0802d036: d170        bne.n	0x2d11a
@   0x0802d038: 4643        mov	r3, r8
@   0x0802d03a: 0419        lsls	r1, r3, #16
@   0x0802d03c: 88aa        ldrh	r2, [r5, #4]
@   0x0802d03e: 0410        lsls	r0, r2, #16
@   0x0802d040: 4288        cmp	r0, r1
@   0x0802d042: db6a        blt.n	0x2d11a
@   0x0802d044: e01d        b.n	0x2d082
@   0x0802d046: a804        add	r0, sp, #16
@   0x0802d048: 4a07        ldr	r2, [pc, #28]	@ (0x2d068)
@   0x0802d04a: 2302        movs	r3, #2
@   0x0802d04c: 5ec1        ldrsh	r1, [r0, r3]
@   0x0802d04e: 00c8        lsls	r0, r1, #3
@   0x0802d050: 1a40        subs	r0, r0, r1
@   0x0802d052: 0040        lsls	r0, r0, #1
@   0x0802d054: a904        add	r1, sp, #16
@   0x0802d056: 2300        movs	r3, #0
@   0x0802d058: 5ec9        ldrsh	r1, [r1, r3]
@   0x0802d05a: 1840        adds	r0, r0, r1
@   0x0802d05c: 1880        adds	r0, r0, r2
@   0x0802d05e: 7800        ldrb	r0, [r0, #0]
@   0x0802d060: 2800        cmp	r0, #0
@   0x0802d062: d103        bne.n	0x2d06c
@   0x0802d064: 2001        movs	r0, #1
@   0x0802d066: e002        b.n	0x2d06e
@   0x0802d068: 3610        adds	r6, #16
@   0x0802d06a: 0300        lsls	r0, r0, #12
@   0x0802d06c: 2000        movs	r0, #0
@   0x0802d06e: 2800        cmp	r0, #0
@   0x0802d070: d19f        bne.n	0x2cfb2
@   0x0802d072: 0439        lsls	r1, r7, #16
@   0x0802d074: 886a        ldrh	r2, [r5, #2]
@   0x0802d076: 0410        lsls	r0, r2, #16
@   0x0802d078: 4288        cmp	r0, r1
@   0x0802d07a: dc4e        bgt.n	0x2d11a
@   0x0802d07c: 88ab        ldrh	r3, [r5, #4]
@   0x0802d07e: 4543        cmp	r3, r8
@   0x0802d080: d14b        bne.n	0x2d11a
@   0x0802d082: 1c28        adds	r0, r5, #0
@   0x0802d084: 210c        movs	r1, #12
@   0x0802d086: aa04        add	r2, sp, #16
@   0x0802d088: f7ff        fea2 	bl	0x2cdd0
@   0x0802d08c: e045        b.n	0x2d11a
@   0x0802d08e: a804        add	r0, sp, #16
@   0x0802d090: 4a07        ldr	r2, [pc, #28]	@ (0x2d0b0)
@   0x0802d092: 2302        movs	r3, #2
@   0x0802d094: 5ec1        ldrsh	r1, [r0, r3]
@   0x0802d096: 00c8        lsls	r0, r1, #3
@   0x0802d098: 1a40        subs	r0, r0, r1
@   0x0802d09a: 0040        lsls	r0, r0, #1
@   0x0802d09c: a904        add	r1, sp, #16
@   0x0802d09e: 2300        movs	r3, #0
@   0x0802d0a0: 5ec9        ldrsh	r1, [r1, r3]
@   0x0802d0a2: 1840        adds	r0, r0, r1
@   0x0802d0a4: 1880        adds	r0, r0, r2
@   0x0802d0a6: 7800        ldrb	r0, [r0, #0]
@   0x0802d0a8: 2800        cmp	r0, #0
@   0x0802d0aa: d103        bne.n	0x2d0b4
@   0x0802d0ac: 2001        movs	r0, #1
@   0x0802d0ae: e002        b.n	0x2d0b6
@   0x0802d0b0: 3610        adds	r6, #16
@   0x0802d0b2: 0300        lsls	r0, r0, #12
@   0x0802d0b4: 2000        movs	r0, #0
@   0x0802d0b6: 2800        cmp	r0, #0
@   0x0802d0b8: d022        beq.n	0x2d100
@   0x0802d0ba: 2000        movs	r0, #0
@   0x0802d0bc: 76a8        strb	r0, [r5, #26]
@   0x0802d0be: 1c28        adds	r0, r5, #0
@   0x0802d0c0: 2100        movs	r1, #0
@   0x0802d0c2: 2200        movs	r2, #0
@   0x0802d0c4: 2300        movs	r3, #0
@   0x0802d0c6: f7dd        fa5b 	bl	0xa580
@   0x0802d0ca: 2002        movs	r0, #2
@   0x0802d0cc: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802d0ce: 4308        orrs	r0, r1
@   0x0802d0d0: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802d0d2: 4c08        ldr	r4, [pc, #32]	@ (0x2d0f4)
@   0x0802d0d4: 6920        ldr	r0, [r4, #16]
@   0x0802d0d6: 3801        subs	r0, #1
@   0x0802d0d8: 6120        str	r0, [r4, #16]
@   0x0802d0da: 1c20        adds	r0, r4, #0
@   0x0802d0dc: 2108        movs	r1, #8
@   0x0802d0de: 2203        movs	r2, #3
@   0x0802d0e0: f7d9        fa8e 	bl	0x6600
@   0x0802d0e4: 6920        ldr	r0, [r4, #16]
@   0x0802d0e6: 2800        cmp	r0, #0
@   0x0802d0e8: d106        bne.n	0x2d0f8
@   0x0802d0ea: 2069        movs	r0, #105	@ 0x69
@   0x0802d0ec: f7f3        fdc4 	bl	0x20c78
@   0x0802d0f0: e013        b.n	0x2d11a
@   0x0802d0f2: 0000        movs	r0, r0
@   0x0802d0f4: 6110        str	r0, [r2, #16]
@   0x0802d0f6: 0300        lsls	r0, r0, #12
@   0x0802d0f8: 207a        movs	r0, #122	@ 0x7a
@   0x0802d0fa: f7f3        fdbd 	bl	0x20c78
@   0x0802d0fe: e00c        b.n	0x2d11a
@   0x0802d100: 0439        lsls	r1, r7, #16
@   0x0802d102: 886a        ldrh	r2, [r5, #2]
@   0x0802d104: 0410        lsls	r0, r2, #16
@   0x0802d106: 4288        cmp	r0, r1
@   0x0802d108: db07        blt.n	0x2d11a
@   0x0802d10a: 88ab        ldrh	r3, [r5, #4]
@   0x0802d10c: 4543        cmp	r3, r8
@   0x0802d10e: d104        bne.n	0x2d11a
@   0x0802d110: 1c28        adds	r0, r5, #0
@   0x0802d112: 210c        movs	r1, #12
@   0x0802d114: aa04        add	r2, sp, #16
@   0x0802d116: f7ff        fe5b 	bl	0x2cdd0
@   0x0802d11a: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802d11c: 2080        movs	r0, #128	@ 0x80
@   0x0802d11e: 0200        lsls	r0, r0, #8
@   0x0802d120: 4008        ands	r0, r1
@   0x0802d122: 2800        cmp	r0, #0
@   0x0802d124: d010        beq.n	0x2d148
@   0x0802d126: 480e        ldr	r0, [pc, #56]	@ (0x2d160)
@   0x0802d128: 6900        ldr	r0, [r0, #16]
@   0x0802d12a: 2800        cmp	r0, #0
@   0x0802d12c: d102        bne.n	0x2d134
@   0x0802d12e: 2008        movs	r0, #8
@   0x0802d130: 4308        orrs	r0, r1
@   0x0802d132: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802d134: 2002        movs	r0, #2
@   0x0802d136: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802d138: 4308        orrs	r0, r1
@   0x0802d13a: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802d13c: 4909        ldr	r1, [pc, #36]	@ (0x2d164)
@   0x0802d13e: 31a4        adds	r1, #164	@ 0xa4
@   0x0802d140: 4809        ldr	r0, [pc, #36]	@ (0x2d168)
@   0x0802d142: 880a        ldrh	r2, [r1, #0]
@   0x0802d144: 4010        ands	r0, r2
@   0x0802d146: 8008        strh	r0, [r1, #0]
@   0x0802d148: 4808        ldr	r0, [pc, #32]	@ (0x2d16c)
@   0x0802d14a: f7d8        fc3b 	bl	0x59c4
@   0x0802d14e: b005        add	sp, #20
@   0x0802d150: bc38        pop	{r3, r4, r5}
@   0x0802d152: 4698        mov	r8, r3
@   0x0802d154: 46a1        mov	r9, r4
@   0x0802d156: 46aa        mov	sl, r5
@   0x0802d158: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d15a: bc01        pop	{r0}
@   0x0802d15c: 4700        bx	r0
@   0x0802d15e: 0000        movs	r0, r0
@   0x0802d160: 6110        str	r0, [r2, #16]
@   0x0802d162: 0300        lsls	r0, r0, #12
@   0x0802d164: 3720        adds	r7, #32
@   0x0802d166: 0300        lsls	r0, r0, #12
@   0x0802d168: 7fff        ldrb	r7, [r7, #31]
@   0x0802d16a: 0000        movs	r0, r0
@   0x0802d16c: 3790        adds	r7, #144	@ 0x90
@   0x0802d16e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802CE60
sub_0802CE60: @ 0x0802ce60
        .incbin "frog_us_baserom.gba", 0x2ce60, 0x310
        thumb_func_end sub_0802CE60
