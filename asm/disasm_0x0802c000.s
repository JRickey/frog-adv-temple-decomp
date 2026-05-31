@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802c000, 0x0802c200)  (512 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802c000 --end 0x802c200 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802c000: b530        push	{r4, r5, lr}
@   0x0802c002: 4c19        ldr	r4, [pc, #100]	@ (0x2c068)
@   0x0802c004: 1c20        adds	r0, r4, #0
@   0x0802c006: 2103        movs	r1, #3
@   0x0802c008: 2205        movs	r2, #5
@   0x0802c00a: f7da        fbc7 	bl	0x679c
@   0x0802c00e: 0600        lsls	r0, r0, #24
@   0x0802c010: 1c25        adds	r5, r4, #0
@   0x0802c012: 2800        cmp	r0, #0
@   0x0802c014: d016        beq.n	0x2c044
@   0x0802c016: 4c15        ldr	r4, [pc, #84]	@ (0x2c06c)
@   0x0802c018: 4815        ldr	r0, [pc, #84]	@ (0x2c070)
@   0x0802c01a: 1821        adds	r1, r4, r0
@   0x0802c01c: 2000        movs	r0, #0
@   0x0802c01e: 7008        strb	r0, [r1, #0]
@   0x0802c020: 4a14        ldr	r2, [pc, #80]	@ (0x2c074)
@   0x0802c022: 18a1        adds	r1, r4, r2
@   0x0802c024: 2002        movs	r0, #2
@   0x0802c026: 880b        ldrh	r3, [r1, #0]
@   0x0802c028: 4318        orrs	r0, r3
@   0x0802c02a: 8008        strh	r0, [r1, #0]
@   0x0802c02c: f7e9        f8b2 	bl	0x15194
@   0x0802c030: 4811        ldr	r0, [pc, #68]	@ (0x2c078)
@   0x0802c032: 1824        adds	r4, r4, r0
@   0x0802c034: 4811        ldr	r0, [pc, #68]	@ (0x2c07c)
@   0x0802c036: 6800        ldr	r0, [r0, #0]
@   0x0802c038: 6020        str	r0, [r4, #0]
@   0x0802c03a: 1c28        adds	r0, r5, #0
@   0x0802c03c: 2103        movs	r1, #3
@   0x0802c03e: 2205        movs	r2, #5
@   0x0802c040: f7da        fb40 	bl	0x66c4
@   0x0802c044: 2500        movs	r5, #0
@   0x0802c046: 4809        ldr	r0, [pc, #36]	@ (0x2c06c)
@   0x0802c048: 490d        ldr	r1, [pc, #52]	@ (0x2c080)
@   0x0802c04a: 1840        adds	r0, r0, r1
@   0x0802c04c: 2200        movs	r2, #0
@   0x0802c04e: 5e80        ldrsh	r0, [r0, r2]
@   0x0802c050: 2103        movs	r1, #3
@   0x0802c052: f007        fedf 	bl	0x33e14
@   0x0802c056: 0400        lsls	r0, r0, #16
@   0x0802c058: 1401        asrs	r1, r0, #16
@   0x0802c05a: 2901        cmp	r1, #1
@   0x0802c05c: d026        beq.n	0x2c0ac
@   0x0802c05e: 2901        cmp	r1, #1
@   0x0802c060: dc10        bgt.n	0x2c084
@   0x0802c062: 2900        cmp	r1, #0
@   0x0802c064: d011        beq.n	0x2c08a
@   0x0802c066: e047        b.n	0x2c0f8
@   0x0802c068: 6110        str	r0, [r2, #16]
@   0x0802c06a: 0300        lsls	r0, r0, #12
@   0x0802c06c: 3720        adds	r7, #32
@   0x0802c06e: 0300        lsls	r0, r0, #12
@   0x0802c070: 04ea        lsls	r2, r5, #19
@   0x0802c072: 0000        movs	r0, r0
@   0x0802c074: 0504        lsls	r4, r0, #20
@   0x0802c076: 0000        movs	r0, r0
@   0x0802c078: 0b1c        lsrs	r4, r3, #12
@   0x0802c07a: 0000        movs	r0, r0
@   0x0802c07c: 5330        strh	r0, [r6, r4]
@   0x0802c07e: 0300        lsls	r0, r0, #12
@   0x0802c080: 0af2        lsrs	r2, r6, #11
@   0x0802c082: 0000        movs	r0, r0
@   0x0802c084: 2902        cmp	r1, #2
@   0x0802c086: d025        beq.n	0x2c0d4
@   0x0802c088: e036        b.n	0x2c0f8
@   0x0802c08a: 4905        ldr	r1, [pc, #20]	@ (0x2c0a0)
@   0x0802c08c: 2001        movs	r0, #1
@   0x0802c08e: 7008        strb	r0, [r1, #0]
@   0x0802c090: 4804        ldr	r0, [pc, #16]	@ (0x2c0a4)
@   0x0802c092: 4a05        ldr	r2, [pc, #20]	@ (0x2c0a8)
@   0x0802c094: 210c        movs	r1, #12
@   0x0802c096: 2300        movs	r3, #0
@   0x0802c098: f7e8        ffd4 	bl	0x15044
@   0x0802c09c: e00e        b.n	0x2c0bc
@   0x0802c09e: 0000        movs	r0, r0
@   0x0802c0a0: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x0802c0a2: 0300        lsls	r0, r0, #12
@   0x0802c0a4: 79dc        ldrb	r4, [r3, #7]
@   0x0802c0a6: 0830        lsrs	r0, r6, #32
@   0x0802c0a8: 7cb0        ldrb	r0, [r6, #18]
@   0x0802c0aa: 0830        lsrs	r0, r6, #32
@   0x0802c0ac: 4806        ldr	r0, [pc, #24]	@ (0x2c0c8)
@   0x0802c0ae: 7001        strb	r1, [r0, #0]
@   0x0802c0b0: 4806        ldr	r0, [pc, #24]	@ (0x2c0cc)
@   0x0802c0b2: 4a07        ldr	r2, [pc, #28]	@ (0x2c0d0)
@   0x0802c0b4: 2108        movs	r1, #8
@   0x0802c0b6: 2300        movs	r3, #0
@   0x0802c0b8: f7e8        ff16 	bl	0x14ee8
@   0x0802c0bc: 0600        lsls	r0, r0, #24
@   0x0802c0be: 0e05        lsrs	r5, r0, #24
@   0x0802c0c0: 2d00        cmp	r5, #0
@   0x0802c0c2: d019        beq.n	0x2c0f8
@   0x0802c0c4: 2502        movs	r5, #2
@   0x0802c0c6: e017        b.n	0x2c0f8
@   0x0802c0c8: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0802c0ca: 0300        lsls	r0, r0, #12
@   0x0802c0cc: 791c        ldrb	r4, [r3, #4]
@   0x0802c0ce: 0830        lsrs	r0, r6, #32
@   0x0802c0d0: 7cb0        ldrb	r0, [r6, #18]
@   0x0802c0d2: 0830        lsrs	r0, r6, #32
@   0x0802c0d4: 481e        ldr	r0, [pc, #120]	@ (0x2c150)
@   0x0802c0d6: 4c1f        ldr	r4, [pc, #124]	@ (0x2c154)
@   0x0802c0d8: 2108        movs	r1, #8
@   0x0802c0da: 1c22        adds	r2, r4, #0
@   0x0802c0dc: 2300        movs	r3, #0
@   0x0802c0de: f7e8        ff03 	bl	0x14ee8
@   0x0802c0e2: 0600        lsls	r0, r0, #24
@   0x0802c0e4: 0e05        lsrs	r5, r0, #24
@   0x0802c0e6: 481c        ldr	r0, [pc, #112]	@ (0x2c158)
@   0x0802c0e8: 210c        movs	r1, #12
@   0x0802c0ea: 1c22        adds	r2, r4, #0
@   0x0802c0ec: 2300        movs	r3, #0
@   0x0802c0ee: f7e8        ffa9 	bl	0x15044
@   0x0802c0f2: 1828        adds	r0, r5, r0
@   0x0802c0f4: 0600        lsls	r0, r0, #24
@   0x0802c0f6: 0e05        lsrs	r5, r0, #24
@   0x0802c0f8: 2d02        cmp	r5, #2
@   0x0802c0fa: d13a        bne.n	0x2c172
@   0x0802c0fc: 4817        ldr	r0, [pc, #92]	@ (0x2c15c)
@   0x0802c0fe: 4b18        ldr	r3, [pc, #96]	@ (0x2c160)
@   0x0802c100: 18c2        adds	r2, r0, r3
@   0x0802c102: 8810        ldrh	r0, [r2, #0]
@   0x0802c104: 3001        adds	r0, #1
@   0x0802c106: 8010        strh	r0, [r2, #0]
@   0x0802c108: 0400        lsls	r0, r0, #16
@   0x0802c10a: 1400        asrs	r0, r0, #16
@   0x0802c10c: 4d15        ldr	r5, [pc, #84]	@ (0x2c164)
@   0x0802c10e: 2803        cmp	r0, #3
@   0x0802c110: d104        bne.n	0x2c11c
@   0x0802c112: 1c29        adds	r1, r5, #0
@   0x0802c114: 312a        adds	r1, #42	@ 0x2a
@   0x0802c116: 7808        ldrb	r0, [r1, #0]
@   0x0802c118: 3001        adds	r0, #1
@   0x0802c11a: 7008        strb	r0, [r1, #0]
@   0x0802c11c: 2100        movs	r1, #0
@   0x0802c11e: 5e50        ldrsh	r0, [r2, r1]
@   0x0802c120: 2802        cmp	r0, #2
@   0x0802c122: dd21        ble.n	0x2c168
@   0x0802c124: 2000        movs	r0, #0
@   0x0802c126: 8010        strh	r0, [r2, #0]
@   0x0802c128: 1c29        adds	r1, r5, #0
@   0x0802c12a: 312a        adds	r1, #42	@ 0x2a
@   0x0802c12c: 7008        strb	r0, [r1, #0]
@   0x0802c12e: 1c28        adds	r0, r5, #0
@   0x0802c130: 2103        movs	r1, #3
@   0x0802c132: 2206        movs	r2, #6
@   0x0802c134: f7da        fa64 	bl	0x6600
@   0x0802c138: 1c28        adds	r0, r5, #0
@   0x0802c13a: 2103        movs	r1, #3
@   0x0802c13c: 2201        movs	r2, #1
@   0x0802c13e: f7da        fa5f 	bl	0x6600
@   0x0802c142: 1c28        adds	r0, r5, #0
@   0x0802c144: 2103        movs	r1, #3
@   0x0802c146: 2200        movs	r2, #0
@   0x0802c148: f7da        fabc 	bl	0x66c4
@   0x0802c14c: e011        b.n	0x2c172
@   0x0802c14e: 0000        movs	r0, r0
@   0x0802c150: 791c        ldrb	r4, [r3, #4]
@   0x0802c152: 0830        lsrs	r0, r6, #32
@   0x0802c154: 7cb0        ldrb	r0, [r6, #18]
@   0x0802c156: 0830        lsrs	r0, r6, #32
@   0x0802c158: 79dc        ldrb	r4, [r3, #7]
@   0x0802c15a: 0830        lsrs	r0, r6, #32
@   0x0802c15c: 3720        adds	r7, #32
@   0x0802c15e: 0300        lsls	r0, r0, #12
@   0x0802c160: 0af2        lsrs	r2, r6, #11
@   0x0802c162: 0000        movs	r0, r0
@   0x0802c164: 6110        str	r0, [r2, #16]
@   0x0802c166: 0300        lsls	r0, r0, #12
@   0x0802c168: 1c28        adds	r0, r5, #0
@   0x0802c16a: 2103        movs	r1, #3
@   0x0802c16c: 2205        movs	r2, #5
@   0x0802c16e: f7da        fa47 	bl	0x6600
@   0x0802c172: 491f        ldr	r1, [pc, #124]	@ (0x2c1f0)
@   0x0802c174: 2001        movs	r0, #1
@   0x0802c176: 7c09        ldrb	r1, [r1, #16]
@   0x0802c178: 4008        ands	r0, r1
@   0x0802c17a: 2800        cmp	r0, #0
@   0x0802c17c: d134        bne.n	0x2c1e8
@   0x0802c17e: 4c1d        ldr	r4, [pc, #116]	@ (0x2c1f4)
@   0x0802c180: 2004        movs	r0, #4
@   0x0802c182: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x0802c184: 4010        ands	r0, r2
@   0x0802c186: 2800        cmp	r0, #0
@   0x0802c188: d12e        bne.n	0x2c1e8
@   0x0802c18a: 481b        ldr	r0, [pc, #108]	@ (0x2c1f8)
@   0x0802c18c: 2336        movs	r3, #54	@ 0x36
@   0x0802c18e: 5ec0        ldrsh	r0, [r0, r3]
@   0x0802c190: 2103        movs	r1, #3
@   0x0802c192: f007        fdbf 	bl	0x33d14
@   0x0802c196: 4a19        ldr	r2, [pc, #100]	@ (0x2c1fc)
@   0x0802c198: 0400        lsls	r0, r0, #16
@   0x0802c19a: 8953        ldrh	r3, [r2, #10]
@   0x0802c19c: 0419        lsls	r1, r3, #16
@   0x0802c19e: 4288        cmp	r0, r1
@   0x0802c1a0: d10a        bne.n	0x2c1b8
@   0x0802c1a2: 7ea0        ldrb	r0, [r4, #26]
@   0x0802c1a4: 3808        subs	r0, #8
@   0x0802c1a6: 0600        lsls	r0, r0, #24
@   0x0802c1a8: 0e00        lsrs	r0, r0, #24
@   0x0802c1aa: 2803        cmp	r0, #3
@   0x0802c1ac: d904        bls.n	0x2c1b8
@   0x0802c1ae: 2180        movs	r1, #128	@ 0x80
@   0x0802c1b0: 0189        lsls	r1, r1, #6
@   0x0802c1b2: 1c10        adds	r0, r2, #0
@   0x0802c1b4: f7da        fce8 	bl	0x6b88
@   0x0802c1b8: 480f        ldr	r0, [pc, #60]	@ (0x2c1f8)
@   0x0802c1ba: 2134        movs	r1, #52	@ 0x34
@   0x0802c1bc: 5e40        ldrsh	r0, [r0, r1]
@   0x0802c1be: 2103        movs	r1, #3
@   0x0802c1c0: f007        fda8 	bl	0x33d14
@   0x0802c1c4: 4a0d        ldr	r2, [pc, #52]	@ (0x2c1fc)
@   0x0802c1c6: 0400        lsls	r0, r0, #16
@   0x0802c1c8: 8913        ldrh	r3, [r2, #8]
@   0x0802c1ca: 0419        lsls	r1, r3, #16
@   0x0802c1cc: 4288        cmp	r0, r1
@   0x0802c1ce: d10b        bne.n	0x2c1e8
@   0x0802c1d0: 4808        ldr	r0, [pc, #32]	@ (0x2c1f4)
@   0x0802c1d2: 7e80        ldrb	r0, [r0, #26]
@   0x0802c1d4: 3808        subs	r0, #8
@   0x0802c1d6: 0600        lsls	r0, r0, #24
@   0x0802c1d8: 0e00        lsrs	r0, r0, #24
@   0x0802c1da: 2803        cmp	r0, #3
@   0x0802c1dc: d904        bls.n	0x2c1e8
@   0x0802c1de: 2180        movs	r1, #128	@ 0x80
@   0x0802c1e0: 0189        lsls	r1, r1, #6
@   0x0802c1e2: 1c10        adds	r0, r2, #0
@   0x0802c1e4: f7da        fcd0 	bl	0x6b88
@   0x0802c1e8: bc30        pop	{r4, r5}
@   0x0802c1ea: bc01        pop	{r0}
@   0x0802c1ec: 4700        bx	r0
@   0x0802c1ee: 0000        movs	r0, r0
@   0x0802c1f0: 5330        strh	r0, [r6, r4]
@   0x0802c1f2: 0300        lsls	r0, r0, #12
@   0x0802c1f4: 3720        adds	r7, #32
@   0x0802c1f6: 0300        lsls	r0, r0, #12
@   0x0802c1f8: 6540        str	r0, [r0, #84]	@ 0x54
@   0x0802c1fa: 0300        lsls	r0, r0, #12
@   0x0802c1fc: 35e0        adds	r5, #224	@ 0xe0
@   0x0802c1fe: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802C000
sub_0802C000: @ 0x0802c000
        .incbin "frog_us_baserom.gba", 0x2c000, 0x200
        thumb_func_end sub_0802C000
