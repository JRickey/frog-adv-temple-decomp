@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800885c, 0x080089a4)  (328 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800885c --end 0x80089a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800885c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800885e: b086        sub	sp, #24
@   0x08008860: 0600        lsls	r0, r0, #24
@   0x08008862: 0e02        lsrs	r2, r0, #24
@   0x08008864: 0609        lsls	r1, r1, #24
@   0x08008866: 0e09        lsrs	r1, r1, #24
@   0x08008868: 4804        ldr	r0, [pc, #16]	@ (0x887c)
@   0x0800886a: 7e80        ldrb	r0, [r0, #26]
@   0x0800886c: 280d        cmp	r0, #13
@   0x0800886e: d01a        beq.n	0x88a6
@   0x08008870: 280d        cmp	r0, #13
@   0x08008872: dc05        bgt.n	0x8880
@   0x08008874: 280c        cmp	r0, #12
@   0x08008876: d008        beq.n	0x888a
@   0x08008878: e04d        b.n	0x8916
@   0x0800887a: 0000        movs	r0, r0
@   0x0800887c: 3720        adds	r7, #32
@   0x0800887e: 0300        lsls	r0, r0, #12
@   0x08008880: 280e        cmp	r0, #14
@   0x08008882: d021        beq.n	0x88c8
@   0x08008884: 280f        cmp	r0, #15
@   0x08008886: d036        beq.n	0x88f6
@   0x08008888: e045        b.n	0x8916
@   0x0800888a: 060b        lsls	r3, r1, #24
@   0x0800888c: 161b        asrs	r3, r3, #24
@   0x0800888e: 0612        lsls	r2, r2, #24
@   0x08008890: 1612        asrs	r2, r2, #24
@   0x08008892: a804        add	r0, sp, #16
@   0x08008894: 9000        str	r0, [sp, #0]
@   0x08008896: 3002        adds	r0, #2
@   0x08008898: 9001        str	r0, [sp, #4]
@   0x0800889a: a805        add	r0, sp, #20
@   0x0800889c: 9002        str	r0, [sp, #8]
@   0x0800889e: 3002        adds	r0, #2
@   0x080088a0: 9003        str	r0, [sp, #12]
@   0x080088a2: 2000        movs	r0, #0
@   0x080088a4: e00c        b.n	0x88c0
@   0x080088a6: 060b        lsls	r3, r1, #24
@   0x080088a8: 161b        asrs	r3, r3, #24
@   0x080088aa: 0612        lsls	r2, r2, #24
@   0x080088ac: 1612        asrs	r2, r2, #24
@   0x080088ae: a804        add	r0, sp, #16
@   0x080088b0: 9000        str	r0, [sp, #0]
@   0x080088b2: 3002        adds	r0, #2
@   0x080088b4: 9001        str	r0, [sp, #4]
@   0x080088b6: a805        add	r0, sp, #20
@   0x080088b8: 9002        str	r0, [sp, #8]
@   0x080088ba: 3002        adds	r0, #2
@   0x080088bc: 9003        str	r0, [sp, #12]
@   0x080088be: 2001        movs	r0, #1
@   0x080088c0: 1c19        adds	r1, r3, #0
@   0x080088c2: f000        f86f 	bl	0x89a4
@   0x080088c6: e026        b.n	0x8916
@   0x080088c8: 0612        lsls	r2, r2, #24
@   0x080088ca: 1612        asrs	r2, r2, #24
@   0x080088cc: 060b        lsls	r3, r1, #24
@   0x080088ce: 161b        asrs	r3, r3, #24
@   0x080088d0: a804        add	r0, sp, #16
@   0x080088d2: 9000        str	r0, [sp, #0]
@   0x080088d4: 3002        adds	r0, #2
@   0x080088d6: 9001        str	r0, [sp, #4]
@   0x080088d8: a805        add	r0, sp, #20
@   0x080088da: 9002        str	r0, [sp, #8]
@   0x080088dc: 3002        adds	r0, #2
@   0x080088de: 9003        str	r0, [sp, #12]
@   0x080088e0: 2002        movs	r0, #2
@   0x080088e2: 1c11        adds	r1, r2, #0
@   0x080088e4: f000        f85e 	bl	0x89a4
@   0x080088e8: e015        b.n	0x8916
@   0x080088ea: 2080        movs	r0, #128	@ 0x80
@   0x080088ec: 4328        orrs	r0, r5
@   0x080088ee: 4338        orrs	r0, r7
@   0x080088f0: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x080088f2: 2001        movs	r0, #1
@   0x080088f4: e04c        b.n	0x8990
@   0x080088f6: 0612        lsls	r2, r2, #24
@   0x080088f8: 1612        asrs	r2, r2, #24
@   0x080088fa: 060b        lsls	r3, r1, #24
@   0x080088fc: 161b        asrs	r3, r3, #24
@   0x080088fe: a804        add	r0, sp, #16
@   0x08008900: 9000        str	r0, [sp, #0]
@   0x08008902: 3002        adds	r0, #2
@   0x08008904: 9001        str	r0, [sp, #4]
@   0x08008906: a805        add	r0, sp, #20
@   0x08008908: 9002        str	r0, [sp, #8]
@   0x0800890a: 3002        adds	r0, #2
@   0x0800890c: 9003        str	r0, [sp, #12]
@   0x0800890e: 2003        movs	r0, #3
@   0x08008910: 1c11        adds	r1, r2, #0
@   0x08008912: f000        f847 	bl	0x89a4
@   0x08008916: 2400        movs	r4, #0
@   0x08008918: 481f        ldr	r0, [pc, #124]	@ (0x8998)
@   0x0800891a: 3031        adds	r0, #49	@ 0x31
@   0x0800891c: 7800        ldrb	r0, [r0, #0]
@   0x0800891e: 4284        cmp	r4, r0
@   0x08008920: da35        bge.n	0x898e
@   0x08008922: 1c06        adds	r6, r0, #0
@   0x08008924: 491d        ldr	r1, [pc, #116]	@ (0x899c)
@   0x08008926: 00e0        lsls	r0, r4, #3
@   0x08008928: 1840        adds	r0, r0, r1
@   0x0800892a: 7801        ldrb	r1, [r0, #0]
@   0x0800892c: 2900        cmp	r1, #0
@   0x0800892e: d02b        beq.n	0x8988
@   0x08008930: 4b1b        ldr	r3, [pc, #108]	@ (0x89a0)
@   0x08008932: 00c8        lsls	r0, r1, #3
@   0x08008934: 1a40        subs	r0, r0, r1
@   0x08008936: 00c0        lsls	r0, r0, #3
@   0x08008938: 18c2        adds	r2, r0, r3
@   0x0800893a: 8e95        ldrh	r5, [r2, #52]	@ 0x34
@   0x0800893c: 2704        movs	r7, #4
@   0x0800893e: 2004        movs	r0, #4
@   0x08008940: 4028        ands	r0, r5
@   0x08008942: 2800        cmp	r0, #0
@   0x08008944: d120        bne.n	0x8988
@   0x08008946: 799b        ldrb	r3, [r3, #6]
@   0x08008948: 7990        ldrb	r0, [r2, #6]
@   0x0800894a: 4283        cmp	r3, r0
@   0x0800894c: d11c        bne.n	0x8988
@   0x0800894e: a805        add	r0, sp, #20
@   0x08008950: 2302        movs	r3, #2
@   0x08008952: 5ed1        ldrsh	r1, [r2, r3]
@   0x08008954: 2300        movs	r3, #0
@   0x08008956: 5ec0        ldrsh	r0, [r0, r3]
@   0x08008958: 4281        cmp	r1, r0
@   0x0800895a: dd15        ble.n	0x8988
@   0x0800895c: 4668        mov	r0, sp
@   0x0800895e: 3016        adds	r0, #22
@   0x08008960: 2300        movs	r3, #0
@   0x08008962: 5ec0        ldrsh	r0, [r0, r3]
@   0x08008964: 4281        cmp	r1, r0
@   0x08008966: da0f        bge.n	0x8988
@   0x08008968: a804        add	r0, sp, #16
@   0x0800896a: 2304        movs	r3, #4
@   0x0800896c: 5ed1        ldrsh	r1, [r2, r3]
@   0x0800896e: 2300        movs	r3, #0
@   0x08008970: 5ec0        ldrsh	r0, [r0, r3]
@   0x08008972: 4281        cmp	r1, r0
@   0x08008974: dd08        ble.n	0x8988
@   0x08008976: 4668        mov	r0, sp
@   0x08008978: 3012        adds	r0, #18
@   0x0800897a: 2300        movs	r3, #0
@   0x0800897c: 5ec0        ldrsh	r0, [r0, r3]
@   0x0800897e: 4281        cmp	r1, r0
@   0x08008980: da02        bge.n	0x8988
@   0x08008982: 7810        ldrb	r0, [r2, #0]
@   0x08008984: 280b        cmp	r0, #11
@   0x08008986: d0b0        beq.n	0x88ea
@   0x08008988: 3401        adds	r4, #1
@   0x0800898a: 42b4        cmp	r4, r6
@   0x0800898c: dbca        blt.n	0x8924
@   0x0800898e: 2000        movs	r0, #0
@   0x08008990: b006        add	sp, #24
@   0x08008992: bcf0        pop	{r4, r5, r6, r7}
@   0x08008994: bc02        pop	{r1}
@   0x08008996: 4708        bx	r1
@   0x08008998: 6110        str	r0, [r2, #16]
@   0x0800899a: 0300        lsls	r0, r0, #12
@   0x0800899c: 6160        str	r0, [r4, #20]
@   0x0800899e: 0300        lsls	r0, r0, #12
@   0x080089a0: 3720        adds	r7, #32
@   0x080089a2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800885C
sub_0800885C: @ 0x0800885c
        .incbin "frog_us_baserom.gba", 0x885c, 0x148
        thumb_func_end sub_0800885C
