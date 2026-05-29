@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c978, 0x0800cb80)  (520 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c978 --end 0x800cb80 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c978: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800c97a: b081        sub	sp, #4
@   0x0800c97c: 9c06        ldr	r4, [sp, #24]
@   0x0800c97e: 0600        lsls	r0, r0, #24
@   0x0800c980: 0e06        lsrs	r6, r0, #24
@   0x0800c982: 0609        lsls	r1, r1, #24
@   0x0800c984: 0e0f        lsrs	r7, r1, #24
@   0x0800c986: 0412        lsls	r2, r2, #16
@   0x0800c988: 0c15        lsrs	r5, r2, #16
@   0x0800c98a: 041b        lsls	r3, r3, #16
@   0x0800c98c: 0c1b        lsrs	r3, r3, #16
@   0x0800c98e: 0624        lsls	r4, r4, #24
@   0x0800c990: 0e24        lsrs	r4, r4, #24
@   0x0800c992: 1e60        subs	r0, r4, #1
@   0x0800c994: 280f        cmp	r0, #15
@   0x0800c996: d900        bls.n	0xc99a
@   0x0800c998: e0ec        b.n	0xcb74
@   0x0800c99a: 0080        lsls	r0, r0, #2
@   0x0800c99c: 4901        ldr	r1, [pc, #4]	@ (0xc9a4)
@   0x0800c99e: 1840        adds	r0, r0, r1
@   0x0800c9a0: 6800        ldr	r0, [r0, #0]
@   0x0800c9a2: 4687        mov	pc, r0
@   0x0800c9a4: c9a8        ldmia	r1!, {r3, r5, r7}
@   0x0800c9a6: 0800        lsrs	r0, r0, #32
@   0x0800c9a8: c9e8        ldmia	r1!, {r3, r5, r6, r7}
@   0x0800c9aa: 0800        lsrs	r0, r0, #32
@   0x0800c9ac: ca1c        ldmia	r2, {r2, r3, r4}
@   0x0800c9ae: 0800        lsrs	r0, r0, #32
@   0x0800c9b0: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9b2: 0800        lsrs	r0, r0, #32
@   0x0800c9b4: ca54        ldmia	r2, {r2, r4, r6}
@   0x0800c9b6: 0800        lsrs	r0, r0, #32
@   0x0800c9b8: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9ba: 0800        lsrs	r0, r0, #32
@   0x0800c9bc: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9be: 0800        lsrs	r0, r0, #32
@   0x0800c9c0: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9c2: 0800        lsrs	r0, r0, #32
@   0x0800c9c4: ca88        ldmia	r2!, {r3, r7}
@   0x0800c9c6: 0800        lsrs	r0, r0, #32
@   0x0800c9c8: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9ca: 0800        lsrs	r0, r0, #32
@   0x0800c9cc: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9ce: 0800        lsrs	r0, r0, #32
@   0x0800c9d0: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9d2: 0800        lsrs	r0, r0, #32
@   0x0800c9d4: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9d6: 0800        lsrs	r0, r0, #32
@   0x0800c9d8: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9da: 0800        lsrs	r0, r0, #32
@   0x0800c9dc: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9de: 0800        lsrs	r0, r0, #32
@   0x0800c9e0: cb74        ldmia	r3!, {r2, r4, r5, r6}
@   0x0800c9e2: 0800        lsrs	r0, r0, #32
@   0x0800c9e4: cac8        ldmia	r2!, {r3, r6, r7}
@   0x0800c9e6: 0800        lsrs	r0, r0, #32
@   0x0800c9e8: 0418        lsls	r0, r3, #16
@   0x0800c9ea: 1400        asrs	r0, r0, #16
@   0x0800c9ec: 1e43        subs	r3, r0, #1
@   0x0800c9ee: 2b00        cmp	r3, #0
@   0x0800c9f0: da00        bge.n	0xc9f4
@   0x0800c9f2: e0bf        b.n	0xcb74
@   0x0800c9f4: 4907        ldr	r1, [pc, #28]	@ (0xca14)
@   0x0800c9f6: 00f0        lsls	r0, r6, #3
@   0x0800c9f8: 1840        adds	r0, r0, r1
@   0x0800c9fa: 7900        ldrb	r0, [r0, #4]
@   0x0800c9fc: 1c02        adds	r2, r0, #0
@   0x0800c9fe: 435a        muls	r2, r3
@   0x0800ca00: 0429        lsls	r1, r5, #16
@   0x0800ca02: 13c9        asrs	r1, r1, #15
@   0x0800ca04: 00b8        lsls	r0, r7, #2
@   0x0800ca06: 19c0        adds	r0, r0, r7
@   0x0800ca08: 0300        lsls	r0, r0, #12
@   0x0800ca0a: 0052        lsls	r2, r2, #1
@   0x0800ca0c: 1880        adds	r0, r0, r2
@   0x0800ca0e: 1809        adds	r1, r1, r0
@   0x0800ca10: 4801        ldr	r0, [pc, #4]	@ (0xca18)
@   0x0800ca12: e04d        b.n	0xcab0
@   0x0800ca14: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ca16: 0830        lsrs	r0, r6, #32
@   0x0800ca18: 0000        movs	r0, r0
@   0x0800ca1a: 0203        lsls	r3, r0, #8
@   0x0800ca1c: 0418        lsls	r0, r3, #16
@   0x0800ca1e: 1400        asrs	r0, r0, #16
@   0x0800ca20: 1c43        adds	r3, r0, #1
@   0x0800ca22: 490a        ldr	r1, [pc, #40]	@ (0xca4c)
@   0x0800ca24: 00f0        lsls	r0, r6, #3
@   0x0800ca26: 1840        adds	r0, r0, r1
@   0x0800ca28: 7941        ldrb	r1, [r0, #5]
@   0x0800ca2a: 428b        cmp	r3, r1
@   0x0800ca2c: db00        blt.n	0xca30
@   0x0800ca2e: e0a1        b.n	0xcb74
@   0x0800ca30: 7900        ldrb	r0, [r0, #4]
@   0x0800ca32: 1c02        adds	r2, r0, #0
@   0x0800ca34: 435a        muls	r2, r3
@   0x0800ca36: 0429        lsls	r1, r5, #16
@   0x0800ca38: 13c9        asrs	r1, r1, #15
@   0x0800ca3a: 00b8        lsls	r0, r7, #2
@   0x0800ca3c: 19c0        adds	r0, r0, r7
@   0x0800ca3e: 0300        lsls	r0, r0, #12
@   0x0800ca40: 0052        lsls	r2, r2, #1
@   0x0800ca42: 1880        adds	r0, r0, r2
@   0x0800ca44: 1809        adds	r1, r1, r0
@   0x0800ca46: 4802        ldr	r0, [pc, #8]	@ (0xca50)
@   0x0800ca48: e032        b.n	0xcab0
@   0x0800ca4a: 0000        movs	r0, r0
@   0x0800ca4c: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ca4e: 0830        lsrs	r0, r6, #32
@   0x0800ca50: 0000        movs	r0, r0
@   0x0800ca52: 0203        lsls	r3, r0, #8
@   0x0800ca54: 0428        lsls	r0, r5, #16
@   0x0800ca56: 1404        asrs	r4, r0, #16
@   0x0800ca58: 1e60        subs	r0, r4, #1
@   0x0800ca5a: 2800        cmp	r0, #0
@   0x0800ca5c: da00        bge.n	0xca60
@   0x0800ca5e: e089        b.n	0xcb74
@   0x0800ca60: 0419        lsls	r1, r3, #16
@   0x0800ca62: 1409        asrs	r1, r1, #16
@   0x0800ca64: 4a06        ldr	r2, [pc, #24]	@ (0xca80)
@   0x0800ca66: 00f0        lsls	r0, r6, #3
@   0x0800ca68: 1880        adds	r0, r0, r2
@   0x0800ca6a: 7900        ldrb	r0, [r0, #4]
@   0x0800ca6c: 4348        muls	r0, r1
@   0x0800ca6e: 00b9        lsls	r1, r7, #2
@   0x0800ca70: 19c9        adds	r1, r1, r7
@   0x0800ca72: 0309        lsls	r1, r1, #12
@   0x0800ca74: 0040        lsls	r0, r0, #1
@   0x0800ca76: 1809        adds	r1, r1, r0
@   0x0800ca78: 0060        lsls	r0, r4, #1
@   0x0800ca7a: 1809        adds	r1, r1, r0
@   0x0800ca7c: 4801        ldr	r0, [pc, #4]	@ (0xca84)
@   0x0800ca7e: e017        b.n	0xcab0
@   0x0800ca80: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800ca82: 0830        lsrs	r0, r6, #32
@   0x0800ca84: fffe        0202 	vmovn.i<illegal width 128>	d16, q1
@   0x0800ca88: 0428        lsls	r0, r5, #16
@   0x0800ca8a: 1404        asrs	r4, r0, #16
@   0x0800ca8c: 1c62        adds	r2, r4, #1
@   0x0800ca8e: 490c        ldr	r1, [pc, #48]	@ (0xcac0)
@   0x0800ca90: 00f0        lsls	r0, r6, #3
@   0x0800ca92: 1840        adds	r0, r0, r1
@   0x0800ca94: 7901        ldrb	r1, [r0, #4]
@   0x0800ca96: 428a        cmp	r2, r1
@   0x0800ca98: da6c        bge.n	0xcb74
@   0x0800ca9a: 0418        lsls	r0, r3, #16
@   0x0800ca9c: 1400        asrs	r0, r0, #16
@   0x0800ca9e: 4348        muls	r0, r1
@   0x0800caa0: 00b9        lsls	r1, r7, #2
@   0x0800caa2: 19c9        adds	r1, r1, r7
@   0x0800caa4: 0309        lsls	r1, r1, #12
@   0x0800caa6: 0040        lsls	r0, r0, #1
@   0x0800caa8: 1809        adds	r1, r1, r0
@   0x0800caaa: 0060        lsls	r0, r4, #1
@   0x0800caac: 1809        adds	r1, r1, r0
@   0x0800caae: 4805        ldr	r0, [pc, #20]	@ (0xcac4)
@   0x0800cab0: 1809        adds	r1, r1, r0
@   0x0800cab2: 20fc        movs	r0, #252	@ 0xfc
@   0x0800cab4: 0080        lsls	r0, r0, #2
@   0x0800cab6: 8809        ldrh	r1, [r1, #0]
@   0x0800cab8: 4008        ands	r0, r1
@   0x0800caba: 0900        lsrs	r0, r0, #4
@   0x0800cabc: e05b        b.n	0xcb76
@   0x0800cabe: 0000        movs	r0, r0
@   0x0800cac0: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cac2: 0830        lsrs	r0, r6, #32
@   0x0800cac4: 0002        movs	r2, r0
@   0x0800cac6: 0203        lsls	r3, r0, #8
@   0x0800cac8: 4804        ldr	r0, [pc, #16]	@ (0xcadc)
@   0x0800caca: 7e80        ldrb	r0, [r0, #26]
@   0x0800cacc: 2801        cmp	r0, #1
@   0x0800cace: d018        beq.n	0xcb02
@   0x0800cad0: 2801        cmp	r0, #1
@   0x0800cad2: dc05        bgt.n	0xcae0
@   0x0800cad4: 2800        cmp	r0, #0
@   0x0800cad6: d008        beq.n	0xcaea
@   0x0800cad8: e04c        b.n	0xcb74
@   0x0800cada: 0000        movs	r0, r0
@   0x0800cadc: 3720        adds	r7, #32
@   0x0800cade: 0300        lsls	r0, r0, #12
@   0x0800cae0: 2802        cmp	r0, #2
@   0x0800cae2: d021        beq.n	0xcb28
@   0x0800cae4: 2803        cmp	r0, #3
@   0x0800cae6: d02b        beq.n	0xcb40
@   0x0800cae8: e044        b.n	0xcb74
@   0x0800caea: 0418        lsls	r0, r3, #16
@   0x0800caec: 1401        asrs	r1, r0, #16
@   0x0800caee: 1e88        subs	r0, r1, #2
@   0x0800caf0: 2800        cmp	r0, #0
@   0x0800caf2: db3f        blt.n	0xcb74
@   0x0800caf4: 042a        lsls	r2, r5, #16
@   0x0800caf6: 1412        asrs	r2, r2, #16
@   0x0800caf8: 1e4b        subs	r3, r1, #1
@   0x0800cafa: 041b        lsls	r3, r3, #16
@   0x0800cafc: 141b        asrs	r3, r3, #16
@   0x0800cafe: 2001        movs	r0, #1
@   0x0800cb00: e02d        b.n	0xcb5e
@   0x0800cb02: 0418        lsls	r0, r3, #16
@   0x0800cb04: 1403        asrs	r3, r0, #16
@   0x0800cb06: 1c9a        adds	r2, r3, #2
@   0x0800cb08: 4906        ldr	r1, [pc, #24]	@ (0xcb24)
@   0x0800cb0a: 00f0        lsls	r0, r6, #3
@   0x0800cb0c: 1840        adds	r0, r0, r1
@   0x0800cb0e: 7940        ldrb	r0, [r0, #5]
@   0x0800cb10: 4282        cmp	r2, r0
@   0x0800cb12: da2f        bge.n	0xcb74
@   0x0800cb14: 042a        lsls	r2, r5, #16
@   0x0800cb16: 1412        asrs	r2, r2, #16
@   0x0800cb18: 3301        adds	r3, #1
@   0x0800cb1a: 041b        lsls	r3, r3, #16
@   0x0800cb1c: 141b        asrs	r3, r3, #16
@   0x0800cb1e: 2002        movs	r0, #2
@   0x0800cb20: e01d        b.n	0xcb5e
@   0x0800cb22: 0000        movs	r0, r0
@   0x0800cb24: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cb26: 0830        lsrs	r0, r6, #32
@   0x0800cb28: 0428        lsls	r0, r5, #16
@   0x0800cb2a: 1401        asrs	r1, r0, #16
@   0x0800cb2c: 1e88        subs	r0, r1, #2
@   0x0800cb2e: 2800        cmp	r0, #0
@   0x0800cb30: db20        blt.n	0xcb74
@   0x0800cb32: 1e4a        subs	r2, r1, #1
@   0x0800cb34: 0412        lsls	r2, r2, #16
@   0x0800cb36: 1412        asrs	r2, r2, #16
@   0x0800cb38: 041b        lsls	r3, r3, #16
@   0x0800cb3a: 141b        asrs	r3, r3, #16
@   0x0800cb3c: 2004        movs	r0, #4
@   0x0800cb3e: e00e        b.n	0xcb5e
@   0x0800cb40: 0428        lsls	r0, r5, #16
@   0x0800cb42: 1404        asrs	r4, r0, #16
@   0x0800cb44: 1ca2        adds	r2, r4, #2
@   0x0800cb46: 490a        ldr	r1, [pc, #40]	@ (0xcb70)
@   0x0800cb48: 00f0        lsls	r0, r6, #3
@   0x0800cb4a: 1840        adds	r0, r0, r1
@   0x0800cb4c: 7900        ldrb	r0, [r0, #4]
@   0x0800cb4e: 4282        cmp	r2, r0
@   0x0800cb50: da10        bge.n	0xcb74
@   0x0800cb52: 1c62        adds	r2, r4, #1
@   0x0800cb54: 0412        lsls	r2, r2, #16
@   0x0800cb56: 1412        asrs	r2, r2, #16
@   0x0800cb58: 041b        lsls	r3, r3, #16
@   0x0800cb5a: 141b        asrs	r3, r3, #16
@   0x0800cb5c: 2008        movs	r0, #8
@   0x0800cb5e: 9000        str	r0, [sp, #0]
@   0x0800cb60: 1c30        adds	r0, r6, #0
@   0x0800cb62: 1c39        adds	r1, r7, #0
@   0x0800cb64: f7ff        ff08 	bl	0xc978
@   0x0800cb68: 0600        lsls	r0, r0, #24
@   0x0800cb6a: 0e00        lsrs	r0, r0, #24
@   0x0800cb6c: e003        b.n	0xcb76
@   0x0800cb6e: 0000        movs	r0, r0
@   0x0800cb70: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800cb72: 0830        lsrs	r0, r6, #32
@   0x0800cb74: 2000        movs	r0, #0
@   0x0800cb76: b001        add	sp, #4
@   0x0800cb78: bcf0        pop	{r4, r5, r6, r7}
@   0x0800cb7a: bc02        pop	{r1}
@   0x0800cb7c: 4708        bx	r1

        thumb_func_start sub_0800C978
sub_0800C978: @ 0x0800c978
        .incbin "frog_us_baserom.gba", 0xc978, 0x208
        thumb_func_end sub_0800C978
