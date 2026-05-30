@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080181d0, 0x080182cc)  (252 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80181d0 --end 0x80182cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080181d0: b500        push	{lr}
@   0x080181d2: b081        sub	sp, #4
@   0x080181d4: 480e        ldr	r0, [pc, #56]	@ (0x18210)
@   0x080181d6: 9900        ldr	r1, [sp, #0]
@   0x080181d8: 4001        ands	r1, r0
@   0x080181da: 2009        movs	r0, #9
@   0x080181dc: 4301        orrs	r1, r0
@   0x080181de: 4a0d        ldr	r2, [pc, #52]	@ (0x18214)
@   0x080181e0: 4011        ands	r1, r2
@   0x080181e2: 20c0        movs	r0, #192	@ 0xc0
@   0x080181e4: 00c0        lsls	r0, r0, #3
@   0x080181e6: 4301        orrs	r1, r0
@   0x080181e8: 480b        ldr	r0, [pc, #44]	@ (0x18218)
@   0x080181ea: 4001        ands	r1, r0
@   0x080181ec: 20c0        movs	r0, #192	@ 0xc0
@   0x080181ee: 0480        lsls	r0, r0, #18
@   0x080181f0: 4301        orrs	r1, r0
@   0x080181f2: 480a        ldr	r0, [pc, #40]	@ (0x1821c)
@   0x080181f4: 4001        ands	r1, r0
@   0x080181f6: 20e0        movs	r0, #224	@ 0xe0
@   0x080181f8: 0300        lsls	r0, r0, #12
@   0x080181fa: 4301        orrs	r1, r0
@   0x080181fc: 9100        str	r1, [sp, #0]
@   0x080181fe: 4808        ldr	r0, [pc, #32]	@ (0x18220)
@   0x08018200: 7d00        ldrb	r0, [r0, #20]
@   0x08018202: 2801        cmp	r0, #1
@   0x08018204: d015        beq.n	0x18232
@   0x08018206: 2801        cmp	r0, #1
@   0x08018208: dc0c        bgt.n	0x18224
@   0x0801820a: 2800        cmp	r0, #0
@   0x0801820c: d00d        beq.n	0x1822a
@   0x0801820e: e019        b.n	0x18244
@   0x08018210: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08018214: 00ff        lsls	r7, r7, #3
@   0x08018216: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801821a: 00ff        lsls	r7, r7, #3
@   0x0801821c: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x08018220: 3480        adds	r4, #128	@ 0x80
@   0x08018222: 0300        lsls	r0, r0, #12
@   0x08018224: 2802        cmp	r0, #2
@   0x08018226: d008        beq.n	0x1823a
@   0x08018228: e00c        b.n	0x18244
@   0x0801822a: 4011        ands	r1, r2
@   0x0801822c: 20a0        movs	r0, #160	@ 0xa0
@   0x0801822e: 00c0        lsls	r0, r0, #3
@   0x08018230: e006        b.n	0x18240
@   0x08018232: 4011        ands	r1, r2
@   0x08018234: 2090        movs	r0, #144	@ 0x90
@   0x08018236: 0100        lsls	r0, r0, #4
@   0x08018238: e002        b.n	0x18240
@   0x0801823a: 4011        ands	r1, r2
@   0x0801823c: 20d0        movs	r0, #208	@ 0xd0
@   0x0801823e: 0100        lsls	r0, r0, #4
@   0x08018240: 4301        orrs	r1, r0
@   0x08018242: 9100        str	r1, [sp, #0]
@   0x08018244: 490a        ldr	r1, [pc, #40]	@ (0x18270)
@   0x08018246: 4a0b        ldr	r2, [pc, #44]	@ (0x18274)
@   0x08018248: 480b        ldr	r0, [pc, #44]	@ (0x18278)
@   0x0801824a: 6800        ldr	r0, [r0, #0]
@   0x0801824c: 0080        lsls	r0, r0, #2
@   0x0801824e: 1880        adds	r0, r0, r2
@   0x08018250: 6800        ldr	r0, [r0, #0]
@   0x08018252: 6008        str	r0, [r1, #0]
@   0x08018254: 4809        ldr	r0, [pc, #36]	@ (0x1827c)
@   0x08018256: 6048        str	r0, [r1, #4]
@   0x08018258: 4809        ldr	r0, [pc, #36]	@ (0x18280)
@   0x0801825a: 6088        str	r0, [r1, #8]
@   0x0801825c: 6888        ldr	r0, [r1, #8]
@   0x0801825e: 4668        mov	r0, sp
@   0x08018260: 2105        movs	r1, #5
@   0x08018262: 2204        movs	r2, #4
@   0x08018264: 2302        movs	r3, #2
@   0x08018266: f000        f939 	bl	0x184dc
@   0x0801826a: b001        add	sp, #4
@   0x0801826c: bc01        pop	{r0}
@   0x0801826e: 4700        bx	r0
@   0x08018270: 00d4        lsls	r4, r2, #3
@   0x08018272: 0400        lsls	r0, r0, #16
@   0x08018274: 8f70        ldrh	r0, [r6, #58]	@ 0x3a
@   0x08018276: 0830        lsrs	r0, r6, #32
@   0x08018278: 34b0        adds	r4, #176	@ 0xb0
@   0x0801827a: 0300        lsls	r0, r0, #12
@   0x0801827c: f000        0600 	and.w	r6, r0, #0
@   0x08018280: 0400        lsls	r0, r0, #16
@   0x08018282: 8000        strh	r0, [r0, #0]
@   0x08018284: b510        push	{r4, lr}
@   0x08018286: f7e8        fb3b 	bl	0x900
@   0x0801828a: 4c0c        ldr	r4, [pc, #48]	@ (0x182bc)
@   0x0801828c: 60e0        str	r0, [r4, #12]
@   0x0801828e: 20bf        movs	r0, #191	@ 0xbf
@   0x08018290: f7f8        fa2c 	bl	0x106ec
@   0x08018294: 490a        ldr	r1, [pc, #40]	@ (0x182c0)
@   0x08018296: 2200        movs	r2, #0
@   0x08018298: 700a        strb	r2, [r1, #0]
@   0x0801829a: 704a        strb	r2, [r1, #1]
@   0x0801829c: 20a0        movs	r0, #160	@ 0xa0
@   0x0801829e: 70c8        strb	r0, [r1, #3]
@   0x080182a0: 20f0        movs	r0, #240	@ 0xf0
@   0x080182a2: 7088        strb	r0, [r1, #2]
@   0x080182a4: 4807        ldr	r0, [pc, #28]	@ (0x182c4)
@   0x080182a6: 2100        movs	r1, #0
@   0x080182a8: 8002        strh	r2, [r0, #0]
@   0x080182aa: 8042        strh	r2, [r0, #2]
@   0x080182ac: 78e0        ldrb	r0, [r4, #3]
@   0x080182ae: 3001        adds	r0, #1
@   0x080182b0: 70e0        strb	r0, [r4, #3]
@   0x080182b2: 4805        ldr	r0, [pc, #20]	@ (0x182c8)
@   0x080182b4: 7041        strb	r1, [r0, #1]
@   0x080182b6: bc10        pop	{r4}
@   0x080182b8: bc01        pop	{r0}
@   0x080182ba: 4700        bx	r0
@   0x080182bc: 3480        adds	r4, #128	@ 0x80
@   0x080182be: 0300        lsls	r0, r0, #12
@   0x080182c0: 3470        adds	r4, #112	@ 0x70
@   0x080182c2: 0300        lsls	r0, r0, #12
@   0x080182c4: 3550        adds	r5, #80	@ 0x50
@   0x080182c6: 0300        lsls	r0, r0, #12
@   0x080182c8: 34a0        adds	r4, #160	@ 0xa0
@   0x080182ca: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080181D0
sub_080181D0: @ 0x080181d0
        .incbin "frog_us_baserom.gba", 0x181d0, 0xfc
        thumb_func_end sub_080181D0
