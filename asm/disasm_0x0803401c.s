@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803401c, 0x080340d4)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803401c --end 0x80340d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803401c: b570        push	{r4, r5, r6, lr}
@   0x0803401e: 68c2        ldr	r2, [r0, #12]
@   0x08034020: 6846        ldr	r6, [r0, #4]
@   0x08034022: 2500        movs	r5, #0
@   0x08034024: 2100        movs	r1, #0
@   0x08034026: 6803        ldr	r3, [r0, #0]
@   0x08034028: 2b01        cmp	r3, #1
@   0x0803402a: d800        bhi.n	0x3402e
@   0x0803402c: 2101        movs	r1, #1
@   0x0803402e: 2900        cmp	r1, #0
@   0x08034030: d004        beq.n	0x3403c
@   0x08034032: 25ff        movs	r5, #255	@ 0xff
@   0x08034034: 2080        movs	r0, #128	@ 0x80
@   0x08034036: 0340        lsls	r0, r0, #13
@   0x08034038: 4302        orrs	r2, r0
@   0x0803403a: e032        b.n	0x340a2
@   0x0803403c: 2100        movs	r1, #0
@   0x0803403e: 2b04        cmp	r3, #4
@   0x08034040: d100        bne.n	0x34044
@   0x08034042: 2101        movs	r1, #1
@   0x08034044: 2900        cmp	r1, #0
@   0x08034046: d117        bne.n	0x34078
@   0x08034048: 2100        movs	r1, #0
@   0x0803404a: 2b02        cmp	r3, #2
@   0x0803404c: d100        bne.n	0x34050
@   0x0803404e: 2101        movs	r1, #1
@   0x08034050: 2900        cmp	r1, #0
@   0x08034052: d001        beq.n	0x34058
@   0x08034054: 2200        movs	r2, #0
@   0x08034056: e024        b.n	0x340a2
@   0x08034058: 2a00        cmp	r2, #0
@   0x0803405a: d022        beq.n	0x340a2
@   0x0803405c: 6880        ldr	r0, [r0, #8]
@   0x0803405e: 237e        movs	r3, #126	@ 0x7e
@   0x08034060: 425b        negs	r3, r3
@   0x08034062: 4298        cmp	r0, r3
@   0x08034064: da06        bge.n	0x34074
@   0x08034066: 1a18        subs	r0, r3, r0
@   0x08034068: 2819        cmp	r0, #25
@   0x0803406a: dd01        ble.n	0x34070
@   0x0803406c: 2200        movs	r2, #0
@   0x0803406e: e017        b.n	0x340a0
@   0x08034070: 40c2        lsrs	r2, r0
@   0x08034072: e015        b.n	0x340a0
@   0x08034074: 287f        cmp	r0, #127	@ 0x7f
@   0x08034076: dd02        ble.n	0x3407e
@   0x08034078: 25ff        movs	r5, #255	@ 0xff
@   0x0803407a: 2200        movs	r2, #0
@   0x0803407c: e011        b.n	0x340a2
@   0x0803407e: 1c05        adds	r5, r0, #0
@   0x08034080: 357f        adds	r5, #127	@ 0x7f
@   0x08034082: 207f        movs	r0, #127	@ 0x7f
@   0x08034084: 4010        ands	r0, r2
@   0x08034086: 2840        cmp	r0, #64	@ 0x40
@   0x08034088: d105        bne.n	0x34096
@   0x0803408a: 2080        movs	r0, #128	@ 0x80
@   0x0803408c: 4010        ands	r0, r2
@   0x0803408e: 2800        cmp	r0, #0
@   0x08034090: d002        beq.n	0x34098
@   0x08034092: 3240        adds	r2, #64	@ 0x40
@   0x08034094: e000        b.n	0x34098
@   0x08034096: 323f        adds	r2, #63	@ 0x3f
@   0x08034098: 2a00        cmp	r2, #0
@   0x0803409a: da01        bge.n	0x340a0
@   0x0803409c: 0852        lsrs	r2, r2, #1
@   0x0803409e: 3501        adds	r5, #1
@   0x080340a0: 09d2        lsrs	r2, r2, #7
@   0x080340a2: 4808        ldr	r0, [pc, #32]	@ (0x340c4)
@   0x080340a4: 4002        ands	r2, r0
@   0x080340a6: 4808        ldr	r0, [pc, #32]	@ (0x340c8)
@   0x080340a8: 4004        ands	r4, r0
@   0x080340aa: 4314        orrs	r4, r2
@   0x080340ac: 20ff        movs	r0, #255	@ 0xff
@   0x080340ae: 4005        ands	r5, r0
@   0x080340b0: 05e9        lsls	r1, r5, #23
@   0x080340b2: 4806        ldr	r0, [pc, #24]	@ (0x340cc)
@   0x080340b4: 4004        ands	r4, r0
@   0x080340b6: 430c        orrs	r4, r1
@   0x080340b8: 07f1        lsls	r1, r6, #31
@   0x080340ba: 4805        ldr	r0, [pc, #20]	@ (0x340d0)
@   0x080340bc: 4004        ands	r4, r0
@   0x080340be: 430c        orrs	r4, r1
@   0x080340c0: 1c20        adds	r0, r4, #0
@   0x080340c2: bd70        pop	{r4, r5, r6, pc}
@   0x080340c4: ffff        007f 	vshr.u32	q8, <illegal reg q15.5>, #1
@   0x080340c8: 0000        movs	r0, r0
@   0x080340ca: ff80        ffff 			@ <UNDEFINED> instruction: 0xff80ffff
@   0x080340ce: 807f        strh	r7, [r7, #2]
@   0x080340d0: ffff        7fff 			@ <UNDEFINED> instruction: 0xffff7fff

        thumb_func_start sub_0803401C
sub_0803401C: @ 0x0803401c
        .incbin "frog_us_baserom.gba", 0x3401c, 0xb8
        thumb_func_end sub_0803401C
