@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08005404, 0x080054a8)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8005404 --end 0x80054a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08005404: b530        push	{r4, r5, lr}
@   0x08005406: 1c05        adds	r5, r0, #0
@   0x08005408: f005        feb6 	bl	0xb178
@   0x0800540c: 4c21        ldr	r4, [pc, #132]	@ (0x5494)
@   0x0800540e: 1c20        adds	r0, r4, #0
@   0x08005410: 2105        movs	r1, #5
@   0x08005412: 2204        movs	r2, #4
@   0x08005414: f001        f9c2 	bl	0x679c
@   0x08005418: 0600        lsls	r0, r0, #24
@   0x0800541a: 2800        cmp	r0, #0
@   0x0800541c: d021        beq.n	0x5462
@   0x0800541e: 1c20        adds	r0, r4, #0
@   0x08005420: 302b        adds	r0, #43	@ 0x2b
@   0x08005422: 7802        ldrb	r2, [r0, #0]
@   0x08005424: 1c20        adds	r0, r4, #0
@   0x08005426: 2105        movs	r1, #5
@   0x08005428: f001        f9b8 	bl	0x679c
@   0x0800542c: 0600        lsls	r0, r0, #24
@   0x0800542e: 2800        cmp	r0, #0
@   0x08005430: d117        bne.n	0x5462
@   0x08005432: 4819        ldr	r0, [pc, #100]	@ (0x5498)
@   0x08005434: 4a19        ldr	r2, [pc, #100]	@ (0x549c)
@   0x08005436: 491a        ldr	r1, [pc, #104]	@ (0x54a0)
@   0x08005438: 1854        adds	r4, r2, r1
@   0x0800543a: 6803        ldr	r3, [r0, #0]
@   0x0800543c: 6820        ldr	r0, [r4, #0]
@   0x0800543e: 1a18        subs	r0, r3, r0
@   0x08005440: 28b4        cmp	r0, #180	@ 0xb4
@   0x08005442: d90e        bls.n	0x5462
@   0x08005444: 20b7        movs	r0, #183	@ 0xb7
@   0x08005446: 0100        lsls	r0, r0, #4
@   0x08005448: 1812        adds	r2, r2, r0
@   0x0800544a: 8810        ldrh	r0, [r2, #0]
@   0x0800544c: 3001        adds	r0, #1
@   0x0800544e: 8010        strh	r0, [r2, #0]
@   0x08005450: 2000        movs	r0, #0
@   0x08005452: 5e11        ldrsh	r1, [r2, r0]
@   0x08005454: 0fc8        lsrs	r0, r1, #31
@   0x08005456: 1808        adds	r0, r1, r0
@   0x08005458: 1040        asrs	r0, r0, #1
@   0x0800545a: 0040        lsls	r0, r0, #1
@   0x0800545c: 1a09        subs	r1, r1, r0
@   0x0800545e: 8011        strh	r1, [r2, #0]
@   0x08005460: 6023        str	r3, [r4, #0]
@   0x08005462: 4b10        ldr	r3, [pc, #64]	@ (0x54a4)
@   0x08005464: 2010        movs	r0, #16
@   0x08005466: 8a19        ldrh	r1, [r3, #16]
@   0x08005468: 4008        ands	r0, r1
@   0x0800546a: 2800        cmp	r0, #0
@   0x0800546c: d00e        beq.n	0x548c
@   0x0800546e: 7e18        ldrb	r0, [r3, #24]
@   0x08005470: 7e59        ldrb	r1, [r3, #25]
@   0x08005472: 2408        movs	r4, #8
@   0x08005474: 5f1a        ldrsh	r2, [r3, r4]
@   0x08005476: 240a        movs	r4, #10
@   0x08005478: 5f1b        ldrsh	r3, [r3, r4]
@   0x0800547a: f007        fc85 	bl	0xcd88
@   0x0800547e: 0600        lsls	r0, r0, #24
@   0x08005480: 0e00        lsrs	r0, r0, #24
@   0x08005482: f005        fcdb 	bl	0xae3c
@   0x08005486: 1c28        adds	r0, r5, #0
@   0x08005488: f005        fdf8 	bl	0xb07c
@   0x0800548c: bc30        pop	{r4, r5}
@   0x0800548e: bc01        pop	{r0}
@   0x08005490: 4700        bx	r0
@   0x08005492: 0000        movs	r0, r0
@   0x08005494: 6110        str	r0, [r2, #16]
@   0x08005496: 0300        lsls	r0, r0, #12
@   0x08005498: 5330        strh	r0, [r6, r4]
@   0x0800549a: 0300        lsls	r0, r0, #12
@   0x0800549c: 3720        adds	r7, #32
@   0x0800549e: 0300        lsls	r0, r0, #12
@   0x080054a0: 0b8c        lsrs	r4, r1, #14
@   0x080054a2: 0000        movs	r0, r0
@   0x080054a4: 35e0        adds	r5, #224	@ 0xe0
@   0x080054a6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08005404
sub_08005404: @ 0x08005404
        .incbin "frog_us_baserom.gba", 0x5404, 0xa4
        thumb_func_end sub_08005404
