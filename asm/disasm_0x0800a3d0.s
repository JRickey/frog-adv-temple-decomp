@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a3d0, 0x0800a4d0)  (256 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a3d0 --end 0x800a4d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a3d0: b510        push	{r4, lr}
@   0x0800a3d2: 0400        lsls	r0, r0, #16
@   0x0800a3d4: 0c03        lsrs	r3, r0, #16
@   0x0800a3d6: 0409        lsls	r1, r1, #16
@   0x0800a3d8: 0c09        lsrs	r1, r1, #16
@   0x0800a3da: 4803        ldr	r0, [pc, #12]	@ (0xa3e8)
@   0x0800a3dc: 7e80        ldrb	r0, [r0, #26]
@   0x0800a3de: 2803        cmp	r0, #3
@   0x0800a3e0: d904        bls.n	0xa3ec
@   0x0800a3e2: 2000        movs	r0, #0
@   0x0800a3e4: e032        b.n	0xa44c
@   0x0800a3e6: 0000        movs	r0, r0
@   0x0800a3e8: 3720        adds	r7, #32
@   0x0800a3ea: 0300        lsls	r0, r0, #12
@   0x0800a3ec: 2b02        cmp	r3, #2
@   0x0800a3ee: d015        beq.n	0xa41c
@   0x0800a3f0: 2b02        cmp	r3, #2
@   0x0800a3f2: dc05        bgt.n	0xa400
@   0x0800a3f4: 2b01        cmp	r3, #1
@   0x0800a3f6: d00b        beq.n	0xa410
@   0x0800a3f8: 4800        ldr	r0, [pc, #0]	@ (0xa3fc)
@   0x0800a3fa: e025        b.n	0xa448
@   0x0800a3fc: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a3fe: 0300        lsls	r0, r0, #12
@   0x0800a400: 2b04        cmp	r3, #4
@   0x0800a402: d011        beq.n	0xa428
@   0x0800a404: 2b08        cmp	r3, #8
@   0x0800a406: d019        beq.n	0xa43c
@   0x0800a408: 4800        ldr	r0, [pc, #0]	@ (0xa40c)
@   0x0800a40a: e01d        b.n	0xa448
@   0x0800a40c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a40e: 0300        lsls	r0, r0, #12
@   0x0800a410: 4801        ldr	r0, [pc, #4]	@ (0xa418)
@   0x0800a412: 040a        lsls	r2, r1, #16
@   0x0800a414: 8944        ldrh	r4, [r0, #10]
@   0x0800a416: e00a        b.n	0xa42e
@   0x0800a418: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a41a: 0300        lsls	r0, r0, #12
@   0x0800a41c: 4801        ldr	r0, [pc, #4]	@ (0xa424)
@   0x0800a41e: 040a        lsls	r2, r1, #16
@   0x0800a420: 8944        ldrh	r4, [r0, #10]
@   0x0800a422: e00e        b.n	0xa442
@   0x0800a424: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a426: 0300        lsls	r0, r0, #12
@   0x0800a428: 4803        ldr	r0, [pc, #12]	@ (0xa438)
@   0x0800a42a: 040a        lsls	r2, r1, #16
@   0x0800a42c: 8904        ldrh	r4, [r0, #8]
@   0x0800a42e: 0421        lsls	r1, r4, #16
@   0x0800a430: 4291        cmp	r1, r2
@   0x0800a432: dc09        bgt.n	0xa448
@   0x0800a434: 20ff        movs	r0, #255	@ 0xff
@   0x0800a436: e009        b.n	0xa44c
@   0x0800a438: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a43a: 0300        lsls	r0, r0, #12
@   0x0800a43c: 4805        ldr	r0, [pc, #20]	@ (0xa454)
@   0x0800a43e: 040a        lsls	r2, r1, #16
@   0x0800a440: 8904        ldrh	r4, [r0, #8]
@   0x0800a442: 0421        lsls	r1, r4, #16
@   0x0800a444: 4291        cmp	r1, r2
@   0x0800a446: daf5        bge.n	0xa434
@   0x0800a448: 8243        strh	r3, [r0, #18]
@   0x0800a44a: 2001        movs	r0, #1
@   0x0800a44c: bc10        pop	{r4}
@   0x0800a44e: bc02        pop	{r1}
@   0x0800a450: 4708        bx	r1
@   0x0800a452: 0000        movs	r0, r0
@   0x0800a454: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a456: 0300        lsls	r0, r0, #12
@   0x0800a458: b530        push	{r4, r5, lr}
@   0x0800a45a: 0400        lsls	r0, r0, #16
@   0x0800a45c: 0409        lsls	r1, r1, #16
@   0x0800a45e: 0c0c        lsrs	r4, r1, #16
@   0x0800a460: 4905        ldr	r1, [pc, #20]	@ (0xa478)
@   0x0800a462: 0c05        lsrs	r5, r0, #16
@   0x0800a464: 890b        ldrh	r3, [r1, #8]
@   0x0800a466: 041a        lsls	r2, r3, #16
@   0x0800a468: 1c0b        adds	r3, r1, #0
@   0x0800a46a: 4282        cmp	r2, r0
@   0x0800a46c: d106        bne.n	0xa47c
@   0x0800a46e: 8958        ldrh	r0, [r3, #10]
@   0x0800a470: 42a0        cmp	r0, r4
@   0x0800a472: d103        bne.n	0xa47c
@   0x0800a474: 2001        movs	r0, #1
@   0x0800a476: e028        b.n	0xa4ca
@   0x0800a478: 35e0        adds	r5, #224	@ 0xe0
@   0x0800a47a: 0300        lsls	r0, r0, #12
@   0x0800a47c: 0428        lsls	r0, r5, #16
@   0x0800a47e: 1401        asrs	r1, r0, #16
@   0x0800a480: 2208        movs	r2, #8
@   0x0800a482: 5e98        ldrsh	r0, [r3, r2]
@   0x0800a484: 4281        cmp	r1, r0
@   0x0800a486: da01        bge.n	0xa48c
@   0x0800a488: 2004        movs	r0, #4
@   0x0800a48a: e00a        b.n	0xa4a2
@   0x0800a48c: 4281        cmp	r1, r0
@   0x0800a48e: dd01        ble.n	0xa494
@   0x0800a490: 2008        movs	r0, #8
@   0x0800a492: e006        b.n	0xa4a2
@   0x0800a494: 0420        lsls	r0, r4, #16
@   0x0800a496: 1401        asrs	r1, r0, #16
@   0x0800a498: 220a        movs	r2, #10
@   0x0800a49a: 5e98        ldrsh	r0, [r3, r2]
@   0x0800a49c: 4281        cmp	r1, r0
@   0x0800a49e: da08        bge.n	0xa4b2
@   0x0800a4a0: 2001        movs	r0, #1
@   0x0800a4a2: f7ff        ff95 	bl	0xa3d0
@   0x0800a4a6: 0600        lsls	r0, r0, #24
@   0x0800a4a8: 0e00        lsrs	r0, r0, #24
@   0x0800a4aa: 2801        cmp	r0, #1
@   0x0800a4ac: d00a        beq.n	0xa4c4
@   0x0800a4ae: 2000        movs	r0, #0
@   0x0800a4b0: e00b        b.n	0xa4ca
@   0x0800a4b2: 4281        cmp	r1, r0
@   0x0800a4b4: dd09        ble.n	0xa4ca
@   0x0800a4b6: 2002        movs	r0, #2
@   0x0800a4b8: f7ff        ff8a 	bl	0xa3d0
@   0x0800a4bc: 0600        lsls	r0, r0, #24
@   0x0800a4be: 0e00        lsrs	r0, r0, #24
@   0x0800a4c0: 2801        cmp	r0, #1
@   0x0800a4c2: d101        bne.n	0xa4c8
@   0x0800a4c4: 20ff        movs	r0, #255	@ 0xff
@   0x0800a4c6: e000        b.n	0xa4ca
@   0x0800a4c8: 2000        movs	r0, #0
@   0x0800a4ca: bc30        pop	{r4, r5}
@   0x0800a4cc: bc02        pop	{r1}
@   0x0800a4ce: 4708        bx	r1

        thumb_func_start sub_0800A3D0
sub_0800A3D0: @ 0x0800a3d0
        .incbin "frog_us_baserom.gba", 0xa3d0, 0x100
        thumb_func_end sub_0800A3D0
