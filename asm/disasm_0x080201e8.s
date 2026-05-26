@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080201e8, 0x08020270)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80201e8 --end 0x8020270 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080201e8: b500        push	{lr}
@   0x080201ea: 4905        ldr	r1, [pc, #20]	@ (0x20200)
@   0x080201ec: 4805        ldr	r0, [pc, #20]	@ (0x20204)
@   0x080201ee: 7880        ldrb	r0, [r0, #2]
@   0x080201f0: 0080        lsls	r0, r0, #2
@   0x080201f2: 1840        adds	r0, r0, r1
@   0x080201f4: 6800        ldr	r0, [r0, #0]
@   0x080201f6: f013        fd6f 	bl	0x33cd8
@   0x080201fa: bc01        pop	{r0}
@   0x080201fc: 4700        bx	r0
@   0x080201fe: 0000        movs	r0, r0
@   0x08020200: 8ae0        ldrh	r0, [r4, #22]
@   0x08020202: 0830        lsrs	r0, r6, #32
@   0x08020204: 3480        adds	r4, #128	@ 0x80
@   0x08020206: 0300        lsls	r0, r0, #12
@   0x08020208: 4908        ldr	r1, [pc, #32]	@ (0x2022c)
@   0x0802020a: 2300        movs	r3, #0
@   0x0802020c: 2004        movs	r0, #4
@   0x0802020e: 7248        strb	r0, [r1, #9]
@   0x08020210: 4a07        ldr	r2, [pc, #28]	@ (0x20230)
@   0x08020212: 2008        movs	r0, #8
@   0x08020214: 7010        strb	r0, [r2, #0]
@   0x08020216: 2002        movs	r0, #2
@   0x08020218: 7510        strb	r0, [r2, #20]
@   0x0802021a: 4806        ldr	r0, [pc, #24]	@ (0x20234)
@   0x0802021c: 2100        movs	r1, #0
@   0x0802021e: 8003        strh	r3, [r0, #0]
@   0x08020220: 7091        strb	r1, [r2, #2]
@   0x08020222: 7151        strb	r1, [r2, #5]
@   0x08020224: 4804        ldr	r0, [pc, #16]	@ (0x20238)
@   0x08020226: 7001        strb	r1, [r0, #0]
@   0x08020228: 4770        bx	lr
@   0x0802022a: 0000        movs	r0, r0
@   0x0802022c: 5330        strh	r0, [r6, r4]
@   0x0802022e: 0300        lsls	r0, r0, #12
@   0x08020230: 3480        adds	r4, #128	@ 0x80
@   0x08020232: 0300        lsls	r0, r0, #12
@   0x08020234: 5398        strh	r0, [r3, r6]
@   0x08020236: 0300        lsls	r0, r0, #12
@   0x08020238: 34a0        adds	r4, #160	@ 0xa0
@   0x0802023a: 0300        lsls	r0, r0, #12
@   0x0802023c: 4908        ldr	r1, [pc, #32]	@ (0x20260)
@   0x0802023e: 2300        movs	r3, #0
@   0x08020240: 2004        movs	r0, #4
@   0x08020242: 7248        strb	r0, [r1, #9]
@   0x08020244: 4a07        ldr	r2, [pc, #28]	@ (0x20264)
@   0x08020246: 2008        movs	r0, #8
@   0x08020248: 7010        strb	r0, [r2, #0]
@   0x0802024a: 2001        movs	r0, #1
@   0x0802024c: 7510        strb	r0, [r2, #20]
@   0x0802024e: 4806        ldr	r0, [pc, #24]	@ (0x20268)
@   0x08020250: 2100        movs	r1, #0
@   0x08020252: 8003        strh	r3, [r0, #0]
@   0x08020254: 7091        strb	r1, [r2, #2]
@   0x08020256: 7151        strb	r1, [r2, #5]
@   0x08020258: 4804        ldr	r0, [pc, #16]	@ (0x2026c)
@   0x0802025a: 7041        strb	r1, [r0, #1]
@   0x0802025c: 4770        bx	lr
@   0x0802025e: 0000        movs	r0, r0
@   0x08020260: 5330        strh	r0, [r6, r4]
@   0x08020262: 0300        lsls	r0, r0, #12
@   0x08020264: 3480        adds	r4, #128	@ 0x80
@   0x08020266: 0300        lsls	r0, r0, #12
@   0x08020268: 5398        strh	r0, [r3, r6]
@   0x0802026a: 0300        lsls	r0, r0, #12
@   0x0802026c: 34a0        adds	r4, #160	@ 0xa0
@   0x0802026e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080201E8
sub_080201E8: @ 0x080201e8
        .incbin "frog_us_baserom.gba", 0x201e8, 0x88
        thumb_func_end sub_080201E8
