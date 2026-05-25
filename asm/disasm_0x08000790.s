@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000790, 0x08000820)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000790 --end 0x8000820 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000790: b500        push	{lr}
@   0x08000792: f035        faf3 	bl	0x35d7c
@   0x08000796: 491c        ldr	r1, [pc, #112]	@ (0x808)
@   0x08000798: 2001        movs	r0, #1
@   0x0800079a: 7e0a        ldrb	r2, [r1, #24]
@   0x0800079c: 4010        ands	r0, r2
@   0x0800079e: 2800        cmp	r0, #0
@   0x080007a0: d102        bne.n	0x7a8
@   0x080007a2: 6808        ldr	r0, [r1, #0]
@   0x080007a4: 3001        adds	r0, #1
@   0x080007a6: 6008        str	r0, [r1, #0]
@   0x080007a8: 6848        ldr	r0, [r1, #4]
@   0x080007aa: 3001        adds	r0, #1
@   0x080007ac: 6048        str	r0, [r1, #4]
@   0x080007ae: 7a49        ldrb	r1, [r1, #9]
@   0x080007b0: 1c08        adds	r0, r1, #0
@   0x080007b2: 3808        subs	r0, #8
@   0x080007b4: 0600        lsls	r0, r0, #24
@   0x080007b6: 0e00        lsrs	r0, r0, #24
@   0x080007b8: 280f        cmp	r0, #15
@   0x080007ba: d91b        bls.n	0x7f4
@   0x080007bc: 291d        cmp	r1, #29
@   0x080007be: d019        beq.n	0x7f4
@   0x080007c0: 4812        ldr	r0, [pc, #72]	@ (0x80c)
@   0x080007c2: 21e0        movs	r1, #224	@ 0xe0
@   0x080007c4: 04c9        lsls	r1, r1, #19
@   0x080007c6: 2280        movs	r2, #128	@ 0x80
@   0x080007c8: 0052        lsls	r2, r2, #1
@   0x080007ca: f02c        fec5 	bl	0x2d558
@   0x080007ce: 4910        ldr	r1, [pc, #64]	@ (0x810)
@   0x080007d0: 4a10        ldr	r2, [pc, #64]	@ (0x814)
@   0x080007d2: 8810        ldrh	r0, [r2, #0]
@   0x080007d4: 8008        strh	r0, [r1, #0]
@   0x080007d6: 3102        adds	r1, #2
@   0x080007d8: 8850        ldrh	r0, [r2, #2]
@   0x080007da: 8008        strh	r0, [r1, #0]
@   0x080007dc: 3102        adds	r1, #2
@   0x080007de: 8890        ldrh	r0, [r2, #4]
@   0x080007e0: 8008        strh	r0, [r1, #0]
@   0x080007e2: 3102        adds	r1, #2
@   0x080007e4: 88d0        ldrh	r0, [r2, #6]
@   0x080007e6: 8008        strh	r0, [r1, #0]
@   0x080007e8: 3102        adds	r1, #2
@   0x080007ea: 8910        ldrh	r0, [r2, #8]
@   0x080007ec: 8008        strh	r0, [r1, #0]
@   0x080007ee: 3102        adds	r1, #2
@   0x080007f0: 8950        ldrh	r0, [r2, #10]
@   0x080007f2: 8008        strh	r0, [r1, #0]
@   0x080007f4: f02e        fe5c 	bl	0x2f4b0
@   0x080007f8: 4807        ldr	r0, [pc, #28]	@ (0x818)
@   0x080007fa: 2101        movs	r1, #1
@   0x080007fc: 8001        strh	r1, [r0, #0]
@   0x080007fe: 4807        ldr	r0, [pc, #28]	@ (0x81c)
@   0x08000800: 8001        strh	r1, [r0, #0]
@   0x08000802: bc01        pop	{r0}
@   0x08000804: 4700        bx	r0
@   0x08000806: 0000        movs	r0, r0
@   0x08000808: 5330        strh	r0, [r6, r4]
@   0x0800080a: 0300        lsls	r0, r0, #12
@   0x0800080c: 54a0        strb	r0, [r4, r2]
@   0x0800080e: 0300        lsls	r0, r0, #12
@   0x08000810: 0010        movs	r0, r2
@   0x08000812: 0400        lsls	r0, r0, #16
@   0x08000814: 3550        adds	r5, #80	@ 0x50
@   0x08000816: 0300        lsls	r0, r0, #12
@   0x08000818: 0202        lsls	r2, r0, #8
@   0x0800081a: 0400        lsls	r0, r0, #16
@   0x0800081c: 6148        str	r0, [r1, #20]
@   0x0800081e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08000790
sub_08000790: @ 0x08000790
        .incbin "frog_us_baserom.gba", 0x790, 0x90
        thumb_func_end sub_08000790
