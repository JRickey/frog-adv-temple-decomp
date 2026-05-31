@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020414, 0x080204a0)  (140 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020414 --end 0x80204a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020414: b570        push	{r4, r5, r6, lr}
@   0x08020416: 1c04        adds	r4, r0, #0
@   0x08020418: 0609        lsls	r1, r1, #24
@   0x0802041a: 0e0e        lsrs	r6, r1, #24
@   0x0802041c: 0612        lsls	r2, r2, #24
@   0x0802041e: 0e12        lsrs	r2, r2, #24
@   0x08020420: 061b        lsls	r3, r3, #24
@   0x08020422: 0e1b        lsrs	r3, r3, #24
@   0x08020424: 1c11        adds	r1, r2, #0
@   0x08020426: 1c1a        adds	r2, r3, #0
@   0x08020428: f001        fd04 	bl	0x21e34
@   0x0802042c: 0600        lsls	r0, r0, #24
@   0x0802042e: 2800        cmp	r0, #0
@   0x08020430: d02e        beq.n	0x20490
@   0x08020432: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08020434: 2280        movs	r2, #128	@ 0x80
@   0x08020436: 0192        lsls	r2, r2, #6
@   0x08020438: 1c10        adds	r0, r2, #0
@   0x0802043a: 4008        ands	r0, r1
@   0x0802043c: 2800        cmp	r0, #0
@   0x0802043e: d12b        bne.n	0x20498
@   0x08020440: 1c10        adds	r0, r2, #0
@   0x08020442: 4308        orrs	r0, r1
@   0x08020444: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08020446: 4d11        ldr	r5, [pc, #68]	@ (0x2048c)
@   0x08020448: 00f4        lsls	r4, r6, #3
@   0x0802044a: 1c28        adds	r0, r5, #0
@   0x0802044c: 3008        adds	r0, #8
@   0x0802044e: 1826        adds	r6, r4, r0
@   0x08020450: 6830        ldr	r0, [r6, #0]
@   0x08020452: f00d        fe97 	bl	0x2e184
@   0x08020456: 2800        cmp	r0, #0
@   0x08020458: d11e        bne.n	0x20498
@   0x0802045a: 1d28        adds	r0, r5, #4
@   0x0802045c: 1820        adds	r0, r4, r0
@   0x0802045e: 6801        ldr	r1, [r0, #0]
@   0x08020460: 2401        movs	r4, #1
@   0x08020462: 4264        negs	r4, r4
@   0x08020464: 2010        movs	r0, #16
@   0x08020466: 782a        ldrb	r2, [r5, #0]
@   0x08020468: 4010        ands	r0, r2
@   0x0802046a: 2800        cmp	r0, #0
@   0x0802046c: d00b        beq.n	0x20486
@   0x0802046e: 1c08        adds	r0, r1, #0
@   0x08020470: 21ff        movs	r1, #255	@ 0xff
@   0x08020472: 22ff        movs	r2, #255	@ 0xff
@   0x08020474: 23ff        movs	r3, #255	@ 0xff
@   0x08020476: f00d        fab9 	bl	0x2d9ec
@   0x0802047a: 1c04        adds	r4, r0, #0
@   0x0802047c: 217f        movs	r1, #127	@ 0x7f
@   0x0802047e: 78ad        ldrb	r5, [r5, #2]
@   0x08020480: 4029        ands	r1, r5
@   0x08020482: f00d        fbcb 	bl	0x2dc1c
@   0x08020486: 6034        str	r4, [r6, #0]
@   0x08020488: e006        b.n	0x20498
@   0x0802048a: 0000        movs	r0, r0
@   0x0802048c: 3570        adds	r5, #112	@ 0x70
@   0x0802048e: 0300        lsls	r0, r0, #12
@   0x08020490: 4803        ldr	r0, [pc, #12]	@ (0x204a0)
@   0x08020492: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08020494: 4008        ands	r0, r1
@   0x08020496: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08020498: bc70        pop	{r4, r5, r6}
@   0x0802049a: bc01        pop	{r0}
@   0x0802049c: 4700        bx	r0

        thumb_func_start sub_08020414
sub_08020414: @ 0x08020414
        .incbin "frog_us_baserom.gba", 0x20414, 0x8c
        thumb_func_end sub_08020414
