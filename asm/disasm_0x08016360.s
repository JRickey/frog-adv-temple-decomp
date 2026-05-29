@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08016360, 0x08016404)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8016360 --end 0x8016404 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08016360: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08016362: b081        sub	sp, #4
@   0x08016364: 1c07        adds	r7, r0, #0
@   0x08016366: 0609        lsls	r1, r1, #24
@   0x08016368: 0e0d        lsrs	r5, r1, #24
@   0x0801636a: 4668        mov	r0, sp
@   0x0801636c: 2300        movs	r3, #0
@   0x0801636e: 8003        strh	r3, [r0, #0]
@   0x08016370: 481c        ldr	r0, [pc, #112]	@ (0x163e4)
@   0x08016372: 4669        mov	r1, sp
@   0x08016374: 6001        str	r1, [r0, #0]
@   0x08016376: 491c        ldr	r1, [pc, #112]	@ (0x163e8)
@   0x08016378: 6041        str	r1, [r0, #4]
@   0x0801637a: 4a1c        ldr	r2, [pc, #112]	@ (0x163ec)
@   0x0801637c: 6082        str	r2, [r0, #8]
@   0x0801637e: 6881        ldr	r1, [r0, #8]
@   0x08016380: 4669        mov	r1, sp
@   0x08016382: 800b        strh	r3, [r1, #0]
@   0x08016384: 6001        str	r1, [r0, #0]
@   0x08016386: 491a        ldr	r1, [pc, #104]	@ (0x163f0)
@   0x08016388: 6041        str	r1, [r0, #4]
@   0x0801638a: 6082        str	r2, [r0, #8]
@   0x0801638c: 6880        ldr	r0, [r0, #8]
@   0x0801638e: 2300        movs	r3, #0
@   0x08016390: 4a18        ldr	r2, [pc, #96]	@ (0x163f4)
@   0x08016392: 4694        mov	ip, r2
@   0x08016394: 42ab        cmp	r3, r5
@   0x08016396: d212        bcs.n	0x163be
@   0x08016398: 4e17        ldr	r6, [pc, #92]	@ (0x163f8)
@   0x0801639a: 2400        movs	r4, #0
@   0x0801639c: 011a        lsls	r2, r3, #4
@   0x0801639e: 1992        adds	r2, r2, r6
@   0x080163a0: 00d9        lsls	r1, r3, #3
@   0x080163a2: 19c9        adds	r1, r1, r7
@   0x080163a4: 7908        ldrb	r0, [r1, #4]
@   0x080163a6: 7110        strb	r0, [r2, #4]
@   0x080163a8: 7948        ldrb	r0, [r1, #5]
@   0x080163aa: 7150        strb	r0, [r2, #5]
@   0x080163ac: 7988        ldrb	r0, [r1, #6]
@   0x080163ae: 7310        strb	r0, [r2, #12]
@   0x080163b0: 8014        strh	r4, [r2, #0]
@   0x080163b2: 8054        strh	r4, [r2, #2]
@   0x080163b4: 1c58        adds	r0, r3, #1
@   0x080163b6: 0600        lsls	r0, r0, #24
@   0x080163b8: 0e03        lsrs	r3, r0, #24
@   0x080163ba: 42ab        cmp	r3, r5
@   0x080163bc: d3ee        bcc.n	0x1639c
@   0x080163be: 2100        movs	r1, #0
@   0x080163c0: 2001        movs	r0, #1
@   0x080163c2: 4662        mov	r2, ip
@   0x080163c4: 7110        strb	r0, [r2, #4]
@   0x080163c6: 7151        strb	r1, [r2, #5]
@   0x080163c8: 4a0c        ldr	r2, [pc, #48]	@ (0x163fc)
@   0x080163ca: 8810        ldrh	r0, [r2, #0]
@   0x080163cc: 2103        movs	r1, #3
@   0x080163ce: 4308        orrs	r0, r1
@   0x080163d0: 8010        strh	r0, [r2, #0]
@   0x080163d2: 4a0b        ldr	r2, [pc, #44]	@ (0x16400)
@   0x080163d4: 8810        ldrh	r0, [r2, #0]
@   0x080163d6: 2118        movs	r1, #24
@   0x080163d8: 4308        orrs	r0, r1
@   0x080163da: 8010        strh	r0, [r2, #0]
@   0x080163dc: b001        add	sp, #4
@   0x080163de: bcf0        pop	{r4, r5, r6, r7}
@   0x080163e0: bc01        pop	{r0}
@   0x080163e2: 4700        bx	r0
@   0x080163e4: 00d4        lsls	r4, r2, #3
@   0x080163e6: 0400        lsls	r0, r0, #16
@   0x080163e8: 53a0        strh	r0, [r4, r6]
@   0x080163ea: 0300        lsls	r0, r0, #12
@   0x080163ec: 0080        lsls	r0, r0, #2
@   0x080163ee: 8100        strh	r0, [r0, #8]
@   0x080163f0: 3610        adds	r6, #16
@   0x080163f2: 0300        lsls	r0, r0, #12
@   0x080163f4: 3608        adds	r6, #8
@   0x080163f6: 0300        lsls	r0, r0, #12
@   0x080163f8: 6360        str	r0, [r4, #52]	@ 0x34
@   0x080163fa: 0300        lsls	r0, r0, #12
@   0x080163fc: 0200        lsls	r0, r0, #8
@   0x080163fe: 0400        lsls	r0, r0, #16
@   0x08016400: 0004        movs	r4, r0
@   0x08016402: 0400        lsls	r0, r0, #16

        thumb_func_start sub_08016360
sub_08016360: @ 0x08016360
        .incbin "frog_us_baserom.gba", 0x16360, 0xa4
        thumb_func_end sub_08016360
