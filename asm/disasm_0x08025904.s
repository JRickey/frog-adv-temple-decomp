@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025904, 0x080259c4)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025904 --end 0x80259c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025904: b570        push	{r4, r5, r6, lr}
@   0x08025906: 464e        mov	r6, r9
@   0x08025908: 4645        mov	r5, r8
@   0x0802590a: b460        push	{r5, r6}
@   0x0802590c: b084        sub	sp, #16
@   0x0802590e: 482b        ldr	r0, [pc, #172]	@ (0x259bc)
@   0x08025910: 4681        mov	r9, r0
@   0x08025912: 6801        ldr	r1, [r0, #0]
@   0x08025914: 4c2a        ldr	r4, [pc, #168]	@ (0x259c0)
@   0x08025916: 9400        str	r4, [sp, #0]
@   0x08025918: 2009        movs	r0, #9
@   0x0802591a: 4680        mov	r8, r0
@   0x0802591c: 9001        str	r0, [sp, #4]
@   0x0802591e: 2603        movs	r6, #3
@   0x08025920: 9602        str	r6, [sp, #8]
@   0x08025922: 2502        movs	r5, #2
@   0x08025924: 9503        str	r5, [sp, #12]
@   0x08025926: 204a        movs	r0, #74	@ 0x4a
@   0x08025928: 2200        movs	r2, #0
@   0x0802592a: 232d        movs	r3, #45	@ 0x2d
@   0x0802592c: f7fb        fbb8 	bl	0x210a0
@   0x08025930: 4648        mov	r0, r9
@   0x08025932: 6841        ldr	r1, [r0, #4]
@   0x08025934: 9400        str	r4, [sp, #0]
@   0x08025936: 4640        mov	r0, r8
@   0x08025938: 9001        str	r0, [sp, #4]
@   0x0802593a: 9602        str	r6, [sp, #8]
@   0x0802593c: 9503        str	r5, [sp, #12]
@   0x0802593e: 204b        movs	r0, #75	@ 0x4b
@   0x08025940: 2200        movs	r2, #0
@   0x08025942: 232d        movs	r3, #45	@ 0x2d
@   0x08025944: f7fb        fbac 	bl	0x210a0
@   0x08025948: 4648        mov	r0, r9
@   0x0802594a: 6881        ldr	r1, [r0, #8]
@   0x0802594c: 3420        adds	r4, #32
@   0x0802594e: 9400        str	r4, [sp, #0]
@   0x08025950: 4640        mov	r0, r8
@   0x08025952: 9001        str	r0, [sp, #4]
@   0x08025954: 9602        str	r6, [sp, #8]
@   0x08025956: 9503        str	r5, [sp, #12]
@   0x08025958: 204c        movs	r0, #76	@ 0x4c
@   0x0802595a: 2200        movs	r2, #0
@   0x0802595c: 232e        movs	r3, #46	@ 0x2e
@   0x0802595e: f7fb        fb9f 	bl	0x210a0
@   0x08025962: 4648        mov	r0, r9
@   0x08025964: 68c1        ldr	r1, [r0, #12]
@   0x08025966: 9400        str	r4, [sp, #0]
@   0x08025968: 4640        mov	r0, r8
@   0x0802596a: 9001        str	r0, [sp, #4]
@   0x0802596c: 9602        str	r6, [sp, #8]
@   0x0802596e: 9503        str	r5, [sp, #12]
@   0x08025970: 204d        movs	r0, #77	@ 0x4d
@   0x08025972: 2200        movs	r2, #0
@   0x08025974: 232e        movs	r3, #46	@ 0x2e
@   0x08025976: f7fb        fb93 	bl	0x210a0
@   0x0802597a: 4648        mov	r0, r9
@   0x0802597c: 6901        ldr	r1, [r0, #16]
@   0x0802597e: 3420        adds	r4, #32
@   0x08025980: 9400        str	r4, [sp, #0]
@   0x08025982: 4640        mov	r0, r8
@   0x08025984: 9001        str	r0, [sp, #4]
@   0x08025986: 9602        str	r6, [sp, #8]
@   0x08025988: 9503        str	r5, [sp, #12]
@   0x0802598a: 204e        movs	r0, #78	@ 0x4e
@   0x0802598c: 2200        movs	r2, #0
@   0x0802598e: 232c        movs	r3, #44	@ 0x2c
@   0x08025990: f7fb        fb86 	bl	0x210a0
@   0x08025994: 4648        mov	r0, r9
@   0x08025996: 6941        ldr	r1, [r0, #20]
@   0x08025998: 9400        str	r4, [sp, #0]
@   0x0802599a: 4640        mov	r0, r8
@   0x0802599c: 9001        str	r0, [sp, #4]
@   0x0802599e: 9602        str	r6, [sp, #8]
@   0x080259a0: 9503        str	r5, [sp, #12]
@   0x080259a2: 204f        movs	r0, #79	@ 0x4f
@   0x080259a4: 2200        movs	r2, #0
@   0x080259a6: 232c        movs	r3, #44	@ 0x2c
@   0x080259a8: f7fb        fb7a 	bl	0x210a0
@   0x080259ac: b004        add	sp, #16
@   0x080259ae: bc18        pop	{r3, r4}
@   0x080259b0: 4698        mov	r8, r3
@   0x080259b2: 46a1        mov	r9, r4
@   0x080259b4: bc70        pop	{r4, r5, r6}
@   0x080259b6: bc01        pop	{r0}
@   0x080259b8: 4700        bx	r0
@   0x080259ba: 0000        movs	r0, r0
@   0x080259bc: 4b08        ldr	r3, [pc, #32]	@ (0x259e0)
@   0x080259be: 0831        lsrs	r1, r6, #32
@   0x080259c0: 0181        lsls	r1, r0, #6

        thumb_func_start sub_08025904
sub_08025904: @ 0x08025904
        .incbin "baserom.gba", 0x25904, 0xc0
        thumb_func_end sub_08025904
