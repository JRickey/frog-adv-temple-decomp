@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08007228, 0x080072e0)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8007228 --end 0x80072e0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08007228: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800722a: 4657        mov	r7, sl
@   0x0800722c: 464e        mov	r6, r9
@   0x0800722e: 4645        mov	r5, r8
@   0x08007230: b4e0        push	{r5, r6, r7}
@   0x08007232: b085        sub	sp, #20
@   0x08007234: 0612        lsls	r2, r2, #24
@   0x08007236: 0e12        lsrs	r2, r2, #24
@   0x08007238: 4691        mov	r9, r2
@   0x0800723a: 2600        movs	r6, #0
@   0x0800723c: 4a27        ldr	r2, [pc, #156]	@ (0x72dc)
@   0x0800723e: 0600        lsls	r0, r0, #24
@   0x08007240: 4682        mov	sl, r0
@   0x08007242: 1540        asrs	r0, r0, #21
@   0x08007244: 1880        adds	r0, r0, r2
@   0x08007246: 7800        ldrb	r0, [r0, #0]
@   0x08007248: 0600        lsls	r0, r0, #24
@   0x0800724a: 1600        asrs	r0, r0, #24
@   0x0800724c: 4286        cmp	r6, r0
@   0x0800724e: da3d        bge.n	0x72cc
@   0x08007250: 4690        mov	r8, r2
@   0x08007252: 466d        mov	r5, sp
@   0x08007254: 2000        movs	r0, #0
@   0x08007256: 4684        mov	ip, r0
@   0x08007258: 1c0c        adds	r4, r1, #0
@   0x0800725a: 4651        mov	r1, sl
@   0x0800725c: 1549        asrs	r1, r1, #21
@   0x0800725e: 9104        str	r1, [sp, #16]
@   0x08007260: 4640        mov	r0, r8
@   0x08007262: 3004        adds	r0, #4
@   0x08007264: 1808        adds	r0, r1, r0
@   0x08007266: 6802        ldr	r2, [r0, #0]
@   0x08007268: 0130        lsls	r0, r6, #4
@   0x0800726a: 4669        mov	r1, sp
@   0x0800726c: 1880        adds	r0, r0, r2
@   0x0800726e: c88c        ldmia	r0!, {r2, r3, r7}
@   0x08007270: c18c        stmia	r1!, {r2, r3, r7}
@   0x08007272: 6800        ldr	r0, [r0, #0]
@   0x08007274: 6008        str	r0, [r1, #0]
@   0x08007276: 8828        ldrh	r0, [r5, #0]
@   0x08007278: 8020        strh	r0, [r4, #0]
@   0x0800727a: 8868        ldrh	r0, [r5, #2]
@   0x0800727c: 8060        strh	r0, [r4, #2]
@   0x0800727e: 2104        movs	r1, #4
@   0x08007280: 5669        ldrsb	r1, [r5, r1]
@   0x08007282: 0048        lsls	r0, r1, #1
@   0x08007284: 1840        adds	r0, r0, r1
@   0x08007286: 00c0        lsls	r0, r0, #3
@   0x08007288: 80a0        strh	r0, [r4, #4]
@   0x0800728a: 2105        movs	r1, #5
@   0x0800728c: 5669        ldrsb	r1, [r5, r1]
@   0x0800728e: 0048        lsls	r0, r1, #1
@   0x08007290: 1840        adds	r0, r0, r1
@   0x08007292: 00c0        lsls	r0, r0, #3
@   0x08007294: 80e0        strh	r0, [r4, #6]
@   0x08007296: 7a28        ldrb	r0, [r5, #8]
@   0x08007298: 74a0        strb	r0, [r4, #18]
@   0x0800729a: 7a68        ldrb	r0, [r5, #9]
@   0x0800729c: 7620        strb	r0, [r4, #24]
@   0x0800729e: 4660        mov	r0, ip
@   0x080072a0: 76a0        strb	r0, [r4, #26]
@   0x080072a2: 7929        ldrb	r1, [r5, #4]
@   0x080072a4: 796a        ldrb	r2, [r5, #5]
@   0x080072a6: 1c08        adds	r0, r1, #0
@   0x080072a8: 4350        muls	r0, r2
@   0x080072aa: 7720        strb	r0, [r4, #28]
@   0x080072ac: 9803        ldr	r0, [sp, #12]
@   0x080072ae: 6220        str	r0, [r4, #32]
@   0x080072b0: 9b04        ldr	r3, [sp, #16]
@   0x080072b2: 4443        add	r3, r8
@   0x080072b4: 7858        ldrb	r0, [r3, #1]
@   0x080072b6: 7220        strb	r0, [r4, #8]
@   0x080072b8: 4667        mov	r7, ip
@   0x080072ba: 7667        strb	r7, [r4, #25]
@   0x080072bc: 4648        mov	r0, r9
@   0x080072be: 76e0        strb	r0, [r4, #27]
@   0x080072c0: 3424        adds	r4, #36	@ 0x24
@   0x080072c2: 3601        adds	r6, #1
@   0x080072c4: 2000        movs	r0, #0
@   0x080072c6: 5618        ldrsb	r0, [r3, r0]
@   0x080072c8: 4286        cmp	r6, r0
@   0x080072ca: dbc6        blt.n	0x725a
@   0x080072cc: b005        add	sp, #20
@   0x080072ce: bc38        pop	{r3, r4, r5}
@   0x080072d0: 4698        mov	r8, r3
@   0x080072d2: 46a1        mov	r9, r4
@   0x080072d4: 46aa        mov	sl, r5
@   0x080072d6: bcf0        pop	{r4, r5, r6, r7}
@   0x080072d8: bc01        pop	{r0}
@   0x080072da: 4700        bx	r0
@   0x080072dc: 0ab0        lsrs	r0, r6, #10
@   0x080072de: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_08007228
sub_08007228: @ 0x08007228
        .incbin "frog_us_baserom.gba", 0x7228, 0xb8
        thumb_func_end sub_08007228
