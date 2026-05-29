@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080005d8, 0x08000678)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80005d8 --end 0x8000678 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080005d8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080005da: 4814        ldr	r0, [pc, #80]	@ (0x62c)
@   0x080005dc: 8800        ldrh	r0, [r0, #0]
@   0x080005de: 43c0        mvns	r0, r0
@   0x080005e0: 0400        lsls	r0, r0, #16
@   0x080005e2: 0c06        lsrs	r6, r0, #16
@   0x080005e4: 2400        movs	r4, #0
@   0x080005e6: 4812        ldr	r0, [pc, #72]	@ (0x630)
@   0x080005e8: 4912        ldr	r1, [pc, #72]	@ (0x634)
@   0x080005ea: 880b        ldrh	r3, [r1, #0]
@   0x080005ec: 1c32        adds	r2, r6, #0
@   0x080005ee: 439a        bics	r2, r3
@   0x080005f0: 8002        strh	r2, [r0, #0]
@   0x080005f2: 2501        movs	r5, #1
@   0x080005f4: 1c28        adds	r0, r5, #0
@   0x080005f6: 4018        ands	r0, r3
@   0x080005f8: 1c0f        adds	r7, r1, #0
@   0x080005fa: 2800        cmp	r0, #0
@   0x080005fc: d106        bne.n	0x60c
@   0x080005fe: 1c10        adds	r0, r2, #0
@   0x08000600: 4028        ands	r0, r5
@   0x08000602: 4241        negs	r1, r0
@   0x08000604: 4301        orrs	r1, r0
@   0x08000606: 17cc        asrs	r4, r1, #31
@   0x08000608: 2010        movs	r0, #16
@   0x0800060a: 4004        ands	r4, r0
@   0x0800060c: 2102        movs	r1, #2
@   0x0800060e: 1c08        adds	r0, r1, #0
@   0x08000610: 4018        ands	r0, r3
@   0x08000612: 2800        cmp	r0, #0
@   0x08000614: d103        bne.n	0x61e
@   0x08000616: 400a        ands	r2, r1
@   0x08000618: 2a00        cmp	r2, #0
@   0x0800061a: d000        beq.n	0x61e
@   0x0800061c: 2420        movs	r4, #32
@   0x0800061e: 803e        strh	r6, [r7, #0]
@   0x08000620: 4805        ldr	r0, [pc, #20]	@ (0x638)
@   0x08000622: 7a41        ldrb	r1, [r0, #9]
@   0x08000624: 2918        cmp	r1, #24
@   0x08000626: d009        beq.n	0x63c
@   0x08000628: 1c20        adds	r0, r4, #0
@   0x0800062a: e020        b.n	0x66e
@   0x0800062c: 0130        lsls	r0, r6, #4
@   0x0800062e: 0400        lsls	r0, r0, #16
@   0x08000630: 5358        strh	r0, [r3, r5]
@   0x08000632: 0300        lsls	r0, r0, #12
@   0x08000634: 3710        adds	r7, #16
@   0x08000636: 0300        lsls	r0, r0, #12
@   0x08000638: 5330        strh	r0, [r6, r4]
@   0x0800063a: 0300        lsls	r0, r0, #12
@   0x0800063c: 2c00        cmp	r4, #0
@   0x0800063e: d111        bne.n	0x664
@   0x08000640: f000        f95e 	bl	0x900
@   0x08000644: 4c06        ldr	r4, [pc, #24]	@ (0x660)
@   0x08000646: 68a1        ldr	r1, [r4, #8]
@   0x08000648: 1a40        subs	r0, r0, r1
@   0x0800064a: 280a        cmp	r0, #10
@   0x0800064c: d90e        bls.n	0x66c
@   0x0800064e: f000        f957 	bl	0x900
@   0x08000652: 60a0        str	r0, [r4, #8]
@   0x08000654: f017        f9b0 	bl	0x179b8
@   0x08000658: 0400        lsls	r0, r0, #16
@   0x0800065a: 0c00        lsrs	r0, r0, #16
@   0x0800065c: e007        b.n	0x66e
@   0x0800065e: 0000        movs	r0, r0
@   0x08000660: 34c0        adds	r4, #192	@ 0xc0
@   0x08000662: 0300        lsls	r0, r0, #12
@   0x08000664: 2104        movs	r1, #4
@   0x08000666: 7241        strb	r1, [r0, #9]
@   0x08000668: 4802        ldr	r0, [pc, #8]	@ (0x674)
@   0x0800066a: 7001        strb	r1, [r0, #0]
@   0x0800066c: 2000        movs	r0, #0
@   0x0800066e: bcf0        pop	{r4, r5, r6, r7}
@   0x08000670: bc02        pop	{r1}
@   0x08000672: 4708        bx	r1
@   0x08000674: 3480        adds	r4, #128	@ 0x80
@   0x08000676: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080005D8
sub_080005D8: @ 0x080005d8
        .incbin "frog_us_baserom.gba", 0x5d8, 0xa0
        thumb_func_end sub_080005D8
