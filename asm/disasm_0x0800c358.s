@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c358, 0x0800c444)  (236 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c358 --end 0x800c444 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c358: b530        push	{r4, r5, lr}
@   0x0800c35a: 0600        lsls	r0, r0, #24
@   0x0800c35c: 0e04        lsrs	r4, r0, #24
@   0x0800c35e: 2c14        cmp	r4, #20
@   0x0800c360: d10f        bne.n	0xc382
@   0x0800c362: 4d1f        ldr	r5, [pc, #124]	@ (0xc3e0)
@   0x0800c364: 1c28        adds	r0, r5, #0
@   0x0800c366: 2105        movs	r1, #5
@   0x0800c368: 2200        movs	r2, #0
@   0x0800c36a: f7fa        fa17 	bl	0x679c
@   0x0800c36e: 0600        lsls	r0, r0, #24
@   0x0800c370: 2800        cmp	r0, #0
@   0x0800c372: d106        bne.n	0xc382
@   0x0800c374: 1c28        adds	r0, r5, #0
@   0x0800c376: 2105        movs	r1, #5
@   0x0800c378: 2200        movs	r2, #0
@   0x0800c37a: f7fa        f941 	bl	0x6600
@   0x0800c37e: f7fe        fac7 	bl	0xa910
@   0x0800c382: 2c15        cmp	r4, #21
@   0x0800c384: d10f        bne.n	0xc3a6
@   0x0800c386: 4d16        ldr	r5, [pc, #88]	@ (0xc3e0)
@   0x0800c388: 1c28        adds	r0, r5, #0
@   0x0800c38a: 2105        movs	r1, #5
@   0x0800c38c: 2201        movs	r2, #1
@   0x0800c38e: f7fa        fa05 	bl	0x679c
@   0x0800c392: 0600        lsls	r0, r0, #24
@   0x0800c394: 2800        cmp	r0, #0
@   0x0800c396: d106        bne.n	0xc3a6
@   0x0800c398: 1c28        adds	r0, r5, #0
@   0x0800c39a: 2105        movs	r1, #5
@   0x0800c39c: 2201        movs	r2, #1
@   0x0800c39e: f7fa        f92f 	bl	0x6600
@   0x0800c3a2: f7fe        fab5 	bl	0xa910
@   0x0800c3a6: 2c16        cmp	r4, #22
@   0x0800c3a8: d117        bne.n	0xc3da
@   0x0800c3aa: 4c0d        ldr	r4, [pc, #52]	@ (0xc3e0)
@   0x0800c3ac: 1c20        adds	r0, r4, #0
@   0x0800c3ae: 2105        movs	r1, #5
@   0x0800c3b0: 2203        movs	r2, #3
@   0x0800c3b2: f7fa        f9f3 	bl	0x679c
@   0x0800c3b6: 0600        lsls	r0, r0, #24
@   0x0800c3b8: 2800        cmp	r0, #0
@   0x0800c3ba: d00e        beq.n	0xc3da
@   0x0800c3bc: 1c20        adds	r0, r4, #0
@   0x0800c3be: 2105        movs	r1, #5
@   0x0800c3c0: 2202        movs	r2, #2
@   0x0800c3c2: f7fa        f9eb 	bl	0x679c
@   0x0800c3c6: 0600        lsls	r0, r0, #24
@   0x0800c3c8: 2800        cmp	r0, #0
@   0x0800c3ca: d106        bne.n	0xc3da
@   0x0800c3cc: 1c20        adds	r0, r4, #0
@   0x0800c3ce: 2105        movs	r1, #5
@   0x0800c3d0: 2202        movs	r2, #2
@   0x0800c3d2: f7fa        f915 	bl	0x6600
@   0x0800c3d6: f7fe        fa9b 	bl	0xa910
@   0x0800c3da: bc30        pop	{r4, r5}
@   0x0800c3dc: bc01        pop	{r0}
@   0x0800c3de: 4700        bx	r0
@   0x0800c3e0: 6110        str	r0, [r2, #16]
@   0x0800c3e2: 0300        lsls	r0, r0, #12
@   0x0800c3e4: b530        push	{r4, r5, lr}
@   0x0800c3e6: 0600        lsls	r0, r0, #24
@   0x0800c3e8: 0e04        lsrs	r4, r0, #24
@   0x0800c3ea: 2c14        cmp	r4, #20
@   0x0800c3ec: d10d        bne.n	0xc40a
@   0x0800c3ee: 4d14        ldr	r5, [pc, #80]	@ (0xc440)
@   0x0800c3f0: 1c28        adds	r0, r5, #0
@   0x0800c3f2: 2105        movs	r1, #5
@   0x0800c3f4: 2200        movs	r2, #0
@   0x0800c3f6: f7fa        f9d1 	bl	0x679c
@   0x0800c3fa: 0600        lsls	r0, r0, #24
@   0x0800c3fc: 2800        cmp	r0, #0
@   0x0800c3fe: d104        bne.n	0xc40a
@   0x0800c400: 1c28        adds	r0, r5, #0
@   0x0800c402: 2105        movs	r1, #5
@   0x0800c404: 2200        movs	r2, #0
@   0x0800c406: f7fa        f8fb 	bl	0x6600
@   0x0800c40a: 2c15        cmp	r4, #21
@   0x0800c40c: d115        bne.n	0xc43a
@   0x0800c40e: 4c0c        ldr	r4, [pc, #48]	@ (0xc440)
@   0x0800c410: 1c20        adds	r0, r4, #0
@   0x0800c412: 2105        movs	r1, #5
@   0x0800c414: 2200        movs	r2, #0
@   0x0800c416: f7fa        f9c1 	bl	0x679c
@   0x0800c41a: 0600        lsls	r0, r0, #24
@   0x0800c41c: 2800        cmp	r0, #0
@   0x0800c41e: d00c        beq.n	0xc43a
@   0x0800c420: 1c20        adds	r0, r4, #0
@   0x0800c422: 2105        movs	r1, #5
@   0x0800c424: 2201        movs	r2, #1
@   0x0800c426: f7fa        f9b9 	bl	0x679c
@   0x0800c42a: 0600        lsls	r0, r0, #24
@   0x0800c42c: 2800        cmp	r0, #0
@   0x0800c42e: d104        bne.n	0xc43a
@   0x0800c430: 1c20        adds	r0, r4, #0
@   0x0800c432: 2105        movs	r1, #5
@   0x0800c434: 2201        movs	r2, #1
@   0x0800c436: f7fa        f8e3 	bl	0x6600
@   0x0800c43a: bc30        pop	{r4, r5}
@   0x0800c43c: bc01        pop	{r0}
@   0x0800c43e: 4700        bx	r0
@   0x0800c440: 6110        str	r0, [r2, #16]
@   0x0800c442: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800C358
sub_0800C358: @ 0x0800c358
        .incbin "frog_us_baserom.gba", 0xc358, 0x8c
        thumb_func_end sub_0800C358

        thumb_func_start sub_0800C3E4
sub_0800C3E4: @ 0x0800c3e4
        .incbin "frog_us_baserom.gba", 0xc3e4, 0x60
        thumb_func_end sub_0800C3E4
