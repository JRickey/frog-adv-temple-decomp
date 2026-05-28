@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a894, 0x0801a980)  (236 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a894 --end 0x801a980 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a894: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801a896: 4657        mov	r7, sl
@   0x0801a898: 464e        mov	r6, r9
@   0x0801a89a: 4645        mov	r5, r8
@   0x0801a89c: b4e0        push	{r5, r6, r7}
@   0x0801a89e: b081        sub	sp, #4
@   0x0801a8a0: 0600        lsls	r0, r0, #24
@   0x0801a8a2: 0e00        lsrs	r0, r0, #24
@   0x0801a8a4: 1c05        adds	r5, r0, #0
@   0x0801a8a6: 0609        lsls	r1, r1, #24
@   0x0801a8a8: 0e0c        lsrs	r4, r1, #24
@   0x0801a8aa: 2038        movs	r0, #56	@ 0x38
@   0x0801a8ac: 1c21        adds	r1, r4, #0
@   0x0801a8ae: f019        fa31 	bl	0x33d14
@   0x0801a8b2: 0600        lsls	r0, r0, #24
@   0x0801a8b4: 0e06        lsrs	r6, r0, #24
@   0x0801a8b6: 46b2        mov	sl, r6
@   0x0801a8b8: 23a0        movs	r3, #160	@ 0xa0
@   0x0801a8ba: 2700        movs	r7, #0
@   0x0801a8bc: 2001        movs	r0, #1
@   0x0801a8be: 4028        ands	r0, r5
@   0x0801a8c0: 2800        cmp	r0, #0
@   0x0801a8c2: d008        beq.n	0x1a8d6
@   0x0801a8c4: 2080        movs	r0, #128	@ 0x80
@   0x0801a8c6: 04c0        lsls	r0, r0, #19
@   0x0801a8c8: 8801        ldrh	r1, [r0, #0]
@   0x0801a8ca: 2280        movs	r2, #128	@ 0x80
@   0x0801a8cc: 0192        lsls	r2, r2, #6
@   0x0801a8ce: 4690        mov	r8, r2
@   0x0801a8d0: 4642        mov	r2, r8
@   0x0801a8d2: 4311        orrs	r1, r2
@   0x0801a8d4: 8001        strh	r1, [r0, #0]
@   0x0801a8d6: 2002        movs	r0, #2
@   0x0801a8d8: 4028        ands	r0, r5
@   0x0801a8da: 2800        cmp	r0, #0
@   0x0801a8dc: d007        beq.n	0x1a8ee
@   0x0801a8de: 2080        movs	r0, #128	@ 0x80
@   0x0801a8e0: 04c0        lsls	r0, r0, #19
@   0x0801a8e2: 8801        ldrh	r1, [r0, #0]
@   0x0801a8e4: 2580        movs	r5, #128	@ 0x80
@   0x0801a8e6: 01ed        lsls	r5, r5, #7
@   0x0801a8e8: 1c2a        adds	r2, r5, #0
@   0x0801a8ea: 4311        orrs	r1, r2
@   0x0801a8ec: 8001        strh	r1, [r0, #0]
@   0x0801a8ee: 1c60        adds	r0, r4, #1
@   0x0801a8f0: 0600        lsls	r0, r0, #24
@   0x0801a8f2: 0e04        lsrs	r4, r0, #24
@   0x0801a8f4: 2c00        cmp	r4, #0
@   0x0801a8f6: d01f        beq.n	0x1a938
@   0x0801a8f8: 481d        ldr	r0, [pc, #116]	@ (0x1a970)
@   0x0801a8fa: 4681        mov	r9, r0
@   0x0801a8fc: 25f0        movs	r5, #240	@ 0xf0
@   0x0801a8fe: 491d        ldr	r1, [pc, #116]	@ (0x1a974)
@   0x0801a900: 4688        mov	r8, r1
@   0x0801a902: 464a        mov	r2, r9
@   0x0801a904: 8015        strh	r5, [r2, #0]
@   0x0801a906: 0218        lsls	r0, r3, #8
@   0x0801a908: 21a0        movs	r1, #160	@ 0xa0
@   0x0801a90a: 4308        orrs	r0, r1
@   0x0801a90c: 4641        mov	r1, r8
@   0x0801a90e: 8008        strh	r0, [r1, #0]
@   0x0801a910: 4819        ldr	r0, [pc, #100]	@ (0x1a978)
@   0x0801a912: 8005        strh	r5, [r0, #0]
@   0x0801a914: 3004        adds	r0, #4
@   0x0801a916: 8007        strh	r7, [r0, #0]
@   0x0801a918: 9300        str	r3, [sp, #0]
@   0x0801a91a: f7e5        ffdf 	bl	0x8dc
@   0x0801a91e: 9b00        ldr	r3, [sp, #0]
@   0x0801a920: 1b98        subs	r0, r3, r6
@   0x0801a922: 0600        lsls	r0, r0, #24
@   0x0801a924: 0e03        lsrs	r3, r0, #24
@   0x0801a926: 4652        mov	r2, sl
@   0x0801a928: 18b8        adds	r0, r7, r2
@   0x0801a92a: 0600        lsls	r0, r0, #24
@   0x0801a92c: 0e07        lsrs	r7, r0, #24
@   0x0801a92e: 1e60        subs	r0, r4, #1
@   0x0801a930: 0600        lsls	r0, r0, #24
@   0x0801a932: 0e04        lsrs	r4, r0, #24
@   0x0801a934: 2c00        cmp	r4, #0
@   0x0801a936: d1e4        bne.n	0x1a902
@   0x0801a938: 480d        ldr	r0, [pc, #52]	@ (0x1a970)
@   0x0801a93a: 22f0        movs	r2, #240	@ 0xf0
@   0x0801a93c: 8002        strh	r2, [r0, #0]
@   0x0801a93e: 490d        ldr	r1, [pc, #52]	@ (0x1a974)
@   0x0801a940: 4b0e        ldr	r3, [pc, #56]	@ (0x1a97c)
@   0x0801a942: 1c18        adds	r0, r3, #0
@   0x0801a944: 8008        strh	r0, [r1, #0]
@   0x0801a946: 480c        ldr	r0, [pc, #48]	@ (0x1a978)
@   0x0801a948: 8002        strh	r2, [r0, #0]
@   0x0801a94a: 3102        adds	r1, #2
@   0x0801a94c: 2030        movs	r0, #48	@ 0x30
@   0x0801a94e: 8008        strh	r0, [r1, #0]
@   0x0801a950: 2280        movs	r2, #128	@ 0x80
@   0x0801a952: 04d2        lsls	r2, r2, #19
@   0x0801a954: 8810        ldrh	r0, [r2, #0]
@   0x0801a956: 2580        movs	r5, #128	@ 0x80
@   0x0801a958: 012d        lsls	r5, r5, #4
@   0x0801a95a: 1c29        adds	r1, r5, #0
@   0x0801a95c: 4308        orrs	r0, r1
@   0x0801a95e: 8010        strh	r0, [r2, #0]
@   0x0801a960: b001        add	sp, #4
@   0x0801a962: bc38        pop	{r3, r4, r5}
@   0x0801a964: 4698        mov	r8, r3
@   0x0801a966: 46a1        mov	r9, r4
@   0x0801a968: 46aa        mov	sl, r5
@   0x0801a96a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801a96c: bc01        pop	{r0}
@   0x0801a96e: 4700        bx	r0
@   0x0801a970: 0040        lsls	r0, r0, #1
@   0x0801a972: 0400        lsls	r0, r0, #16
@   0x0801a974: 0044        lsls	r4, r0, #1
@   0x0801a976: 0400        lsls	r0, r0, #16
@   0x0801a978: 0042        lsls	r2, r0, #1
@   0x0801a97a: 0400        lsls	r0, r0, #16
@   0x0801a97c: 70a0        strb	r0, [r4, #2]

        thumb_func_start sub_0801A894
sub_0801A894: @ 0x0801a894
        .incbin "frog_us_baserom.gba", 0x1a894, 0xec
        thumb_func_end sub_0801A894
