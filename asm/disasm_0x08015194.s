@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015194, 0x080152b0)  (284 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015194 --end 0x80152b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015194: b510        push	{r4, lr}
@   0x08015196: 4b1a        ldr	r3, [pc, #104]	@ (0x15200)
@   0x08015198: 2100        movs	r1, #0
@   0x0801519a: 7219        strb	r1, [r3, #8]
@   0x0801519c: 4c19        ldr	r4, [pc, #100]	@ (0x15204)
@   0x0801519e: 7221        strb	r1, [r4, #8]
@   0x080151a0: 4a19        ldr	r2, [pc, #100]	@ (0x15208)
@   0x080151a2: 7211        strb	r1, [r2, #8]
@   0x080151a4: 4819        ldr	r0, [pc, #100]	@ (0x1520c)
@   0x080151a6: 7201        strb	r1, [r0, #8]
@   0x080151a8: 7019        strb	r1, [r3, #0]
@   0x080151aa: 7021        strb	r1, [r4, #0]
@   0x080151ac: 7011        strb	r1, [r2, #0]
@   0x080151ae: 7001        strb	r1, [r0, #0]
@   0x080151b0: 4817        ldr	r0, [pc, #92]	@ (0x15210)
@   0x080151b2: 7281        strb	r1, [r0, #10]
@   0x080151b4: 2200        movs	r2, #0
@   0x080151b6: 86d9        strh	r1, [r3, #54]	@ 0x36
@   0x080151b8: 4816        ldr	r0, [pc, #88]	@ (0x15214)
@   0x080151ba: 7002        strb	r2, [r0, #0]
@   0x080151bc: 7282        strb	r2, [r0, #10]
@   0x080151be: 7082        strb	r2, [r0, #2]
@   0x080151c0: 7102        strb	r2, [r0, #4]
@   0x080151c2: 8699        strh	r1, [r3, #52]	@ 0x34
@   0x080151c4: 20c0        movs	r0, #192	@ 0xc0
@   0x080151c6: 86e0        strh	r0, [r4, #54]	@ 0x36
@   0x080151c8: 72da        strb	r2, [r3, #11]
@   0x080151ca: 2004        movs	r0, #4
@   0x080151cc: 72e0        strb	r0, [r4, #11]
@   0x080151ce: 725a        strb	r2, [r3, #9]
@   0x080151d0: 2002        movs	r0, #2
@   0x080151d2: 7260        strb	r0, [r4, #9]
@   0x080151d4: 4a10        ldr	r2, [pc, #64]	@ (0x15218)
@   0x080151d6: 8811        ldrh	r1, [r2, #0]
@   0x080151d8: 4b10        ldr	r3, [pc, #64]	@ (0x1521c)
@   0x080151da: 1c18        adds	r0, r3, #0
@   0x080151dc: 4008        ands	r0, r1
@   0x080151de: 8010        strh	r0, [r2, #0]
@   0x080151e0: 8810        ldrh	r0, [r2, #0]
@   0x080151e2: 2101        movs	r1, #1
@   0x080151e4: 4308        orrs	r0, r1
@   0x080151e6: 8010        strh	r0, [r2, #0]
@   0x080151e8: 3202        adds	r2, #2
@   0x080151ea: 8810        ldrh	r0, [r2, #0]
@   0x080151ec: 4003        ands	r3, r0
@   0x080151ee: 8013        strh	r3, [r2, #0]
@   0x080151f0: 8810        ldrh	r0, [r2, #0]
@   0x080151f2: 2102        movs	r1, #2
@   0x080151f4: 4308        orrs	r0, r1
@   0x080151f6: 8010        strh	r0, [r2, #0]
@   0x080151f8: bc10        pop	{r4}
@   0x080151fa: bc01        pop	{r0}
@   0x080151fc: 4700        bx	r0
@   0x080151fe: 0000        movs	r0, r0
@   0x08015200: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08015202: 0300        lsls	r0, r0, #12
@   0x08015204: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08015206: 0300        lsls	r0, r0, #12
@   0x08015208: 6500        str	r0, [r0, #80]	@ 0x50
@   0x0801520a: 0300        lsls	r0, r0, #12
@   0x0801520c: 6580        str	r0, [r0, #88]	@ 0x58
@   0x0801520e: 0300        lsls	r0, r0, #12
@   0x08015210: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08015212: 0300        lsls	r0, r0, #12
@   0x08015214: 3610        adds	r6, #16
@   0x08015216: 0300        lsls	r0, r0, #12
@   0x08015218: 000a        movs	r2, r1
@   0x0801521a: 0400        lsls	r0, r0, #16
@   0x0801521c: fffc        0000 	vrev64.<illegal width 64>	d16, d0
@   0x08015220: b500        push	{lr}
@   0x08015222: 2003        movs	r0, #3
@   0x08015224: f7f9        fb1a 	bl	0xe85c
@   0x08015228: f7f9        fc78 	bl	0xeb1c
@   0x0801522c: 2003        movs	r0, #3
@   0x0801522e: f7fa        f80d 	bl	0xf24c
@   0x08015232: f7ff        ffaf 	bl	0x15194
@   0x08015236: 4809        ldr	r0, [pc, #36]	@ (0x1525c)
@   0x08015238: 3033        adds	r0, #51	@ 0x33
@   0x0801523a: 7800        ldrb	r0, [r0, #0]
@   0x0801523c: 2801        cmp	r0, #1
@   0x0801523e: d117        bne.n	0x15270
@   0x08015240: 4a07        ldr	r2, [pc, #28]	@ (0x15260)
@   0x08015242: 4808        ldr	r0, [pc, #32]	@ (0x15264)
@   0x08015244: 6010        str	r0, [r2, #0]
@   0x08015246: 2180        movs	r1, #128	@ 0x80
@   0x08015248: 0489        lsls	r1, r1, #18
@   0x0801524a: 6051        str	r1, [r2, #4]
@   0x0801524c: 4806        ldr	r0, [pc, #24]	@ (0x15268)
@   0x0801524e: 6090        str	r0, [r2, #8]
@   0x08015250: 6890        ldr	r0, [r2, #8]
@   0x08015252: 4a06        ldr	r2, [pc, #24]	@ (0x1526c)
@   0x08015254: 2000        movs	r0, #0
@   0x08015256: f7fa        ff45 	bl	0x100e4
@   0x0801525a: e016        b.n	0x1528a
@   0x0801525c: 6110        str	r0, [r2, #16]
@   0x0801525e: 0300        lsls	r0, r0, #12
@   0x08015260: 00d4        lsls	r4, r2, #3
@   0x08015262: 0400        lsls	r0, r0, #16
@   0x08015264: c312        stmia	r3!, {r1, r4}
@   0x08015266: 0819        lsrs	r1, r3, #32
@   0x08015268: 8000        strh	r0, [r0, #0]
@   0x0801526a: 8000        strh	r0, [r0, #0]
@   0x0801526c: e000        b.n	0x15270
@   0x0801526e: 0600        lsls	r0, r0, #24
@   0x08015270: 4a0b        ldr	r2, [pc, #44]	@ (0x152a0)
@   0x08015272: 480c        ldr	r0, [pc, #48]	@ (0x152a4)
@   0x08015274: 6010        str	r0, [r2, #0]
@   0x08015276: 2180        movs	r1, #128	@ 0x80
@   0x08015278: 0489        lsls	r1, r1, #18
@   0x0801527a: 6051        str	r1, [r2, #4]
@   0x0801527c: 480a        ldr	r0, [pc, #40]	@ (0x152a8)
@   0x0801527e: 6090        str	r0, [r2, #8]
@   0x08015280: 6890        ldr	r0, [r2, #8]
@   0x08015282: 4a0a        ldr	r2, [pc, #40]	@ (0x152ac)
@   0x08015284: 2000        movs	r0, #0
@   0x08015286: f7fa        ff2d 	bl	0x100e4
@   0x0801528a: 2003        movs	r0, #3
@   0x0801528c: f7f9        fca6 	bl	0xebdc
@   0x08015290: f001        fbd6 	bl	0x16a40
@   0x08015294: 2002        movs	r0, #2
@   0x08015296: f7f9        fdcd 	bl	0xee34
@   0x0801529a: bc01        pop	{r0}
@   0x0801529c: 4700        bx	r0
@   0x0801529e: 0000        movs	r0, r0
@   0x080152a0: 00d4        lsls	r4, r2, #3
@   0x080152a2: 0400        lsls	r0, r0, #16
@   0x080152a4: cfde        ldmia	r7, {r1, r2, r3, r4, r6, r7}
@   0x080152a6: 0819        lsrs	r1, r3, #32
@   0x080152a8: 8000        strh	r0, [r0, #0]
@   0x080152aa: 8000        strh	r0, [r0, #0]
@   0x080152ac: e000        b.n	0x152b0
@   0x080152ae: 0600        lsls	r0, r0, #24

        thumb_func_start sub_08015194
sub_08015194: @ 0x08015194
        .incbin "frog_us_baserom.gba", 0x15194, 0x11c
        thumb_func_end sub_08015194
