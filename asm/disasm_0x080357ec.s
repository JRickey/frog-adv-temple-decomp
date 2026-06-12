@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080357ec, 0x08035d7c)  (1424 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80357ec --end 0x8035d7c --mode thumb
@
@ Boundary evidence (manual; boundary.py overshot into already-mapped
@ territory past 0x8035d7c, so its recommended-end mismatch is a false
@ negative):
@   - bl target from mapped Entity_Advance (0x08009188); f0b5 +
@     hi-reg-save prologue at 0x080357ec.
@   - Epilogue add sp,#32 / pop {r3,r4,r5} / mov r8,r9,sl /
@     pop {r4-r7,pc} ends exactly at 0x08035d7c = start of the
@     already-mapped IntrEnable_Thunk; whole unmapped gap consumed.
@   - Body is fully coherent thumb (0 data words); the only bl targets
@     are _call_via_r2 (24x, the comparison callback), __udivsi3 (2x),
@     and itself (1x, recursion at 0x8035d56).
@   - Identification: libc qsort (BSD-style) — n<=6 insertion-sort
@     path, swap-type select (aligned-word single / word-loop /
@     byte-loop), recurse-smaller + loop-larger tail (b.n 0x8035800).
@     Sits in the libgcc/libc tail right after Memcpy.

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080357ec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080357ee: 4657        mov	r7, sl
@   0x080357f0: 464e        mov	r6, r9
@   0x080357f2: 4645        mov	r5, r8
@   0x080357f4: b4e0        push	{r5, r6, r7}
@   0x080357f6: b088        sub	sp, #32
@   0x080357f8: 9000        str	r0, [sp, #0]
@   0x080357fa: 4689        mov	r9, r1
@   0x080357fc: 1c17        adds	r7, r2, #0
@   0x080357fe: 9301        str	r3, [sp, #4]
@   0x08035800: 2103        movs	r1, #3
@   0x08035802: 9800        ldr	r0, [sp, #0]
@   0x08035804: 4008        ands	r0, r1
@   0x08035806: 2800        cmp	r0, #0
@   0x08035808: d109        bne.n	0x3581e
@   0x0803580a: 1c38        adds	r0, r7, #0
@   0x0803580c: 4008        ands	r0, r1
@   0x0803580e: 2800        cmp	r0, #0
@   0x08035810: d105        bne.n	0x3581e
@   0x08035812: 2104        movs	r1, #4
@   0x08035814: 4079        eors	r1, r7
@   0x08035816: 4248        negs	r0, r1
@   0x08035818: 4308        orrs	r0, r1
@   0x0803581a: 0fc0        lsrs	r0, r0, #31
@   0x0803581c: e000        b.n	0x35820
@   0x0803581e: 2002        movs	r0, #2
@   0x08035820: 9003        str	r0, [sp, #12]
@   0x08035822: 2100        movs	r1, #0
@   0x08035824: 9104        str	r1, [sp, #16]
@   0x08035826: 464a        mov	r2, r9
@   0x08035828: 2a06        cmp	r2, #6
@   0x0803582a: d843        bhi.n	0x358b4
@   0x0803582c: 9800        ldr	r0, [sp, #0]
@   0x0803582e: 19c5        adds	r5, r0, r7
@   0x08035830: 4648        mov	r0, r9
@   0x08035832: 4378        muls	r0, r7
@   0x08035834: 9a00        ldr	r2, [sp, #0]
@   0x08035836: 1811        adds	r1, r2, r0
@   0x08035838: 9007        str	r0, [sp, #28]
@   0x0803583a: 428d        cmp	r5, r1
@   0x0803583c: d300        bcc.n	0x35840
@   0x0803583e: e297        b.n	0x35d70
@   0x08035840: 1c2e        adds	r6, r5, #0
@   0x08035842: 19ed        adds	r5, r5, r7
@   0x08035844: 46a8        mov	r8, r5
@   0x08035846: e022        b.n	0x3588e
@   0x08035848: 9803        ldr	r0, [sp, #12]
@   0x0803584a: 2800        cmp	r0, #0
@   0x0803584c: d104        bne.n	0x35858
@   0x0803584e: 6831        ldr	r1, [r6, #0]
@   0x08035850: 6828        ldr	r0, [r5, #0]
@   0x08035852: 6030        str	r0, [r6, #0]
@   0x08035854: 6029        str	r1, [r5, #0]
@   0x08035856: e019        b.n	0x3588c
@   0x08035858: 9903        ldr	r1, [sp, #12]
@   0x0803585a: 2901        cmp	r1, #1
@   0x0803585c: dc0a        bgt.n	0x35874
@   0x0803585e: 08ba        lsrs	r2, r7, #2
@   0x08035860: 1c34        adds	r4, r6, #0
@   0x08035862: 1c2b        adds	r3, r5, #0
@   0x08035864: 6821        ldr	r1, [r4, #0]
@   0x08035866: 6818        ldr	r0, [r3, #0]
@   0x08035868: c401        stmia	r4!, {r0}
@   0x0803586a: c302        stmia	r3!, {r1}
@   0x0803586c: 3a01        subs	r2, #1
@   0x0803586e: 2a00        cmp	r2, #0
@   0x08035870: dcf8        bgt.n	0x35864
@   0x08035872: e00b        b.n	0x3588c
@   0x08035874: 1c3b        adds	r3, r7, #0
@   0x08035876: 1c34        adds	r4, r6, #0
@   0x08035878: 1c2a        adds	r2, r5, #0
@   0x0803587a: 7821        ldrb	r1, [r4, #0]
@   0x0803587c: 7810        ldrb	r0, [r2, #0]
@   0x0803587e: 7020        strb	r0, [r4, #0]
@   0x08035880: 3401        adds	r4, #1
@   0x08035882: 7011        strb	r1, [r2, #0]
@   0x08035884: 3201        adds	r2, #1
@   0x08035886: 3b01        subs	r3, #1
@   0x08035888: 2b00        cmp	r3, #0
@   0x0803588a: dcf6        bgt.n	0x3587a
@   0x0803588c: 1c2e        adds	r6, r5, #0
@   0x0803588e: 9a00        ldr	r2, [sp, #0]
@   0x08035890: 4296        cmp	r6, r2
@   0x08035892: d908        bls.n	0x358a6
@   0x08035894: 1bf4        subs	r4, r6, r7
@   0x08035896: 1c20        adds	r0, r4, #0
@   0x08035898: 1c31        adds	r1, r6, #0
@   0x0803589a: 9a01        ldr	r2, [sp, #4]
@   0x0803589c: f7fe        fa20 	bl	0x33ce0
@   0x080358a0: 1c25        adds	r5, r4, #0
@   0x080358a2: 2800        cmp	r0, #0
@   0x080358a4: dcd0        bgt.n	0x35848
@   0x080358a6: 4645        mov	r5, r8
@   0x080358a8: 9900        ldr	r1, [sp, #0]
@   0x080358aa: 9a07        ldr	r2, [sp, #28]
@   0x080358ac: 1888        adds	r0, r1, r2
@   0x080358ae: 4285        cmp	r5, r0
@   0x080358b0: d3c6        bcc.n	0x35840
@   0x080358b2: e25d        b.n	0x35d70
@   0x080358b4: 4649        mov	r1, r9
@   0x080358b6: 0848        lsrs	r0, r1, #1
@   0x080358b8: 4378        muls	r0, r7
@   0x080358ba: 9a00        ldr	r2, [sp, #0]
@   0x080358bc: 1815        adds	r5, r2, r0
@   0x080358be: 3901        subs	r1, #1
@   0x080358c0: 9105        str	r1, [sp, #20]
@   0x080358c2: 4648        mov	r0, r9
@   0x080358c4: 2807        cmp	r0, #7
@   0x080358c6: d800        bhi.n	0x358ca
@   0x080358c8: e0c6        b.n	0x35a58
@   0x080358ca: 1c16        adds	r6, r2, #0
@   0x080358cc: 1c08        adds	r0, r1, #0
@   0x080358ce: 4378        muls	r0, r7
@   0x080358d0: 1812        adds	r2, r2, r0
@   0x080358d2: 4692        mov	sl, r2
@   0x080358d4: 4649        mov	r1, r9
@   0x080358d6: 2928        cmp	r1, #40	@ 0x28
@   0x080358d8: d800        bhi.n	0x358dc
@   0x080358da: e092        b.n	0x35a02
@   0x080358dc: 08c8        lsrs	r0, r1, #3
@   0x080358de: 1c02        adds	r2, r0, #0
@   0x080358e0: 437a        muls	r2, r7
@   0x080358e2: 9202        str	r2, [sp, #8]
@   0x080358e4: 18b4        adds	r4, r6, r2
@   0x080358e6: 0050        lsls	r0, r2, #1
@   0x080358e8: 1986        adds	r6, r0, r6
@   0x080358ea: 9800        ldr	r0, [sp, #0]
@   0x080358ec: 1c21        adds	r1, r4, #0
@   0x080358ee: 9a01        ldr	r2, [sp, #4]
@   0x080358f0: f7fe        f9f6 	bl	0x33ce0
@   0x080358f4: 2800        cmp	r0, #0
@   0x080358f6: da10        bge.n	0x3591a
@   0x080358f8: 1c20        adds	r0, r4, #0
@   0x080358fa: 1c31        adds	r1, r6, #0
@   0x080358fc: 9a01        ldr	r2, [sp, #4]
@   0x080358fe: f7fe        f9ef 	bl	0x33ce0
@   0x08035902: 2800        cmp	r0, #0
@   0x08035904: db1a        blt.n	0x3593c
@   0x08035906: 9800        ldr	r0, [sp, #0]
@   0x08035908: 1c31        adds	r1, r6, #0
@   0x0803590a: 9a01        ldr	r2, [sp, #4]
@   0x0803590c: f7fe        f9e8 	bl	0x33ce0
@   0x08035910: 9900        ldr	r1, [sp, #0]
@   0x08035912: 2800        cmp	r0, #0
@   0x08035914: da13        bge.n	0x3593e
@   0x08035916: 1c31        adds	r1, r6, #0
@   0x08035918: e011        b.n	0x3593e
@   0x0803591a: 1c20        adds	r0, r4, #0
@   0x0803591c: 1c31        adds	r1, r6, #0
@   0x0803591e: 9a01        ldr	r2, [sp, #4]
@   0x08035920: f7fe        f9de 	bl	0x33ce0
@   0x08035924: 2800        cmp	r0, #0
@   0x08035926: dc09        bgt.n	0x3593c
@   0x08035928: 9800        ldr	r0, [sp, #0]
@   0x0803592a: 1c31        adds	r1, r6, #0
@   0x0803592c: 9a01        ldr	r2, [sp, #4]
@   0x0803592e: f7fe        f9d7 	bl	0x33ce0
@   0x08035932: 1c31        adds	r1, r6, #0
@   0x08035934: 2800        cmp	r0, #0
@   0x08035936: da02        bge.n	0x3593e
@   0x08035938: 9900        ldr	r1, [sp, #0]
@   0x0803593a: e000        b.n	0x3593e
@   0x0803593c: 1c21        adds	r1, r4, #0
@   0x0803593e: 1c0e        adds	r6, r1, #0
@   0x08035940: 9802        ldr	r0, [sp, #8]
@   0x08035942: 1a28        subs	r0, r5, r0
@   0x08035944: 4680        mov	r8, r0
@   0x08035946: 9902        ldr	r1, [sp, #8]
@   0x08035948: 186c        adds	r4, r5, r1
@   0x0803594a: 1c29        adds	r1, r5, #0
@   0x0803594c: 9a01        ldr	r2, [sp, #4]
@   0x0803594e: f7fe        f9c7 	bl	0x33ce0
@   0x08035952: 2800        cmp	r0, #0
@   0x08035954: da10        bge.n	0x35978
@   0x08035956: 1c28        adds	r0, r5, #0
@   0x08035958: 1c21        adds	r1, r4, #0
@   0x0803595a: 9a01        ldr	r2, [sp, #4]
@   0x0803595c: f7fe        f9c0 	bl	0x33ce0
@   0x08035960: 2800        cmp	r0, #0
@   0x08035962: db1a        blt.n	0x3599a
@   0x08035964: 4640        mov	r0, r8
@   0x08035966: 1c21        adds	r1, r4, #0
@   0x08035968: 9a01        ldr	r2, [sp, #4]
@   0x0803596a: f7fe        f9b9 	bl	0x33ce0
@   0x0803596e: 4641        mov	r1, r8
@   0x08035970: 2800        cmp	r0, #0
@   0x08035972: da13        bge.n	0x3599c
@   0x08035974: 1c21        adds	r1, r4, #0
@   0x08035976: e011        b.n	0x3599c
@   0x08035978: 1c28        adds	r0, r5, #0
@   0x0803597a: 1c21        adds	r1, r4, #0
@   0x0803597c: 9a01        ldr	r2, [sp, #4]
@   0x0803597e: f7fe        f9af 	bl	0x33ce0
@   0x08035982: 2800        cmp	r0, #0
@   0x08035984: dc09        bgt.n	0x3599a
@   0x08035986: 4640        mov	r0, r8
@   0x08035988: 1c21        adds	r1, r4, #0
@   0x0803598a: 9a01        ldr	r2, [sp, #4]
@   0x0803598c: f7fe        f9a8 	bl	0x33ce0
@   0x08035990: 1c21        adds	r1, r4, #0
@   0x08035992: 2800        cmp	r0, #0
@   0x08035994: da02        bge.n	0x3599c
@   0x08035996: 4641        mov	r1, r8
@   0x08035998: e000        b.n	0x3599c
@   0x0803599a: 1c29        adds	r1, r5, #0
@   0x0803599c: 1c0d        adds	r5, r1, #0
@   0x0803599e: 9902        ldr	r1, [sp, #8]
@   0x080359a0: 0048        lsls	r0, r1, #1
@   0x080359a2: 4652        mov	r2, sl
@   0x080359a4: 1a12        subs	r2, r2, r0
@   0x080359a6: 4690        mov	r8, r2
@   0x080359a8: 4650        mov	r0, sl
@   0x080359aa: 1a44        subs	r4, r0, r1
@   0x080359ac: 4640        mov	r0, r8
@   0x080359ae: 1c21        adds	r1, r4, #0
@   0x080359b0: 9a01        ldr	r2, [sp, #4]
@   0x080359b2: f7fe        f995 	bl	0x33ce0
@   0x080359b6: 2800        cmp	r0, #0
@   0x080359b8: da10        bge.n	0x359dc
@   0x080359ba: 1c20        adds	r0, r4, #0
@   0x080359bc: 4651        mov	r1, sl
@   0x080359be: 9a01        ldr	r2, [sp, #4]
@   0x080359c0: f7fe        f98e 	bl	0x33ce0
@   0x080359c4: 2800        cmp	r0, #0
@   0x080359c6: db1a        blt.n	0x359fe
@   0x080359c8: 4640        mov	r0, r8
@   0x080359ca: 4651        mov	r1, sl
@   0x080359cc: 9a01        ldr	r2, [sp, #4]
@   0x080359ce: f7fe        f987 	bl	0x33ce0
@   0x080359d2: 4641        mov	r1, r8
@   0x080359d4: 2800        cmp	r0, #0
@   0x080359d6: da13        bge.n	0x35a00
@   0x080359d8: 4651        mov	r1, sl
@   0x080359da: e011        b.n	0x35a00
@   0x080359dc: 1c20        adds	r0, r4, #0
@   0x080359de: 4651        mov	r1, sl
@   0x080359e0: 9a01        ldr	r2, [sp, #4]
@   0x080359e2: f7fe        f97d 	bl	0x33ce0
@   0x080359e6: 2800        cmp	r0, #0
@   0x080359e8: dc09        bgt.n	0x359fe
@   0x080359ea: 4640        mov	r0, r8
@   0x080359ec: 4651        mov	r1, sl
@   0x080359ee: 9a01        ldr	r2, [sp, #4]
@   0x080359f0: f7fe        f976 	bl	0x33ce0
@   0x080359f4: 4651        mov	r1, sl
@   0x080359f6: 2800        cmp	r0, #0
@   0x080359f8: da02        bge.n	0x35a00
@   0x080359fa: 4641        mov	r1, r8
@   0x080359fc: e000        b.n	0x35a00
@   0x080359fe: 1c21        adds	r1, r4, #0
@   0x08035a00: 468a        mov	sl, r1
@   0x08035a02: 1c30        adds	r0, r6, #0
@   0x08035a04: 1c29        adds	r1, r5, #0
@   0x08035a06: 9a01        ldr	r2, [sp, #4]
@   0x08035a08: f7fe        f96a 	bl	0x33ce0
@   0x08035a0c: 2800        cmp	r0, #0
@   0x08035a0e: da10        bge.n	0x35a32
@   0x08035a10: 1c28        adds	r0, r5, #0
@   0x08035a12: 4651        mov	r1, sl
@   0x08035a14: 9a01        ldr	r2, [sp, #4]
@   0x08035a16: f7fe        f963 	bl	0x33ce0
@   0x08035a1a: 2800        cmp	r0, #0
@   0x08035a1c: db1a        blt.n	0x35a54
@   0x08035a1e: 1c30        adds	r0, r6, #0
@   0x08035a20: 4651        mov	r1, sl
@   0x08035a22: 9a01        ldr	r2, [sp, #4]
@   0x08035a24: f7fe        f95c 	bl	0x33ce0
@   0x08035a28: 1c31        adds	r1, r6, #0
@   0x08035a2a: 2800        cmp	r0, #0
@   0x08035a2c: da13        bge.n	0x35a56
@   0x08035a2e: 4651        mov	r1, sl
@   0x08035a30: e011        b.n	0x35a56
@   0x08035a32: 1c28        adds	r0, r5, #0
@   0x08035a34: 4651        mov	r1, sl
@   0x08035a36: 9a01        ldr	r2, [sp, #4]
@   0x08035a38: f7fe        f952 	bl	0x33ce0
@   0x08035a3c: 2800        cmp	r0, #0
@   0x08035a3e: dc09        bgt.n	0x35a54
@   0x08035a40: 1c30        adds	r0, r6, #0
@   0x08035a42: 4651        mov	r1, sl
@   0x08035a44: 9a01        ldr	r2, [sp, #4]
@   0x08035a46: f7fe        f94b 	bl	0x33ce0
@   0x08035a4a: 4651        mov	r1, sl
@   0x08035a4c: 2800        cmp	r0, #0
@   0x08035a4e: da02        bge.n	0x35a56
@   0x08035a50: 1c31        adds	r1, r6, #0
@   0x08035a52: e000        b.n	0x35a56
@   0x08035a54: 1c29        adds	r1, r5, #0
@   0x08035a56: 1c0d        adds	r5, r1, #0
@   0x08035a58: 9803        ldr	r0, [sp, #12]
@   0x08035a5a: 2800        cmp	r0, #0
@   0x08035a5c: d10a        bne.n	0x35a74
@   0x08035a5e: 9a00        ldr	r2, [sp, #0]
@   0x08035a60: 6811        ldr	r1, [r2, #0]
@   0x08035a62: 6828        ldr	r0, [r5, #0]
@   0x08035a64: 6010        str	r0, [r2, #0]
@   0x08035a66: 6029        str	r1, [r5, #0]
@   0x08035a68: 19d0        adds	r0, r2, r7
@   0x08035a6a: 9006        str	r0, [sp, #24]
@   0x08035a6c: 4649        mov	r1, r9
@   0x08035a6e: 4379        muls	r1, r7
@   0x08035a70: 9107        str	r1, [sp, #28]
@   0x08035a72: e023        b.n	0x35abc
@   0x08035a74: 9a03        ldr	r2, [sp, #12]
@   0x08035a76: 2a01        cmp	r2, #1
@   0x08035a78: dc0f        bgt.n	0x35a9a
@   0x08035a7a: 08ba        lsrs	r2, r7, #2
@   0x08035a7c: 9c00        ldr	r4, [sp, #0]
@   0x08035a7e: 1c2b        adds	r3, r5, #0
@   0x08035a80: 19e0        adds	r0, r4, r7
@   0x08035a82: 9006        str	r0, [sp, #24]
@   0x08035a84: 4649        mov	r1, r9
@   0x08035a86: 4379        muls	r1, r7
@   0x08035a88: 9107        str	r1, [sp, #28]
@   0x08035a8a: 6821        ldr	r1, [r4, #0]
@   0x08035a8c: 6818        ldr	r0, [r3, #0]
@   0x08035a8e: c401        stmia	r4!, {r0}
@   0x08035a90: c302        stmia	r3!, {r1}
@   0x08035a92: 3a01        subs	r2, #1
@   0x08035a94: 2a00        cmp	r2, #0
@   0x08035a96: dcf8        bgt.n	0x35a8a
@   0x08035a98: e010        b.n	0x35abc
@   0x08035a9a: 1c3c        adds	r4, r7, #0
@   0x08035a9c: 9b00        ldr	r3, [sp, #0]
@   0x08035a9e: 1c2a        adds	r2, r5, #0
@   0x08035aa0: 19d8        adds	r0, r3, r7
@   0x08035aa2: 9006        str	r0, [sp, #24]
@   0x08035aa4: 4649        mov	r1, r9
@   0x08035aa6: 4379        muls	r1, r7
@   0x08035aa8: 9107        str	r1, [sp, #28]
@   0x08035aaa: 7819        ldrb	r1, [r3, #0]
@   0x08035aac: 7810        ldrb	r0, [r2, #0]
@   0x08035aae: 7018        strb	r0, [r3, #0]
@   0x08035ab0: 3301        adds	r3, #1
@   0x08035ab2: 7011        strb	r1, [r2, #0]
@   0x08035ab4: 3201        adds	r2, #1
@   0x08035ab6: 3c01        subs	r4, #1
@   0x08035ab8: 2c00        cmp	r4, #0
@   0x08035aba: dcf6        bgt.n	0x35aaa
@   0x08035abc: 9e06        ldr	r6, [sp, #24]
@   0x08035abe: 46b1        mov	r9, r6
@   0x08035ac0: 9a05        ldr	r2, [sp, #20]
@   0x08035ac2: 1c10        adds	r0, r2, #0
@   0x08035ac4: 4378        muls	r0, r7
@   0x08035ac6: 9900        ldr	r1, [sp, #0]
@   0x08035ac8: 1809        adds	r1, r1, r0
@   0x08035aca: 4688        mov	r8, r1
@   0x08035acc: 4645        mov	r5, r8
@   0x08035ace: e05d        b.n	0x35b8c
@   0x08035ad0: 6831        ldr	r1, [r6, #0]
@   0x08035ad2: 6828        ldr	r0, [r5, #0]
@   0x08035ad4: 6030        str	r0, [r6, #0]
@   0x08035ad6: 6029        str	r1, [r5, #0]
@   0x08035ad8: 19f6        adds	r6, r6, r7
@   0x08035ada: 46b2        mov	sl, r6
@   0x08035adc: 1bed        subs	r5, r5, r7
@   0x08035ade: 46ac        mov	ip, r5
@   0x08035ae0: e021        b.n	0x35b26
@   0x08035ae2: 9a03        ldr	r2, [sp, #12]
@   0x08035ae4: 2a01        cmp	r2, #1
@   0x08035ae6: dc0e        bgt.n	0x35b06
@   0x08035ae8: 08bb        lsrs	r3, r7, #2
@   0x08035aea: 1c34        adds	r4, r6, #0
@   0x08035aec: 1c2a        adds	r2, r5, #0
@   0x08035aee: 19e0        adds	r0, r4, r7
@   0x08035af0: 4682        mov	sl, r0
@   0x08035af2: 1bd1        subs	r1, r2, r7
@   0x08035af4: 468c        mov	ip, r1
@   0x08035af6: 6821        ldr	r1, [r4, #0]
@   0x08035af8: 6810        ldr	r0, [r2, #0]
@   0x08035afa: c401        stmia	r4!, {r0}
@   0x08035afc: c202        stmia	r2!, {r1}
@   0x08035afe: 3b01        subs	r3, #1
@   0x08035b00: 2b00        cmp	r3, #0
@   0x08035b02: dcf8        bgt.n	0x35af6
@   0x08035b04: e00f        b.n	0x35b26
@   0x08035b06: 1c3c        adds	r4, r7, #0
@   0x08035b08: 1c33        adds	r3, r6, #0
@   0x08035b0a: 1c2a        adds	r2, r5, #0
@   0x08035b0c: 19d8        adds	r0, r3, r7
@   0x08035b0e: 4682        mov	sl, r0
@   0x08035b10: 1bd1        subs	r1, r2, r7
@   0x08035b12: 468c        mov	ip, r1
@   0x08035b14: 7819        ldrb	r1, [r3, #0]
@   0x08035b16: 7810        ldrb	r0, [r2, #0]
@   0x08035b18: 7018        strb	r0, [r3, #0]
@   0x08035b1a: 3301        adds	r3, #1
@   0x08035b1c: 7011        strb	r1, [r2, #0]
@   0x08035b1e: 3201        adds	r2, #1
@   0x08035b20: 3c01        subs	r4, #1
@   0x08035b22: 2c00        cmp	r4, #0
@   0x08035b24: dcf6        bgt.n	0x35b14
@   0x08035b26: 2201        movs	r2, #1
@   0x08035b28: 9204        str	r2, [sp, #16]
@   0x08035b2a: 4656        mov	r6, sl
@   0x08035b2c: 4665        mov	r5, ip
@   0x08035b2e: e02d        b.n	0x35b8c
@   0x08035b30: 19f1        adds	r1, r6, r7
@   0x08035b32: 468a        mov	sl, r1
@   0x08035b34: 2800        cmp	r0, #0
@   0x08035b36: d128        bne.n	0x35b8a
@   0x08035b38: 2201        movs	r2, #1
@   0x08035b3a: 9204        str	r2, [sp, #16]
@   0x08035b3c: 9803        ldr	r0, [sp, #12]
@   0x08035b3e: 2800        cmp	r0, #0
@   0x08035b40: d106        bne.n	0x35b50
@   0x08035b42: 464a        mov	r2, r9
@   0x08035b44: 6811        ldr	r1, [r2, #0]
@   0x08035b46: 6830        ldr	r0, [r6, #0]
@   0x08035b48: 6010        str	r0, [r2, #0]
@   0x08035b4a: 6031        str	r1, [r6, #0]
@   0x08035b4c: 19d6        adds	r6, r2, r7
@   0x08035b4e: e01b        b.n	0x35b88
@   0x08035b50: 9803        ldr	r0, [sp, #12]
@   0x08035b52: 2801        cmp	r0, #1
@   0x08035b54: dc0b        bgt.n	0x35b6e
@   0x08035b56: 08bb        lsrs	r3, r7, #2
@   0x08035b58: 464a        mov	r2, r9
@   0x08035b5a: 1c34        adds	r4, r6, #0
@   0x08035b5c: 19d6        adds	r6, r2, r7
@   0x08035b5e: 6811        ldr	r1, [r2, #0]
@   0x08035b60: 6820        ldr	r0, [r4, #0]
@   0x08035b62: c201        stmia	r2!, {r0}
@   0x08035b64: c402        stmia	r4!, {r1}
@   0x08035b66: 3b01        subs	r3, #1
@   0x08035b68: 2b00        cmp	r3, #0
@   0x08035b6a: dcf8        bgt.n	0x35b5e
@   0x08035b6c: e00c        b.n	0x35b88
@   0x08035b6e: 1c3c        adds	r4, r7, #0
@   0x08035b70: 464a        mov	r2, r9
@   0x08035b72: 1c33        adds	r3, r6, #0
@   0x08035b74: 19d6        adds	r6, r2, r7
@   0x08035b76: 7811        ldrb	r1, [r2, #0]
@   0x08035b78: 7818        ldrb	r0, [r3, #0]
@   0x08035b7a: 7010        strb	r0, [r2, #0]
@   0x08035b7c: 3201        adds	r2, #1
@   0x08035b7e: 7019        strb	r1, [r3, #0]
@   0x08035b80: 3301        adds	r3, #1
@   0x08035b82: 3c01        subs	r4, #1
@   0x08035b84: 2c00        cmp	r4, #0
@   0x08035b86: dcf6        bgt.n	0x35b76
@   0x08035b88: 46b1        mov	r9, r6
@   0x08035b8a: 4656        mov	r6, sl
@   0x08035b8c: 42ae        cmp	r6, r5
@   0x08035b8e: d835        bhi.n	0x35bfc
@   0x08035b90: 1c30        adds	r0, r6, #0
@   0x08035b92: 9900        ldr	r1, [sp, #0]
@   0x08035b94: 9a01        ldr	r2, [sp, #4]
@   0x08035b96: f7fe        f8a3 	bl	0x33ce0
@   0x08035b9a: 2800        cmp	r0, #0
@   0x08035b9c: ddc8        ble.n	0x35b30
@   0x08035b9e: e02d        b.n	0x35bfc
@   0x08035ba0: 1be9        subs	r1, r5, r7
@   0x08035ba2: 468c        mov	ip, r1
@   0x08035ba4: 2800        cmp	r0, #0
@   0x08035ba6: d128        bne.n	0x35bfa
@   0x08035ba8: 2201        movs	r2, #1
@   0x08035baa: 9204        str	r2, [sp, #16]
@   0x08035bac: 9803        ldr	r0, [sp, #12]
@   0x08035bae: 2800        cmp	r0, #0
@   0x08035bb0: d106        bne.n	0x35bc0
@   0x08035bb2: 6829        ldr	r1, [r5, #0]
@   0x08035bb4: 4642        mov	r2, r8
@   0x08035bb6: 6810        ldr	r0, [r2, #0]
@   0x08035bb8: 6028        str	r0, [r5, #0]
@   0x08035bba: 6011        str	r1, [r2, #0]
@   0x08035bbc: 1bd5        subs	r5, r2, r7
@   0x08035bbe: e01b        b.n	0x35bf8
@   0x08035bc0: 9803        ldr	r0, [sp, #12]
@   0x08035bc2: 2801        cmp	r0, #1
@   0x08035bc4: dc0b        bgt.n	0x35bde
@   0x08035bc6: 08bb        lsrs	r3, r7, #2
@   0x08035bc8: 1c2c        adds	r4, r5, #0
@   0x08035bca: 4642        mov	r2, r8
@   0x08035bcc: 1bd5        subs	r5, r2, r7
@   0x08035bce: 6821        ldr	r1, [r4, #0]
@   0x08035bd0: 6810        ldr	r0, [r2, #0]
@   0x08035bd2: c401        stmia	r4!, {r0}
@   0x08035bd4: c202        stmia	r2!, {r1}
@   0x08035bd6: 3b01        subs	r3, #1
@   0x08035bd8: 2b00        cmp	r3, #0
@   0x08035bda: dcf8        bgt.n	0x35bce
@   0x08035bdc: e00c        b.n	0x35bf8
@   0x08035bde: 1c3c        adds	r4, r7, #0
@   0x08035be0: 1c2b        adds	r3, r5, #0
@   0x08035be2: 4642        mov	r2, r8
@   0x08035be4: 1bd5        subs	r5, r2, r7
@   0x08035be6: 7819        ldrb	r1, [r3, #0]
@   0x08035be8: 7810        ldrb	r0, [r2, #0]
@   0x08035bea: 7018        strb	r0, [r3, #0]
@   0x08035bec: 3301        adds	r3, #1
@   0x08035bee: 7011        strb	r1, [r2, #0]
@   0x08035bf0: 3201        adds	r2, #1
@   0x08035bf2: 3c01        subs	r4, #1
@   0x08035bf4: 2c00        cmp	r4, #0
@   0x08035bf6: dcf6        bgt.n	0x35be6
@   0x08035bf8: 46a8        mov	r8, r5
@   0x08035bfa: 4665        mov	r5, ip
@   0x08035bfc: 42ae        cmp	r6, r5
@   0x08035bfe: d80b        bhi.n	0x35c18
@   0x08035c00: 1c28        adds	r0, r5, #0
@   0x08035c02: 9900        ldr	r1, [sp, #0]
@   0x08035c04: 9a01        ldr	r2, [sp, #4]
@   0x08035c06: f7fe        f86b 	bl	0x33ce0
@   0x08035c0a: 2800        cmp	r0, #0
@   0x08035c0c: dac8        bge.n	0x35ba0
@   0x08035c0e: 9803        ldr	r0, [sp, #12]
@   0x08035c10: 2800        cmp	r0, #0
@   0x08035c12: d000        beq.n	0x35c16
@   0x08035c14: e765        b.n	0x35ae2
@   0x08035c16: e75b        b.n	0x35ad0
@   0x08035c18: 9904        ldr	r1, [sp, #16]
@   0x08035c1a: 2900        cmp	r1, #0
@   0x08035c1c: d140        bne.n	0x35ca0
@   0x08035c1e: 9d06        ldr	r5, [sp, #24]
@   0x08035c20: 9a00        ldr	r2, [sp, #0]
@   0x08035c22: 9907        ldr	r1, [sp, #28]
@   0x08035c24: 1850        adds	r0, r2, r1
@   0x08035c26: 4285        cmp	r5, r0
@   0x08035c28: d300        bcc.n	0x35c2c
@   0x08035c2a: e0a1        b.n	0x35d70
@   0x08035c2c: 1c2e        adds	r6, r5, #0
@   0x08035c2e: 19ed        adds	r5, r5, r7
@   0x08035c30: 46a8        mov	r8, r5
@   0x08035c32: e022        b.n	0x35c7a
@   0x08035c34: 9a03        ldr	r2, [sp, #12]
@   0x08035c36: 2a00        cmp	r2, #0
@   0x08035c38: d104        bne.n	0x35c44
@   0x08035c3a: 6831        ldr	r1, [r6, #0]
@   0x08035c3c: 6828        ldr	r0, [r5, #0]
@   0x08035c3e: 6030        str	r0, [r6, #0]
@   0x08035c40: 6029        str	r1, [r5, #0]
@   0x08035c42: e019        b.n	0x35c78
@   0x08035c44: 9803        ldr	r0, [sp, #12]
@   0x08035c46: 2801        cmp	r0, #1
@   0x08035c48: dc0a        bgt.n	0x35c60
@   0x08035c4a: 08ba        lsrs	r2, r7, #2
@   0x08035c4c: 1c34        adds	r4, r6, #0
@   0x08035c4e: 1c2b        adds	r3, r5, #0
@   0x08035c50: 6821        ldr	r1, [r4, #0]
@   0x08035c52: 6818        ldr	r0, [r3, #0]
@   0x08035c54: c401        stmia	r4!, {r0}
@   0x08035c56: c302        stmia	r3!, {r1}
@   0x08035c58: 3a01        subs	r2, #1
@   0x08035c5a: 2a00        cmp	r2, #0
@   0x08035c5c: dcf8        bgt.n	0x35c50
@   0x08035c5e: e00b        b.n	0x35c78
@   0x08035c60: 1c3b        adds	r3, r7, #0
@   0x08035c62: 1c34        adds	r4, r6, #0
@   0x08035c64: 1c2a        adds	r2, r5, #0
@   0x08035c66: 7821        ldrb	r1, [r4, #0]
@   0x08035c68: 7810        ldrb	r0, [r2, #0]
@   0x08035c6a: 7020        strb	r0, [r4, #0]
@   0x08035c6c: 3401        adds	r4, #1
@   0x08035c6e: 7011        strb	r1, [r2, #0]
@   0x08035c70: 3201        adds	r2, #1
@   0x08035c72: 3b01        subs	r3, #1
@   0x08035c74: 2b00        cmp	r3, #0
@   0x08035c76: dcf6        bgt.n	0x35c66
@   0x08035c78: 1c2e        adds	r6, r5, #0
@   0x08035c7a: 9900        ldr	r1, [sp, #0]
@   0x08035c7c: 428e        cmp	r6, r1
@   0x08035c7e: d908        bls.n	0x35c92
@   0x08035c80: 1bf4        subs	r4, r6, r7
@   0x08035c82: 1c20        adds	r0, r4, #0
@   0x08035c84: 1c31        adds	r1, r6, #0
@   0x08035c86: 9a01        ldr	r2, [sp, #4]
@   0x08035c88: f7fe        f82a 	bl	0x33ce0
@   0x08035c8c: 1c25        adds	r5, r4, #0
@   0x08035c8e: 2800        cmp	r0, #0
@   0x08035c90: dcd0        bgt.n	0x35c34
@   0x08035c92: 4645        mov	r5, r8
@   0x08035c94: 9900        ldr	r1, [sp, #0]
@   0x08035c96: 9a07        ldr	r2, [sp, #28]
@   0x08035c98: 1888        adds	r0, r1, r2
@   0x08035c9a: 4285        cmp	r5, r0
@   0x08035c9c: d3c6        bcc.n	0x35c2c
@   0x08035c9e: e067        b.n	0x35d70
@   0x08035ca0: 9800        ldr	r0, [sp, #0]
@   0x08035ca2: 9907        ldr	r1, [sp, #28]
@   0x08035ca4: 1840        adds	r0, r0, r1
@   0x08035ca6: 4682        mov	sl, r0
@   0x08035ca8: 464a        mov	r2, r9
@   0x08035caa: 9800        ldr	r0, [sp, #0]
@   0x08035cac: 1a11        subs	r1, r2, r0
@   0x08035cae: 1ab0        subs	r0, r6, r2
@   0x08035cb0: 4681        mov	r9, r0
@   0x08035cb2: 4288        cmp	r0, r1
@   0x08035cb4: dd00        ble.n	0x35cb8
@   0x08035cb6: 1c08        adds	r0, r1, #0
@   0x08035cb8: 4641        mov	r1, r8
@   0x08035cba: 1b4d        subs	r5, r1, r5
@   0x08035cbc: 4652        mov	r2, sl
@   0x08035cbe: 1a52        subs	r2, r2, r1
@   0x08035cc0: 4690        mov	r8, r2
@   0x08035cc2: 2800        cmp	r0, #0
@   0x08035cc4: dd1a        ble.n	0x35cfc
@   0x08035cc6: 1a31        subs	r1, r6, r0
@   0x08035cc8: 9a03        ldr	r2, [sp, #12]
@   0x08035cca: 2a01        cmp	r2, #1
@   0x08035ccc: dc0a        bgt.n	0x35ce4
@   0x08035cce: 0882        lsrs	r2, r0, #2
@   0x08035cd0: 9c00        ldr	r4, [sp, #0]
@   0x08035cd2: 1c0b        adds	r3, r1, #0
@   0x08035cd4: 6821        ldr	r1, [r4, #0]
@   0x08035cd6: 6818        ldr	r0, [r3, #0]
@   0x08035cd8: c401        stmia	r4!, {r0}
@   0x08035cda: c302        stmia	r3!, {r1}
@   0x08035cdc: 3a01        subs	r2, #1
@   0x08035cde: 2a00        cmp	r2, #0
@   0x08035ce0: dcf8        bgt.n	0x35cd4
@   0x08035ce2: e00b        b.n	0x35cfc
@   0x08035ce4: 1c04        adds	r4, r0, #0
@   0x08035ce6: 9b00        ldr	r3, [sp, #0]
@   0x08035ce8: 1c0a        adds	r2, r1, #0
@   0x08035cea: 7819        ldrb	r1, [r3, #0]
@   0x08035cec: 7810        ldrb	r0, [r2, #0]
@   0x08035cee: 7018        strb	r0, [r3, #0]
@   0x08035cf0: 3301        adds	r3, #1
@   0x08035cf2: 7011        strb	r1, [r2, #0]
@   0x08035cf4: 3201        adds	r2, #1
@   0x08035cf6: 3c01        subs	r4, #1
@   0x08035cf8: 2c00        cmp	r4, #0
@   0x08035cfa: dcf6        bgt.n	0x35cea
@   0x08035cfc: 4641        mov	r1, r8
@   0x08035cfe: 1bc8        subs	r0, r1, r7
@   0x08035d00: 42a8        cmp	r0, r5
@   0x08035d02: d900        bls.n	0x35d06
@   0x08035d04: 1c28        adds	r0, r5, #0
@   0x08035d06: 2800        cmp	r0, #0
@   0x08035d08: dd1b        ble.n	0x35d42
@   0x08035d0a: 4652        mov	r2, sl
@   0x08035d0c: 1a11        subs	r1, r2, r0
@   0x08035d0e: 9a03        ldr	r2, [sp, #12]
@   0x08035d10: 2a01        cmp	r2, #1
@   0x08035d12: dc0a        bgt.n	0x35d2a
@   0x08035d14: 0882        lsrs	r2, r0, #2
@   0x08035d16: 1c34        adds	r4, r6, #0
@   0x08035d18: 1c0b        adds	r3, r1, #0
@   0x08035d1a: 6821        ldr	r1, [r4, #0]
@   0x08035d1c: 6818        ldr	r0, [r3, #0]
@   0x08035d1e: c401        stmia	r4!, {r0}
@   0x08035d20: c302        stmia	r3!, {r1}
@   0x08035d22: 3a01        subs	r2, #1
@   0x08035d24: 2a00        cmp	r2, #0
@   0x08035d26: dcf8        bgt.n	0x35d1a
@   0x08035d28: e00b        b.n	0x35d42
@   0x08035d2a: 1c04        adds	r4, r0, #0
@   0x08035d2c: 1c33        adds	r3, r6, #0
@   0x08035d2e: 1c0a        adds	r2, r1, #0
@   0x08035d30: 7819        ldrb	r1, [r3, #0]
@   0x08035d32: 7810        ldrb	r0, [r2, #0]
@   0x08035d34: 7018        strb	r0, [r3, #0]
@   0x08035d36: 3301        adds	r3, #1
@   0x08035d38: 7011        strb	r1, [r2, #0]
@   0x08035d3a: 3201        adds	r2, #1
@   0x08035d3c: 3c01        subs	r4, #1
@   0x08035d3e: 2c00        cmp	r4, #0
@   0x08035d40: dcf6        bgt.n	0x35d30
@   0x08035d42: 4648        mov	r0, r9
@   0x08035d44: 42b8        cmp	r0, r7
@   0x08035d46: d908        bls.n	0x35d5a
@   0x08035d48: 1c39        adds	r1, r7, #0
@   0x08035d4a: f7fe        f8cb 	bl	0x33ee4
@   0x08035d4e: 1c01        adds	r1, r0, #0
@   0x08035d50: 9800        ldr	r0, [sp, #0]
@   0x08035d52: 1c3a        adds	r2, r7, #0
@   0x08035d54: 9b01        ldr	r3, [sp, #4]
@   0x08035d56: f7ff        fd49 	bl	0x357ec
@   0x08035d5a: 42bd        cmp	r5, r7
@   0x08035d5c: d908        bls.n	0x35d70
@   0x08035d5e: 4650        mov	r0, sl
@   0x08035d60: 1b40        subs	r0, r0, r5
@   0x08035d62: 9000        str	r0, [sp, #0]
@   0x08035d64: 1c28        adds	r0, r5, #0
@   0x08035d66: 1c39        adds	r1, r7, #0
@   0x08035d68: f7fe        f8bc 	bl	0x33ee4
@   0x08035d6c: 4681        mov	r9, r0
@   0x08035d6e: e547        b.n	0x35800
@   0x08035d70: b008        add	sp, #32
@   0x08035d72: bc38        pop	{r3, r4, r5}
@   0x08035d74: 4698        mov	r8, r3
@   0x08035d76: 46a1        mov	r9, r4
@   0x08035d78: 46aa        mov	sl, r5
@   0x08035d7a: bdf0        pop	{r4, r5, r6, r7, pc}

        thumb_func_start qsort
qsort: @ 0x080357ec
        .incbin "frog_us_baserom.gba", 0x357ec, 0x590
        thumb_func_end qsort
