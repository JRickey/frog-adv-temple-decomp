@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d8f8, 0x0802d9ec)  (244 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d8f8 --end 0x802d9ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d8f8: b570        push	{r4, r5, r6, lr}
@   0x0802d8fa: 4a26        ldr	r2, [pc, #152]	@ (0x2d994)
@   0x0802d8fc: 6810        ldr	r0, [r2, #0]
@   0x0802d8fe: 218c        movs	r1, #140	@ 0x8c
@   0x0802d900: 0049        lsls	r1, r1, #1
@   0x0802d902: 1840        adds	r0, r0, r1
@   0x0802d904: 6800        ldr	r0, [r0, #0]
@   0x0802d906: 4b24        ldr	r3, [pc, #144]	@ (0x2d998)
@   0x0802d908: 18c1        adds	r1, r0, r3
@   0x0802d90a: 2000        movs	r0, #0
@   0x0802d90c: 7008        strb	r0, [r1, #0]
@   0x0802d90e: 2400        movs	r4, #0
@   0x0802d910: 6810        ldr	r0, [r2, #0]
@   0x0802d912: 7800        ldrb	r0, [r0, #0]
@   0x0802d914: 3004        adds	r0, #4
@   0x0802d916: 4284        cmp	r4, r0
@   0x0802d918: da19        bge.n	0x2d94e
@   0x0802d91a: 1c16        adds	r6, r2, #0
@   0x0802d91c: 2500        movs	r5, #0
@   0x0802d91e: 6832        ldr	r2, [r6, #0]
@   0x0802d920: 218a        movs	r1, #138	@ 0x8a
@   0x0802d922: 0049        lsls	r1, r1, #1
@   0x0802d924: 1850        adds	r0, r2, r1
@   0x0802d926: 6801        ldr	r1, [r0, #0]
@   0x0802d928: 0120        lsls	r0, r4, #4
@   0x0802d92a: 1840        adds	r0, r0, r1
@   0x0802d92c: 6005        str	r5, [r0, #0]
@   0x0802d92e: 2390        movs	r3, #144	@ 0x90
@   0x0802d930: 005b        lsls	r3, r3, #1
@   0x0802d932: 18d0        adds	r0, r2, r3
@   0x0802d934: 6801        ldr	r1, [r0, #0]
@   0x0802d936: 00a0        lsls	r0, r4, #2
@   0x0802d938: 1840        adds	r0, r0, r1
@   0x0802d93a: 6005        str	r5, [r0, #0]
@   0x0802d93c: 1c20        adds	r0, r4, #0
@   0x0802d93e: f000        fef1 	bl	0x2e724
@   0x0802d942: 3401        adds	r4, #1
@   0x0802d944: 6830        ldr	r0, [r6, #0]
@   0x0802d946: 7800        ldrb	r0, [r0, #0]
@   0x0802d948: 3004        adds	r0, #4
@   0x0802d94a: 4284        cmp	r4, r0
@   0x0802d94c: dbe7        blt.n	0x2d91e
@   0x0802d94e: 2400        movs	r4, #0
@   0x0802d950: 4810        ldr	r0, [pc, #64]	@ (0x2d994)
@   0x0802d952: 6801        ldr	r1, [r0, #0]
@   0x0802d954: 1c06        adds	r6, r0, #0
@   0x0802d956: 7809        ldrb	r1, [r1, #0]
@   0x0802d958: 428c        cmp	r4, r1
@   0x0802d95a: da12        bge.n	0x2d982
@   0x0802d95c: 1c35        adds	r5, r6, #0
@   0x0802d95e: 2300        movs	r3, #0
@   0x0802d960: 682a        ldr	r2, [r5, #0]
@   0x0802d962: 1c10        adds	r0, r2, #0
@   0x0802d964: 30cc        adds	r0, #204	@ 0xcc
@   0x0802d966: 6801        ldr	r1, [r0, #0]
@   0x0802d968: 00a0        lsls	r0, r4, #2
@   0x0802d96a: 1840        adds	r0, r0, r1
@   0x0802d96c: 6003        str	r3, [r0, #0]
@   0x0802d96e: 1c10        adds	r0, r2, #0
@   0x0802d970: 30c8        adds	r0, #200	@ 0xc8
@   0x0802d972: 6801        ldr	r1, [r0, #0]
@   0x0802d974: 01a0        lsls	r0, r4, #6
@   0x0802d976: 1840        adds	r0, r0, r1
@   0x0802d978: 6383        str	r3, [r0, #56]	@ 0x38
@   0x0802d97a: 3401        adds	r4, #1
@   0x0802d97c: 7812        ldrb	r2, [r2, #0]
@   0x0802d97e: 4294        cmp	r4, r2
@   0x0802d980: dbee        blt.n	0x2d960
@   0x0802d982: 6831        ldr	r1, [r6, #0]
@   0x0802d984: 2000        movs	r0, #0
@   0x0802d986: 7048        strb	r0, [r1, #1]
@   0x0802d988: f002        fc6c 	bl	0x30264
@   0x0802d98c: bc70        pop	{r4, r5, r6}
@   0x0802d98e: bc01        pop	{r0}
@   0x0802d990: 4700        bx	r0
@   0x0802d992: 0000        movs	r0, r0
@   0x0802d994: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d996: 0300        lsls	r0, r0, #12
@   0x0802d998: 0151        lsls	r1, r2, #5
@   0x0802d99a: 0000        movs	r0, r0
@   0x0802d99c: b510        push	{r4, lr}
@   0x0802d99e: 4c12        ldr	r4, [pc, #72]	@ (0x2d9e8)
@   0x0802d9a0: 6821        ldr	r1, [r4, #0]
@   0x0802d9a2: 31bb        adds	r1, #187	@ 0xbb
@   0x0802d9a4: 7808        ldrb	r0, [r1, #0]
@   0x0802d9a6: 3001        adds	r0, #1
@   0x0802d9a8: 7008        strb	r0, [r1, #0]
@   0x0802d9aa: 0600        lsls	r0, r0, #24
@   0x0802d9ac: 0e00        lsrs	r0, r0, #24
@   0x0802d9ae: 2801        cmp	r0, #1
@   0x0802d9b0: d101        bne.n	0x2d9b6
@   0x0802d9b2: f008        f9eb 	bl	0x35d8c
@   0x0802d9b6: f7ff        ff9f 	bl	0x2d8f8
@   0x0802d9ba: 2200        movs	r2, #0
@   0x0802d9bc: 6821        ldr	r1, [r4, #0]
@   0x0802d9be: 7808        ldrb	r0, [r1, #0]
@   0x0802d9c0: 2800        cmp	r0, #0
@   0x0802d9c2: d00e        beq.n	0x2d9e2
@   0x0802d9c4: 238c        movs	r3, #140	@ 0x8c
@   0x0802d9c6: 005b        lsls	r3, r3, #1
@   0x0802d9c8: 18c8        adds	r0, r1, r3
@   0x0802d9ca: 6800        ldr	r0, [r0, #0]
@   0x0802d9cc: 333a        adds	r3, #58	@ 0x3a
@   0x0802d9ce: 18c0        adds	r0, r0, r3
@   0x0802d9d0: 7803        ldrb	r3, [r0, #0]
@   0x0802d9d2: 429a        cmp	r2, r3
@   0x0802d9d4: d900        bls.n	0x2d9d8
@   0x0802d9d6: 7802        ldrb	r2, [r0, #0]
@   0x0802d9d8: 700a        strb	r2, [r1, #0]
@   0x0802d9da: 2a00        cmp	r2, #0
@   0x0802d9dc: d101        bne.n	0x2d9e2
@   0x0802d9de: f002        fabb 	bl	0x2ff58
@   0x0802d9e2: bc10        pop	{r4}
@   0x0802d9e4: bc01        pop	{r0}
@   0x0802d9e6: 4700        bx	r0
@   0x0802d9e8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d9ea: 0300        lsls	r0, r0, #12
        .thumb
        .thumb_func
        .global sub_0802D99C
        .type   sub_0802D99C, %function
sub_0802D99C: @ 0x0802d99c
        .incbin "frog_us_baserom.gba", 0x2d99c, 0x50
        .size   sub_0802D99C, . - sub_0802D99C
