@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b514, 0x0801b694)  (384 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b514 --end 0x801b694 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b514: b530        push	{r4, r5, lr}
@   0x0801b516: 0600        lsls	r0, r0, #24
@   0x0801b518: 0e05        lsrs	r5, r0, #24
@   0x0801b51a: 2d10        cmp	r5, #16
@   0x0801b51c: d101        bne.n	0x1b522
@   0x0801b51e: 2506        movs	r5, #6
@   0x0801b520: e011        b.n	0x1b546
@   0x0801b522: 1c28        adds	r0, r5, #0
@   0x0801b524: 2103        movs	r1, #3
@   0x0801b526: f018        fd19 	bl	0x33f5c
@   0x0801b52a: 0600        lsls	r0, r0, #24
@   0x0801b52c: 2800        cmp	r0, #0
@   0x0801b52e: d108        bne.n	0x1b542
@   0x0801b530: 2d00        cmp	r5, #0
@   0x0801b532: d006        beq.n	0x1b542
@   0x0801b534: 1c28        adds	r0, r5, #0
@   0x0801b536: 2103        movs	r1, #3
@   0x0801b538: f018        fcd4 	bl	0x33ee4
@   0x0801b53c: 0600        lsls	r0, r0, #24
@   0x0801b53e: 0e05        lsrs	r5, r0, #24
@   0x0801b540: e001        b.n	0x1b546
@   0x0801b542: 2000        movs	r0, #0
@   0x0801b544: e051        b.n	0x1b5ea
@   0x0801b546: 1e68        subs	r0, r5, #1
@   0x0801b548: 0600        lsls	r0, r0, #24
@   0x0801b54a: 0e05        lsrs	r5, r0, #24
@   0x0801b54c: 4828        ldr	r0, [pc, #160]	@ (0x1b5f0)
@   0x0801b54e: 22f0        movs	r2, #240	@ 0xf0
@   0x0801b550: 8002        strh	r2, [r0, #0]
@   0x0801b552: 4928        ldr	r1, [pc, #160]	@ (0x1b5f4)
@   0x0801b554: 4b28        ldr	r3, [pc, #160]	@ (0x1b5f8)
@   0x0801b556: 1c18        adds	r0, r3, #0
@   0x0801b558: 8008        strh	r0, [r1, #0]
@   0x0801b55a: 4828        ldr	r0, [pc, #160]	@ (0x1b5fc)
@   0x0801b55c: 8002        strh	r2, [r0, #0]
@   0x0801b55e: 3102        adds	r1, #2
@   0x0801b560: 2030        movs	r0, #48	@ 0x30
@   0x0801b562: 8008        strh	r0, [r1, #0]
@   0x0801b564: 3102        adds	r1, #2
@   0x0801b566: 4a26        ldr	r2, [pc, #152]	@ (0x1b600)
@   0x0801b568: 1c10        adds	r0, r2, #0
@   0x0801b56a: 8008        strh	r0, [r1, #0]
@   0x0801b56c: 4a25        ldr	r2, [pc, #148]	@ (0x1b604)
@   0x0801b56e: 4b26        ldr	r3, [pc, #152]	@ (0x1b608)
@   0x0801b570: 1c18        adds	r0, r3, #0
@   0x0801b572: 8010        strh	r0, [r2, #0]
@   0x0801b574: 8810        ldrh	r0, [r2, #0]
@   0x0801b576: 2108        movs	r1, #8
@   0x0801b578: 4048        eors	r0, r1
@   0x0801b57a: 8010        strh	r0, [r2, #0]
@   0x0801b57c: 4923        ldr	r1, [pc, #140]	@ (0x1b60c)
@   0x0801b57e: 4a24        ldr	r2, [pc, #144]	@ (0x1b610)
@   0x0801b580: 1c10        adds	r0, r2, #0
@   0x0801b582: 8008        strh	r0, [r1, #0]
@   0x0801b584: 4923        ldr	r1, [pc, #140]	@ (0x1b614)
@   0x0801b586: 2400        movs	r4, #0
@   0x0801b588: 2000        movs	r0, #0
@   0x0801b58a: 8188        strh	r0, [r1, #12]
@   0x0801b58c: 81c8        strh	r0, [r1, #14]
@   0x0801b58e: 1c28        adds	r0, r5, #0
@   0x0801b590: f7ff        fef0 	bl	0x1b374
@   0x0801b594: 4820        ldr	r0, [pc, #128]	@ (0x1b618)
@   0x0801b596: 7044        strb	r4, [r0, #1]
@   0x0801b598: 7304        strb	r4, [r0, #12]
@   0x0801b59a: f005        fb07 	bl	0x20bac
@   0x0801b59e: 2010        movs	r0, #16
@   0x0801b5a0: f005        faf2 	bl	0x20b88
@   0x0801b5a4: 2002        movs	r0, #2
@   0x0801b5a6: 2114        movs	r1, #20
@   0x0801b5a8: f7ff        f974 	bl	0x1a894
@   0x0801b5ac: 1c28        adds	r0, r5, #0
@   0x0801b5ae: f7ff        ff3f 	bl	0x1b430
@   0x0801b5b2: 1c28        adds	r0, r5, #0
@   0x0801b5b4: f000        f86e 	bl	0x1b694
@   0x0801b5b8: 4c18        ldr	r4, [pc, #96]	@ (0x1b61c)
@   0x0801b5ba: f7e4        ff83 	bl	0x4c4
@   0x0801b5be: 8020        strh	r0, [r4, #0]
@   0x0801b5c0: 1c28        adds	r0, r5, #0
@   0x0801b5c2: f000        fa0f 	bl	0x1b9e4
@   0x0801b5c6: 0600        lsls	r0, r0, #24
@   0x0801b5c8: 0e00        lsrs	r0, r0, #24
@   0x0801b5ca: 28fe        cmp	r0, #254	@ 0xfe
@   0x0801b5cc: d1f5        bne.n	0x1b5ba
@   0x0801b5ce: 2002        movs	r0, #2
@   0x0801b5d0: 2114        movs	r1, #20
@   0x0801b5d2: f7ff        f9d5 	bl	0x1a980
@   0x0801b5d6: 4806        ldr	r0, [pc, #24]	@ (0x1b5f0)
@   0x0801b5d8: 2100        movs	r1, #0
@   0x0801b5da: 8001        strh	r1, [r0, #0]
@   0x0801b5dc: 3004        adds	r0, #4
@   0x0801b5de: 8001        strh	r1, [r0, #0]
@   0x0801b5e0: f7f3        fa9c 	bl	0xeb1c
@   0x0801b5e4: f7fb        fa2c 	bl	0x16a40
@   0x0801b5e8: 2001        movs	r0, #1
@   0x0801b5ea: bc30        pop	{r4, r5}
@   0x0801b5ec: bc02        pop	{r1}
@   0x0801b5ee: 4708        bx	r1
@   0x0801b5f0: 0040        lsls	r0, r0, #1
@   0x0801b5f2: 0400        lsls	r0, r0, #16
@   0x0801b5f4: 0044        lsls	r4, r0, #1
@   0x0801b5f6: 0400        lsls	r0, r0, #16
@   0x0801b5f8: 70a0        strb	r0, [r4, #2]
@   0x0801b5fa: 0000        movs	r0, r0
@   0x0801b5fc: 0042        lsls	r2, r0, #1
@   0x0801b5fe: 0400        lsls	r0, r0, #16
@   0x0801b600: 0808        lsrs	r0, r1, #32
@   0x0801b602: 0000        movs	r0, r0
@   0x0801b604: 004a        lsls	r2, r1, #1
@   0x0801b606: 0400        lsls	r0, r0, #16
@   0x0801b608: 3f3f        subs	r7, #63	@ 0x3f
@   0x0801b60a: 0000        movs	r0, r0
@   0x0801b60c: 000e        movs	r6, r1
@   0x0801b60e: 0400        lsls	r0, r0, #16
@   0x0801b610: 1f08        subs	r0, r1, #4
@   0x0801b612: 0000        movs	r0, r0
@   0x0801b614: 3550        adds	r5, #80	@ 0x50
@   0x0801b616: 0300        lsls	r0, r0, #12
@   0x0801b618: 3540        adds	r5, #64	@ 0x40
@   0x0801b61a: 0300        lsls	r0, r0, #12
@   0x0801b61c: 5398        strh	r0, [r3, r6]
@   0x0801b61e: 0300        lsls	r0, r0, #12
@   0x0801b620: b510        push	{r4, lr}
@   0x0801b622: b081        sub	sp, #4
@   0x0801b624: 0600        lsls	r0, r0, #24
@   0x0801b626: 0e00        lsrs	r0, r0, #24
@   0x0801b628: 4b13        ldr	r3, [pc, #76]	@ (0x1b678)
@   0x0801b62a: 4914        ldr	r1, [pc, #80]	@ (0x1b67c)
@   0x0801b62c: 6159        str	r1, [r3, #20]
@   0x0801b62e: 3180        adds	r1, #128	@ 0x80
@   0x0801b630: 6259        str	r1, [r3, #36]	@ 0x24
@   0x0801b632: 4c13        ldr	r4, [pc, #76]	@ (0x1b680)
@   0x0801b634: 4913        ldr	r1, [pc, #76]	@ (0x1b684)
@   0x0801b636: 680a        ldr	r2, [r1, #0]
@   0x0801b638: 0051        lsls	r1, r2, #1
@   0x0801b63a: 1889        adds	r1, r1, r2
@   0x0801b63c: 00c9        lsls	r1, r1, #3
@   0x0801b63e: 1909        adds	r1, r1, r4
@   0x0801b640: 680a        ldr	r2, [r1, #0]
@   0x0801b642: 0081        lsls	r1, r0, #2
@   0x0801b644: 1889        adds	r1, r1, r2
@   0x0801b646: 6a09        ldr	r1, [r1, #32]
@   0x0801b648: 60d9        str	r1, [r3, #12]
@   0x0801b64a: 2100        movs	r1, #0
@   0x0801b64c: 2200        movs	r2, #0
@   0x0801b64e: 7219        strb	r1, [r3, #8]
@   0x0801b650: 859a        strh	r2, [r3, #44]	@ 0x2c
@   0x0801b652: 861a        strh	r2, [r3, #48]	@ 0x30
@   0x0801b654: 865a        strh	r2, [r3, #50]	@ 0x32
@   0x0801b656: 2108        movs	r1, #8
@   0x0801b658: 72d9        strb	r1, [r3, #11]
@   0x0801b65a: 4669        mov	r1, sp
@   0x0801b65c: 800a        strh	r2, [r1, #0]
@   0x0801b65e: 4a0a        ldr	r2, [pc, #40]	@ (0x1b688)
@   0x0801b660: 6011        str	r1, [r2, #0]
@   0x0801b662: 490a        ldr	r1, [pc, #40]	@ (0x1b68c)
@   0x0801b664: 6051        str	r1, [r2, #4]
@   0x0801b666: 490a        ldr	r1, [pc, #40]	@ (0x1b690)
@   0x0801b668: 6091        str	r1, [r2, #8]
@   0x0801b66a: 6891        ldr	r1, [r2, #8]
@   0x0801b66c: f7ff        fee0 	bl	0x1b430
@   0x0801b670: b001        add	sp, #4
@   0x0801b672: bc10        pop	{r4}
@   0x0801b674: bc01        pop	{r0}
@   0x0801b676: 4700        bx	r0
@   0x0801b678: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801b67a: 0300        lsls	r0, r0, #12
@   0x0801b67c: fbc2        0600 	smlal	r0, r6, r2, r0
@   0x0801b680: 1254        asrs	r4, r2, #9
@   0x0801b682: 080c        lsrs	r4, r1, #32
@   0x0801b684: 34b0        adds	r4, #176	@ 0xb0
@   0x0801b686: 0300        lsls	r0, r0, #12
@   0x0801b688: 00d4        lsls	r4, r2, #3
@   0x0801b68a: 0400        lsls	r0, r0, #16
@   0x0801b68c: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801b690: 00c0        lsls	r0, r0, #3
@   0x0801b692: 8100        strh	r0, [r0, #8]

        thumb_func_start sub_0801B514
sub_0801B514: @ 0x0801b514
        .incbin "frog_us_baserom.gba", 0x1b514, 0x180
        thumb_func_end sub_0801B514
