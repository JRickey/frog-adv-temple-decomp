@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801c078, 0x0801c2b4)  (572 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801c078 --end 0x801c2b4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801c078: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801c07a: 4657        mov	r7, sl
@   0x0801c07c: 464e        mov	r6, r9
@   0x0801c07e: 4645        mov	r5, r8
@   0x0801c080: b4e0        push	{r5, r6, r7}
@   0x0801c082: b084        sub	sp, #16
@   0x0801c084: 9000        str	r0, [sp, #0]
@   0x0801c086: 980c        ldr	r0, [sp, #48]	@ 0x30
@   0x0801c088: 9d0d        ldr	r5, [sp, #52]	@ 0x34
@   0x0801c08a: 9c0e        ldr	r4, [sp, #56]	@ 0x38
@   0x0801c08c: 0609        lsls	r1, r1, #24
@   0x0801c08e: 0e09        lsrs	r1, r1, #24
@   0x0801c090: 9101        str	r1, [sp, #4]
@   0x0801c092: 0612        lsls	r2, r2, #24
@   0x0801c094: 0e12        lsrs	r2, r2, #24
@   0x0801c096: 061b        lsls	r3, r3, #24
@   0x0801c098: 0e1f        lsrs	r7, r3, #24
@   0x0801c09a: 0400        lsls	r0, r0, #16
@   0x0801c09c: 0c00        lsrs	r0, r0, #16
@   0x0801c09e: 9002        str	r0, [sp, #8]
@   0x0801c0a0: 0624        lsls	r4, r4, #24
@   0x0801c0a2: 0e24        lsrs	r4, r4, #24
@   0x0801c0a4: 1c20        adds	r0, r4, #0
@   0x0801c0a6: 072d        lsls	r5, r5, #28
@   0x0801c0a8: 0c2d        lsrs	r5, r5, #16
@   0x0801c0aa: 46aa        mov	sl, r5
@   0x0801c0ac: 2100        movs	r1, #0
@   0x0801c0ae: 4688        mov	r8, r1
@   0x0801c0b0: 4689        mov	r9, r1
@   0x0801c0b2: 2c01        cmp	r4, #1
@   0x0801c0b4: d00e        beq.n	0x1c0d4
@   0x0801c0b6: 2c01        cmp	r4, #1
@   0x0801c0b8: dc02        bgt.n	0x1c0c0
@   0x0801c0ba: 2c00        cmp	r4, #0
@   0x0801c0bc: d005        beq.n	0x1c0ca
@   0x0801c0be: e012        b.n	0x1c0e6
@   0x0801c0c0: 2802        cmp	r0, #2
@   0x0801c0c2: d00b        beq.n	0x1c0dc
@   0x0801c0c4: 2803        cmp	r0, #3
@   0x0801c0c6: d00d        beq.n	0x1c0e4
@   0x0801c0c8: e00d        b.n	0x1c0e6
@   0x0801c0ca: 4e01        ldr	r6, [pc, #4]	@ (0x1c0d0)
@   0x0801c0cc: e00b        b.n	0x1c0e6
@   0x0801c0ce: 0000        movs	r0, r0
@   0x0801c0d0: e000        b.n	0x1c0d4
@   0x0801c0d2: 0600        lsls	r0, r0, #24
@   0x0801c0d4: 4e00        ldr	r6, [pc, #0]	@ (0x1c0d8)
@   0x0801c0d6: e006        b.n	0x1c0e6
@   0x0801c0d8: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801c0dc: 4e00        ldr	r6, [pc, #0]	@ (0x1c0e0)
@   0x0801c0de: e002        b.n	0x1c0e6
@   0x0801c0e0: f000        0600 	and.w	r6, r0, #0
@   0x0801c0e4: 4e0b        ldr	r6, [pc, #44]	@ (0x1c114)
@   0x0801c0e6: 2300        movs	r3, #0
@   0x0801c0e8: 9303        str	r3, [sp, #12]
@   0x0801c0ea: 9801        ldr	r0, [sp, #4]
@   0x0801c0ec: 4283        cmp	r3, r0
@   0x0801c0ee: d300        bcc.n	0x1c0f2
@   0x0801c0f0: e0d7        b.n	0x1c2a2
@   0x0801c0f2: 0050        lsls	r0, r2, #1
@   0x0801c0f4: 1986        adds	r6, r0, r6
@   0x0801c0f6: 9900        ldr	r1, [sp, #0]
@   0x0801c0f8: 9b03        ldr	r3, [sp, #12]
@   0x0801c0fa: 18ca        adds	r2, r1, r3
@   0x0801c0fc: 7815        ldrb	r5, [r2, #0]
@   0x0801c0fe: 1c28        adds	r0, r5, #0
@   0x0801c100: 3830        subs	r0, #48	@ 0x30
@   0x0801c102: 0600        lsls	r0, r0, #24
@   0x0801c104: 0e00        lsrs	r0, r0, #24
@   0x0801c106: 2809        cmp	r0, #9
@   0x0801c108: d818        bhi.n	0x1c13c
@   0x0801c10a: 2d30        cmp	r5, #48	@ 0x30
@   0x0801c10c: d104        bne.n	0x1c118
@   0x0801c10e: 2209        movs	r2, #9
@   0x0801c110: e006        b.n	0x1c120
@   0x0801c112: 0000        movs	r0, r0
@   0x0801c114: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801c118: 1c28        adds	r0, r5, #0
@   0x0801c11a: 3831        subs	r0, #49	@ 0x31
@   0x0801c11c: 0400        lsls	r0, r0, #16
@   0x0801c11e: 0c02        lsrs	r2, r0, #16
@   0x0801c120: 4649        mov	r1, r9
@   0x0801c122: 0048        lsls	r0, r1, #1
@   0x0801c124: 19c0        adds	r0, r0, r7
@   0x0801c126: 0180        lsls	r0, r0, #6
@   0x0801c128: 4643        mov	r3, r8
@   0x0801c12a: 0059        lsls	r1, r3, #1
@   0x0801c12c: 1989        adds	r1, r1, r6
@   0x0801c12e: 1840        adds	r0, r0, r1
@   0x0801c130: 3040        adds	r0, #64	@ 0x40
@   0x0801c132: 1c11        adds	r1, r2, #0
@   0x0801c134: 313a        adds	r1, #58	@ 0x3a
@   0x0801c136: 9a02        ldr	r2, [sp, #8]
@   0x0801c138: 1851        adds	r1, r2, r1
@   0x0801c13a: e093        b.n	0x1c264
@   0x0801c13c: 1c29        adds	r1, r5, #0
@   0x0801c13e: 3941        subs	r1, #65	@ 0x41
@   0x0801c140: 0608        lsls	r0, r1, #24
@   0x0801c142: 0e00        lsrs	r0, r0, #24
@   0x0801c144: 2819        cmp	r0, #25
@   0x0801c146: d80d        bhi.n	0x1c164
@   0x0801c148: 0408        lsls	r0, r1, #16
@   0x0801c14a: 0c02        lsrs	r2, r0, #16
@   0x0801c14c: 464b        mov	r3, r9
@   0x0801c14e: 0059        lsls	r1, r3, #1
@   0x0801c150: 19c9        adds	r1, r1, r7
@   0x0801c152: 0189        lsls	r1, r1, #6
@   0x0801c154: 4643        mov	r3, r8
@   0x0801c156: 0058        lsls	r0, r3, #1
@   0x0801c158: 1980        adds	r0, r0, r6
@   0x0801c15a: 1809        adds	r1, r1, r0
@   0x0801c15c: 3140        adds	r1, #64	@ 0x40
@   0x0801c15e: 9b02        ldr	r3, [sp, #8]
@   0x0801c160: 1898        adds	r0, r3, r2
@   0x0801c162: e014        b.n	0x1c18e
@   0x0801c164: 1c29        adds	r1, r5, #0
@   0x0801c166: 3961        subs	r1, #97	@ 0x61
@   0x0801c168: 0608        lsls	r0, r1, #24
@   0x0801c16a: 0e00        lsrs	r0, r0, #24
@   0x0801c16c: 2819        cmp	r0, #25
@   0x0801c16e: d811        bhi.n	0x1c194
@   0x0801c170: 0408        lsls	r0, r1, #16
@   0x0801c172: 0c02        lsrs	r2, r0, #16
@   0x0801c174: 4648        mov	r0, r9
@   0x0801c176: 0041        lsls	r1, r0, #1
@   0x0801c178: 19c9        adds	r1, r1, r7
@   0x0801c17a: 0189        lsls	r1, r1, #6
@   0x0801c17c: 4643        mov	r3, r8
@   0x0801c17e: 0058        lsls	r0, r3, #1
@   0x0801c180: 1980        adds	r0, r0, r6
@   0x0801c182: 1809        adds	r1, r1, r0
@   0x0801c184: 3140        adds	r1, #64	@ 0x40
@   0x0801c186: 1c10        adds	r0, r2, #0
@   0x0801c188: 301a        adds	r0, #26
@   0x0801c18a: 9a02        ldr	r2, [sp, #8]
@   0x0801c18c: 1810        adds	r0, r2, r0
@   0x0801c18e: 4450        add	r0, sl
@   0x0801c190: 8008        strh	r0, [r1, #0]
@   0x0801c192: e06f        b.n	0x1c274
@   0x0801c194: 2d5b        cmp	r5, #91	@ 0x5b
@   0x0801c196: d129        bne.n	0x1c1ec
@   0x0801c198: 7913        ldrb	r3, [r2, #4]
@   0x0801c19a: 2b5d        cmp	r3, #93	@ 0x5d
@   0x0801c19c: d126        bne.n	0x1c1ec
@   0x0801c19e: 1c50        adds	r0, r2, #1
@   0x0801c1a0: 2103        movs	r1, #3
@   0x0801c1a2: f000        fe8d 	bl	0x1cec0
@   0x0801c1a6: 1c04        adds	r4, r0, #0
@   0x0801c1a8: 3cc0        subs	r4, #192	@ 0xc0
@   0x0801c1aa: 2c3f        cmp	r4, #63	@ 0x3f
@   0x0801c1ac: d815        bhi.n	0x1c1da
@   0x0801c1ae: 4648        mov	r0, r9
@   0x0801c1b0: 0042        lsls	r2, r0, #1
@   0x0801c1b2: 19d2        adds	r2, r2, r7
@   0x0801c1b4: 0192        lsls	r2, r2, #6
@   0x0801c1b6: 4641        mov	r1, r8
@   0x0801c1b8: 0048        lsls	r0, r1, #1
@   0x0801c1ba: 1980        adds	r0, r0, r6
@   0x0801c1bc: 1812        adds	r2, r2, r0
@   0x0801c1be: 4b0a        ldr	r3, [pc, #40]	@ (0x1c1e8)
@   0x0801c1c0: 0061        lsls	r1, r4, #1
@   0x0801c1c2: 1909        adds	r1, r1, r4
@   0x0801c1c4: 1c48        adds	r0, r1, #1
@   0x0801c1c6: 0040        lsls	r0, r0, #1
@   0x0801c1c8: 18c0        adds	r0, r0, r3
@   0x0801c1ca: 8800        ldrh	r0, [r0, #0]
@   0x0801c1cc: 8010        strh	r0, [r2, #0]
@   0x0801c1ce: 3240        adds	r2, #64	@ 0x40
@   0x0801c1d0: 3102        adds	r1, #2
@   0x0801c1d2: 0049        lsls	r1, r1, #1
@   0x0801c1d4: 18c9        adds	r1, r1, r3
@   0x0801c1d6: 8808        ldrh	r0, [r1, #0]
@   0x0801c1d8: 8010        strh	r0, [r2, #0]
@   0x0801c1da: 9803        ldr	r0, [sp, #12]
@   0x0801c1dc: 3004        adds	r0, #4
@   0x0801c1de: 0600        lsls	r0, r0, #24
@   0x0801c1e0: 0e00        lsrs	r0, r0, #24
@   0x0801c1e2: 9003        str	r0, [sp, #12]
@   0x0801c1e4: e046        b.n	0x1c274
@   0x0801c1e6: 0000        movs	r0, r0
@   0x0801c1e8: ee64        081b 	mcr	8, 3, r0, cr4, cr11, {0}
@   0x0801c1ec: 2d20        cmp	r5, #32
@   0x0801c1ee: d10b        bne.n	0x1c208
@   0x0801c1f0: 464a        mov	r2, r9
@   0x0801c1f2: 0050        lsls	r0, r2, #1
@   0x0801c1f4: 19c0        adds	r0, r0, r7
@   0x0801c1f6: 0180        lsls	r0, r0, #6
@   0x0801c1f8: 4643        mov	r3, r8
@   0x0801c1fa: 0059        lsls	r1, r3, #1
@   0x0801c1fc: 1989        adds	r1, r1, r6
@   0x0801c1fe: 1840        adds	r0, r0, r1
@   0x0801c200: 3040        adds	r0, #64	@ 0x40
@   0x0801c202: 2100        movs	r1, #0
@   0x0801c204: 8001        strh	r1, [r0, #0]
@   0x0801c206: e035        b.n	0x1c274
@   0x0801c208: 2d2a        cmp	r5, #42	@ 0x2a
@   0x0801c20a: d10e        bne.n	0x1c22a
@   0x0801c20c: 4648        mov	r0, r9
@   0x0801c20e: 0041        lsls	r1, r0, #1
@   0x0801c210: 19c9        adds	r1, r1, r7
@   0x0801c212: 0189        lsls	r1, r1, #6
@   0x0801c214: 4642        mov	r2, r8
@   0x0801c216: 0050        lsls	r0, r2, #1
@   0x0801c218: 1980        adds	r0, r0, r6
@   0x0801c21a: 1809        adds	r1, r1, r0
@   0x0801c21c: 4650        mov	r0, sl
@   0x0801c21e: 3024        adds	r0, #36	@ 0x24
@   0x0801c220: 8008        strh	r0, [r1, #0]
@   0x0801c222: 3140        adds	r1, #64	@ 0x40
@   0x0801c224: 381b        subs	r0, #27
@   0x0801c226: 8008        strh	r0, [r1, #0]
@   0x0801c228: e024        b.n	0x1c274
@   0x0801c22a: 2d3f        cmp	r5, #63	@ 0x3f
@   0x0801c22c: d10e        bne.n	0x1c24c
@   0x0801c22e: 464b        mov	r3, r9
@   0x0801c230: 0058        lsls	r0, r3, #1
@   0x0801c232: 19c0        adds	r0, r0, r7
@   0x0801c234: 0180        lsls	r0, r0, #6
@   0x0801c236: 4642        mov	r2, r8
@   0x0801c238: 0051        lsls	r1, r2, #1
@   0x0801c23a: 1989        adds	r1, r1, r6
@   0x0801c23c: 1840        adds	r0, r0, r1
@   0x0801c23e: 3040        adds	r0, #64	@ 0x40
@   0x0801c240: 4b01        ldr	r3, [pc, #4]	@ (0x1c248)
@   0x0801c242: 1c19        adds	r1, r3, #0
@   0x0801c244: 8001        strh	r1, [r0, #0]
@   0x0801c246: e015        b.n	0x1c274
@   0x0801c248: e0d6        b.n	0x1c3f8
@   0x0801c24a: 0000        movs	r0, r0
@   0x0801c24c: 2d7e        cmp	r5, #126	@ 0x7e
@   0x0801c24e: d10f        bne.n	0x1c270
@   0x0801c250: 4649        mov	r1, r9
@   0x0801c252: 0048        lsls	r0, r1, #1
@   0x0801c254: 19c0        adds	r0, r0, r7
@   0x0801c256: 0180        lsls	r0, r0, #6
@   0x0801c258: 4642        mov	r2, r8
@   0x0801c25a: 0051        lsls	r1, r2, #1
@   0x0801c25c: 1989        adds	r1, r1, r6
@   0x0801c25e: 1840        adds	r0, r0, r1
@   0x0801c260: 3040        adds	r0, #64	@ 0x40
@   0x0801c262: 4902        ldr	r1, [pc, #8]	@ (0x1c26c)
@   0x0801c264: 4451        add	r1, sl
@   0x0801c266: 8001        strh	r1, [r0, #0]
@   0x0801c268: e004        b.n	0x1c274
@   0x0801c26a: 0000        movs	r0, r0
@   0x0801c26c: e0ea        b.n	0x1c444
@   0x0801c26e: 0000        movs	r0, r0
@   0x0801c270: 2d7c        cmp	r5, #124	@ 0x7c
@   0x0801c272: d016        beq.n	0x1c2a2
@   0x0801c274: 4640        mov	r0, r8
@   0x0801c276: 3001        adds	r0, #1
@   0x0801c278: 0600        lsls	r0, r0, #24
@   0x0801c27a: 0e00        lsrs	r0, r0, #24
@   0x0801c27c: 4680        mov	r8, r0
@   0x0801c27e: 2d0a        cmp	r5, #10
@   0x0801c280: d106        bne.n	0x1c290
@   0x0801c282: 2300        movs	r3, #0
@   0x0801c284: 4698        mov	r8, r3
@   0x0801c286: 4648        mov	r0, r9
@   0x0801c288: 3001        adds	r0, #1
@   0x0801c28a: 0600        lsls	r0, r0, #24
@   0x0801c28c: 0e00        lsrs	r0, r0, #24
@   0x0801c28e: 4681        mov	r9, r0
@   0x0801c290: 9803        ldr	r0, [sp, #12]
@   0x0801c292: 3001        adds	r0, #1
@   0x0801c294: 0600        lsls	r0, r0, #24
@   0x0801c296: 0e00        lsrs	r0, r0, #24
@   0x0801c298: 9003        str	r0, [sp, #12]
@   0x0801c29a: 9901        ldr	r1, [sp, #4]
@   0x0801c29c: 4288        cmp	r0, r1
@   0x0801c29e: d200        bcs.n	0x1c2a2
@   0x0801c2a0: e729        b.n	0x1c0f6
@   0x0801c2a2: b004        add	sp, #16
@   0x0801c2a4: bc38        pop	{r3, r4, r5}
@   0x0801c2a6: 4698        mov	r8, r3
@   0x0801c2a8: 46a1        mov	r9, r4
@   0x0801c2aa: 46aa        mov	sl, r5
@   0x0801c2ac: bcf0        pop	{r4, r5, r6, r7}
@   0x0801c2ae: bc01        pop	{r0}
@   0x0801c2b0: 4700        bx	r0

        thumb_func_start sub_0801C078
sub_0801C078: @ 0x0801c078
        .incbin "frog_us_baserom.gba", 0x1c078, 0x23c
        thumb_func_end sub_0801C078
