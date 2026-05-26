@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d9ec, 0x0802dcbc)  (720 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d9ec --end 0x802dcbc --mode thumb
@ Split into sub_0802D9EC [0x0802d9ec, 0x0802dc1c) and sub_0802DC1C [0x0802dc1c, 0x0802dcbc).

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d9ec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d9ee: 4657        mov	r7, sl
@   0x0802d9f0: 464e        mov	r6, r9
@   0x0802d9f2: 4645        mov	r5, r8
@   0x0802d9f4: b4e0        push	{r5, r6, r7}
@   0x0802d9f6: b081        sub	sp, #4
@   0x0802d9f8: 1c05        adds	r5, r0, #0
@   0x0802d9fa: 4689        mov	r9, r1
@   0x0802d9fc: 1c17        adds	r7, r2, #0
@   0x0802d9fe: 4698        mov	r8, r3
@   0x0802da00: 4919        ldr	r1, [pc, #100]	@ (0x2da68)
@   0x0802da02: 680e        ldr	r6, [r1, #0]
@   0x0802da04: 2288        movs	r2, #136	@ 0x88
@   0x0802da06: 0052        lsls	r2, r2, #1
@   0x0802da08: 18b0        adds	r0, r6, r2
@   0x0802da0a: 6802        ldr	r2, [r0, #0]
@   0x0802da0c: 68d0        ldr	r0, [r2, #12]
@   0x0802da0e: 1814        adds	r4, r2, r0
@   0x0802da10: 6820        ldr	r0, [r4, #0]
@   0x0802da12: 1c0b        adds	r3, r1, #0
@   0x0802da14: 4285        cmp	r5, r0
@   0x0802da16: d300        bcc.n	0x2da1a
@   0x0802da18: e07a        b.n	0x2db10
@   0x0802da1a: 00e8        lsls	r0, r5, #3
@   0x0802da1c: 3004        adds	r0, #4
@   0x0802da1e: 1825        adds	r5, r4, r0
@   0x0802da20: 6810        ldr	r0, [r2, #0]
@   0x0802da22: 882c        ldrh	r4, [r5, #0]
@   0x0802da24: 00a1        lsls	r1, r4, #2
@   0x0802da26: 1810        adds	r0, r2, r0
@   0x0802da28: 1809        adds	r1, r1, r0
@   0x0802da2a: 6808        ldr	r0, [r1, #0]
@   0x0802da2c: 1812        adds	r2, r2, r0
@   0x0802da2e: 4692        mov	sl, r2
@   0x0802da30: 7814        ldrb	r4, [r2, #0]
@   0x0802da32: 2cff        cmp	r4, #255	@ 0xff
@   0x0802da34: d102        bne.n	0x2da3c
@   0x0802da36: 792c        ldrb	r4, [r5, #4]
@   0x0802da38: 2cff        cmp	r4, #255	@ 0xff
@   0x0802da3a: d003        beq.n	0x2da44
@   0x0802da3c: 7830        ldrb	r0, [r6, #0]
@   0x0802da3e: 3004        adds	r0, #4
@   0x0802da40: 4284        cmp	r4, r0
@   0x0802da42: da65        bge.n	0x2db10
@   0x0802da44: 4648        mov	r0, r9
@   0x0802da46: 287f        cmp	r0, #127	@ 0x7f
@   0x0802da48: dd01        ble.n	0x2da4e
@   0x0802da4a: 79e9        ldrb	r1, [r5, #7]
@   0x0802da4c: 4689        mov	r9, r1
@   0x0802da4e: 2f7f        cmp	r7, #127	@ 0x7f
@   0x0802da50: dd00        ble.n	0x2da54
@   0x0802da52: 796f        ldrb	r7, [r5, #5]
@   0x0802da54: 6818        ldr	r0, [r3, #0]
@   0x0802da56: 89c0        ldrh	r0, [r0, #14]
@   0x0802da58: 4378        muls	r0, r7
@   0x0802da5a: 1207        asrs	r7, r0, #8
@   0x0802da5c: 4642        mov	r2, r8
@   0x0802da5e: 2a80        cmp	r2, #128	@ 0x80
@   0x0802da60: dd04        ble.n	0x2da6c
@   0x0802da62: 79a8        ldrb	r0, [r5, #6]
@   0x0802da64: 4680        mov	r8, r0
@   0x0802da66: e006        b.n	0x2da76
@   0x0802da68: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802da6a: 0300        lsls	r0, r0, #12
@   0x0802da6c: 4641        mov	r1, r8
@   0x0802da6e: 2980        cmp	r1, #128	@ 0x80
@   0x0802da70: d101        bne.n	0x2da76
@   0x0802da72: 22ff        movs	r2, #255	@ 0xff
@   0x0802da74: 4690        mov	r8, r2
@   0x0802da76: 2c03        cmp	r4, #3
@   0x0802da78: dc3e        bgt.n	0x2daf8
@   0x0802da7a: 78a9        ldrb	r1, [r5, #2]
@   0x0802da7c: 2001        movs	r0, #1
@   0x0802da7e: 1c22        adds	r2, r4, #0
@   0x0802da80: f005        f88e 	bl	0x32ba0
@   0x0802da84: 2800        cmp	r0, #0
@   0x0802da86: d043        beq.n	0x2db10
@   0x0802da88: 480f        ldr	r0, [pc, #60]	@ (0x2dac8)
@   0x0802da8a: 6800        ldr	r0, [r0, #0]
@   0x0802da8c: 228e        movs	r2, #142	@ 0x8e
@   0x0802da8e: 0052        lsls	r2, r2, #1
@   0x0802da90: 1881        adds	r1, r0, r2
@   0x0802da92: 8808        ldrh	r0, [r1, #0]
@   0x0802da94: 3001        adds	r0, #1
@   0x0802da96: 8008        strh	r0, [r1, #0]
@   0x0802da98: 0400        lsls	r0, r0, #16
@   0x0802da9a: 2800        cmp	r0, #0
@   0x0802da9c: d101        bne.n	0x2daa2
@   0x0802da9e: 2001        movs	r0, #1
@   0x0802daa0: 8008        strh	r0, [r1, #0]
@   0x0802daa2: 2080        movs	r0, #128	@ 0x80
@   0x0802daa4: 4651        mov	r1, sl
@   0x0802daa6: 7849        ldrb	r1, [r1, #1]
@   0x0802daa8: 4008        ands	r0, r1
@   0x0802daaa: 2800        cmp	r0, #0
@   0x0802daac: d10e        bne.n	0x2dacc
@   0x0802daae: 2080        movs	r0, #128	@ 0x80
@   0x0802dab0: 0040        lsls	r0, r0, #1
@   0x0802dab2: 78aa        ldrb	r2, [r5, #2]
@   0x0802dab4: 4310        orrs	r0, r2
@   0x0802dab6: 9000        str	r0, [sp, #0]
@   0x0802dab8: 1c20        adds	r0, r4, #0
@   0x0802daba: 4649        mov	r1, r9
@   0x0802dabc: 4642        mov	r2, r8
@   0x0802dabe: 1c3b        adds	r3, r7, #0
@   0x0802dac0: f004        ff20 	bl	0x32904
@   0x0802dac4: e00b        b.n	0x2dade
@   0x0802dac6: 0000        movs	r0, r0
@   0x0802dac8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802daca: 0300        lsls	r0, r0, #12
@   0x0802dacc: 2380        movs	r3, #128	@ 0x80
@   0x0802dace: 005b        lsls	r3, r3, #1
@   0x0802dad0: 78a8        ldrb	r0, [r5, #2]
@   0x0802dad2: 4303        orrs	r3, r0
@   0x0802dad4: 1c20        adds	r0, r4, #0
@   0x0802dad6: 4649        mov	r1, r9
@   0x0802dad8: 1c3a        adds	r2, r7, #0
@   0x0802dada: f004        ff5f 	bl	0x3299c
@   0x0802dade: 4b05        ldr	r3, [pc, #20]	@ (0x2daf4)
@   0x0802dae0: 6819        ldr	r1, [r3, #0]
@   0x0802dae2: 00a0        lsls	r0, r4, #2
@   0x0802dae4: 3110        adds	r1, #16
@   0x0802dae6: 1809        adds	r1, r1, r0
@   0x0802dae8: 6808        ldr	r0, [r1, #0]
@   0x0802daea: 2280        movs	r2, #128	@ 0x80
@   0x0802daec: 0252        lsls	r2, r2, #9
@   0x0802daee: 4310        orrs	r0, r2
@   0x0802daf0: 6008        str	r0, [r1, #0]
@   0x0802daf2: e04c        b.n	0x2db8e
@   0x0802daf4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802daf6: 0300        lsls	r0, r0, #12
@   0x0802daf8: 2cff        cmp	r4, #255	@ 0xff
@   0x0802dafa: d000        beq.n	0x2dafe
@   0x0802dafc: 3c04        subs	r4, #4
@   0x0802dafe: 78a9        ldrb	r1, [r5, #2]
@   0x0802db00: 2001        movs	r0, #1
@   0x0802db02: 22ff        movs	r2, #255	@ 0xff
@   0x0802db04: 1c23        adds	r3, r4, #0
@   0x0802db06: f005        f807 	bl	0x32b18
@   0x0802db0a: 1c04        adds	r4, r0, #0
@   0x0802db0c: 2c00        cmp	r4, #0
@   0x0802db0e: da01        bge.n	0x2db14
@   0x0802db10: 2000        movs	r0, #0
@   0x0802db12: e077        b.n	0x2dc04
@   0x0802db14: 4811        ldr	r0, [pc, #68]	@ (0x2db5c)
@   0x0802db16: 6802        ldr	r2, [r0, #0]
@   0x0802db18: 1c10        adds	r0, r2, #0
@   0x0802db1a: 30c8        adds	r0, #200	@ 0xc8
@   0x0802db1c: 01a1        lsls	r1, r4, #6
@   0x0802db1e: 6800        ldr	r0, [r0, #0]
@   0x0802db20: 1846        adds	r6, r0, r1
@   0x0802db22: 208e        movs	r0, #142	@ 0x8e
@   0x0802db24: 0040        lsls	r0, r0, #1
@   0x0802db26: 1811        adds	r1, r2, r0
@   0x0802db28: 8808        ldrh	r0, [r1, #0]
@   0x0802db2a: 3001        adds	r0, #1
@   0x0802db2c: 8008        strh	r0, [r1, #0]
@   0x0802db2e: 0400        lsls	r0, r0, #16
@   0x0802db30: 2800        cmp	r0, #0
@   0x0802db32: d101        bne.n	0x2db38
@   0x0802db34: 2001        movs	r0, #1
@   0x0802db36: 8008        strh	r0, [r1, #0]
@   0x0802db38: 2080        movs	r0, #128	@ 0x80
@   0x0802db3a: 4651        mov	r1, sl
@   0x0802db3c: 7849        ldrb	r1, [r1, #1]
@   0x0802db3e: 4008        ands	r0, r1
@   0x0802db40: 2800        cmp	r0, #0
@   0x0802db42: d10d        bne.n	0x2db60
@   0x0802db44: 2080        movs	r0, #128	@ 0x80
@   0x0802db46: 0040        lsls	r0, r0, #1
@   0x0802db48: 78aa        ldrb	r2, [r5, #2]
@   0x0802db4a: 4310        orrs	r0, r2
@   0x0802db4c: 9000        str	r0, [sp, #0]
@   0x0802db4e: 1c30        adds	r0, r6, #0
@   0x0802db50: 4649        mov	r1, r9
@   0x0802db52: 4642        mov	r2, r8
@   0x0802db54: 1c3b        adds	r3, r7, #0
@   0x0802db56: f004        fe9d 	bl	0x32894
@   0x0802db5a: e00a        b.n	0x2db72
@   0x0802db5c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802db5e: 0300        lsls	r0, r0, #12
@   0x0802db60: 2380        movs	r3, #128	@ 0x80
@   0x0802db62: 005b        lsls	r3, r3, #1
@   0x0802db64: 78a8        ldrb	r0, [r5, #2]
@   0x0802db66: 4303        orrs	r3, r0
@   0x0802db68: 1c30        adds	r0, r6, #0
@   0x0802db6a: 4649        mov	r1, r9
@   0x0802db6c: 1c3a        adds	r2, r7, #0
@   0x0802db6e: f005        f82b 	bl	0x32bc8
@   0x0802db72: 6bb0        ldr	r0, [r6, #56]	@ 0x38
@   0x0802db74: 2180        movs	r1, #128	@ 0x80
@   0x0802db76: 0249        lsls	r1, r1, #9
@   0x0802db78: 4308        orrs	r0, r1
@   0x0802db7a: 63b0        str	r0, [r6, #56]	@ 0x38
@   0x0802db7c: 4a25        ldr	r2, [pc, #148]	@ (0x2dc14)
@   0x0802db7e: 6810        ldr	r0, [r2, #0]
@   0x0802db80: 30cc        adds	r0, #204	@ 0xcc
@   0x0802db82: 6801        ldr	r1, [r0, #0]
@   0x0802db84: 00a0        lsls	r0, r4, #2
@   0x0802db86: 1840        adds	r0, r0, r1
@   0x0802db88: 6006        str	r6, [r0, #0]
@   0x0802db8a: 3404        adds	r4, #4
@   0x0802db8c: 1c13        adds	r3, r2, #0
@   0x0802db8e: 6818        ldr	r0, [r3, #0]
@   0x0802db90: 218c        movs	r1, #140	@ 0x8c
@   0x0802db92: 0049        lsls	r1, r1, #1
@   0x0802db94: 1840        adds	r0, r0, r1
@   0x0802db96: 6801        ldr	r1, [r0, #0]
@   0x0802db98: 2288        movs	r2, #136	@ 0x88
@   0x0802db9a: 0052        lsls	r2, r2, #1
@   0x0802db9c: 1889        adds	r1, r1, r2
@   0x0802db9e: 0060        lsls	r0, r4, #1
@   0x0802dba0: 1900        adds	r0, r0, r4
@   0x0802dba2: 0080        lsls	r0, r0, #2
@   0x0802dba4: 6809        ldr	r1, [r1, #0]
@   0x0802dba6: 1809        adds	r1, r1, r0
@   0x0802dba8: 2200        movs	r2, #0
@   0x0802dbaa: 710a        strb	r2, [r1, #4]
@   0x0802dbac: 20ff        movs	r0, #255	@ 0xff
@   0x0802dbae: 7148        strb	r0, [r1, #5]
@   0x0802dbb0: 7968        ldrb	r0, [r5, #5]
@   0x0802dbb2: 7188        strb	r0, [r1, #6]
@   0x0802dbb4: 7968        ldrb	r0, [r5, #5]
@   0x0802dbb6: 7208        strb	r0, [r1, #8]
@   0x0802dbb8: 79e8        ldrb	r0, [r5, #7]
@   0x0802dbba: 71c8        strb	r0, [r1, #7]
@   0x0802dbbc: 681b        ldr	r3, [r3, #0]
@   0x0802dbbe: 218a        movs	r1, #138	@ 0x8a
@   0x0802dbc0: 0049        lsls	r1, r1, #1
@   0x0802dbc2: 1858        adds	r0, r3, r1
@   0x0802dbc4: 0121        lsls	r1, r4, #4
@   0x0802dbc6: 6800        ldr	r0, [r0, #0]
@   0x0802dbc8: 1840        adds	r0, r0, r1
@   0x0802dbca: 8102        strh	r2, [r0, #8]
@   0x0802dbcc: 8142        strh	r2, [r0, #10]
@   0x0802dbce: 6042        str	r2, [r0, #4]
@   0x0802dbd0: 4651        mov	r1, sl
@   0x0802dbd2: 3104        adds	r1, #4
@   0x0802dbd4: 6001        str	r1, [r0, #0]
@   0x0802dbd6: 8829        ldrh	r1, [r5, #0]
@   0x0802dbd8: 8181        strh	r1, [r0, #12]
@   0x0802dbda: 6859        ldr	r1, [r3, #4]
@   0x0802dbdc: 480e        ldr	r0, [pc, #56]	@ (0x2dc18)
@   0x0802dbde: 4341        muls	r1, r0
@   0x0802dbe0: 6059        str	r1, [r3, #4]
@   0x0802dbe2: 02c9        lsls	r1, r1, #11
@   0x0802dbe4: 0c49        lsrs	r1, r1, #17
@   0x0802dbe6: 208e        movs	r0, #142	@ 0x8e
@   0x0802dbe8: 0040        lsls	r0, r0, #1
@   0x0802dbea: 181a        adds	r2, r3, r0
@   0x0802dbec: 0420        lsls	r0, r4, #16
@   0x0802dbee: 8812        ldrh	r2, [r2, #0]
@   0x0802dbf0: 4310        orrs	r0, r2
@   0x0802dbf2: 0609        lsls	r1, r1, #24
@   0x0802dbf4: 4308        orrs	r0, r1
@   0x0802dbf6: 2290        movs	r2, #144	@ 0x90
@   0x0802dbf8: 0052        lsls	r2, r2, #1
@   0x0802dbfa: 1899        adds	r1, r3, r2
@   0x0802dbfc: 680a        ldr	r2, [r1, #0]
@   0x0802dbfe: 00a1        lsls	r1, r4, #2
@   0x0802dc00: 1889        adds	r1, r1, r2
@   0x0802dc02: 6008        str	r0, [r1, #0]
@   0x0802dc04: b001        add	sp, #4
@   0x0802dc06: bc38        pop	{r3, r4, r5}
@   0x0802dc08: 4698        mov	r8, r3
@   0x0802dc0a: 46a1        mov	r9, r4
@   0x0802dc0c: 46aa        mov	sl, r5
@   0x0802dc0e: bcf0        pop	{r4, r5, r6, r7}
@   0x0802dc10: bc02        pop	{r1}
@   0x0802dc12: 4708        bx	r1
@   0x0802dc14: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802dc16: 0300        lsls	r0, r0, #12
@   0x0802dc18: 1d63        adds	r3, r4, #5
@   0x0802dc1a: a835        add	r0, sp, #212	@ 0xd4
@   0x0802dc1c: b570        push	{r4, r5, r6, lr}
@   0x0802dc1e: 1c04        adds	r4, r0, #0
@   0x0802dc20: 1c0d        adds	r5, r1, #0
@   0x0802dc22: 2c00        cmp	r4, #0
@   0x0802dc24: d00e        beq.n	0x2dc44
@   0x0802dc26: 0c23        lsrs	r3, r4, #16
@   0x0802dc28: 20ff        movs	r0, #255	@ 0xff
@   0x0802dc2a: 4003        ands	r3, r0
@   0x0802dc2c: 4a07        ldr	r2, [pc, #28]	@ (0x2dc4c)
@   0x0802dc2e: 6810        ldr	r0, [r2, #0]
@   0x0802dc30: 2190        movs	r1, #144	@ 0x90
@   0x0802dc32: 0049        lsls	r1, r1, #1
@   0x0802dc34: 1840        adds	r0, r0, r1
@   0x0802dc36: 6801        ldr	r1, [r0, #0]
@   0x0802dc38: 0098        lsls	r0, r3, #2
@   0x0802dc3a: 1840        adds	r0, r0, r1
@   0x0802dc3c: 6800        ldr	r0, [r0, #0]
@   0x0802dc3e: 1c16        adds	r6, r2, #0
@   0x0802dc40: 42a0        cmp	r0, r4
@   0x0802dc42: d005        beq.n	0x2dc50
@   0x0802dc44: 2001        movs	r0, #1
@   0x0802dc46: 4240        negs	r0, r0
@   0x0802dc48: e034        b.n	0x2dcb4
@   0x0802dc4a: 0000        movs	r0, r0
@   0x0802dc4c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802dc4e: 0300        lsls	r0, r0, #12
@   0x0802dc50: 2d00        cmp	r5, #0
@   0x0802dc52: da01        bge.n	0x2dc58
@   0x0802dc54: 2500        movs	r5, #0
@   0x0802dc56: e002        b.n	0x2dc5e
@   0x0802dc58: 2d7f        cmp	r5, #127	@ 0x7f
@   0x0802dc5a: dd00        ble.n	0x2dc5e
@   0x0802dc5c: 257f        movs	r5, #127	@ 0x7f
@   0x0802dc5e: 2b03        cmp	r3, #3
@   0x0802dc60: dc0e        bgt.n	0x2dc80
@   0x0802dc62: 00d8        lsls	r0, r3, #3
@   0x0802dc64: 308c        adds	r0, #140	@ 0x8c
@   0x0802dc66: 6831        ldr	r1, [r6, #0]
@   0x0802dc68: 180a        adds	r2, r1, r0
@   0x0802dc6a: 79d4        ldrb	r4, [r2, #7]
@   0x0802dc6c: 71d5        strb	r5, [r2, #7]
@   0x0802dc6e: 6831        ldr	r1, [r6, #0]
@   0x0802dc70: 0098        lsls	r0, r3, #2
@   0x0802dc72: 3110        adds	r1, #16
@   0x0802dc74: 1809        adds	r1, r1, r0
@   0x0802dc76: 6808        ldr	r0, [r1, #0]
@   0x0802dc78: 2280        movs	r2, #128	@ 0x80
@   0x0802dc7a: 4310        orrs	r0, r2
@   0x0802dc7c: 6008        str	r0, [r1, #0]
@   0x0802dc7e: e018        b.n	0x2dcb2
@   0x0802dc80: 3b04        subs	r3, #4
@   0x0802dc82: 6830        ldr	r0, [r6, #0]
@   0x0802dc84: 30c8        adds	r0, #200	@ 0xc8
@   0x0802dc86: 019b        lsls	r3, r3, #6
@   0x0802dc88: 6800        ldr	r0, [r0, #0]
@   0x0802dc8a: 18c0        adds	r0, r0, r3
@   0x0802dc8c: 1c02        adds	r2, r0, #0
@   0x0802dc8e: 3224        adds	r2, #36	@ 0x24
@   0x0802dc90: 79d0        ldrb	r0, [r2, #7]
@   0x0802dc92: 0844        lsrs	r4, r0, #1
@   0x0802dc94: 0069        lsls	r1, r5, #1
@   0x0802dc96: 71d1        strb	r1, [r2, #7]
@   0x0802dc98: 0608        lsls	r0, r1, #24
@   0x0802dc9a: 2800        cmp	r0, #0
@   0x0802dc9c: d001        beq.n	0x2dca2
@   0x0802dc9e: 1c48        adds	r0, r1, #1
@   0x0802dca0: 71d0        strb	r0, [r2, #7]
@   0x0802dca2: 6830        ldr	r0, [r6, #0]
@   0x0802dca4: 30c8        adds	r0, #200	@ 0xc8
@   0x0802dca6: 6801        ldr	r1, [r0, #0]
@   0x0802dca8: 1859        adds	r1, r3, r1
@   0x0802dcaa: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0802dcac: 2280        movs	r2, #128	@ 0x80
@   0x0802dcae: 4310        orrs	r0, r2
@   0x0802dcb0: 6388        str	r0, [r1, #56]	@ 0x38
@   0x0802dcb2: 1c20        adds	r0, r4, #0
@   0x0802dcb4: bc70        pop	{r4, r5, r6}
@   0x0802dcb6: bc02        pop	{r1}
@   0x0802dcb8: 4708        bx	r1

        thumb_func_start sub_0802D9EC
sub_0802D9EC: @ 0x0802d9ec
        .incbin "frog_us_baserom.gba", 0x2d9ec, 0x230
        thumb_func_end sub_0802D9EC

        thumb_func_start sub_0802DC1C
sub_0802DC1C: @ 0x0802dc1c
        .incbin "frog_us_baserom.gba", 0x2dc1c, 0xa0
        thumb_func_end sub_0802DC1C
