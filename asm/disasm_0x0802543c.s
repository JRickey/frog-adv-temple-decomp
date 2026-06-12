@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802543c, 0x08025484)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802543c --end 0x8025484 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802543c: b570        push	{r4, r5, r6, lr}
@   0x0802543e: 2500        movs	r5, #0
@   0x08025440: 4e0e        ldr	r6, [pc, #56]	@ (0x2547c)
@   0x08025442: 00a8        lsls	r0, r5, #2
@   0x08025444: 1980        adds	r0, r0, r6
@   0x08025446: 6800        ldr	r0, [r0, #0]
@   0x08025448: 1c2c        adds	r4, r5, #0
@   0x0802544a: 343d        adds	r4, #61	@ 0x3d
@   0x0802544c: 1c21        adds	r1, r4, #0
@   0x0802544e: f7fc        fab5 	bl	0x219bc
@   0x08025452: 480b        ldr	r0, [pc, #44]	@ (0x25480)
@   0x08025454: 1c21        adds	r1, r4, #0
@   0x08025456: f7e1        fa89 	bl	0x696c
@   0x0802545a: 1c68        adds	r0, r5, #1
@   0x0802545c: 0600        lsls	r0, r0, #24
@   0x0802545e: 0e05        lsrs	r5, r0, #24
@   0x08025460: 2d03        cmp	r5, #3
@   0x08025462: d9ee        bls.n	0x25442
@   0x08025464: 203d        movs	r0, #61	@ 0x3d
@   0x08025466: 2140        movs	r1, #64	@ 0x40
@   0x08025468: f7fb        fdbc 	bl	0x20fe4
@   0x0802546c: 203d        movs	r0, #61	@ 0x3d
@   0x0802546e: 2140        movs	r1, #64	@ 0x40
@   0x08025470: f7e0        fc4e 	bl	0x5d10
@   0x08025474: bc70        pop	{r4, r5, r6}
@   0x08025476: bc01        pop	{r0}
@   0x08025478: 4700        bx	r0
@   0x0802547a: 0000        movs	r0, r0
@   0x0802547c: 4004        ands	r4, r0
@   0x0802547e: 0831        lsrs	r1, r6, #32
@   0x08025480: 6110        str	r0, [r2, #16]
@   0x08025482: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802543C
sub_0802543C: @ 0x0802543c
        .incbin "baserom.gba", 0x2543c, 0x48
        thumb_func_end sub_0802543C
