@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08011984, 0x08011aa4)  (288 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8011984 --end 0x8011aa4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08011984: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08011986: 4657        mov	r7, sl
@   0x08011988: 464e        mov	r6, r9
@   0x0801198a: 4645        mov	r5, r8
@   0x0801198c: b4e0        push	{r5, r6, r7}
@   0x0801198e: b084        sub	sp, #16
@   0x08011990: 4681        mov	r9, r0
@   0x08011992: 0609        lsls	r1, r1, #24
@   0x08011994: 0e09        lsrs	r1, r1, #24
@   0x08011996: 468c        mov	ip, r1
@   0x08011998: 4c3d        ldr	r4, [pc, #244]	@ (0x11a90)
@   0x0801199a: 2000        movs	r0, #0
@   0x0801199c: 2301        movs	r3, #1
@   0x0801199e: 7023        strb	r3, [r4, #0]
@   0x080119a0: 72a0        strb	r0, [r4, #10]
@   0x080119a2: 4660        mov	r0, ip
@   0x080119a4: 00c0        lsls	r0, r0, #3
@   0x080119a6: 4680        mov	r8, r0
@   0x080119a8: 1a42        subs	r2, r0, r1
@   0x080119aa: 0092        lsls	r2, r2, #2
@   0x080119ac: 444a        add	r2, r9
@   0x080119ae: 8891        ldrh	r1, [r2, #4]
@   0x080119b0: 8621        strh	r1, [r4, #48]	@ 0x30
@   0x080119b2: 88d0        ldrh	r0, [r2, #6]
@   0x080119b4: 8660        strh	r0, [r4, #50]	@ 0x32
@   0x080119b6: 85a1        strh	r1, [r4, #44]	@ 0x2c
@   0x080119b8: 85e0        strh	r0, [r4, #46]	@ 0x2e
@   0x080119ba: 7b10        ldrb	r0, [r2, #12]
@   0x080119bc: 72e0        strb	r0, [r4, #11]
@   0x080119be: 6910        ldr	r0, [r2, #16]
@   0x080119c0: 6120        str	r0, [r4, #16]
@   0x080119c2: 4934        ldr	r1, [pc, #208]	@ (0x11a94)
@   0x080119c4: 700b        strb	r3, [r1, #0]
@   0x080119c6: 724b        strb	r3, [r1, #9]
@   0x080119c8: 1c15        adds	r5, r2, #0
@   0x080119ca: 351c        adds	r5, #28
@   0x080119cc: 8868        ldrh	r0, [r5, #2]
@   0x080119ce: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x080119d0: 8b90        ldrh	r0, [r2, #28]
@   0x080119d2: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x080119d4: 692e        ldr	r6, [r5, #16]
@   0x080119d6: 610e        str	r6, [r1, #16]
@   0x080119d8: 2002        movs	r0, #2
@   0x080119da: 7208        strb	r0, [r1, #8]
@   0x080119dc: 482e        ldr	r0, [pc, #184]	@ (0x11a98)
@   0x080119de: 6188        str	r0, [r1, #24]
@   0x080119e0: 7b28        ldrb	r0, [r5, #12]
@   0x080119e2: 72c8        strb	r0, [r1, #11]
@   0x080119e4: 88ab        ldrh	r3, [r5, #4]
@   0x080119e6: 860b        strh	r3, [r1, #48]	@ 0x30
@   0x080119e8: 464f        mov	r7, r9
@   0x080119ea: 8c78        ldrh	r0, [r7, #34]	@ 0x22
@   0x080119ec: 8648        strh	r0, [r1, #50]	@ 0x32
@   0x080119ee: 858b        strh	r3, [r1, #44]	@ 0x2c
@   0x080119f0: 88e8        ldrh	r0, [r5, #6]
@   0x080119f2: 85c8        strh	r0, [r1, #46]	@ 0x2e
@   0x080119f4: 468a        mov	sl, r1
@   0x080119f6: 4929        ldr	r1, [pc, #164]	@ (0x11a9c)
@   0x080119f8: 8b4b        ldrh	r3, [r1, #26]
@   0x080119fa: 886d        ldrh	r5, [r5, #2]
@   0x080119fc: 1c18        adds	r0, r3, #0
@   0x080119fe: 4368        muls	r0, r5
@   0x08011a00: 8b92        ldrh	r2, [r2, #28]
@   0x08011a02: 1810        adds	r0, r2, r0
@   0x08011a04: 0040        lsls	r0, r0, #1
@   0x08011a06: 4c24        ldr	r4, [pc, #144]	@ (0x11a98)
@   0x08011a08: 1900        adds	r0, r0, r4
@   0x08011a0a: 4655        mov	r5, sl
@   0x08011a0c: 61a8        str	r0, [r5, #24]
@   0x08011a0e: 4f20        ldr	r7, [pc, #128]	@ (0x11a90)
@   0x08011a10: 8e7c        ldrh	r4, [r7, #50]	@ 0x32
@   0x08011a12: 8e3b        ldrh	r3, [r7, #48]	@ 0x30
@   0x08011a14: 1c02        adds	r2, r0, #0
@   0x08011a16: 2000        movs	r0, #0
@   0x08011a18: 4645        mov	r5, r8
@   0x08011a1a: 9503        str	r5, [sp, #12]
@   0x08011a1c: 42a0        cmp	r0, r4
@   0x08011a1e: d216        bcs.n	0x11a4e
@   0x08011a20: 4688        mov	r8, r1
@   0x08011a22: 2100        movs	r1, #0
@   0x08011a24: 1c45        adds	r5, r0, #1
@   0x08011a26: 4299        cmp	r1, r3
@   0x08011a28: d208        bcs.n	0x11a3c
@   0x08011a2a: 8830        ldrh	r0, [r6, #0]
@   0x08011a2c: 8010        strh	r0, [r2, #0]
@   0x08011a2e: 3602        adds	r6, #2
@   0x08011a30: 3202        adds	r2, #2
@   0x08011a32: 1c48        adds	r0, r1, #1
@   0x08011a34: 0400        lsls	r0, r0, #16
@   0x08011a36: 0c01        lsrs	r1, r0, #16
@   0x08011a38: 4299        cmp	r1, r3
@   0x08011a3a: d3f6        bcc.n	0x11a2a
@   0x08011a3c: 4647        mov	r7, r8
@   0x08011a3e: 8b7f        ldrh	r7, [r7, #26]
@   0x08011a40: 1af8        subs	r0, r7, r3
@   0x08011a42: 0040        lsls	r0, r0, #1
@   0x08011a44: 1812        adds	r2, r2, r0
@   0x08011a46: 0428        lsls	r0, r5, #16
@   0x08011a48: 0c00        lsrs	r0, r0, #16
@   0x08011a4a: 42a0        cmp	r0, r4
@   0x08011a4c: d3e9        bcc.n	0x11a22
@   0x08011a4e: 4910        ldr	r1, [pc, #64]	@ (0x11a90)
@   0x08011a50: 8e49        ldrh	r1, [r1, #50]	@ 0x32
@   0x08011a52: 0608        lsls	r0, r1, #24
@   0x08011a54: 0e00        lsrs	r0, r0, #24
@   0x08011a56: 4a0e        ldr	r2, [pc, #56]	@ (0x11a90)
@   0x08011a58: 8e12        ldrh	r2, [r2, #48]	@ 0x30
@   0x08011a5a: 0611        lsls	r1, r2, #24
@   0x08011a5c: 0e09        lsrs	r1, r1, #24
@   0x08011a5e: 4653        mov	r3, sl
@   0x08011a60: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x08011a62: 8edb        ldrh	r3, [r3, #54]	@ 0x36
@   0x08011a64: 2402        movs	r4, #2
@   0x08011a66: 9400        str	r4, [sp, #0]
@   0x08011a68: 9d03        ldr	r5, [sp, #12]
@   0x08011a6a: 4666        mov	r6, ip
@   0x08011a6c: 1bac        subs	r4, r5, r6
@   0x08011a6e: 00a4        lsls	r4, r4, #2
@   0x08011a70: 444c        add	r4, r9
@   0x08011a72: 6924        ldr	r4, [r4, #16]
@   0x08011a74: 9401        str	r4, [sp, #4]
@   0x08011a76: 4c0a        ldr	r4, [pc, #40]	@ (0x11aa0)
@   0x08011a78: 9402        str	r4, [sp, #8]
@   0x08011a7a: f7fe        fbef 	bl	0x1025c
@   0x08011a7e: b004        add	sp, #16
@   0x08011a80: bc38        pop	{r3, r4, r5}
@   0x08011a82: 4698        mov	r8, r3
@   0x08011a84: 46a1        mov	r9, r4
@   0x08011a86: 46aa        mov	sl, r5
@   0x08011a88: bcf0        pop	{r4, r5, r6, r7}
@   0x08011a8a: bc01        pop	{r0}
@   0x08011a8c: 4700        bx	r0
@   0x08011a8e: 0000        movs	r0, r0
@   0x08011a90: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08011a92: 0300        lsls	r0, r0, #12
@   0x08011a94: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08011a96: 0300        lsls	r0, r0, #12
@   0x08011a98: 0000        movs	r0, r0
@   0x08011a9a: 0202        lsls	r2, r0, #8
@   0x08011a9c: 60a0        str	r0, [r4, #8]
@   0x08011a9e: 0300        lsls	r0, r0, #12
@   0x08011aa0: f000        0600 	and.w	r6, r0, #0

        thumb_func_start sub_08011984
sub_08011984: @ 0x08011984
        .incbin "frog_us_baserom.gba", 0x11984, 0x120
        thumb_func_end sub_08011984
