@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802090c, 0x08020b30)  (548 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802090c --end 0x8020b30 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802090c: b510        push	{r4, lr}
@   0x0802090e: 4a08        ldr	r2, [pc, #32]	@ (0x20930)
@   0x08020910: 8a11        ldrh	r1, [r2, #16]
@   0x08020912: 2080        movs	r0, #128	@ 0x80
@   0x08020914: 0100        lsls	r0, r0, #4
@   0x08020916: 4008        ands	r0, r1
@   0x08020918: 2800        cmp	r0, #0
@   0x0802091a: d00d        beq.n	0x20938
@   0x0802091c: 4c05        ldr	r4, [pc, #20]	@ (0x20934)
@   0x0802091e: 2010        movs	r0, #16
@   0x08020920: 7821        ldrb	r1, [r4, #0]
@   0x08020922: 4008        ands	r0, r1
@   0x08020924: 2800        cmp	r0, #0
@   0x08020926: d100        bne.n	0x2092a
@   0x08020928: e0fd        b.n	0x20b26
@   0x0802092a: 205a        movs	r0, #90	@ 0x5a
@   0x0802092c: e0dd        b.n	0x20aea
@   0x0802092e: 0000        movs	r0, r0
@   0x08020930: 35e0        adds	r5, #224	@ 0xe0
@   0x08020932: 0300        lsls	r0, r0, #12
@   0x08020934: 3570        adds	r5, #112	@ 0x70
@   0x08020936: 0300        lsls	r0, r0, #12
@   0x08020938: 2080        movs	r0, #128	@ 0x80
@   0x0802093a: 0180        lsls	r0, r0, #6
@   0x0802093c: 4008        ands	r0, r1
@   0x0802093e: 2800        cmp	r0, #0
@   0x08020940: d00a        beq.n	0x20958
@   0x08020942: 4c04        ldr	r4, [pc, #16]	@ (0x20954)
@   0x08020944: 2010        movs	r0, #16
@   0x08020946: 7821        ldrb	r1, [r4, #0]
@   0x08020948: 4008        ands	r0, r1
@   0x0802094a: 2800        cmp	r0, #0
@   0x0802094c: d100        bne.n	0x20950
@   0x0802094e: e0ea        b.n	0x20b26
@   0x08020950: 205c        movs	r0, #92	@ 0x5c
@   0x08020952: e0ca        b.n	0x20aea
@   0x08020954: 3570        adds	r5, #112	@ 0x70
@   0x08020956: 0300        lsls	r0, r0, #12
@   0x08020958: 7b50        ldrb	r0, [r2, #13]
@   0x0802095a: 3807        subs	r0, #7
@   0x0802095c: 2855        cmp	r0, #85	@ 0x55
@   0x0802095e: d900        bls.n	0x20962
@   0x08020960: e0e1        b.n	0x20b26
@   0x08020962: 0080        lsls	r0, r0, #2
@   0x08020964: 4901        ldr	r1, [pc, #4]	@ (0x2096c)
@   0x08020966: 1840        adds	r0, r0, r1
@   0x08020968: 6800        ldr	r0, [r0, #0]
@   0x0802096a: 4687        mov	pc, r0
@   0x0802096c: 0970        lsrs	r0, r6, #5
@   0x0802096e: 0802        lsrs	r2, r0, #32
@   0x08020970: 0adc        lsrs	r4, r3, #11
@   0x08020972: 0802        lsrs	r2, r0, #32
@   0x08020974: 0adc        lsrs	r4, r3, #11
@   0x08020976: 0802        lsrs	r2, r0, #32
@   0x08020978: 0b04        lsrs	r4, r0, #12
@   0x0802097a: 0802        lsrs	r2, r0, #32
@   0x0802097c: 0b04        lsrs	r4, r0, #12
@   0x0802097e: 0802        lsrs	r2, r0, #32
@   0x08020980: 0b26        lsrs	r6, r4, #12
@   0x08020982: 0802        lsrs	r2, r0, #32
@   0x08020984: 0b26        lsrs	r6, r4, #12
@   0x08020986: 0802        lsrs	r2, r0, #32
@   0x08020988: 0adc        lsrs	r4, r3, #11
@   0x0802098a: 0802        lsrs	r2, r0, #32
@   0x0802098c: 0b26        lsrs	r6, r4, #12
@   0x0802098e: 0802        lsrs	r2, r0, #32
@   0x08020990: 0b04        lsrs	r4, r0, #12
@   0x08020992: 0802        lsrs	r2, r0, #32
@   0x08020994: 0b26        lsrs	r6, r4, #12
@   0x08020996: 0802        lsrs	r2, r0, #32
@   0x08020998: 0adc        lsrs	r4, r3, #11
@   0x0802099a: 0802        lsrs	r2, r0, #32
@   0x0802099c: 0ac8        lsrs	r0, r1, #11
@   0x0802099e: 0802        lsrs	r2, r0, #32
@   0x080209a0: 0b26        lsrs	r6, r4, #12
@   0x080209a2: 0802        lsrs	r2, r0, #32
@   0x080209a4: 0b26        lsrs	r6, r4, #12
@   0x080209a6: 0802        lsrs	r2, r0, #32
@   0x080209a8: 0b26        lsrs	r6, r4, #12
@   0x080209aa: 0802        lsrs	r2, r0, #32
@   0x080209ac: 0b26        lsrs	r6, r4, #12
@   0x080209ae: 0802        lsrs	r2, r0, #32
@   0x080209b0: 0adc        lsrs	r4, r3, #11
@   0x080209b2: 0802        lsrs	r2, r0, #32
@   0x080209b4: 0adc        lsrs	r4, r3, #11
@   0x080209b6: 0802        lsrs	r2, r0, #32
@   0x080209b8: 0adc        lsrs	r4, r3, #11
@   0x080209ba: 0802        lsrs	r2, r0, #32
@   0x080209bc: 0b26        lsrs	r6, r4, #12
@   0x080209be: 0802        lsrs	r2, r0, #32
@   0x080209c0: 0adc        lsrs	r4, r3, #11
@   0x080209c2: 0802        lsrs	r2, r0, #32
@   0x080209c4: 0ac8        lsrs	r0, r1, #11
@   0x080209c6: 0802        lsrs	r2, r0, #32
@   0x080209c8: 0ac8        lsrs	r0, r1, #11
@   0x080209ca: 0802        lsrs	r2, r0, #32
@   0x080209cc: 0b04        lsrs	r4, r0, #12
@   0x080209ce: 0802        lsrs	r2, r0, #32
@   0x080209d0: 0b26        lsrs	r6, r4, #12
@   0x080209d2: 0802        lsrs	r2, r0, #32
@   0x080209d4: 0adc        lsrs	r4, r3, #11
@   0x080209d6: 0802        lsrs	r2, r0, #32
@   0x080209d8: 0adc        lsrs	r4, r3, #11
@   0x080209da: 0802        lsrs	r2, r0, #32
@   0x080209dc: 0adc        lsrs	r4, r3, #11
@   0x080209de: 0802        lsrs	r2, r0, #32
@   0x080209e0: 0b26        lsrs	r6, r4, #12
@   0x080209e2: 0802        lsrs	r2, r0, #32
@   0x080209e4: 0adc        lsrs	r4, r3, #11
@   0x080209e6: 0802        lsrs	r2, r0, #32
@   0x080209e8: 0adc        lsrs	r4, r3, #11
@   0x080209ea: 0802        lsrs	r2, r0, #32
@   0x080209ec: 0adc        lsrs	r4, r3, #11
@   0x080209ee: 0802        lsrs	r2, r0, #32
@   0x080209f0: 0b26        lsrs	r6, r4, #12
@   0x080209f2: 0802        lsrs	r2, r0, #32
@   0x080209f4: 0adc        lsrs	r4, r3, #11
@   0x080209f6: 0802        lsrs	r2, r0, #32
@   0x080209f8: 0b26        lsrs	r6, r4, #12
@   0x080209fa: 0802        lsrs	r2, r0, #32
@   0x080209fc: 0b26        lsrs	r6, r4, #12
@   0x080209fe: 0802        lsrs	r2, r0, #32
@   0x08020a00: 0b26        lsrs	r6, r4, #12
@   0x08020a02: 0802        lsrs	r2, r0, #32
@   0x08020a04: 0b26        lsrs	r6, r4, #12
@   0x08020a06: 0802        lsrs	r2, r0, #32
@   0x08020a08: 0b26        lsrs	r6, r4, #12
@   0x08020a0a: 0802        lsrs	r2, r0, #32
@   0x08020a0c: 0b26        lsrs	r6, r4, #12
@   0x08020a0e: 0802        lsrs	r2, r0, #32
@   0x08020a10: 0adc        lsrs	r4, r3, #11
@   0x08020a12: 0802        lsrs	r2, r0, #32
@   0x08020a14: 0adc        lsrs	r4, r3, #11
@   0x08020a16: 0802        lsrs	r2, r0, #32
@   0x08020a18: 0adc        lsrs	r4, r3, #11
@   0x08020a1a: 0802        lsrs	r2, r0, #32
@   0x08020a1c: 0adc        lsrs	r4, r3, #11
@   0x08020a1e: 0802        lsrs	r2, r0, #32
@   0x08020a20: 0b26        lsrs	r6, r4, #12
@   0x08020a22: 0802        lsrs	r2, r0, #32
@   0x08020a24: 0b26        lsrs	r6, r4, #12
@   0x08020a26: 0802        lsrs	r2, r0, #32
@   0x08020a28: 0b26        lsrs	r6, r4, #12
@   0x08020a2a: 0802        lsrs	r2, r0, #32
@   0x08020a2c: 0ac8        lsrs	r0, r1, #11
@   0x08020a2e: 0802        lsrs	r2, r0, #32
@   0x08020a30: 0ac8        lsrs	r0, r1, #11
@   0x08020a32: 0802        lsrs	r2, r0, #32
@   0x08020a34: 0ac8        lsrs	r0, r1, #11
@   0x08020a36: 0802        lsrs	r2, r0, #32
@   0x08020a38: 0adc        lsrs	r4, r3, #11
@   0x08020a3a: 0802        lsrs	r2, r0, #32
@   0x08020a3c: 0adc        lsrs	r4, r3, #11
@   0x08020a3e: 0802        lsrs	r2, r0, #32
@   0x08020a40: 0adc        lsrs	r4, r3, #11
@   0x08020a42: 0802        lsrs	r2, r0, #32
@   0x08020a44: 0adc        lsrs	r4, r3, #11
@   0x08020a46: 0802        lsrs	r2, r0, #32
@   0x08020a48: 0b26        lsrs	r6, r4, #12
@   0x08020a4a: 0802        lsrs	r2, r0, #32
@   0x08020a4c: 0b26        lsrs	r6, r4, #12
@   0x08020a4e: 0802        lsrs	r2, r0, #32
@   0x08020a50: 0b26        lsrs	r6, r4, #12
@   0x08020a52: 0802        lsrs	r2, r0, #32
@   0x08020a54: 0ac8        lsrs	r0, r1, #11
@   0x08020a56: 0802        lsrs	r2, r0, #32
@   0x08020a58: 0b26        lsrs	r6, r4, #12
@   0x08020a5a: 0802        lsrs	r2, r0, #32
@   0x08020a5c: 0ac8        lsrs	r0, r1, #11
@   0x08020a5e: 0802        lsrs	r2, r0, #32
@   0x08020a60: 0b26        lsrs	r6, r4, #12
@   0x08020a62: 0802        lsrs	r2, r0, #32
@   0x08020a64: 0b26        lsrs	r6, r4, #12
@   0x08020a66: 0802        lsrs	r2, r0, #32
@   0x08020a68: 0b26        lsrs	r6, r4, #12
@   0x08020a6a: 0802        lsrs	r2, r0, #32
@   0x08020a6c: 0b04        lsrs	r4, r0, #12
@   0x08020a6e: 0802        lsrs	r2, r0, #32
@   0x08020a70: 0b04        lsrs	r4, r0, #12
@   0x08020a72: 0802        lsrs	r2, r0, #32
@   0x08020a74: 0adc        lsrs	r4, r3, #11
@   0x08020a76: 0802        lsrs	r2, r0, #32
@   0x08020a78: 0b26        lsrs	r6, r4, #12
@   0x08020a7a: 0802        lsrs	r2, r0, #32
@   0x08020a7c: 0b26        lsrs	r6, r4, #12
@   0x08020a7e: 0802        lsrs	r2, r0, #32
@   0x08020a80: 0adc        lsrs	r4, r3, #11
@   0x08020a82: 0802        lsrs	r2, r0, #32
@   0x08020a84: 0b26        lsrs	r6, r4, #12
@   0x08020a86: 0802        lsrs	r2, r0, #32
@   0x08020a88: 0b26        lsrs	r6, r4, #12
@   0x08020a8a: 0802        lsrs	r2, r0, #32
@   0x08020a8c: 0ac8        lsrs	r0, r1, #11
@   0x08020a8e: 0802        lsrs	r2, r0, #32
@   0x08020a90: 0b26        lsrs	r6, r4, #12
@   0x08020a92: 0802        lsrs	r2, r0, #32
@   0x08020a94: 0adc        lsrs	r4, r3, #11
@   0x08020a96: 0802        lsrs	r2, r0, #32
@   0x08020a98: 0b04        lsrs	r4, r0, #12
@   0x08020a9a: 0802        lsrs	r2, r0, #32
@   0x08020a9c: 0adc        lsrs	r4, r3, #11
@   0x08020a9e: 0802        lsrs	r2, r0, #32
@   0x08020aa0: 0adc        lsrs	r4, r3, #11
@   0x08020aa2: 0802        lsrs	r2, r0, #32
@   0x08020aa4: 0b26        lsrs	r6, r4, #12
@   0x08020aa6: 0802        lsrs	r2, r0, #32
@   0x08020aa8: 0adc        lsrs	r4, r3, #11
@   0x08020aaa: 0802        lsrs	r2, r0, #32
@   0x08020aac: 0b26        lsrs	r6, r4, #12
@   0x08020aae: 0802        lsrs	r2, r0, #32
@   0x08020ab0: 0b26        lsrs	r6, r4, #12
@   0x08020ab2: 0802        lsrs	r2, r0, #32
@   0x08020ab4: 0ac8        lsrs	r0, r1, #11
@   0x08020ab6: 0802        lsrs	r2, r0, #32
@   0x08020ab8: 0adc        lsrs	r4, r3, #11
@   0x08020aba: 0802        lsrs	r2, r0, #32
@   0x08020abc: 0b26        lsrs	r6, r4, #12
@   0x08020abe: 0802        lsrs	r2, r0, #32
@   0x08020ac0: 0ac8        lsrs	r0, r1, #11
@   0x08020ac2: 0802        lsrs	r2, r0, #32
@   0x08020ac4: 0adc        lsrs	r4, r3, #11
@   0x08020ac6: 0802        lsrs	r2, r0, #32
@   0x08020ac8: 4c03        ldr	r4, [pc, #12]	@ (0x20ad8)
@   0x08020aca: 2010        movs	r0, #16
@   0x08020acc: 7821        ldrb	r1, [r4, #0]
@   0x08020ace: 4008        ands	r0, r1
@   0x08020ad0: 2800        cmp	r0, #0
@   0x08020ad2: d028        beq.n	0x20b26
@   0x08020ad4: 205b        movs	r0, #91	@ 0x5b
@   0x08020ad6: e008        b.n	0x20aea
@   0x08020ad8: 3570        adds	r5, #112	@ 0x70
@   0x08020ada: 0300        lsls	r0, r0, #12
@   0x08020adc: 4c08        ldr	r4, [pc, #32]	@ (0x20b00)
@   0x08020ade: 2010        movs	r0, #16
@   0x08020ae0: 7821        ldrb	r1, [r4, #0]
@   0x08020ae2: 4008        ands	r0, r1
@   0x08020ae4: 2800        cmp	r0, #0
@   0x08020ae6: d01e        beq.n	0x20b26
@   0x08020ae8: 200c        movs	r0, #12
@   0x08020aea: 21ff        movs	r1, #255	@ 0xff
@   0x08020aec: 22ff        movs	r2, #255	@ 0xff
@   0x08020aee: 23ff        movs	r3, #255	@ 0xff
@   0x08020af0: f00c        ff7c 	bl	0x2d9ec
@   0x08020af4: 217f        movs	r1, #127	@ 0x7f
@   0x08020af6: 78a4        ldrb	r4, [r4, #2]
@   0x08020af8: 4021        ands	r1, r4
@   0x08020afa: f00d        f88f 	bl	0x2dc1c
@   0x08020afe: e012        b.n	0x20b26
@   0x08020b00: 3570        adds	r5, #112	@ 0x70
@   0x08020b02: 0300        lsls	r0, r0, #12
@   0x08020b04: 4c09        ldr	r4, [pc, #36]	@ (0x20b2c)
@   0x08020b06: 2010        movs	r0, #16
@   0x08020b08: 7821        ldrb	r1, [r4, #0]
@   0x08020b0a: 4008        ands	r0, r1
@   0x08020b0c: 2800        cmp	r0, #0
@   0x08020b0e: d00a        beq.n	0x20b26
@   0x08020b10: 205d        movs	r0, #93	@ 0x5d
@   0x08020b12: 21ff        movs	r1, #255	@ 0xff
@   0x08020b14: 22ff        movs	r2, #255	@ 0xff
@   0x08020b16: 23ff        movs	r3, #255	@ 0xff
@   0x08020b18: f00c        ff68 	bl	0x2d9ec
@   0x08020b1c: 217f        movs	r1, #127	@ 0x7f
@   0x08020b1e: 78a4        ldrb	r4, [r4, #2]
@   0x08020b20: 4021        ands	r1, r4
@   0x08020b22: f00d        f87b 	bl	0x2dc1c
@   0x08020b26: bc10        pop	{r4}
@   0x08020b28: bc01        pop	{r0}
@   0x08020b2a: 4700        bx	r0
@   0x08020b2c: 3570        adds	r5, #112	@ 0x70
@   0x08020b2e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802090C
sub_0802090C: @ 0x0802090c
        .incbin "frog_us_baserom.gba", 0x2090c, 0x224
        thumb_func_end sub_0802090C
