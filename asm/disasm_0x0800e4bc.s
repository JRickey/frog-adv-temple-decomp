@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e4bc, 0x0800e600)  (324 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e4bc --end 0x800e600 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e4bc: b530        push	{r4, r5, lr}
@   0x0800e4be: 2401        movs	r4, #1
@   0x0800e4c0: 4d03        ldr	r5, [pc, #12]	@ (0xe4d0)
@   0x0800e4c2: 7828        ldrb	r0, [r5, #0]
@   0x0800e4c4: 2801        cmp	r0, #1
@   0x0800e4c6: d005        beq.n	0xe4d4
@   0x0800e4c8: 2802        cmp	r0, #2
@   0x0800e4ca: d055        beq.n	0xe578
@   0x0800e4cc: e093        b.n	0xe5f6
@   0x0800e4ce: 0000        movs	r0, r0
@   0x0800e4d0: 5328        strh	r0, [r5, r4]
@   0x0800e4d2: 0300        lsls	r0, r0, #12
@   0x0800e4d4: 4804        ldr	r0, [pc, #16]	@ (0xe4e8)
@   0x0800e4d6: 8800        ldrh	r0, [r0, #0]
@   0x0800e4d8: 2802        cmp	r0, #2
@   0x0800e4da: d017        beq.n	0xe50c
@   0x0800e4dc: 2802        cmp	r0, #2
@   0x0800e4de: dc05        bgt.n	0xe4ec
@   0x0800e4e0: 2801        cmp	r0, #1
@   0x0800e4e2: d008        beq.n	0xe4f6
@   0x0800e4e4: e087        b.n	0xe5f6
@   0x0800e4e6: 0000        movs	r0, r0
@   0x0800e4e8: 5398        strh	r0, [r3, r6]
@   0x0800e4ea: 0300        lsls	r0, r0, #12
@   0x0800e4ec: 2810        cmp	r0, #16
@   0x0800e4ee: d025        beq.n	0xe53c
@   0x0800e4f0: 2840        cmp	r0, #64	@ 0x40
@   0x0800e4f2: d015        beq.n	0xe520
@   0x0800e4f4: e07f        b.n	0xe5f6
@   0x0800e4f6: 2002        movs	r0, #2
@   0x0800e4f8: f012        fbbe 	bl	0x20c78
@   0x0800e4fc: 4902        ldr	r1, [pc, #8]	@ (0xe508)
@   0x0800e4fe: 2003        movs	r0, #3
@   0x0800e500: 7108        strb	r0, [r1, #4]
@   0x0800e502: 720c        strb	r4, [r1, #8]
@   0x0800e504: e077        b.n	0xe5f6
@   0x0800e506: 0000        movs	r0, r0
@   0x0800e508: 5370        strh	r0, [r6, r5]
@   0x0800e50a: 0300        lsls	r0, r0, #12
@   0x0800e50c: 2002        movs	r0, #2
@   0x0800e50e: f012        fbb3 	bl	0x20c78
@   0x0800e512: 4902        ldr	r1, [pc, #8]	@ (0xe51c)
@   0x0800e514: 710c        strb	r4, [r1, #4]
@   0x0800e516: 2003        movs	r0, #3
@   0x0800e518: 7208        strb	r0, [r1, #8]
@   0x0800e51a: e06c        b.n	0xe5f6
@   0x0800e51c: 5370        strh	r0, [r6, r5]
@   0x0800e51e: 0300        lsls	r0, r0, #12
@   0x0800e520: 2001        movs	r0, #1
@   0x0800e522: f012        fba9 	bl	0x20c78
@   0x0800e526: 4a04        ldr	r2, [pc, #16]	@ (0xe538)
@   0x0800e528: 210f        movs	r1, #15
@   0x0800e52a: 1c08        adds	r0, r1, #0
@   0x0800e52c: 7913        ldrb	r3, [r2, #4]
@   0x0800e52e: 4018        ands	r0, r3
@   0x0800e530: 2803        cmp	r0, #3
@   0x0800e532: d00d        beq.n	0xe550
@   0x0800e534: e016        b.n	0xe564
@   0x0800e536: 0000        movs	r0, r0
@   0x0800e538: 5370        strh	r0, [r6, r5]
@   0x0800e53a: 0300        lsls	r0, r0, #12
@   0x0800e53c: 2001        movs	r0, #1
@   0x0800e53e: f012        fb9b 	bl	0x20c78
@   0x0800e542: 4a07        ldr	r2, [pc, #28]	@ (0xe560)
@   0x0800e544: 210f        movs	r1, #15
@   0x0800e546: 1c08        adds	r0, r1, #0
@   0x0800e548: 7913        ldrb	r3, [r2, #4]
@   0x0800e54a: 4018        ands	r0, r3
@   0x0800e54c: 2803        cmp	r0, #3
@   0x0800e54e: d109        bne.n	0xe564
@   0x0800e550: 2100        movs	r1, #0
@   0x0800e552: 2009        movs	r0, #9
@   0x0800e554: 7010        strb	r0, [r2, #0]
@   0x0800e556: 7110        strb	r0, [r2, #4]
@   0x0800e558: 7210        strb	r0, [r2, #8]
@   0x0800e55a: 7029        strb	r1, [r5, #0]
@   0x0800e55c: e04b        b.n	0xe5f6
@   0x0800e55e: 0000        movs	r0, r0
@   0x0800e560: 5370        strh	r0, [r6, r5]
@   0x0800e562: 0300        lsls	r0, r0, #12
@   0x0800e564: 7a10        ldrb	r0, [r2, #8]
@   0x0800e566: 4001        ands	r1, r0
@   0x0800e568: 2903        cmp	r1, #3
@   0x0800e56a: d144        bne.n	0xe5f6
@   0x0800e56c: 2002        movs	r0, #2
@   0x0800e56e: 7210        strb	r0, [r2, #8]
@   0x0800e570: 7314        strb	r4, [r2, #12]
@   0x0800e572: 7411        strb	r1, [r2, #16]
@   0x0800e574: 7028        strb	r0, [r5, #0]
@   0x0800e576: e03e        b.n	0xe5f6
@   0x0800e578: 4804        ldr	r0, [pc, #16]	@ (0xe58c)
@   0x0800e57a: 8800        ldrh	r0, [r0, #0]
@   0x0800e57c: 2808        cmp	r0, #8
@   0x0800e57e: d015        beq.n	0xe5ac
@   0x0800e580: 2808        cmp	r0, #8
@   0x0800e582: dc05        bgt.n	0xe590
@   0x0800e584: 2804        cmp	r0, #4
@   0x0800e586: d006        beq.n	0xe596
@   0x0800e588: e035        b.n	0xe5f6
@   0x0800e58a: 0000        movs	r0, r0
@   0x0800e58c: 5398        strh	r0, [r3, r6]
@   0x0800e58e: 0300        lsls	r0, r0, #12
@   0x0800e590: 2810        cmp	r0, #16
@   0x0800e592: d015        beq.n	0xe5c0
@   0x0800e594: e02f        b.n	0xe5f6
@   0x0800e596: 2002        movs	r0, #2
@   0x0800e598: f012        fb6e 	bl	0x20c78
@   0x0800e59c: 4902        ldr	r1, [pc, #8]	@ (0xe5a8)
@   0x0800e59e: 2003        movs	r0, #3
@   0x0800e5a0: 7308        strb	r0, [r1, #12]
@   0x0800e5a2: 740c        strb	r4, [r1, #16]
@   0x0800e5a4: e027        b.n	0xe5f6
@   0x0800e5a6: 0000        movs	r0, r0
@   0x0800e5a8: 5370        strh	r0, [r6, r5]
@   0x0800e5aa: 0300        lsls	r0, r0, #12
@   0x0800e5ac: 2002        movs	r0, #2
@   0x0800e5ae: f012        fb63 	bl	0x20c78
@   0x0800e5b2: 4902        ldr	r1, [pc, #8]	@ (0xe5bc)
@   0x0800e5b4: 730c        strb	r4, [r1, #12]
@   0x0800e5b6: 2003        movs	r0, #3
@   0x0800e5b8: 7408        strb	r0, [r1, #16]
@   0x0800e5ba: e01c        b.n	0xe5f6
@   0x0800e5bc: 5370        strh	r0, [r6, r5]
@   0x0800e5be: 0300        lsls	r0, r0, #12
@   0x0800e5c0: 2001        movs	r0, #1
@   0x0800e5c2: f012        fb59 	bl	0x20c78
@   0x0800e5c6: 4905        ldr	r1, [pc, #20]	@ (0xe5dc)
@   0x0800e5c8: 220f        movs	r2, #15
@   0x0800e5ca: 1c10        adds	r0, r2, #0
@   0x0800e5cc: 7b0b        ldrb	r3, [r1, #12]
@   0x0800e5ce: 4018        ands	r0, r3
@   0x0800e5d0: 2803        cmp	r0, #3
@   0x0800e5d2: d105        bne.n	0xe5e0
@   0x0800e5d4: 2400        movs	r4, #0
@   0x0800e5d6: f01f        f98f 	bl	0x2d8f8
@   0x0800e5da: e00c        b.n	0xe5f6
@   0x0800e5dc: 5370        strh	r0, [r6, r5]
@   0x0800e5de: 0300        lsls	r0, r0, #12
@   0x0800e5e0: 1c10        adds	r0, r2, #0
@   0x0800e5e2: 7c0a        ldrb	r2, [r1, #16]
@   0x0800e5e4: 4010        ands	r0, r2
@   0x0800e5e6: 2803        cmp	r0, #3
@   0x0800e5e8: d105        bne.n	0xe5f6
@   0x0800e5ea: 710c        strb	r4, [r1, #4]
@   0x0800e5ec: 7208        strb	r0, [r1, #8]
@   0x0800e5ee: 2009        movs	r0, #9
@   0x0800e5f0: 7308        strb	r0, [r1, #12]
@   0x0800e5f2: 7408        strb	r0, [r1, #16]
@   0x0800e5f4: 702c        strb	r4, [r5, #0]
@   0x0800e5f6: 1c20        adds	r0, r4, #0
@   0x0800e5f8: bc30        pop	{r4, r5}
@   0x0800e5fa: bc02        pop	{r1}
@   0x0800e5fc: 4708        bx	r1

        thumb_func_start sub_0800E4BC
sub_0800E4BC: @ 0x0800e4bc
        .incbin "frog_us_baserom.gba", 0xe4bc, 0x144
        thumb_func_end sub_0800E4BC
