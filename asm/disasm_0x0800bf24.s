@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800bf24, 0x0800c2a8)  (900 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800bf24 --end 0x800c2a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800bf24: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800bf26: 4657        mov	r7, sl
@   0x0800bf28: 464e        mov	r6, r9
@   0x0800bf2a: 4645        mov	r5, r8
@   0x0800bf2c: b4e0        push	{r5, r6, r7}
@   0x0800bf2e: b089        sub	sp, #36	@ 0x24
@   0x0800bf30: 9003        str	r0, [sp, #12]
@   0x0800bf32: 9104        str	r1, [sp, #16]
@   0x0800bf34: 0612        lsls	r2, r2, #24
@   0x0800bf36: 0e12        lsrs	r2, r2, #24
@   0x0800bf38: 6808        ldr	r0, [r1, #0]
@   0x0800bf3a: 6849        ldr	r1, [r1, #4]
@   0x0800bf3c: 4308        orrs	r0, r1
@   0x0800bf3e: 2800        cmp	r0, #0
@   0x0800bf40: d100        bne.n	0xbf44
@   0x0800bf42: e1a4        b.n	0xc28e
@   0x0800bf44: 0615        lsls	r5, r2, #24
@   0x0800bf46: 162a        asrs	r2, r5, #24
@   0x0800bf48: 0050        lsls	r0, r2, #1
@   0x0800bf4a: 1880        adds	r0, r0, r2
@   0x0800bf4c: 0080        lsls	r0, r0, #2
@   0x0800bf4e: 4933        ldr	r1, [pc, #204]	@ (0xc01c)
@   0x0800bf50: 1840        adds	r0, r0, r1
@   0x0800bf52: 7a83        ldrb	r3, [r0, #10]
@   0x0800bf54: 2100        movs	r1, #0
@   0x0800bf56: 7800        ldrb	r0, [r0, #0]
@   0x0800bf58: 0600        lsls	r0, r0, #24
@   0x0800bf5a: 1600        asrs	r0, r0, #24
@   0x0800bf5c: 9507        str	r5, [sp, #28]
@   0x0800bf5e: 4281        cmp	r1, r0
@   0x0800bf60: db00        blt.n	0xbf64
@   0x0800bf62: e194        b.n	0xc28e
@   0x0800bf64: 4c2e        ldr	r4, [pc, #184]	@ (0xc020)
@   0x0800bf66: 46a2        mov	sl, r4
@   0x0800bf68: 4699        mov	r9, r3
@   0x0800bf6a: 9205        str	r2, [sp, #20]
@   0x0800bf6c: 9206        str	r2, [sp, #24]
@   0x0800bf6e: 0609        lsls	r1, r1, #24
@   0x0800bf70: 160f        asrs	r7, r1, #24
@   0x0800bf72: 9708        str	r7, [sp, #32]
@   0x0800bf74: 00f8        lsls	r0, r7, #3
@   0x0800bf76: 9a03        ldr	r2, [sp, #12]
@   0x0800bf78: 1886        adds	r6, r0, r2
@   0x0800bf7a: 4688        mov	r8, r1
@   0x0800bf7c: 7933        ldrb	r3, [r6, #4]
@   0x0800bf7e: 2b02        cmp	r3, #2
@   0x0800bf80: d000        beq.n	0xbf84
@   0x0800bf82: e080        b.n	0xc086
@   0x0800bf84: 162d        asrs	r5, r5, #24
@   0x0800bf86: 4654        mov	r4, sl
@   0x0800bf88: 7e20        ldrb	r0, [r4, #24]
@   0x0800bf8a: 006c        lsls	r4, r5, #1
@   0x0800bf8c: 1964        adds	r4, r4, r5
@   0x0800bf8e: 00a4        lsls	r4, r4, #2
@   0x0800bf90: 4f24        ldr	r7, [pc, #144]	@ (0xc024)
@   0x0800bf92: 19e1        adds	r1, r4, r7
@   0x0800bf94: 680a        ldr	r2, [r1, #0]
@   0x0800bf96: 4643        mov	r3, r8
@   0x0800bf98: 0d99        lsrs	r1, r3, #22
@   0x0800bf9a: 1889        adds	r1, r1, r2
@   0x0800bf9c: 2700        movs	r7, #0
@   0x0800bf9e: 5fca        ldrsh	r2, [r1, r7]
@   0x0800bfa0: 2702        movs	r7, #2
@   0x0800bfa2: 5fcb        ldrsh	r3, [r1, r7]
@   0x0800bfa4: 491d        ldr	r1, [pc, #116]	@ (0xc01c)
@   0x0800bfa6: 1864        adds	r4, r4, r1
@   0x0800bfa8: 7a21        ldrb	r1, [r4, #8]
@   0x0800bfaa: 9100        str	r1, [sp, #0]
@   0x0800bfac: 2100        movs	r1, #0
@   0x0800bfae: f000        fde7 	bl	0xcb80
@   0x0800bfb2: 2000        movs	r0, #0
@   0x0800bfb4: 71b0        strb	r0, [r6, #6]
@   0x0800bfb6: 4652        mov	r2, sl
@   0x0800bfb8: 7e10        ldrb	r0, [r2, #24]
@   0x0800bfba: 7e51        ldrb	r1, [r2, #25]
@   0x0800bfbc: 006a        lsls	r2, r5, #1
@   0x0800bfbe: 1952        adds	r2, r2, r5
@   0x0800bfc0: 0092        lsls	r2, r2, #2
@   0x0800bfc2: 4b18        ldr	r3, [pc, #96]	@ (0xc024)
@   0x0800bfc4: 18d5        adds	r5, r2, r3
@   0x0800bfc6: 682b        ldr	r3, [r5, #0]
@   0x0800bfc8: 9f08        ldr	r7, [sp, #32]
@   0x0800bfca: 00bc        lsls	r4, r7, #2
@   0x0800bfcc: 18e3        adds	r3, r4, r3
@   0x0800bfce: 2700        movs	r7, #0
@   0x0800bfd0: 5fda        ldrsh	r2, [r3, r7]
@   0x0800bfd2: 885b        ldrh	r3, [r3, #2]
@   0x0800bfd4: 3301        adds	r3, #1
@   0x0800bfd6: 041b        lsls	r3, r3, #16
@   0x0800bfd8: 141b        asrs	r3, r3, #16
@   0x0800bfda: f000        fed5 	bl	0xcd88
@   0x0800bfde: 0600        lsls	r0, r0, #24
@   0x0800bfe0: 0e00        lsrs	r0, r0, #24
@   0x0800bfe2: 2808        cmp	r0, #8
@   0x0800bfe4: d001        beq.n	0xbfea
@   0x0800bfe6: 280b        cmp	r0, #11
@   0x0800bfe8: d11e        bne.n	0xc028
@   0x0800bfea: 6829        ldr	r1, [r5, #0]
@   0x0800bfec: 1861        adds	r1, r4, r1
@   0x0800bfee: 2200        movs	r2, #0
@   0x0800bff0: 5e88        ldrsh	r0, [r1, r2]
@   0x0800bff2: 0043        lsls	r3, r0, #1
@   0x0800bff4: 181b        adds	r3, r3, r0
@   0x0800bff6: 041b        lsls	r3, r3, #16
@   0x0800bff8: 0c1b        lsrs	r3, r3, #16
@   0x0800bffa: 2402        movs	r4, #2
@   0x0800bffc: 5f09        ldrsh	r1, [r1, r4]
@   0x0800bffe: 0048        lsls	r0, r1, #1
@   0x0800c000: 1840        adds	r0, r0, r1
@   0x0800c002: 0400        lsls	r0, r0, #16
@   0x0800c004: 0c00        lsrs	r0, r0, #16
@   0x0800c006: 9000        str	r0, [sp, #0]
@   0x0800c008: 464f        mov	r7, r9
@   0x0800c00a: 9701        str	r7, [sp, #4]
@   0x0800c00c: 79b0        ldrb	r0, [r6, #6]
@   0x0800c00e: 9002        str	r0, [sp, #8]
@   0x0800c010: 2002        movs	r0, #2
@   0x0800c012: 2104        movs	r1, #4
@   0x0800c014: 2203        movs	r2, #3
@   0x0800c016: f005        f953 	bl	0x112c0
@   0x0800c01a: e01d        b.n	0xc058
@   0x0800c01c: 0b00        lsrs	r0, r0, #12
@   0x0800c01e: 080c        lsrs	r4, r1, #32
@   0x0800c020: 35e0        adds	r5, #224	@ 0xe0
@   0x0800c022: 0300        lsls	r0, r0, #12
@   0x0800c024: 0b04        lsrs	r4, r0, #12
@   0x0800c026: 080c        lsrs	r4, r1, #32
@   0x0800c028: 6829        ldr	r1, [r5, #0]
@   0x0800c02a: 1861        adds	r1, r4, r1
@   0x0800c02c: 2200        movs	r2, #0
@   0x0800c02e: 5e88        ldrsh	r0, [r1, r2]
@   0x0800c030: 0043        lsls	r3, r0, #1
@   0x0800c032: 181b        adds	r3, r3, r0
@   0x0800c034: 041b        lsls	r3, r3, #16
@   0x0800c036: 0c1b        lsrs	r3, r3, #16
@   0x0800c038: 2402        movs	r4, #2
@   0x0800c03a: 5f09        ldrsh	r1, [r1, r4]
@   0x0800c03c: 0048        lsls	r0, r1, #1
@   0x0800c03e: 1840        adds	r0, r0, r1
@   0x0800c040: 0400        lsls	r0, r0, #16
@   0x0800c042: 0c00        lsrs	r0, r0, #16
@   0x0800c044: 9000        str	r0, [sp, #0]
@   0x0800c046: 464f        mov	r7, r9
@   0x0800c048: 9701        str	r7, [sp, #4]
@   0x0800c04a: 79b0        ldrb	r0, [r6, #6]
@   0x0800c04c: 9002        str	r0, [sp, #8]
@   0x0800c04e: 2002        movs	r0, #2
@   0x0800c050: 2103        movs	r1, #3
@   0x0800c052: 2203        movs	r2, #3
@   0x0800c054: f005        f934 	bl	0x112c0
@   0x0800c058: 4640        mov	r0, r8
@   0x0800c05a: 1602        asrs	r2, r0, #24
@   0x0800c05c: 00d0        lsls	r0, r2, #3
@   0x0800c05e: 9903        ldr	r1, [sp, #12]
@   0x0800c060: 1840        adds	r0, r0, r1
@   0x0800c062: 7901        ldrb	r1, [r0, #4]
@   0x0800c064: 2300        movs	r3, #0
@   0x0800c066: 7141        strb	r1, [r0, #5]
@   0x0800c068: 7103        strb	r3, [r0, #4]
@   0x0800c06a: 2001        movs	r0, #1
@   0x0800c06c: 2100        movs	r1, #0
@   0x0800c06e: f027        fe19 	bl	0x33ca4
@   0x0800c072: 43c0        mvns	r0, r0
@   0x0800c074: 43c9        mvns	r1, r1
@   0x0800c076: 9c04        ldr	r4, [sp, #16]
@   0x0800c078: 6822        ldr	r2, [r4, #0]
@   0x0800c07a: 6863        ldr	r3, [r4, #4]
@   0x0800c07c: 4002        ands	r2, r0
@   0x0800c07e: 400b        ands	r3, r1
@   0x0800c080: 1c27        adds	r7, r4, #0
@   0x0800c082: 603a        str	r2, [r7, #0]
@   0x0800c084: 607b        str	r3, [r7, #4]
@   0x0800c086: 4640        mov	r0, r8
@   0x0800c088: 1605        asrs	r5, r0, #24
@   0x0800c08a: 00e8        lsls	r0, r5, #3
@   0x0800c08c: 9903        ldr	r1, [sp, #12]
@   0x0800c08e: 1846        adds	r6, r0, r1
@   0x0800c090: 7932        ldrb	r2, [r6, #4]
@   0x0800c092: 2a01        cmp	r2, #1
@   0x0800c094: d000        beq.n	0xc098
@   0x0800c096: e0ea        b.n	0xc26e
@   0x0800c098: 7970        ldrb	r0, [r6, #5]
@   0x0800c09a: 2800        cmp	r0, #0
@   0x0800c09c: d166        bne.n	0xc16c
@   0x0800c09e: 481d        ldr	r0, [pc, #116]	@ (0xc114)
@   0x0800c0a0: 6800        ldr	r0, [r0, #0]
@   0x0800c0a2: 6831        ldr	r1, [r6, #0]
@   0x0800c0a4: 1a40        subs	r0, r0, r1
@   0x0800c0a6: 2832        cmp	r0, #50	@ 0x32
@   0x0800c0a8: d800        bhi.n	0xc0ac
@   0x0800c0aa: e0e0        b.n	0xc26e
@   0x0800c0ac: 71b2        strb	r2, [r6, #6]
@   0x0800c0ae: 4652        mov	r2, sl
@   0x0800c0b0: 7e10        ldrb	r0, [r2, #24]
@   0x0800c0b2: 7e51        ldrb	r1, [r2, #25]
@   0x0800c0b4: 9b05        ldr	r3, [sp, #20]
@   0x0800c0b6: 005a        lsls	r2, r3, #1
@   0x0800c0b8: 18d2        adds	r2, r2, r3
@   0x0800c0ba: 0092        lsls	r2, r2, #2
@   0x0800c0bc: 4f16        ldr	r7, [pc, #88]	@ (0xc118)
@   0x0800c0be: 19d4        adds	r4, r2, r7
@   0x0800c0c0: 6823        ldr	r3, [r4, #0]
@   0x0800c0c2: 00ad        lsls	r5, r5, #2
@   0x0800c0c4: 18eb        adds	r3, r5, r3
@   0x0800c0c6: 2700        movs	r7, #0
@   0x0800c0c8: 5fda        ldrsh	r2, [r3, r7]
@   0x0800c0ca: 885b        ldrh	r3, [r3, #2]
@   0x0800c0cc: 3301        adds	r3, #1
@   0x0800c0ce: 041b        lsls	r3, r3, #16
@   0x0800c0d0: 141b        asrs	r3, r3, #16
@   0x0800c0d2: f000        fe59 	bl	0xcd88
@   0x0800c0d6: 0600        lsls	r0, r0, #24
@   0x0800c0d8: 0e00        lsrs	r0, r0, #24
@   0x0800c0da: 2808        cmp	r0, #8
@   0x0800c0dc: d001        beq.n	0xc0e2
@   0x0800c0de: 280b        cmp	r0, #11
@   0x0800c0e0: d11c        bne.n	0xc11c
@   0x0800c0e2: 6821        ldr	r1, [r4, #0]
@   0x0800c0e4: 1869        adds	r1, r5, r1
@   0x0800c0e6: 2200        movs	r2, #0
@   0x0800c0e8: 5e88        ldrsh	r0, [r1, r2]
@   0x0800c0ea: 0043        lsls	r3, r0, #1
@   0x0800c0ec: 181b        adds	r3, r3, r0
@   0x0800c0ee: 041b        lsls	r3, r3, #16
@   0x0800c0f0: 0c1b        lsrs	r3, r3, #16
@   0x0800c0f2: 2402        movs	r4, #2
@   0x0800c0f4: 5f09        ldrsh	r1, [r1, r4]
@   0x0800c0f6: 0048        lsls	r0, r1, #1
@   0x0800c0f8: 1840        adds	r0, r0, r1
@   0x0800c0fa: 0400        lsls	r0, r0, #16
@   0x0800c0fc: 0c00        lsrs	r0, r0, #16
@   0x0800c0fe: 9000        str	r0, [sp, #0]
@   0x0800c100: 464f        mov	r7, r9
@   0x0800c102: 9701        str	r7, [sp, #4]
@   0x0800c104: 79b0        ldrb	r0, [r6, #6]
@   0x0800c106: 9002        str	r0, [sp, #8]
@   0x0800c108: 2002        movs	r0, #2
@   0x0800c10a: 2104        movs	r1, #4
@   0x0800c10c: 2203        movs	r2, #3
@   0x0800c10e: f005        f8d7 	bl	0x112c0
@   0x0800c112: e01b        b.n	0xc14c
@   0x0800c114: 5330        strh	r0, [r6, r4]
@   0x0800c116: 0300        lsls	r0, r0, #12
@   0x0800c118: 0b04        lsrs	r4, r0, #12
@   0x0800c11a: 080c        lsrs	r4, r1, #32
@   0x0800c11c: 6821        ldr	r1, [r4, #0]
@   0x0800c11e: 1869        adds	r1, r5, r1
@   0x0800c120: 2200        movs	r2, #0
@   0x0800c122: 5e88        ldrsh	r0, [r1, r2]
@   0x0800c124: 0043        lsls	r3, r0, #1
@   0x0800c126: 181b        adds	r3, r3, r0
@   0x0800c128: 041b        lsls	r3, r3, #16
@   0x0800c12a: 0c1b        lsrs	r3, r3, #16
@   0x0800c12c: 2402        movs	r4, #2
@   0x0800c12e: 5f09        ldrsh	r1, [r1, r4]
@   0x0800c130: 0048        lsls	r0, r1, #1
@   0x0800c132: 1840        adds	r0, r0, r1
@   0x0800c134: 0400        lsls	r0, r0, #16
@   0x0800c136: 0c00        lsrs	r0, r0, #16
@   0x0800c138: 9000        str	r0, [sp, #0]
@   0x0800c13a: 464f        mov	r7, r9
@   0x0800c13c: 9701        str	r7, [sp, #4]
@   0x0800c13e: 79b0        ldrb	r0, [r6, #6]
@   0x0800c140: 9002        str	r0, [sp, #8]
@   0x0800c142: 2002        movs	r0, #2
@   0x0800c144: 2103        movs	r1, #3
@   0x0800c146: 2203        movs	r2, #3
@   0x0800c148: f005        f8ba 	bl	0x112c0
@   0x0800c14c: 4640        mov	r0, r8
@   0x0800c14e: 1541        asrs	r1, r0, #21
@   0x0800c150: 9a03        ldr	r2, [sp, #12]
@   0x0800c152: 1889        adds	r1, r1, r2
@   0x0800c154: 4804        ldr	r0, [pc, #16]	@ (0xc168)
@   0x0800c156: 6800        ldr	r0, [r0, #0]
@   0x0800c158: 6008        str	r0, [r1, #0]
@   0x0800c15a: 2001        movs	r0, #1
@   0x0800c15c: 7148        strb	r0, [r1, #5]
@   0x0800c15e: 2066        movs	r0, #102	@ 0x66
@   0x0800c160: f014        fd8a 	bl	0x20c78
@   0x0800c164: e083        b.n	0xc26e
@   0x0800c166: 0000        movs	r0, r0
@   0x0800c168: 5330        strh	r0, [r6, r4]
@   0x0800c16a: 0300        lsls	r0, r0, #12
@   0x0800c16c: 4805        ldr	r0, [pc, #20]	@ (0xc184)
@   0x0800c16e: 6800        ldr	r0, [r0, #0]
@   0x0800c170: 6831        ldr	r1, [r6, #0]
@   0x0800c172: 1a40        subs	r0, r0, r1
@   0x0800c174: 2805        cmp	r0, #5
@   0x0800c176: d97a        bls.n	0xc26e
@   0x0800c178: 79b0        ldrb	r0, [r6, #6]
@   0x0800c17a: 2804        cmp	r0, #4
@   0x0800c17c: d104        bne.n	0xc188
@   0x0800c17e: 2002        movs	r0, #2
@   0x0800c180: 7130        strb	r0, [r6, #4]
@   0x0800c182: e074        b.n	0xc26e
@   0x0800c184: 5330        strh	r0, [r6, r4]
@   0x0800c186: 0300        lsls	r0, r0, #12
@   0x0800c188: 2803        cmp	r0, #3
@   0x0800c18a: d116        bne.n	0xc1ba
@   0x0800c18c: 4653        mov	r3, sl
@   0x0800c18e: 7e18        ldrb	r0, [r3, #24]
@   0x0800c190: 9f06        ldr	r7, [sp, #24]
@   0x0800c192: 007c        lsls	r4, r7, #1
@   0x0800c194: 19e4        adds	r4, r4, r7
@   0x0800c196: 00a4        lsls	r4, r4, #2
@   0x0800c198: 4a23        ldr	r2, [pc, #140]	@ (0xc228)
@   0x0800c19a: 18a1        adds	r1, r4, r2
@   0x0800c19c: 680a        ldr	r2, [r1, #0]
@   0x0800c19e: 4643        mov	r3, r8
@   0x0800c1a0: 0d99        lsrs	r1, r3, #22
@   0x0800c1a2: 1889        adds	r1, r1, r2
@   0x0800c1a4: 2700        movs	r7, #0
@   0x0800c1a6: 5fca        ldrsh	r2, [r1, r7]
@   0x0800c1a8: 2702        movs	r7, #2
@   0x0800c1aa: 5fcb        ldrsh	r3, [r1, r7]
@   0x0800c1ac: 491f        ldr	r1, [pc, #124]	@ (0xc22c)
@   0x0800c1ae: 1864        adds	r4, r4, r1
@   0x0800c1b0: 7a61        ldrb	r1, [r4, #9]
@   0x0800c1b2: 9100        str	r1, [sp, #0]
@   0x0800c1b4: 2100        movs	r1, #0
@   0x0800c1b6: f000        fce3 	bl	0xcb80
@   0x0800c1ba: 79b0        ldrb	r0, [r6, #6]
@   0x0800c1bc: 3001        adds	r0, #1
@   0x0800c1be: 71b0        strb	r0, [r6, #6]
@   0x0800c1c0: 4652        mov	r2, sl
@   0x0800c1c2: 7e10        ldrb	r0, [r2, #24]
@   0x0800c1c4: 7e51        ldrb	r1, [r2, #25]
@   0x0800c1c6: 9b05        ldr	r3, [sp, #20]
@   0x0800c1c8: 005a        lsls	r2, r3, #1
@   0x0800c1ca: 18d2        adds	r2, r2, r3
@   0x0800c1cc: 0092        lsls	r2, r2, #2
@   0x0800c1ce: 4f16        ldr	r7, [pc, #88]	@ (0xc228)
@   0x0800c1d0: 19d4        adds	r4, r2, r7
@   0x0800c1d2: 6823        ldr	r3, [r4, #0]
@   0x0800c1d4: 00ad        lsls	r5, r5, #2
@   0x0800c1d6: 18eb        adds	r3, r5, r3
@   0x0800c1d8: 2700        movs	r7, #0
@   0x0800c1da: 5fda        ldrsh	r2, [r3, r7]
@   0x0800c1dc: 885b        ldrh	r3, [r3, #2]
@   0x0800c1de: 3301        adds	r3, #1
@   0x0800c1e0: 041b        lsls	r3, r3, #16
@   0x0800c1e2: 141b        asrs	r3, r3, #16
@   0x0800c1e4: f000        fdd0 	bl	0xcd88
@   0x0800c1e8: 0600        lsls	r0, r0, #24
@   0x0800c1ea: 0e00        lsrs	r0, r0, #24
@   0x0800c1ec: 2808        cmp	r0, #8
@   0x0800c1ee: d001        beq.n	0xc1f4
@   0x0800c1f0: 280b        cmp	r0, #11
@   0x0800c1f2: d11d        bne.n	0xc230
@   0x0800c1f4: 6821        ldr	r1, [r4, #0]
@   0x0800c1f6: 1869        adds	r1, r5, r1
@   0x0800c1f8: 2200        movs	r2, #0
@   0x0800c1fa: 5e88        ldrsh	r0, [r1, r2]
@   0x0800c1fc: 0043        lsls	r3, r0, #1
@   0x0800c1fe: 181b        adds	r3, r3, r0
@   0x0800c200: 041b        lsls	r3, r3, #16
@   0x0800c202: 0c1b        lsrs	r3, r3, #16
@   0x0800c204: 2402        movs	r4, #2
@   0x0800c206: 5f09        ldrsh	r1, [r1, r4]
@   0x0800c208: 0048        lsls	r0, r1, #1
@   0x0800c20a: 1840        adds	r0, r0, r1
@   0x0800c20c: 0400        lsls	r0, r0, #16
@   0x0800c20e: 0c00        lsrs	r0, r0, #16
@   0x0800c210: 9000        str	r0, [sp, #0]
@   0x0800c212: 464f        mov	r7, r9
@   0x0800c214: 9701        str	r7, [sp, #4]
@   0x0800c216: 79b0        ldrb	r0, [r6, #6]
@   0x0800c218: 9002        str	r0, [sp, #8]
@   0x0800c21a: 2002        movs	r0, #2
@   0x0800c21c: 2104        movs	r1, #4
@   0x0800c21e: 2203        movs	r2, #3
@   0x0800c220: f005        f84e 	bl	0x112c0
@   0x0800c224: e01c        b.n	0xc260
@   0x0800c226: 0000        movs	r0, r0
@   0x0800c228: 0b04        lsrs	r4, r0, #12
@   0x0800c22a: 080c        lsrs	r4, r1, #32
@   0x0800c22c: 0b00        lsrs	r0, r0, #12
@   0x0800c22e: 080c        lsrs	r4, r1, #32
@   0x0800c230: 6821        ldr	r1, [r4, #0]
@   0x0800c232: 1869        adds	r1, r5, r1
@   0x0800c234: 2200        movs	r2, #0
@   0x0800c236: 5e88        ldrsh	r0, [r1, r2]
@   0x0800c238: 0043        lsls	r3, r0, #1
@   0x0800c23a: 181b        adds	r3, r3, r0
@   0x0800c23c: 041b        lsls	r3, r3, #16
@   0x0800c23e: 0c1b        lsrs	r3, r3, #16
@   0x0800c240: 2402        movs	r4, #2
@   0x0800c242: 5f09        ldrsh	r1, [r1, r4]
@   0x0800c244: 0048        lsls	r0, r1, #1
@   0x0800c246: 1840        adds	r0, r0, r1
@   0x0800c248: 0400        lsls	r0, r0, #16
@   0x0800c24a: 0c00        lsrs	r0, r0, #16
@   0x0800c24c: 9000        str	r0, [sp, #0]
@   0x0800c24e: 464f        mov	r7, r9
@   0x0800c250: 9701        str	r7, [sp, #4]
@   0x0800c252: 79b0        ldrb	r0, [r6, #6]
@   0x0800c254: 9002        str	r0, [sp, #8]
@   0x0800c256: 2002        movs	r0, #2
@   0x0800c258: 2103        movs	r1, #3
@   0x0800c25a: 2203        movs	r2, #3
@   0x0800c25c: f005        f830 	bl	0x112c0
@   0x0800c260: 4641        mov	r1, r8
@   0x0800c262: 1548        asrs	r0, r1, #21
@   0x0800c264: 9a03        ldr	r2, [sp, #12]
@   0x0800c266: 1880        adds	r0, r0, r2
@   0x0800c268: 490d        ldr	r1, [pc, #52]	@ (0xc2a0)
@   0x0800c26a: 6809        ldr	r1, [r1, #0]
@   0x0800c26c: 6001        str	r1, [r0, #0]
@   0x0800c26e: 2280        movs	r2, #128	@ 0x80
@   0x0800c270: 0452        lsls	r2, r2, #17
@   0x0800c272: 4442        add	r2, r8
@   0x0800c274: 9d07        ldr	r5, [sp, #28]
@   0x0800c276: 1629        asrs	r1, r5, #24
@   0x0800c278: 0048        lsls	r0, r1, #1
@   0x0800c27a: 1840        adds	r0, r0, r1
@   0x0800c27c: 0080        lsls	r0, r0, #2
@   0x0800c27e: 4b09        ldr	r3, [pc, #36]	@ (0xc2a4)
@   0x0800c280: 18c0        adds	r0, r0, r3
@   0x0800c282: 0e11        lsrs	r1, r2, #24
@   0x0800c284: 7800        ldrb	r0, [r0, #0]
@   0x0800c286: 0600        lsls	r0, r0, #24
@   0x0800c288: 4282        cmp	r2, r0
@   0x0800c28a: da00        bge.n	0xc28e
@   0x0800c28c: e66f        b.n	0xbf6e
@   0x0800c28e: b009        add	sp, #36	@ 0x24
@   0x0800c290: bc38        pop	{r3, r4, r5}
@   0x0800c292: 4698        mov	r8, r3
@   0x0800c294: 46a1        mov	r9, r4
@   0x0800c296: 46aa        mov	sl, r5
@   0x0800c298: bcf0        pop	{r4, r5, r6, r7}
@   0x0800c29a: bc01        pop	{r0}
@   0x0800c29c: 4700        bx	r0
@   0x0800c29e: 0000        movs	r0, r0
@   0x0800c2a0: 5330        strh	r0, [r6, r4]
@   0x0800c2a2: 0300        lsls	r0, r0, #12
@   0x0800c2a4: 0b00        lsrs	r0, r0, #12
@   0x0800c2a6: 080c        lsrs	r4, r1, #32

        thumb_func_start Entity_ScanHitboxAndBlit
Entity_ScanHitboxAndBlit: @ 0x0800bf24
        .incbin "frog_us_baserom.gba", 0xbf24, 0x384
        thumb_func_end Entity_ScanHitboxAndBlit
