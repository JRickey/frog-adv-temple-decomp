@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080249e8, 0x08024a20)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80249e8 --end 0x8024a20 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080249e8: b530        push	{r4, r5, lr}
@   0x080249ea: 2400        movs	r4, #0
@   0x080249ec: 4d0b        ldr	r5, [pc, #44]	@ (0x24a1c)
@   0x080249ee: 00a0        lsls	r0, r4, #2
@   0x080249f0: 1940        adds	r0, r0, r5
@   0x080249f2: 6800        ldr	r0, [r0, #0]
@   0x080249f4: 1c21        adds	r1, r4, #0
@   0x080249f6: 3149        adds	r1, #73	@ 0x49
@   0x080249f8: f7fc        ffe0 	bl	0x219bc
@   0x080249fc: 1c60        adds	r0, r4, #1
@   0x080249fe: 0600        lsls	r0, r0, #24
@   0x08024a00: 0e04        lsrs	r4, r0, #24
@   0x08024a02: 2c00        cmp	r4, #0
@   0x08024a04: d0f3        beq.n	0x249ee
@   0x08024a06: 2049        movs	r0, #73	@ 0x49
@   0x08024a08: 2149        movs	r1, #73	@ 0x49
@   0x08024a0a: f7fc        faeb 	bl	0x20fe4
@   0x08024a0e: 2049        movs	r0, #73	@ 0x49
@   0x08024a10: 2149        movs	r1, #73	@ 0x49
@   0x08024a12: f7e1        f97d 	bl	0x5d10
@   0x08024a16: bc30        pop	{r4, r5}
@   0x08024a18: bc01        pop	{r0}
@   0x08024a1a: 4700        bx	r0
@   0x08024a1c: 3344        adds	r3, #68	@ 0x44
@   0x08024a1e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080249E8
sub_080249E8: @ 0x080249e8
        .incbin "baserom.gba", 0x249e8, 0x38
        thumb_func_end sub_080249E8
