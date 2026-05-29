@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080097fc, 0x08009884)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80097fc --end 0x8009884 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080097fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080097fe: 4647        mov	r7, r8
@   0x08009800: b480        push	{r7}
@   0x08009802: 1c02        adds	r2, r0, #0
@   0x08009804: 1c0c        adds	r4, r1, #0
@   0x08009806: 2a00        cmp	r2, #0
@   0x08009808: d035        beq.n	0x9876
@   0x0800980a: 2c00        cmp	r4, #0
@   0x0800980c: d033        beq.n	0x9876
@   0x0800980e: 2002        movs	r0, #2
@   0x08009810: 5e11        ldrsh	r1, [r2, r0]
@   0x08009812: 2324        movs	r3, #36	@ 0x24
@   0x08009814: 5ed0        ldrsh	r0, [r2, r3]
@   0x08009816: 1809        adds	r1, r1, r0
@   0x08009818: 1c10        adds	r0, r2, #0
@   0x0800981a: 3028        adds	r0, #40	@ 0x28
@   0x0800981c: 7800        ldrb	r0, [r0, #0]
@   0x0800981e: 0840        lsrs	r0, r0, #1
@   0x08009820: 1a0b        subs	r3, r1, r0
@   0x08009822: 1809        adds	r1, r1, r0
@   0x08009824: 468c        mov	ip, r1
@   0x08009826: 2504        movs	r5, #4
@   0x08009828: 5f51        ldrsh	r1, [r2, r5]
@   0x0800982a: 2726        movs	r7, #38	@ 0x26
@   0x0800982c: 5fd0        ldrsh	r0, [r2, r7]
@   0x0800982e: 180e        adds	r6, r1, r0
@   0x08009830: 1c10        adds	r0, r2, #0
@   0x08009832: 3029        adds	r0, #41	@ 0x29
@   0x08009834: 7800        ldrb	r0, [r0, #0]
@   0x08009836: 1a30        subs	r0, r6, r0
@   0x08009838: 4680        mov	r8, r0
@   0x0800983a: 2002        movs	r0, #2
@   0x0800983c: 5e21        ldrsh	r1, [r4, r0]
@   0x0800983e: 2224        movs	r2, #36	@ 0x24
@   0x08009840: 5ea0        ldrsh	r0, [r4, r2]
@   0x08009842: 1809        adds	r1, r1, r0
@   0x08009844: 1c20        adds	r0, r4, #0
@   0x08009846: 3028        adds	r0, #40	@ 0x28
@   0x08009848: 7800        ldrb	r0, [r0, #0]
@   0x0800984a: 0840        lsrs	r0, r0, #1
@   0x0800984c: 1a0d        subs	r5, r1, r0
@   0x0800984e: 1809        adds	r1, r1, r0
@   0x08009850: 2704        movs	r7, #4
@   0x08009852: 5fe2        ldrsh	r2, [r4, r7]
@   0x08009854: 2726        movs	r7, #38	@ 0x26
@   0x08009856: 5fe0        ldrsh	r0, [r4, r7]
@   0x08009858: 1812        adds	r2, r2, r0
@   0x0800985a: 1c20        adds	r0, r4, #0
@   0x0800985c: 3029        adds	r0, #41	@ 0x29
@   0x0800985e: 7800        ldrb	r0, [r0, #0]
@   0x08009860: 1a10        subs	r0, r2, r0
@   0x08009862: 428b        cmp	r3, r1
@   0x08009864: dc07        bgt.n	0x9876
@   0x08009866: 45ac        cmp	ip, r5
@   0x08009868: db05        blt.n	0x9876
@   0x0800986a: 4590        cmp	r8, r2
@   0x0800986c: dc03        bgt.n	0x9876
@   0x0800986e: 4286        cmp	r6, r0
@   0x08009870: db01        blt.n	0x9876
@   0x08009872: 2001        movs	r0, #1
@   0x08009874: e000        b.n	0x9878
@   0x08009876: 2000        movs	r0, #0
@   0x08009878: bc08        pop	{r3}
@   0x0800987a: 4698        mov	r8, r3
@   0x0800987c: bcf0        pop	{r4, r5, r6, r7}
@   0x0800987e: bc02        pop	{r1}
@   0x08009880: 4708        bx	r1

        thumb_func_start sub_080097FC
sub_080097FC: @ 0x080097fc
        .incbin "frog_us_baserom.gba", 0x97fc, 0x88
        thumb_func_end sub_080097FC
