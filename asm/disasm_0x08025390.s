@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025390, 0x080253f0)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025390 --end 0x80253f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025390: b570        push	{r4, r5, r6, lr}
@   0x08025392: b081        sub	sp, #4
@   0x08025394: 2400        movs	r4, #0
@   0x08025396: 4d13        ldr	r5, [pc, #76]	@ (0x253e4)
@   0x08025398: 20cb        movs	r0, #203	@ 0xcb
@   0x0802539a: 0100        lsls	r0, r0, #4
@   0x0802539c: 182e        adds	r6, r5, r0
@   0x0802539e: 1c21        adds	r1, r4, #0
@   0x080253a0: 313a        adds	r1, #58	@ 0x3a
@   0x080253a2: 00c8        lsls	r0, r1, #3
@   0x080253a4: 1a40        subs	r0, r0, r1
@   0x080253a6: 00c0        lsls	r0, r0, #3
@   0x080253a8: 1940        adds	r0, r0, r5
@   0x080253aa: 7ec0        ldrb	r0, [r0, #27]
@   0x080253ac: 2801        cmp	r0, #1
@   0x080253ae: d108        bne.n	0x253c2
@   0x080253b0: 00e0        lsls	r0, r4, #3
@   0x080253b2: 1b00        subs	r0, r0, r4
@   0x080253b4: 00c0        lsls	r0, r0, #3
@   0x080253b6: 1980        adds	r0, r0, r6
@   0x080253b8: 2105        movs	r1, #5
@   0x080253ba: 2201        movs	r2, #1
@   0x080253bc: 2301        movs	r3, #1
@   0x080253be: f7fb        fd29 	bl	0x20e14
@   0x080253c2: 1c60        adds	r0, r4, #1
@   0x080253c4: 0600        lsls	r0, r0, #24
@   0x080253c6: 0e04        lsrs	r4, r0, #24
@   0x080253c8: 2c02        cmp	r4, #2
@   0x080253ca: d9e8        bls.n	0x2539e
@   0x080253cc: 4906        ldr	r1, [pc, #24]	@ (0x253e8)
@   0x080253ce: 4b07        ldr	r3, [pc, #28]	@ (0x253ec)
@   0x080253d0: 2000        movs	r0, #0
@   0x080253d2: 9000        str	r0, [sp, #0]
@   0x080253d4: 203a        movs	r0, #58	@ 0x3a
@   0x080253d6: 2222        movs	r2, #34	@ 0x22
@   0x080253d8: f7fc        f89a 	bl	0x21510
@   0x080253dc: b001        add	sp, #4
@   0x080253de: bc70        pop	{r4, r5, r6}
@   0x080253e0: bc01        pop	{r0}
@   0x080253e2: 4700        bx	r0
@   0x080253e4: 3720        adds	r7, #32
@   0x080253e6: 0300        lsls	r0, r0, #12
@   0x080253e8: 3508        adds	r5, #8
@   0x080253ea: 0831        lsrs	r1, r6, #32
@   0x080253ec: 6110        str	r0, [r2, #16]
@   0x080253ee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025390
sub_08025390: @ 0x08025390
        .incbin "baserom.gba", 0x25390, 0x60
        thumb_func_end sub_08025390
