@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d3c0, 0x0802d448)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d3c0 --end 0x802d448 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d3c0: b510        push	{r4, lr}
@   0x0802d3c2: b084        sub	sp, #16
@   0x0802d3c4: 4c0d        ldr	r4, [pc, #52]	@ (0x2d3fc)
@   0x0802d3c6: 2041        movs	r0, #65	@ 0x41
@   0x0802d3c8: 9000        str	r0, [sp, #0]
@   0x0802d3ca: 2001        movs	r0, #1
@   0x0802d3cc: 9001        str	r0, [sp, #4]
@   0x0802d3ce: 2003        movs	r0, #3
@   0x0802d3d0: 9002        str	r0, [sp, #8]
@   0x0802d3d2: 2002        movs	r0, #2
@   0x0802d3d4: 9003        str	r0, [sp, #12]
@   0x0802d3d6: 1c21        adds	r1, r4, #0
@   0x0802d3d8: 2210        movs	r2, #16
@   0x0802d3da: 2359        movs	r3, #89	@ 0x59
@   0x0802d3dc: f7f3        fe60 	bl	0x210a0
@   0x0802d3e0: 4907        ldr	r1, [pc, #28]	@ (0x2d400)
@   0x0802d3e2: 8922        ldrh	r2, [r4, #8]
@   0x0802d3e4: 4b07        ldr	r3, [pc, #28]	@ (0x2d404)
@   0x0802d3e6: 18c8        adds	r0, r1, r3
@   0x0802d3e8: 8002        strh	r2, [r0, #0]
@   0x0802d3ea: 8960        ldrh	r0, [r4, #10]
@   0x0802d3ec: 303a        adds	r0, #58	@ 0x3a
@   0x0802d3ee: 4a06        ldr	r2, [pc, #24]	@ (0x2d408)
@   0x0802d3f0: 1889        adds	r1, r1, r2
@   0x0802d3f2: 8008        strh	r0, [r1, #0]
@   0x0802d3f4: b004        add	sp, #16
@   0x0802d3f6: bc10        pop	{r4}
@   0x0802d3f8: bc01        pop	{r0}
@   0x0802d3fa: 4700        bx	r0
@   0x0802d3fc: 813c        strh	r4, [r7, #8]
@   0x0802d3fe: 0831        lsrs	r1, r6, #32
@   0x0802d400: 3720        adds	r7, #32
@   0x0802d402: 0300        lsls	r0, r0, #12
@   0x0802d404: 0af2        lsrs	r2, r6, #11
@   0x0802d406: 0000        movs	r0, r0
@   0x0802d408: 0af4        lsrs	r4, r6, #11
@   0x0802d40a: 0000        movs	r0, r0
@   0x0802d40c: b510        push	{r4, lr}
@   0x0802d40e: 0600        lsls	r0, r0, #24
@   0x0802d410: 0e00        lsrs	r0, r0, #24
@   0x0802d412: 0609        lsls	r1, r1, #24
@   0x0802d414: 0e09        lsrs	r1, r1, #24
@   0x0802d416: 1840        adds	r0, r0, r1
@   0x0802d418: 00c4        lsls	r4, r0, #3
@   0x0802d41a: 1a24        subs	r4, r4, r0
@   0x0802d41c: 00e4        lsls	r4, r4, #3
@   0x0802d41e: 4807        ldr	r0, [pc, #28]	@ (0x2d43c)
@   0x0802d420: 1824        adds	r4, r4, r0
@   0x0802d422: 2006        movs	r0, #6
@   0x0802d424: f7d3        f99e 	bl	0x764
@   0x0802d428: 3005        adds	r0, #5
@   0x0802d42a: 0041        lsls	r1, r0, #1
@   0x0802d42c: 1809        adds	r1, r1, r0
@   0x0802d42e: 04c9        lsls	r1, r1, #19
@   0x0802d430: 88a4        ldrh	r4, [r4, #4]
@   0x0802d432: 0420        lsls	r0, r4, #16
@   0x0802d434: 4288        cmp	r0, r1
@   0x0802d436: da03        bge.n	0x2d440
@   0x0802d438: 2000        movs	r0, #0
@   0x0802d43a: e002        b.n	0x2d442
@   0x0802d43c: 3720        adds	r7, #32
@   0x0802d43e: 0300        lsls	r0, r0, #12
@   0x0802d440: 2001        movs	r0, #1
@   0x0802d442: bc10        pop	{r4}
@   0x0802d444: bc02        pop	{r1}
@   0x0802d446: 4708        bx	r1

        thumb_func_start sub_0802D3C0
sub_0802D3C0: @ 0x0802d3c0
        .incbin "frog_us_baserom.gba", 0x2d3c0, 0x88
        thumb_func_end sub_0802D3C0
