@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022360, 0x08022434)  (212 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022360 --end 0x8022434 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022360: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022362: 4c27        ldr	r4, [pc, #156]	@ (0x22400)
@   0x08022364: 2710        movs	r7, #16
@   0x08022366: 260f        movs	r6, #15
@   0x08022368: 4926        ldr	r1, [pc, #152]	@ (0x22404)
@   0x0802236a: 1860        adds	r0, r4, r1
@   0x0802236c: 250c        movs	r5, #12
@   0x0802236e: 2303        movs	r3, #3
@   0x08022370: 2202        movs	r2, #2
@   0x08022372: 2101        movs	r1, #1
@   0x08022374: 8687        strh	r7, [r0, #52]	@ 0x34
@   0x08022376: 7006        strb	r6, [r0, #0]
@   0x08022378: 7585        strb	r5, [r0, #22]
@   0x0802237a: 75c3        strb	r3, [r0, #23]
@   0x0802237c: 7182        strb	r2, [r0, #6]
@   0x0802237e: 3038        adds	r0, #56	@ 0x38
@   0x08022380: 3901        subs	r1, #1
@   0x08022382: 2900        cmp	r1, #0
@   0x08022384: daf6        bge.n	0x22374
@   0x08022386: 4a20        ldr	r2, [pc, #128]	@ (0x22408)
@   0x08022388: 18a1        adds	r1, r4, r2
@   0x0802238a: 2300        movs	r3, #0
@   0x0802238c: 481f        ldr	r0, [pc, #124]	@ (0x2240c)
@   0x0802238e: 8008        strh	r0, [r1, #0]
@   0x08022390: 481f        ldr	r0, [pc, #124]	@ (0x22410)
@   0x08022392: 1821        adds	r1, r4, r0
@   0x08022394: 481f        ldr	r0, [pc, #124]	@ (0x22414)
@   0x08022396: 8008        strh	r0, [r1, #0]
@   0x08022398: 3a12        subs	r2, #18
@   0x0802239a: 18a1        adds	r1, r4, r2
@   0x0802239c: 3842        subs	r0, #66	@ 0x42
@   0x0802239e: 8008        strh	r0, [r1, #0]
@   0x080223a0: 481d        ldr	r0, [pc, #116]	@ (0x22418)
@   0x080223a2: 1821        adds	r1, r4, r0
@   0x080223a4: 20bd        movs	r0, #189	@ 0xbd
@   0x080223a6: 0080        lsls	r0, r0, #2
@   0x080223a8: 8008        strh	r0, [r1, #0]
@   0x080223aa: 3238        adds	r2, #56	@ 0x38
@   0x080223ac: 18a1        adds	r1, r4, r2
@   0x080223ae: 481b        ldr	r0, [pc, #108]	@ (0x2241c)
@   0x080223b0: 8008        strh	r0, [r1, #0]
@   0x080223b2: 481b        ldr	r0, [pc, #108]	@ (0x22420)
@   0x080223b4: 1821        adds	r1, r4, r0
@   0x080223b6: 481b        ldr	r0, [pc, #108]	@ (0x22424)
@   0x080223b8: 8008        strh	r0, [r1, #0]
@   0x080223ba: 491b        ldr	r1, [pc, #108]	@ (0x22428)
@   0x080223bc: 1860        adds	r0, r4, r1
@   0x080223be: 7003        strb	r3, [r0, #0]
@   0x080223c0: 481a        ldr	r0, [pc, #104]	@ (0x2242c)
@   0x080223c2: 1822        adds	r2, r4, r0
@   0x080223c4: 2102        movs	r1, #2
@   0x080223c6: 8810        ldrh	r0, [r2, #0]
@   0x080223c8: 4308        orrs	r0, r1
@   0x080223ca: 8010        strh	r0, [r2, #0]
@   0x080223cc: 4a18        ldr	r2, [pc, #96]	@ (0x22430)
@   0x080223ce: 18a0        adds	r0, r4, r2
@   0x080223d0: 7003        strb	r3, [r0, #0]
@   0x080223d2: 321a        adds	r2, #26
@   0x080223d4: 18a0        adds	r0, r4, r2
@   0x080223d6: 8802        ldrh	r2, [r0, #0]
@   0x080223d8: 4311        orrs	r1, r2
@   0x080223da: 8001        strh	r1, [r0, #0]
@   0x080223dc: 4909        ldr	r1, [pc, #36]	@ (0x22404)
@   0x080223de: 1860        adds	r0, r4, r1
@   0x080223e0: 2104        movs	r1, #4
@   0x080223e2: 2200        movs	r2, #0
@   0x080223e4: 2301        movs	r3, #1
@   0x080223e6: f7e8        f8cb 	bl	0xa580
@   0x080223ea: 22f5        movs	r2, #245	@ 0xf5
@   0x080223ec: 0112        lsls	r2, r2, #4
@   0x080223ee: 18a0        adds	r0, r4, r2
@   0x080223f0: 2104        movs	r1, #4
@   0x080223f2: 2200        movs	r2, #0
@   0x080223f4: 2301        movs	r3, #1
@   0x080223f6: f7e8        f8c3 	bl	0xa580
@   0x080223fa: bcf0        pop	{r4, r5, r6, r7}
@   0x080223fc: bc01        pop	{r0}
@   0x080223fe: 4700        bx	r0
@   0x08022400: 3720        adds	r7, #32
@   0x08022402: 0300        lsls	r0, r0, #12
@   0x08022404: 0f18        lsrs	r0, r3, #28
@   0x08022406: 0000        movs	r0, r0
@   0x08022408: 0f2c        lsrs	r4, r5, #28
@   0x0802240a: 0000        movs	r0, r0
@   0x0802240c: 0175        lsls	r5, r6, #5
@   0x0802240e: 0000        movs	r0, r0
@   0x08022410: 0f64        lsrs	r4, r4, #29
@   0x08022412: 0000        movs	r0, r0
@   0x08022414: 0185        lsls	r5, r0, #6
@   0x08022416: 0000        movs	r0, r0
@   0x08022418: 0f1c        lsrs	r4, r3, #28
@   0x0802241a: 0000        movs	r0, r0
@   0x0802241c: 015b        lsls	r3, r3, #5
@   0x0802241e: 0000        movs	r0, r0
@   0x08022420: 0f54        lsrs	r4, r2, #29
@   0x08022422: 0000        movs	r0, r0
@   0x08022424: 033a        lsls	r2, r7, #12
@   0x08022426: 0000        movs	r0, r0
@   0x08022428: 0f32        lsrs	r2, r6, #28
@   0x0802242a: 0000        movs	r0, r0
@   0x0802242c: 0f4c        lsrs	r4, r1, #29
@   0x0802242e: 0000        movs	r0, r0
@   0x08022430: 0f6a        lsrs	r2, r5, #29

        thumb_func_start sub_08022360
sub_08022360: @ 0x08022360
        .incbin "frog_us_baserom.gba", 0x22360, 0xd4
        thumb_func_end sub_08022360
