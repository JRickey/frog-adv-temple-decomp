@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003604, 0x08003668)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003604 --end 0x8003668 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003604: b530        push	{r4, r5, lr}
@   0x08003606: 4914        ldr	r1, [pc, #80]	@ (0x3658)
@   0x08003608: 2004        movs	r0, #4
@   0x0800360a: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800360c: 4008        ands	r0, r1
@   0x0800360e: 2800        cmp	r0, #0
@   0x08003610: d11e        bne.n	0x3650
@   0x08003612: 4812        ldr	r0, [pc, #72]	@ (0x365c)
@   0x08003614: 6900        ldr	r0, [r0, #16]
@   0x08003616: 2802        cmp	r0, #2
@   0x08003618: d11a        bne.n	0x3650
@   0x0800361a: 4c11        ldr	r4, [pc, #68]	@ (0x3660)
@   0x0800361c: 7e20        ldrb	r0, [r4, #24]
@   0x0800361e: 7e61        ldrb	r1, [r4, #25]
@   0x08003620: 2308        movs	r3, #8
@   0x08003622: 5ee2        ldrsh	r2, [r4, r3]
@   0x08003624: 250a        movs	r5, #10
@   0x08003626: 5f63        ldrsh	r3, [r4, r5]
@   0x08003628: f009        fbae 	bl	0xcd88
@   0x0800362c: 0600        lsls	r0, r0, #24
@   0x0800362e: 0e02        lsrs	r2, r0, #24
@   0x08003630: 490c        ldr	r1, [pc, #48]	@ (0x3664)
@   0x08003632: 2001        movs	r0, #1
@   0x08003634: 7c09        ldrb	r1, [r1, #16]
@   0x08003636: 4008        ands	r0, r1
@   0x08003638: 2800        cmp	r0, #0
@   0x0800363a: d109        bne.n	0x3650
@   0x0800363c: 2a02        cmp	r2, #2
@   0x0800363e: d107        bne.n	0x3650
@   0x08003640: 2180        movs	r1, #128	@ 0x80
@   0x08003642: 00c9        lsls	r1, r1, #3
@   0x08003644: 1c20        adds	r0, r4, #0
@   0x08003646: f003        fa9f 	bl	0x6b88
@   0x0800364a: 205d        movs	r0, #93	@ 0x5d
@   0x0800364c: f01d        fb14 	bl	0x20c78
@   0x08003650: bc30        pop	{r4, r5}
@   0x08003652: bc01        pop	{r0}
@   0x08003654: 4700        bx	r0
@   0x08003656: 0000        movs	r0, r0
@   0x08003658: 3720        adds	r7, #32
@   0x0800365a: 0300        lsls	r0, r0, #12
@   0x0800365c: 6110        str	r0, [r2, #16]
@   0x0800365e: 0300        lsls	r0, r0, #12
@   0x08003660: 35e0        adds	r5, #224	@ 0xe0
@   0x08003662: 0300        lsls	r0, r0, #12
@   0x08003664: 5330        strh	r0, [r6, r4]
@   0x08003666: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003604
sub_08003604: @ 0x08003604
        .incbin "frog_us_baserom.gba", 0x3604, 0x64
        thumb_func_end sub_08003604
