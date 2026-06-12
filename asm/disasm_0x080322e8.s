@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080322e8, 0x080323cc)  (228 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80322e8 --end 0x80323cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080322e8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080322ea: 4647        mov	r7, r8
@   0x080322ec: b480        push	{r7}
@   0x080322ee: 1c06        adds	r6, r0, #0
@   0x080322f0: 2003        movs	r0, #3
@   0x080322f2: 4030        ands	r0, r6
@   0x080322f4: 2800        cmp	r0, #0
@   0x080322f6: d163        bne.n	0x323c0
@   0x080322f8: 482f        ldr	r0, [pc, #188]	@ (0x323b8)
@   0x080322fa: 4680        mov	r8, r0
@   0x080322fc: 6800        ldr	r0, [r0, #0]
@   0x080322fe: 218c        movs	r1, #140	@ 0x8c
@   0x08032300: 0049        lsls	r1, r1, #1
@   0x08032302: 1840        adds	r0, r0, r1
@   0x08032304: 6805        ldr	r5, [r0, #0]
@   0x08032306: 4a2d        ldr	r2, [pc, #180]	@ (0x323bc)
@   0x08032308: 18af        adds	r7, r5, r2
@   0x0803230a: 2002        movs	r0, #2
@   0x0803230c: 783b        ldrb	r3, [r7, #0]
@   0x0803230e: 4018        ands	r0, r3
@   0x08032310: 2800        cmp	r0, #0
@   0x08032312: d155        bne.n	0x323c0
@   0x08032314: 1c28        adds	r0, r5, #0
@   0x08032316: 1c31        adds	r1, r6, #0
@   0x08032318: 2288        movs	r2, #136	@ 0x88
@   0x0803231a: f7fc        f83b 	bl	0x2e394
@   0x0803231e: 1c28        adds	r0, r5, #0
@   0x08032320: 3088        adds	r0, #136	@ 0x88
@   0x08032322: 1c31        adds	r1, r6, #0
@   0x08032324: 3188        adds	r1, #136	@ 0x88
@   0x08032326: 2288        movs	r2, #136	@ 0x88
@   0x08032328: f7fc        f834 	bl	0x2e394
@   0x0803232c: 218c        movs	r1, #140	@ 0x8c
@   0x0803232e: 0049        lsls	r1, r1, #1
@   0x08032330: 1868        adds	r0, r5, r1
@   0x08032332: 248a        movs	r4, #138	@ 0x8a
@   0x08032334: 0064        lsls	r4, r4, #1
@   0x08032336: 1931        adds	r1, r6, r4
@   0x08032338: 2210        movs	r2, #16
@   0x0803233a: f7fc        f82b 	bl	0x2e394
@   0x0803233e: 2294        movs	r2, #148	@ 0x94
@   0x08032340: 0052        lsls	r2, r2, #1
@   0x08032342: 18a8        adds	r0, r5, r2
@   0x08032344: 2392        movs	r3, #146	@ 0x92
@   0x08032346: 005b        lsls	r3, r3, #1
@   0x08032348: 18f1        adds	r1, r6, r3
@   0x0803234a: 2210        movs	r2, #16
@   0x0803234c: f7fc        f822 	bl	0x2e394
@   0x08032350: 219c        movs	r1, #156	@ 0x9c
@   0x08032352: 0049        lsls	r1, r1, #1
@   0x08032354: 1868        adds	r0, r5, r1
@   0x08032356: 229a        movs	r2, #154	@ 0x9a
@   0x08032358: 0052        lsls	r2, r2, #1
@   0x0803235a: 18b1        adds	r1, r6, r2
@   0x0803235c: 2210        movs	r2, #16
@   0x0803235e: f7fc        f819 	bl	0x2e394
@   0x08032362: 192c        adds	r4, r5, r4
@   0x08032364: 2388        movs	r3, #136	@ 0x88
@   0x08032366: 005b        lsls	r3, r3, #1
@   0x08032368: 18f0        adds	r0, r6, r3
@   0x0803236a: 6800        ldr	r0, [r0, #0]
@   0x0803236c: 6020        str	r0, [r4, #0]
@   0x0803236e: 21a2        movs	r1, #162	@ 0xa2
@   0x08032370: 0049        lsls	r1, r1, #1
@   0x08032372: 1870        adds	r0, r6, r1
@   0x08032374: 8802        ldrh	r2, [r0, #0]
@   0x08032376: 3104        adds	r1, #4
@   0x08032378: 1868        adds	r0, r5, r1
@   0x0803237a: 8002        strh	r2, [r0, #0]
@   0x0803237c: 22a3        movs	r2, #163	@ 0xa3
@   0x0803237e: 0052        lsls	r2, r2, #1
@   0x08032380: 18b0        adds	r0, r6, r2
@   0x08032382: 8803        ldrh	r3, [r0, #0]
@   0x08032384: 3204        adds	r2, #4
@   0x08032386: 18a8        adds	r0, r5, r2
@   0x08032388: 8003        strh	r3, [r0, #0]
@   0x0803238a: 1871        adds	r1, r6, r1
@   0x0803238c: 880b        ldrh	r3, [r1, #0]
@   0x0803238e: 21a6        movs	r1, #166	@ 0xa6
@   0x08032390: 0049        lsls	r1, r1, #1
@   0x08032392: 1868        adds	r0, r5, r1
@   0x08032394: 8003        strh	r3, [r0, #0]
@   0x08032396: 18b2        adds	r2, r6, r2
@   0x08032398: 8810        ldrh	r0, [r2, #0]
@   0x0803239a: 23a7        movs	r3, #167	@ 0xa7
@   0x0803239c: 005b        lsls	r3, r3, #1
@   0x0803239e: 18ea        adds	r2, r5, r3
@   0x080323a0: 8010        strh	r0, [r2, #0]
@   0x080323a2: 4640        mov	r0, r8
@   0x080323a4: 6802        ldr	r2, [r0, #0]
@   0x080323a6: 3b01        subs	r3, #1
@   0x080323a8: 18f0        adds	r0, r6, r3
@   0x080323aa: 7800        ldrb	r0, [r0, #0]
@   0x080323ac: 7050        strb	r0, [r2, #1]
@   0x080323ae: 1871        adds	r1, r6, r1
@   0x080323b0: 7808        ldrb	r0, [r1, #0]
@   0x080323b2: 7038        strb	r0, [r7, #0]
@   0x080323b4: 2001        movs	r0, #1
@   0x080323b6: e004        b.n	0x323c2
@   0x080323b8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080323ba: 0300        lsls	r0, r0, #12
@   0x080323bc: 0151        lsls	r1, r2, #5
@   0x080323be: 0000        movs	r0, r0
@   0x080323c0: 2000        movs	r0, #0
@   0x080323c2: bc08        pop	{r3}
@   0x080323c4: 4698        mov	r8, r3
@   0x080323c6: bcf0        pop	{r4, r5, r6, r7}
@   0x080323c8: bc02        pop	{r1}
@   0x080323ca: 4708        bx	r1

        thumb_func_start sub_080322E8
sub_080322E8: @ 0x080322e8
        .incbin "baserom.gba", 0x322e8, 0xe4
        thumb_func_end sub_080322E8
