@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803299c, 0x08032aa0)  (260 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803299c --end 0x8032aa0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803299c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0803299e: 1c07        adds	r7, r0, #0
@   0x080329a0: 468c        mov	ip, r1
@   0x080329a2: 4e12        ldr	r6, [pc, #72]	@ (0x329ec)
@   0x080329a4: 6835        ldr	r5, [r6, #0]
@   0x080329a6: 00b8        lsls	r0, r7, #2
@   0x080329a8: 1c29        adds	r1, r5, #0
@   0x080329aa: 3110        adds	r1, #16
@   0x080329ac: 1809        adds	r1, r1, r0
@   0x080329ae: 6808        ldr	r0, [r1, #0]
@   0x080329b0: 4c0f        ldr	r4, [pc, #60]	@ (0x329f0)
@   0x080329b2: 4020        ands	r0, r4
@   0x080329b4: 6008        str	r0, [r1, #0]
@   0x080329b6: 00fc        lsls	r4, r7, #3
@   0x080329b8: 192d        adds	r5, r5, r4
@   0x080329ba: 3593        adds	r5, #147	@ 0x93
@   0x080329bc: 702a        strb	r2, [r5, #0]
@   0x080329be: 6836        ldr	r6, [r6, #0]
@   0x080329c0: 0079        lsls	r1, r7, #1
@   0x080329c2: 1c30        adds	r0, r6, #0
@   0x080329c4: 30ac        adds	r0, #172	@ 0xac
@   0x080329c6: 1840        adds	r0, r0, r1
@   0x080329c8: 8003        strh	r3, [r0, #0]
@   0x080329ca: 2f03        cmp	r7, #3
@   0x080329cc: d00b        beq.n	0x329e6
@   0x080329ce: 19e0        adds	r0, r4, r7
@   0x080329d0: 0080        lsls	r0, r0, #2
@   0x080329d2: 1830        adds	r0, r6, r0
@   0x080329d4: 8c02        ldrh	r2, [r0, #32]
@   0x080329d6: 8f83        ldrh	r3, [r0, #60]	@ 0x3c
@   0x080329d8: 18d1        adds	r1, r2, r3
@   0x080329da: 1c02        adds	r2, r0, #0
@   0x080329dc: 3242        adds	r2, #66	@ 0x42
@   0x080329de: 8011        strh	r1, [r2, #0]
@   0x080329e0: 4662        mov	r2, ip
@   0x080329e2: 0211        lsls	r1, r2, #8
@   0x080329e4: 8401        strh	r1, [r0, #32]
@   0x080329e6: bcf0        pop	{r4, r5, r6, r7}
@   0x080329e8: bc01        pop	{r0}
@   0x080329ea: 4700        bx	r0
@   0x080329ec: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080329ee: 0300        lsls	r0, r0, #12
@   0x080329f0: 7eef        ldrb	r7, [r5, #27]
@   0x080329f2: ffff        4806 	vtbl.8	d20, {d15}, d6
@   0x080329f6: 6800        ldr	r0, [r0, #0]
@   0x080329f8: 218c        movs	r1, #140	@ 0x8c
@   0x080329fa: 0049        lsls	r1, r1, #1
@   0x080329fc: 1840        adds	r0, r0, r1
@   0x080329fe: 6800        ldr	r0, [r0, #0]
@   0x08032a00: 3139        adds	r1, #57	@ 0x39
@   0x08032a02: 1842        adds	r2, r0, r1
@   0x08032a04: 7811        ldrb	r1, [r2, #0]
@   0x08032a06: 2901        cmp	r1, #1
@   0x08032a08: d004        beq.n	0x32a14
@   0x08032a0a: 2000        movs	r0, #0
@   0x08032a0c: e006        b.n	0x32a1c
@   0x08032a0e: 0000        movs	r0, r0
@   0x08032a10: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032a12: 0300        lsls	r0, r0, #12
@   0x08032a14: 2002        movs	r0, #2
@   0x08032a16: 4308        orrs	r0, r1
@   0x08032a18: 7010        strb	r0, [r2, #0]
@   0x08032a1a: 2001        movs	r0, #1
@   0x08032a1c: 4770        bx	lr
@   0x08032a1e: 0000        movs	r0, r0
@   0x08032a20: 4807        ldr	r0, [pc, #28]	@ (0x32a40)
@   0x08032a22: 6800        ldr	r0, [r0, #0]
@   0x08032a24: 218c        movs	r1, #140	@ 0x8c
@   0x08032a26: 0049        lsls	r1, r1, #1
@   0x08032a28: 1840        adds	r0, r0, r1
@   0x08032a2a: 6800        ldr	r0, [r0, #0]
@   0x08032a2c: 3139        adds	r1, #57	@ 0x39
@   0x08032a2e: 1842        adds	r2, r0, r1
@   0x08032a30: 7811        ldrb	r1, [r2, #0]
@   0x08032a32: 2007        movs	r0, #7
@   0x08032a34: 4008        ands	r0, r1
@   0x08032a36: 2805        cmp	r0, #5
@   0x08032a38: d004        beq.n	0x32a44
@   0x08032a3a: 2000        movs	r0, #0
@   0x08032a3c: e008        b.n	0x32a50
@   0x08032a3e: 0000        movs	r0, r0
@   0x08032a40: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032a42: 0300        lsls	r0, r0, #12
@   0x08032a44: 20fb        movs	r0, #251	@ 0xfb
@   0x08032a46: 4008        ands	r0, r1
@   0x08032a48: 2102        movs	r1, #2
@   0x08032a4a: 4308        orrs	r0, r1
@   0x08032a4c: 7010        strb	r0, [r2, #0]
@   0x08032a4e: 2001        movs	r0, #1
@   0x08032a50: 4770        bx	lr
@   0x08032a52: 0000        movs	r0, r0
@   0x08032a54: b500        push	{lr}
@   0x08032a56: 0400        lsls	r0, r0, #16
@   0x08032a58: 0c03        lsrs	r3, r0, #16
@   0x08032a5a: 480b        ldr	r0, [pc, #44]	@ (0x32a88)
@   0x08032a5c: 6800        ldr	r0, [r0, #0]
@   0x08032a5e: 218c        movs	r1, #140	@ 0x8c
@   0x08032a60: 0049        lsls	r1, r1, #1
@   0x08032a62: 1840        adds	r0, r0, r1
@   0x08032a64: 6802        ldr	r2, [r0, #0]
@   0x08032a66: 2b00        cmp	r3, #0
@   0x08032a68: d012        beq.n	0x32a90
@   0x08032a6a: 4808        ldr	r0, [pc, #32]	@ (0x32a8c)
@   0x08032a6c: 1811        adds	r1, r2, r0
@   0x08032a6e: 2001        movs	r0, #1
@   0x08032a70: 7809        ldrb	r1, [r1, #0]
@   0x08032a72: 4008        ands	r0, r1
@   0x08032a74: 2800        cmp	r0, #0
@   0x08032a76: d00b        beq.n	0x32a90
@   0x08032a78: 21a4        movs	r1, #164	@ 0xa4
@   0x08032a7a: 0049        lsls	r1, r1, #1
@   0x08032a7c: 1850        adds	r0, r2, r1
@   0x08032a7e: 8003        strh	r3, [r0, #0]
@   0x08032a80: f7ff        f99c 	bl	0x31dbc
@   0x08032a84: 2001        movs	r0, #1
@   0x08032a86: e004        b.n	0x32a92
@   0x08032a88: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032a8a: 0300        lsls	r0, r0, #12
@   0x08032a8c: 0151        lsls	r1, r2, #5
@   0x08032a8e: 0000        movs	r0, r0
@   0x08032a90: 2000        movs	r0, #0
@   0x08032a92: bc02        pop	{r1}
@   0x08032a94: 4708        bx	r1
@   0x08032a96: 0000        movs	r0, r0
@   0x08032a98: 20a8        movs	r0, #168	@ 0xa8
@   0x08032a9a: 0040        lsls	r0, r0, #1
@   0x08032a9c: 4770        bx	lr

        thumb_func_start sub_0803299C
sub_0803299C: @ 0x0803299c
        .incbin "frog_us_baserom.gba", 0x3299c, 0x104
        thumb_func_end sub_0803299C
