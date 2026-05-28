@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000678, 0x0800072c)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000678 --end 0x800072c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000678: b510        push	{r4, lr}
@   0x0800067a: 4820        ldr	r0, [pc, #128]	@ (0x6fc)
@   0x0800067c: 8800        ldrh	r0, [r0, #0]
@   0x0800067e: 43c0        mvns	r0, r0
@   0x08000680: 0400        lsls	r0, r0, #16
@   0x08000682: 0c03        lsrs	r3, r0, #16
@   0x08000684: 4a1e        ldr	r2, [pc, #120]	@ (0x700)
@   0x08000686: 491f        ldr	r1, [pc, #124]	@ (0x704)
@   0x08000688: 1c18        adds	r0, r3, #0
@   0x0800068a: 880c        ldrh	r4, [r1, #0]
@   0x0800068c: 43a0        bics	r0, r4
@   0x0800068e: 8010        strh	r0, [r2, #0]
@   0x08000690: 800b        strh	r3, [r1, #0]
@   0x08000692: 2108        movs	r1, #8
@   0x08000694: 4008        ands	r0, r1
@   0x08000696: 0400        lsls	r0, r0, #16
@   0x08000698: 0c00        lsrs	r0, r0, #16
@   0x0800069a: 4240        negs	r0, r0
@   0x0800069c: 17c2        asrs	r2, r0, #31
@   0x0800069e: 2140        movs	r1, #64	@ 0x40
@   0x080006a0: 400a        ands	r2, r1
@   0x080006a2: 1c18        adds	r0, r3, #0
@   0x080006a4: 4008        ands	r0, r1
@   0x080006a6: 2800        cmp	r0, #0
@   0x080006a8: d003        beq.n	0x6b2
@   0x080006aa: 2180        movs	r1, #128	@ 0x80
@   0x080006ac: 00c9        lsls	r1, r1, #3
@   0x080006ae: 1c08        adds	r0, r1, #0
@   0x080006b0: 4302        orrs	r2, r0
@   0x080006b2: 2080        movs	r0, #128	@ 0x80
@   0x080006b4: 4018        ands	r0, r3
@   0x080006b6: 2800        cmp	r0, #0
@   0x080006b8: d005        beq.n	0x6c6
@   0x080006ba: 2480        movs	r4, #128	@ 0x80
@   0x080006bc: 0124        lsls	r4, r4, #4
@   0x080006be: 1c20        adds	r0, r4, #0
@   0x080006c0: 4302        orrs	r2, r0
@   0x080006c2: 0410        lsls	r0, r2, #16
@   0x080006c4: 0c02        lsrs	r2, r0, #16
@   0x080006c6: 2020        movs	r0, #32
@   0x080006c8: 4018        ands	r0, r3
@   0x080006ca: 2800        cmp	r0, #0
@   0x080006cc: d005        beq.n	0x6da
@   0x080006ce: 2180        movs	r1, #128	@ 0x80
@   0x080006d0: 0149        lsls	r1, r1, #5
@   0x080006d2: 1c08        adds	r0, r1, #0
@   0x080006d4: 4302        orrs	r2, r0
@   0x080006d6: 0410        lsls	r0, r2, #16
@   0x080006d8: 0c02        lsrs	r2, r0, #16
@   0x080006da: 2010        movs	r0, #16
@   0x080006dc: 4018        ands	r0, r3
@   0x080006de: 2800        cmp	r0, #0
@   0x080006e0: d005        beq.n	0x6ee
@   0x080006e2: 2480        movs	r4, #128	@ 0x80
@   0x080006e4: 01a4        lsls	r4, r4, #6
@   0x080006e6: 1c20        adds	r0, r4, #0
@   0x080006e8: 4302        orrs	r2, r0
@   0x080006ea: 0410        lsls	r0, r2, #16
@   0x080006ec: 0c02        lsrs	r2, r0, #16
@   0x080006ee: 4906        ldr	r1, [pc, #24]	@ (0x708)
@   0x080006f0: 7a48        ldrb	r0, [r1, #9]
@   0x080006f2: 2818        cmp	r0, #24
@   0x080006f4: d00a        beq.n	0x70c
@   0x080006f6: 1c10        adds	r0, r2, #0
@   0x080006f8: e012        b.n	0x720
@   0x080006fa: 0000        movs	r0, r0
@   0x080006fc: 0130        lsls	r0, r6, #4
@   0x080006fe: 0400        lsls	r0, r0, #16
@   0x08000700: 5358        strh	r0, [r3, r5]
@   0x08000702: 0300        lsls	r0, r0, #12
@   0x08000704: 3710        adds	r7, #16
@   0x08000706: 0300        lsls	r0, r0, #12
@   0x08000708: 5330        strh	r0, [r6, r4]
@   0x0800070a: 0300        lsls	r0, r0, #12
@   0x0800070c: 2a00        cmp	r2, #0
@   0x0800070e: d003        beq.n	0x718
@   0x08000710: 2004        movs	r0, #4
@   0x08000712: 7248        strb	r0, [r1, #9]
@   0x08000714: 2000        movs	r0, #0
@   0x08000716: e003        b.n	0x720
@   0x08000718: f017        f94e 	bl	0x179b8
@   0x0800071c: 0400        lsls	r0, r0, #16
@   0x0800071e: 0c00        lsrs	r0, r0, #16
@   0x08000720: bc10        pop	{r4}
@   0x08000722: bc02        pop	{r1}
@   0x08000724: 4708        bx	r1
@   0x08000726: 0000        movs	r0, r0
@   0x08000728: 4770        bx	lr

        thumb_func_start sub_08000678
sub_08000678: @ 0x08000678
        .incbin "frog_us_baserom.gba", 0x678, 0xb4
        thumb_func_end sub_08000678
