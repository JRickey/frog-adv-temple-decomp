@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080087b4, 0x0800885c)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80087b4 --end 0x800885c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080087b4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080087b6: 480d        ldr	r0, [pc, #52]	@ (0x87ec)
@   0x080087b8: 7f03        ldrb	r3, [r0, #28]
@   0x080087ba: 7ec4        ldrb	r4, [r0, #27]
@   0x080087bc: 490c        ldr	r1, [pc, #48]	@ (0x87f0)
@   0x080087be: 7e8a        ldrb	r2, [r1, #26]
@   0x080087c0: 1c05        adds	r5, r0, #0
@   0x080087c2: 1c0e        adds	r6, r1, #0
@   0x080087c4: 2a00        cmp	r2, #0
@   0x080087c6: d015        beq.n	0x87f4
@   0x080087c8: 7eb0        ldrb	r0, [r6, #26]
@   0x080087ca: 00c1        lsls	r1, r0, #3
@   0x080087cc: 1a09        subs	r1, r1, r0
@   0x080087ce: 00c9        lsls	r1, r1, #3
@   0x080087d0: 1949        adds	r1, r1, r5
@   0x080087d2: 2204        movs	r2, #4
@   0x080087d4: 5e88        ldrsh	r0, [r1, r2]
@   0x080087d6: 2726        movs	r7, #38	@ 0x26
@   0x080087d8: 5fca        ldrsh	r2, [r1, r7]
@   0x080087da: 1880        adds	r0, r0, r2
@   0x080087dc: 3129        adds	r1, #41	@ 0x29
@   0x080087de: 7809        ldrb	r1, [r1, #0]
@   0x080087e0: 0849        lsrs	r1, r1, #1
@   0x080087e2: 1a40        subs	r0, r0, r1
@   0x080087e4: 2204        movs	r2, #4
@   0x080087e6: 5ea9        ldrsh	r1, [r5, r2]
@   0x080087e8: e00c        b.n	0x8804
@   0x080087ea: 0000        movs	r0, r0
@   0x080087ec: 3720        adds	r7, #32
@   0x080087ee: 0300        lsls	r0, r0, #12
@   0x080087f0: 35e0        adds	r5, #224	@ 0xe0
@   0x080087f2: 0300        lsls	r0, r0, #12
@   0x080087f4: 201e        movs	r0, #30
@   0x080087f6: 5e31        ldrsh	r1, [r6, r0]
@   0x080087f8: 0048        lsls	r0, r1, #1
@   0x080087fa: 1840        adds	r0, r0, r1
@   0x080087fc: 00c0        lsls	r0, r0, #3
@   0x080087fe: 2204        movs	r2, #4
@   0x08008800: 5ea9        ldrsh	r1, [r5, r2]
@   0x08008802: 390b        subs	r1, #11
@   0x08008804: 1a40        subs	r0, r0, r1
@   0x08008806: 1b1c        subs	r4, r3, r4
@   0x08008808: 1c21        adds	r1, r4, #0
@   0x0800880a: f02b        fa83 	bl	0x33d14
@   0x0800880e: 88af        ldrh	r7, [r5, #4]
@   0x08008810: 1838        adds	r0, r7, r0
@   0x08008812: 80a8        strh	r0, [r5, #4]
@   0x08008814: 1c32        adds	r2, r6, #0
@   0x08008816: 7e90        ldrb	r0, [r2, #26]
@   0x08008818: 2800        cmp	r0, #0
@   0x0800881a: d00c        beq.n	0x8836
@   0x0800881c: 7e90        ldrb	r0, [r2, #26]
@   0x0800881e: 00c1        lsls	r1, r0, #3
@   0x08008820: 1a09        subs	r1, r1, r0
@   0x08008822: 00c9        lsls	r1, r1, #3
@   0x08008824: 1949        adds	r1, r1, r5
@   0x08008826: 2202        movs	r2, #2
@   0x08008828: 5e88        ldrsh	r0, [r1, r2]
@   0x0800882a: 2724        movs	r7, #36	@ 0x24
@   0x0800882c: 5fc9        ldrsh	r1, [r1, r7]
@   0x0800882e: 1840        adds	r0, r0, r1
@   0x08008830: 2202        movs	r2, #2
@   0x08008832: 5ea9        ldrsh	r1, [r5, r2]
@   0x08008834: e007        b.n	0x8846
@   0x08008836: 201c        movs	r0, #28
@   0x08008838: 5e31        ldrsh	r1, [r6, r0]
@   0x0800883a: 0048        lsls	r0, r1, #1
@   0x0800883c: 1840        adds	r0, r0, r1
@   0x0800883e: 00c0        lsls	r0, r0, #3
@   0x08008840: 2202        movs	r2, #2
@   0x08008842: 5ea9        ldrsh	r1, [r5, r2]
@   0x08008844: 390b        subs	r1, #11
@   0x08008846: 1a40        subs	r0, r0, r1
@   0x08008848: 1c21        adds	r1, r4, #0
@   0x0800884a: f02b        fa63 	bl	0x33d14
@   0x0800884e: 886f        ldrh	r7, [r5, #2]
@   0x08008850: 1838        adds	r0, r7, r0
@   0x08008852: 8068        strh	r0, [r5, #2]
@   0x08008854: bcf0        pop	{r4, r5, r6, r7}
@   0x08008856: bc01        pop	{r0}
@   0x08008858: 4700        bx	r0

        thumb_func_start sub_080087B4
sub_080087B4: @ 0x080087b4
        .incbin "frog_us_baserom.gba", 0x87b4, 0xa8
        thumb_func_end sub_080087B4
