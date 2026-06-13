@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028684, 0x08028720)  (156 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028684 --end 0x8028720 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028684: b510        push	{r4, lr}
@   0x08028686: b081        sub	sp, #4
@   0x08028688: 2400        movs	r4, #0
@   0x0802868a: 00e0        lsls	r0, r4, #3
@   0x0802868c: 1b00        subs	r0, r0, r4
@   0x0802868e: 00c0        lsls	r0, r0, #3
@   0x08028690: 4905        ldr	r1, [pc, #20]	@ (0x286a8)
@   0x08028692: 1840        adds	r0, r0, r1
@   0x08028694: 7e81        ldrb	r1, [r0, #26]
@   0x08028696: 2900        cmp	r1, #0
@   0x08028698: d108        bne.n	0x286ac
@   0x0802869a: 7ec1        ldrb	r1, [r0, #27]
@   0x0802869c: 2901        cmp	r1, #1
@   0x0802869e: d01c        beq.n	0x286da
@   0x080286a0: 2907        cmp	r1, #7
@   0x080286a2: d127        bne.n	0x286f4
@   0x080286a4: 2106        movs	r1, #6
@   0x080286a6: e019        b.n	0x286dc
@   0x080286a8: 47c0        blx	r8
@   0x080286aa: 0300        lsls	r0, r0, #12
@   0x080286ac: 2901        cmp	r1, #1
@   0x080286ae: d106        bne.n	0x286be
@   0x080286b0: 7ec1        ldrb	r1, [r0, #27]
@   0x080286b2: 2903        cmp	r1, #3
@   0x080286b4: d011        beq.n	0x286da
@   0x080286b6: 2909        cmp	r1, #9
@   0x080286b8: d11c        bne.n	0x286f4
@   0x080286ba: 2106        movs	r1, #6
@   0x080286bc: e00e        b.n	0x286dc
@   0x080286be: 2902        cmp	r1, #2
@   0x080286c0: d106        bne.n	0x286d0
@   0x080286c2: 7ec1        ldrb	r1, [r0, #27]
@   0x080286c4: 2901        cmp	r1, #1
@   0x080286c6: d008        beq.n	0x286da
@   0x080286c8: 2907        cmp	r1, #7
@   0x080286ca: d113        bne.n	0x286f4
@   0x080286cc: 2106        movs	r1, #6
@   0x080286ce: e005        b.n	0x286dc
@   0x080286d0: 2903        cmp	r1, #3
@   0x080286d2: d10f        bne.n	0x286f4
@   0x080286d4: 7ec1        ldrb	r1, [r0, #27]
@   0x080286d6: 2903        cmp	r1, #3
@   0x080286d8: d105        bne.n	0x286e6
@   0x080286da: 2105        movs	r1, #5
@   0x080286dc: 2202        movs	r2, #2
@   0x080286de: 2302        movs	r3, #2
@   0x080286e0: f7f8        fb98 	bl	0x20e14
@   0x080286e4: e006        b.n	0x286f4
@   0x080286e6: 2909        cmp	r1, #9
@   0x080286e8: d104        bne.n	0x286f4
@   0x080286ea: 2106        movs	r1, #6
@   0x080286ec: 2202        movs	r2, #2
@   0x080286ee: 2302        movs	r3, #2
@   0x080286f0: f7f8        fb90 	bl	0x20e14
@   0x080286f4: 1c60        adds	r0, r4, #1
@   0x080286f6: 0600        lsls	r0, r0, #24
@   0x080286f8: 0e04        lsrs	r4, r0, #24
@   0x080286fa: 2c0a        cmp	r4, #10
@   0x080286fc: d9c5        bls.n	0x2868a
@   0x080286fe: 4906        ldr	r1, [pc, #24]	@ (0x28718)
@   0x08028700: 4b06        ldr	r3, [pc, #24]	@ (0x2871c)
@   0x08028702: 2000        movs	r0, #0
@   0x08028704: 9000        str	r0, [sp, #0]
@   0x08028706: 204c        movs	r0, #76	@ 0x4c
@   0x08028708: 2211        movs	r2, #17
@   0x0802870a: f7f8        ff01 	bl	0x21510
@   0x0802870e: b001        add	sp, #4
@   0x08028710: bc10        pop	{r4}
@   0x08028712: bc01        pop	{r0}
@   0x08028714: 4700        bx	r0
@   0x08028716: 0000        movs	r0, r0
@   0x08028718: 6ec4        ldr	r4, [r0, #108]	@ 0x6c
@   0x0802871a: 0831        lsrs	r1, r6, #32
@   0x0802871c: 6110        str	r0, [r2, #16]
@   0x0802871e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08028684
sub_08028684: @ 0x08028684
        .incbin "baserom.gba", 0x28684, 0x9c
        thumb_func_end sub_08028684
