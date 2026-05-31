@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a538, 0x0802a63c)  (260 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a538 --end 0x802a63c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a538: b510        push	{r4, lr}
@   0x0802a53a: 4c09        ldr	r4, [pc, #36]	@ (0x2a560)
@   0x0802a53c: 1c20        adds	r0, r4, #0
@   0x0802a53e: 2108        movs	r1, #8
@   0x0802a540: 2200        movs	r2, #0
@   0x0802a542: f7dc        f92b 	bl	0x679c
@   0x0802a546: 0600        lsls	r0, r0, #24
@   0x0802a548: 2800        cmp	r0, #0
@   0x0802a54a: d049        beq.n	0x2a5e0
@   0x0802a54c: 203b        movs	r0, #59	@ 0x3b
@   0x0802a54e: f7f6        fb93 	bl	0x20c78
@   0x0802a552: 1c20        adds	r0, r4, #0
@   0x0802a554: 302b        adds	r0, #43	@ 0x2b
@   0x0802a556: 7800        ldrb	r0, [r0, #0]
@   0x0802a558: 2800        cmp	r0, #0
@   0x0802a55a: d103        bne.n	0x2a564
@   0x0802a55c: 2005        movs	r0, #5
@   0x0802a55e: e006        b.n	0x2a56e
@   0x0802a560: 6110        str	r0, [r2, #16]
@   0x0802a562: 0300        lsls	r0, r0, #12
@   0x0802a564: 2801        cmp	r0, #1
@   0x0802a566: d101        bne.n	0x2a56c
@   0x0802a568: 2005        movs	r0, #5
@   0x0802a56a: e000        b.n	0x2a56e
@   0x0802a56c: 2006        movs	r0, #6
@   0x0802a56e: 81a0        strh	r0, [r4, #12]
@   0x0802a570: 4c07        ldr	r4, [pc, #28]	@ (0x2a590)
@   0x0802a572: 1c20        adds	r0, r4, #0
@   0x0802a574: 2108        movs	r1, #8
@   0x0802a576: 2207        movs	r2, #7
@   0x0802a578: f7dc        f842 	bl	0x6600
@   0x0802a57c: 342b        adds	r4, #43	@ 0x2b
@   0x0802a57e: 7820        ldrb	r0, [r4, #0]
@   0x0802a580: 2802        cmp	r0, #2
@   0x0802a582: d109        bne.n	0x2a598
@   0x0802a584: 2005        movs	r0, #5
@   0x0802a586: f7d6        f8ed 	bl	0x764
@   0x0802a58a: 4902        ldr	r1, [pc, #8]	@ (0x2a594)
@   0x0802a58c: 3003        adds	r0, #3
@   0x0802a58e: e011        b.n	0x2a5b4
@   0x0802a590: 6110        str	r0, [r2, #16]
@   0x0802a592: 0300        lsls	r0, r0, #12
@   0x0802a594: 3720        adds	r7, #32
@   0x0802a596: 0300        lsls	r0, r0, #12
@   0x0802a598: 2801        cmp	r0, #1
@   0x0802a59a: d107        bne.n	0x2a5ac
@   0x0802a59c: 2005        movs	r0, #5
@   0x0802a59e: f7d6        f8e1 	bl	0x764
@   0x0802a5a2: 4901        ldr	r1, [pc, #4]	@ (0x2a5a8)
@   0x0802a5a4: 3003        adds	r0, #3
@   0x0802a5a6: e005        b.n	0x2a5b4
@   0x0802a5a8: 3720        adds	r7, #32
@   0x0802a5aa: 0300        lsls	r0, r0, #12
@   0x0802a5ac: 2003        movs	r0, #3
@   0x0802a5ae: f7d6        f8d9 	bl	0x764
@   0x0802a5b2: 491d        ldr	r1, [pc, #116]	@ (0x2a628)
@   0x0802a5b4: 4a1d        ldr	r2, [pc, #116]	@ (0x2a62c)
@   0x0802a5b6: 1889        adds	r1, r1, r2
@   0x0802a5b8: 7008        strb	r0, [r1, #0]
@   0x0802a5ba: 491b        ldr	r1, [pc, #108]	@ (0x2a628)
@   0x0802a5bc: 20d6        movs	r0, #214	@ 0xd6
@   0x0802a5be: 00c0        lsls	r0, r0, #3
@   0x0802a5c0: 180a        adds	r2, r1, r0
@   0x0802a5c2: 481b        ldr	r0, [pc, #108]	@ (0x2a630)
@   0x0802a5c4: 6800        ldr	r0, [r0, #0]
@   0x0802a5c6: 6010        str	r0, [r2, #0]
@   0x0802a5c8: 22d3        movs	r2, #211	@ 0xd3
@   0x0802a5ca: 00d2        lsls	r2, r2, #3
@   0x0802a5cc: 1888        adds	r0, r1, r2
@   0x0802a5ce: 2200        movs	r2, #0
@   0x0802a5d0: 8002        strh	r2, [r0, #0]
@   0x0802a5d2: 4818        ldr	r0, [pc, #96]	@ (0x2a634)
@   0x0802a5d4: 1809        adds	r1, r1, r0
@   0x0802a5d6: 800a        strh	r2, [r1, #0]
@   0x0802a5d8: 4817        ldr	r0, [pc, #92]	@ (0x2a638)
@   0x0802a5da: 2108        movs	r1, #8
@   0x0802a5dc: f7dc        f872 	bl	0x66c4
@   0x0802a5e0: 4c15        ldr	r4, [pc, #84]	@ (0x2a638)
@   0x0802a5e2: 1c20        adds	r0, r4, #0
@   0x0802a5e4: 2108        movs	r1, #8
@   0x0802a5e6: 2207        movs	r2, #7
@   0x0802a5e8: f7dc        f8d8 	bl	0x679c
@   0x0802a5ec: 0600        lsls	r0, r0, #24
@   0x0802a5ee: 2800        cmp	r0, #0
@   0x0802a5f0: d00c        beq.n	0x2a60c
@   0x0802a5f2: 89a0        ldrh	r0, [r4, #12]
@   0x0802a5f4: 2800        cmp	r0, #0
@   0x0802a5f6: d109        bne.n	0x2a60c
@   0x0802a5f8: 1c20        adds	r0, r4, #0
@   0x0802a5fa: 2108        movs	r1, #8
@   0x0802a5fc: 2201        movs	r2, #1
@   0x0802a5fe: f7db        ffff 	bl	0x6600
@   0x0802a602: 1c20        adds	r0, r4, #0
@   0x0802a604: 2108        movs	r1, #8
@   0x0802a606: 2207        movs	r2, #7
@   0x0802a608: f7dc        f85c 	bl	0x66c4
@   0x0802a60c: 480a        ldr	r0, [pc, #40]	@ (0x2a638)
@   0x0802a60e: 2108        movs	r1, #8
@   0x0802a610: 2207        movs	r2, #7
@   0x0802a612: f7dc        f8c3 	bl	0x679c
@   0x0802a616: 0600        lsls	r0, r0, #24
@   0x0802a618: 2800        cmp	r0, #0
@   0x0802a61a: d001        beq.n	0x2a620
@   0x0802a61c: f000        f80e 	bl	0x2a63c
@   0x0802a620: bc10        pop	{r4}
@   0x0802a622: bc01        pop	{r0}
@   0x0802a624: 4700        bx	r0
@   0x0802a626: 0000        movs	r0, r0
@   0x0802a628: 3720        adds	r7, #32
@   0x0802a62a: 0300        lsls	r0, r0, #12
@   0x0802a62c: 06aa        lsls	r2, r5, #26
@   0x0802a62e: 0000        movs	r0, r0
@   0x0802a630: 5330        strh	r0, [r6, r4]
@   0x0802a632: 0300        lsls	r0, r0, #12
@   0x0802a634: 069a        lsls	r2, r3, #26
@   0x0802a636: 0000        movs	r0, r0
@   0x0802a638: 6110        str	r0, [r2, #16]
@   0x0802a63a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802A538
sub_0802A538: @ 0x0802a538
        .incbin "frog_us_baserom.gba", 0x2a538, 0x104
        thumb_func_end sub_0802A538
