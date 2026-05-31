@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a394, 0x0802a42c)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a394 --end 0x802a42c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a394: b570        push	{r4, r5, r6, lr}
@   0x0802a396: b083        sub	sp, #12
@   0x0802a398: 4e13        ldr	r6, [pc, #76]	@ (0x2a3e8)
@   0x0802a39a: 4d14        ldr	r5, [pc, #80]	@ (0x2a3ec)
@   0x0802a39c: 4814        ldr	r0, [pc, #80]	@ (0x2a3f0)
@   0x0802a39e: 182c        adds	r4, r5, r0
@   0x0802a3a0: 6830        ldr	r0, [r6, #0]
@   0x0802a3a2: 6821        ldr	r1, [r4, #0]
@   0x0802a3a4: 1a40        subs	r0, r0, r1
@   0x0802a3a6: 2196        movs	r1, #150	@ 0x96
@   0x0802a3a8: 0089        lsls	r1, r1, #2
@   0x0802a3aa: 4288        cmp	r0, r1
@   0x0802a3ac: d903        bls.n	0x2a3b6
@   0x0802a3ae: f7ff        ff9f 	bl	0x2a2f0
@   0x0802a3b2: 6830        ldr	r0, [r6, #0]
@   0x0802a3b4: 6020        str	r0, [r4, #0]
@   0x0802a3b6: 490f        ldr	r1, [pc, #60]	@ (0x2a3f4)
@   0x0802a3b8: 9801        ldr	r0, [sp, #4]
@   0x0802a3ba: 4008        ands	r0, r1
@   0x0802a3bc: 2102        movs	r1, #2
@   0x0802a3be: 4308        orrs	r0, r1
@   0x0802a3c0: 9001        str	r0, [sp, #4]
@   0x0802a3c2: f7d6        fa9d 	bl	0x900
@   0x0802a3c6: 22cf        movs	r2, #207	@ 0xcf
@   0x0802a3c8: 0092        lsls	r2, r2, #2
@   0x0802a3ca: 18a9        adds	r1, r5, r2
@   0x0802a3cc: 6809        ldr	r1, [r1, #0]
@   0x0802a3ce: 1a40        subs	r0, r0, r1
@   0x0802a3d0: 4909        ldr	r1, [pc, #36]	@ (0x2a3f8)
@   0x0802a3d2: 4288        cmp	r0, r1
@   0x0802a3d4: d814        bhi.n	0x2a400
@   0x0802a3d6: 4b09        ldr	r3, [pc, #36]	@ (0x2a3fc)
@   0x0802a3d8: 2000        movs	r0, #0
@   0x0802a3da: 9000        str	r0, [sp, #0]
@   0x0802a3dc: 200e        movs	r0, #14
@   0x0802a3de: a901        add	r1, sp, #4
@   0x0802a3e0: 2203        movs	r2, #3
@   0x0802a3e2: f7f7        f895 	bl	0x21510
@   0x0802a3e6: e01c        b.n	0x2a422
@   0x0802a3e8: 5330        strh	r0, [r6, r4]
@   0x0802a3ea: 0300        lsls	r0, r0, #12
@   0x0802a3ec: 3720        adds	r7, #32
@   0x0802a3ee: 0300        lsls	r0, r0, #12
@   0x0802a3f0: 0b54        lsrs	r4, r2, #13
@   0x0802a3f2: 0000        movs	r0, r0
@   0x0802a3f4: 0000        movs	r0, r0
@   0x0802a3f6: ffff        012b 	vaddw.u<illegal width 64>	q8, <illegal reg q7.5>, d27
@   0x0802a3fa: 0000        movs	r0, r0
@   0x0802a3fc: 6110        str	r0, [r2, #16]
@   0x0802a3fe: 0300        lsls	r0, r0, #12
@   0x0802a400: 2200        movs	r2, #0
@   0x0802a402: 1c2c        adds	r4, r5, #0
@   0x0802a404: 2308        movs	r3, #8
@   0x0802a406: 1c11        adds	r1, r2, #0
@   0x0802a408: 310e        adds	r1, #14
@   0x0802a40a: 00c8        lsls	r0, r1, #3
@   0x0802a40c: 1a40        subs	r0, r0, r1
@   0x0802a40e: 00c0        lsls	r0, r0, #3
@   0x0802a410: 1900        adds	r0, r0, r4
@   0x0802a412: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x0802a414: 4319        orrs	r1, r3
@   0x0802a416: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802a418: 1c50        adds	r0, r2, #1
@   0x0802a41a: 0600        lsls	r0, r0, #24
@   0x0802a41c: 0e02        lsrs	r2, r0, #24
@   0x0802a41e: 2a01        cmp	r2, #1
@   0x0802a420: d9f1        bls.n	0x2a406
@   0x0802a422: b003        add	sp, #12
@   0x0802a424: bc70        pop	{r4, r5, r6}
@   0x0802a426: bc01        pop	{r0}
@   0x0802a428: 4700        bx	r0

        thumb_func_start sub_0802A394
sub_0802A394: @ 0x0802a394
        .incbin "frog_us_baserom.gba", 0x2a394, 0x98
        thumb_func_end sub_0802A394
