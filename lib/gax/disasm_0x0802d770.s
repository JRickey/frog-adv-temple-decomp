@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d770, 0x0802d800)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d770 --end 0x802d800 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d770: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d772: 0600        lsls	r0, r0, #24
@   0x0802d774: 0e03        lsrs	r3, r0, #24
@   0x0802d776: 4921        ldr	r1, [pc, #132]	@ (0x2d7fc)
@   0x0802d778: 6808        ldr	r0, [r1, #0]
@   0x0802d77a: 1c02        adds	r2, r0, #0
@   0x0802d77c: 32bc        adds	r2, #188	@ 0xbc
@   0x0802d77e: 8815        ldrh	r5, [r2, #0]
@   0x0802d780: 8013        strh	r3, [r2, #0]
@   0x0802d782: 1c0c        adds	r4, r1, #0
@   0x0802d784: 2b00        cmp	r3, #0
@   0x0802d786: d001        beq.n	0x2d78c
@   0x0802d788: 1c58        adds	r0, r3, #1
@   0x0802d78a: 8010        strh	r0, [r2, #0]
@   0x0802d78c: 6820        ldr	r0, [r4, #0]
@   0x0802d78e: 30bc        adds	r0, #188	@ 0xbc
@   0x0802d790: 8800        ldrh	r0, [r0, #0]
@   0x0802d792: 42a8        cmp	r0, r5
@   0x0802d794: d02f        beq.n	0x2d7f6
@   0x0802d796: 2300        movs	r3, #0
@   0x0802d798: 1c27        adds	r7, r4, #0
@   0x0802d79a: 2680        movs	r6, #128	@ 0x80
@   0x0802d79c: 0276        lsls	r6, r6, #9
@   0x0802d79e: 2580        movs	r5, #128	@ 0x80
@   0x0802d7a0: 6838        ldr	r0, [r7, #0]
@   0x0802d7a2: 0099        lsls	r1, r3, #2
@   0x0802d7a4: 3010        adds	r0, #16
@   0x0802d7a6: 1842        adds	r2, r0, r1
@   0x0802d7a8: 6811        ldr	r1, [r2, #0]
@   0x0802d7aa: 1c08        adds	r0, r1, #0
@   0x0802d7ac: 4030        ands	r0, r6
@   0x0802d7ae: 2800        cmp	r0, #0
@   0x0802d7b0: d101        bne.n	0x2d7b6
@   0x0802d7b2: 4329        orrs	r1, r5
@   0x0802d7b4: 6011        str	r1, [r2, #0]
@   0x0802d7b6: 3301        adds	r3, #1
@   0x0802d7b8: 2b03        cmp	r3, #3
@   0x0802d7ba: ddf1        ble.n	0x2d7a0
@   0x0802d7bc: 2300        movs	r3, #0
@   0x0802d7be: 6820        ldr	r0, [r4, #0]
@   0x0802d7c0: 7800        ldrb	r0, [r0, #0]
@   0x0802d7c2: 4283        cmp	r3, r0
@   0x0802d7c4: da17        bge.n	0x2d7f6
@   0x0802d7c6: 1c27        adds	r7, r4, #0
@   0x0802d7c8: 2680        movs	r6, #128	@ 0x80
@   0x0802d7ca: 0276        lsls	r6, r6, #9
@   0x0802d7cc: 2580        movs	r5, #128	@ 0x80
@   0x0802d7ce: 6838        ldr	r0, [r7, #0]
@   0x0802d7d0: 30cc        adds	r0, #204	@ 0xcc
@   0x0802d7d2: 6801        ldr	r1, [r0, #0]
@   0x0802d7d4: 0098        lsls	r0, r3, #2
@   0x0802d7d6: 1840        adds	r0, r0, r1
@   0x0802d7d8: 6802        ldr	r2, [r0, #0]
@   0x0802d7da: 2a00        cmp	r2, #0
@   0x0802d7dc: d006        beq.n	0x2d7ec
@   0x0802d7de: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0802d7e0: 1c08        adds	r0, r1, #0
@   0x0802d7e2: 4030        ands	r0, r6
@   0x0802d7e4: 2800        cmp	r0, #0
@   0x0802d7e6: d101        bne.n	0x2d7ec
@   0x0802d7e8: 4329        orrs	r1, r5
@   0x0802d7ea: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802d7ec: 3301        adds	r3, #1
@   0x0802d7ee: 6820        ldr	r0, [r4, #0]
@   0x0802d7f0: 7800        ldrb	r0, [r0, #0]
@   0x0802d7f2: 4283        cmp	r3, r0
@   0x0802d7f4: dbeb        blt.n	0x2d7ce
@   0x0802d7f6: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d7f8: bc01        pop	{r0}
@   0x0802d7fa: 4700        bx	r0
@   0x0802d7fc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d7fe: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802D770
sub_0802D770: @ 0x0802d770
        .incbin "frog_us_baserom.gba", 0x2d770, 0x90
        thumb_func_end sub_0802D770
