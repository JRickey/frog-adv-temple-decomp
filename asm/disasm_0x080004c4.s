@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080004c4, 0x080005d8)  (276 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80004c4 --end 0x80005d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080004c4: b530        push	{r4, r5, lr}
@   0x080004c6: 4831        ldr	r0, [pc, #196]	@ (0x58c)
@   0x080004c8: 8800        ldrh	r0, [r0, #0]
@   0x080004ca: 43c0        mvns	r0, r0
@   0x080004cc: 0400        lsls	r0, r0, #16
@   0x080004ce: 0c00        lsrs	r0, r0, #16
@   0x080004d0: 4a2f        ldr	r2, [pc, #188]	@ (0x590)
@   0x080004d2: 4930        ldr	r1, [pc, #192]	@ (0x594)
@   0x080004d4: 1c03        adds	r3, r0, #0
@   0x080004d6: 880c        ldrh	r4, [r1, #0]
@   0x080004d8: 43a3        bics	r3, r4
@   0x080004da: 8013        strh	r3, [r2, #0]
@   0x080004dc: 8008        strh	r0, [r1, #0]
@   0x080004de: 2008        movs	r0, #8
@   0x080004e0: 4018        ands	r0, r3
@   0x080004e2: 0400        lsls	r0, r0, #16
@   0x080004e4: 0c00        lsrs	r0, r0, #16
@   0x080004e6: 4240        negs	r0, r0
@   0x080004e8: 17c2        asrs	r2, r0, #31
@   0x080004ea: 2140        movs	r1, #64	@ 0x40
@   0x080004ec: 400a        ands	r2, r1
@   0x080004ee: 1c18        adds	r0, r3, #0
@   0x080004f0: 4008        ands	r0, r1
@   0x080004f2: 2800        cmp	r0, #0
@   0x080004f4: d001        beq.n	0x4fa
@   0x080004f6: 2001        movs	r0, #1
@   0x080004f8: 4302        orrs	r2, r0
@   0x080004fa: 2080        movs	r0, #128	@ 0x80
@   0x080004fc: 4018        ands	r0, r3
@   0x080004fe: 2800        cmp	r0, #0
@   0x08000500: d003        beq.n	0x50a
@   0x08000502: 2002        movs	r0, #2
@   0x08000504: 4302        orrs	r2, r0
@   0x08000506: 0410        lsls	r0, r2, #16
@   0x08000508: 0c02        lsrs	r2, r0, #16
@   0x0800050a: 2020        movs	r0, #32
@   0x0800050c: 4018        ands	r0, r3
@   0x0800050e: 2800        cmp	r0, #0
@   0x08000510: d003        beq.n	0x51a
@   0x08000512: 2004        movs	r0, #4
@   0x08000514: 4302        orrs	r2, r0
@   0x08000516: 0410        lsls	r0, r2, #16
@   0x08000518: 0c02        lsrs	r2, r0, #16
@   0x0800051a: 2010        movs	r0, #16
@   0x0800051c: 4018        ands	r0, r3
@   0x0800051e: 2800        cmp	r0, #0
@   0x08000520: d003        beq.n	0x52a
@   0x08000522: 2008        movs	r0, #8
@   0x08000524: 4302        orrs	r2, r0
@   0x08000526: 0410        lsls	r0, r2, #16
@   0x08000528: 0c02        lsrs	r2, r0, #16
@   0x0800052a: 2001        movs	r0, #1
@   0x0800052c: 4018        ands	r0, r3
@   0x0800052e: 2800        cmp	r0, #0
@   0x08000530: d003        beq.n	0x53a
@   0x08000532: 2010        movs	r0, #16
@   0x08000534: 4302        orrs	r2, r0
@   0x08000536: 0410        lsls	r0, r2, #16
@   0x08000538: 0c02        lsrs	r2, r0, #16
@   0x0800053a: 2002        movs	r0, #2
@   0x0800053c: 4018        ands	r0, r3
@   0x0800053e: 2800        cmp	r0, #0
@   0x08000540: d003        beq.n	0x54a
@   0x08000542: 2020        movs	r0, #32
@   0x08000544: 4302        orrs	r2, r0
@   0x08000546: 0410        lsls	r0, r2, #16
@   0x08000548: 0c02        lsrs	r2, r0, #16
@   0x0800054a: 2404        movs	r4, #4
@   0x0800054c: 2004        movs	r0, #4
@   0x0800054e: 4018        ands	r0, r3
@   0x08000550: 2800        cmp	r0, #0
@   0x08000552: d003        beq.n	0x55c
@   0x08000554: 2080        movs	r0, #128	@ 0x80
@   0x08000556: 4302        orrs	r2, r0
@   0x08000558: 0410        lsls	r0, r2, #16
@   0x0800055a: 0c02        lsrs	r2, r0, #16
@   0x0800055c: 2180        movs	r1, #128	@ 0x80
@   0x0800055e: 0089        lsls	r1, r1, #2
@   0x08000560: 1c18        adds	r0, r3, #0
@   0x08000562: 4008        ands	r0, r1
@   0x08000564: 2800        cmp	r0, #0
@   0x08000566: d005        beq.n	0x574
@   0x08000568: 2580        movs	r5, #128	@ 0x80
@   0x0800056a: 006d        lsls	r5, r5, #1
@   0x0800056c: 1c28        adds	r0, r5, #0
@   0x0800056e: 4302        orrs	r2, r0
@   0x08000570: 0410        lsls	r0, r2, #16
@   0x08000572: 0c02        lsrs	r2, r0, #16
@   0x08000574: 2080        movs	r0, #128	@ 0x80
@   0x08000576: 0040        lsls	r0, r0, #1
@   0x08000578: 4003        ands	r3, r0
@   0x0800057a: 2b00        cmp	r3, #0
@   0x0800057c: d000        beq.n	0x580
@   0x0800057e: 430a        orrs	r2, r1
@   0x08000580: 4805        ldr	r0, [pc, #20]	@ (0x598)
@   0x08000582: 7a41        ldrb	r1, [r0, #9]
@   0x08000584: 2918        cmp	r1, #24
@   0x08000586: d009        beq.n	0x59c
@   0x08000588: 1c10        adds	r0, r2, #0
@   0x0800058a: e01f        b.n	0x5cc
@   0x0800058c: 0130        lsls	r0, r6, #4
@   0x0800058e: 0400        lsls	r0, r0, #16
@   0x08000590: 5358        strh	r0, [r3, r5]
@   0x08000592: 0300        lsls	r0, r0, #12
@   0x08000594: 3710        adds	r7, #16
@   0x08000596: 0300        lsls	r0, r0, #12
@   0x08000598: 5330        strh	r0, [r6, r4]
@   0x0800059a: 0300        lsls	r0, r0, #12
@   0x0800059c: 2a00        cmp	r2, #0
@   0x0800059e: d111        bne.n	0x5c4
@   0x080005a0: f000        f9ae 	bl	0x900
@   0x080005a4: 4c06        ldr	r4, [pc, #24]	@ (0x5c0)
@   0x080005a6: 68a1        ldr	r1, [r4, #8]
@   0x080005a8: 1a40        subs	r0, r0, r1
@   0x080005aa: 280a        cmp	r0, #10
@   0x080005ac: d90d        bls.n	0x5ca
@   0x080005ae: f000        f9a7 	bl	0x900
@   0x080005b2: 60a0        str	r0, [r4, #8]
@   0x080005b4: f017        fa00 	bl	0x179b8
@   0x080005b8: 0400        lsls	r0, r0, #16
@   0x080005ba: 0c00        lsrs	r0, r0, #16
@   0x080005bc: e006        b.n	0x5cc
@   0x080005be: 0000        movs	r0, r0
@   0x080005c0: 34c0        adds	r4, #192	@ 0xc0
@   0x080005c2: 0300        lsls	r0, r0, #12
@   0x080005c4: 7244        strb	r4, [r0, #9]
@   0x080005c6: 4803        ldr	r0, [pc, #12]	@ (0x5d4)
@   0x080005c8: 7004        strb	r4, [r0, #0]
@   0x080005ca: 2000        movs	r0, #0
@   0x080005cc: bc30        pop	{r4, r5}
@   0x080005ce: bc02        pop	{r1}
@   0x080005d0: 4708        bx	r1
@   0x080005d2: 0000        movs	r0, r0
@   0x080005d4: 3480        adds	r4, #128	@ 0x80
@   0x080005d6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080004C4
sub_080004C4: @ 0x080004c4
        .incbin "frog_us_baserom.gba", 0x4c4, 0x114
        thumb_func_end sub_080004C4
