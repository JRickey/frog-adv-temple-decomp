@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801190c, 0x08011978)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801190c --end 0x8011978 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801190c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801190e: 4647        mov	r7, r8
@   0x08011910: b480        push	{r7}
@   0x08011912: 2000        movs	r0, #0
@   0x08011914: 4680        mov	r8, r0
@   0x08011916: 2718        movs	r7, #24
@   0x08011918: 427f        negs	r7, r7
@   0x0801191a: 2548        movs	r5, #72	@ 0x48
@   0x0801191c: 426d        negs	r5, r5
@   0x0801191e: 1c38        adds	r0, r7, #0
@   0x08011920: 2102        movs	r1, #2
@   0x08011922: 1c2a        adds	r2, r5, #0
@   0x08011924: 2302        movs	r3, #2
@   0x08011926: f001        fe47 	bl	0x135b8
@   0x0801192a: 4a10        ldr	r2, [pc, #64]	@ (0x1196c)
@   0x0801192c: 4e10        ldr	r6, [pc, #64]	@ (0x11970)
@   0x0801192e: 212c        movs	r1, #44	@ 0x2c
@   0x08011930: 5e70        ldrsh	r0, [r6, r1]
@   0x08011932: 68d1        ldr	r1, [r2, #12]
@   0x08011934: 1809        adds	r1, r1, r0
@   0x08011936: 60d1        str	r1, [r2, #12]
@   0x08011938: 4c0e        ldr	r4, [pc, #56]	@ (0x11974)
@   0x0801193a: 202e        movs	r0, #46	@ 0x2e
@   0x0801193c: 5e23        ldrsh	r3, [r4, r0]
@   0x0801193e: 6910        ldr	r0, [r2, #16]
@   0x08011940: 18c0        adds	r0, r0, r3
@   0x08011942: 6110        str	r0, [r2, #16]
@   0x08011944: 62d1        str	r1, [r2, #44]	@ 0x2c
@   0x08011946: 6310        str	r0, [r2, #48]	@ 0x30
@   0x08011948: 2136        movs	r1, #54	@ 0x36
@   0x0801194a: 5e60        ldrsh	r0, [r4, r1]
@   0x0801194c: 42a8        cmp	r0, r5
@   0x0801194e: d101        bne.n	0x11954
@   0x08011950: 2003        movs	r0, #3
@   0x08011952: 7270        strb	r0, [r6, #9]
@   0x08011954: 2134        movs	r1, #52	@ 0x34
@   0x08011956: 5e70        ldrsh	r0, [r6, r1]
@   0x08011958: 42b8        cmp	r0, r7
@   0x0801195a: d101        bne.n	0x11960
@   0x0801195c: 2001        movs	r0, #1
@   0x0801195e: 4680        mov	r8, r0
@   0x08011960: 4640        mov	r0, r8
@   0x08011962: bc08        pop	{r3}
@   0x08011964: 4698        mov	r8, r3
@   0x08011966: bcf0        pop	{r4, r5, r6, r7}
@   0x08011968: bc02        pop	{r1}
@   0x0801196a: 4708        bx	r1
@   0x0801196c: 60a0        str	r0, [r4, #8]
@   0x0801196e: 0300        lsls	r0, r0, #12
@   0x08011970: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08011972: 0300        lsls	r0, r0, #12
@   0x08011974: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08011976: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801190C
sub_0801190C: @ 0x0801190c
        .incbin "frog_us_baserom.gba", 0x1190c, 0x6c
        thumb_func_end sub_0801190C
