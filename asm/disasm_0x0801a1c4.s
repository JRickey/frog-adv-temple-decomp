@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a1c4, 0x0801a268)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a1c4 --end 0x801a268 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a1c4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801a1c6: 1c17        adds	r7, r2, #0
@   0x0801a1c8: 1c1e        adds	r6, r3, #0
@   0x0801a1ca: 0600        lsls	r0, r0, #24
@   0x0801a1cc: 0e05        lsrs	r5, r0, #24
@   0x0801a1ce: 0609        lsls	r1, r1, #24
@   0x0801a1d0: 2400        movs	r4, #0
@   0x0801a1d2: 2900        cmp	r1, #0
@   0x0801a1d4: d114        bne.n	0x1a200
@   0x0801a1d6: 4a21        ldr	r2, [pc, #132]	@ (0x1a25c)
@   0x0801a1d8: 2002        movs	r0, #2
@   0x0801a1da: 5e11        ldrsh	r1, [r2, r0]
@   0x0801a1dc: 1f08        subs	r0, r1, #4
@   0x0801a1de: 2800        cmp	r0, #0
@   0x0801a1e0: da00        bge.n	0x1a1e4
@   0x0801a1e2: 1cc8        adds	r0, r1, #3
@   0x0801a1e4: 10c0        asrs	r0, r0, #3
@   0x0801a1e6: 0600        lsls	r0, r0, #24
@   0x0801a1e8: 0e00        lsrs	r0, r0, #24
@   0x0801a1ea: 2104        movs	r1, #4
@   0x0801a1ec: 5e52        ldrsh	r2, [r2, r1]
@   0x0801a1ee: 1d11        adds	r1, r2, #4
@   0x0801a1f0: 2900        cmp	r1, #0
@   0x0801a1f2: da00        bge.n	0x1a1f6
@   0x0801a1f4: 3107        adds	r1, #7
@   0x0801a1f6: 10c9        asrs	r1, r1, #3
@   0x0801a1f8: 0609        lsls	r1, r1, #24
@   0x0801a1fa: 0e09        lsrs	r1, r1, #24
@   0x0801a1fc: f001        f886 	bl	0x1b30c
@   0x0801a200: 2e00        cmp	r6, #0
@   0x0801a202: d105        bne.n	0x1a210
@   0x0801a204: 1c28        adds	r0, r5, #0
@   0x0801a206: 1c39        adds	r1, r7, #0
@   0x0801a208: f000        fa0c 	bl	0x1a624
@   0x0801a20c: 0600        lsls	r0, r0, #24
@   0x0801a20e: 0e04        lsrs	r4, r0, #24
@   0x0801a210: 2008        movs	r0, #8
@   0x0801a212: 4020        ands	r0, r4
@   0x0801a214: 2800        cmp	r0, #0
@   0x0801a216: d003        beq.n	0x1a220
@   0x0801a218: 4910        ldr	r1, [pc, #64]	@ (0x1a25c)
@   0x0801a21a: 8848        ldrh	r0, [r1, #2]
@   0x0801a21c: 3002        adds	r0, #2
@   0x0801a21e: 8048        strh	r0, [r1, #2]
@   0x0801a220: 2002        movs	r0, #2
@   0x0801a222: 4020        ands	r0, r4
@   0x0801a224: 2800        cmp	r0, #0
@   0x0801a226: d003        beq.n	0x1a230
@   0x0801a228: 490c        ldr	r1, [pc, #48]	@ (0x1a25c)
@   0x0801a22a: 8888        ldrh	r0, [r1, #4]
@   0x0801a22c: 3002        adds	r0, #2
@   0x0801a22e: 8088        strh	r0, [r1, #4]
@   0x0801a230: 2004        movs	r0, #4
@   0x0801a232: 4020        ands	r0, r4
@   0x0801a234: 2800        cmp	r0, #0
@   0x0801a236: d003        beq.n	0x1a240
@   0x0801a238: 4908        ldr	r1, [pc, #32]	@ (0x1a25c)
@   0x0801a23a: 8848        ldrh	r0, [r1, #2]
@   0x0801a23c: 3802        subs	r0, #2
@   0x0801a23e: 8048        strh	r0, [r1, #2]
@   0x0801a240: 2001        movs	r0, #1
@   0x0801a242: 4020        ands	r0, r4
@   0x0801a244: 2800        cmp	r0, #0
@   0x0801a246: d003        beq.n	0x1a250
@   0x0801a248: 4904        ldr	r1, [pc, #16]	@ (0x1a25c)
@   0x0801a24a: 8888        ldrh	r0, [r1, #4]
@   0x0801a24c: 3802        subs	r0, #2
@   0x0801a24e: 8088        strh	r0, [r1, #4]
@   0x0801a250: f000        ff2c 	bl	0x1b0ac
@   0x0801a254: 2cff        cmp	r4, #255	@ 0xff
@   0x0801a256: d003        beq.n	0x1a260
@   0x0801a258: 2001        movs	r0, #1
@   0x0801a25a: e002        b.n	0x1a262
@   0x0801a25c: 3720        adds	r7, #32
@   0x0801a25e: 0300        lsls	r0, r0, #12
@   0x0801a260: 2000        movs	r0, #0
@   0x0801a262: bcf0        pop	{r4, r5, r6, r7}
@   0x0801a264: bc02        pop	{r1}
@   0x0801a266: 4708        bx	r1

        thumb_func_start sub_0801A1C4
sub_0801A1C4: @ 0x0801a1c4
        .incbin "frog_us_baserom.gba", 0x1a1c4, 0xa4
        thumb_func_end sub_0801A1C4
