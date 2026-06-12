@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080260d4, 0x0802610c)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80260d4 --end 0x802610c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080260d4: b530        push	{r4, r5, lr}
@   0x080260d6: 2400        movs	r4, #0
@   0x080260d8: 4d0b        ldr	r5, [pc, #44]	@ (0x26108)
@   0x080260da: 00a0        lsls	r0, r4, #2
@   0x080260dc: 1940        adds	r0, r0, r5
@   0x080260de: 6800        ldr	r0, [r0, #0]
@   0x080260e0: 1c21        adds	r1, r4, #0
@   0x080260e2: 3153        adds	r1, #83	@ 0x53
@   0x080260e4: f7fb        fc6a 	bl	0x219bc
@   0x080260e8: 1c60        adds	r0, r4, #1
@   0x080260ea: 0600        lsls	r0, r0, #24
@   0x080260ec: 0e04        lsrs	r4, r0, #24
@   0x080260ee: 2c0a        cmp	r4, #10
@   0x080260f0: d9f3        bls.n	0x260da
@   0x080260f2: 2053        movs	r0, #83	@ 0x53
@   0x080260f4: 215d        movs	r1, #93	@ 0x5d
@   0x080260f6: f7fa        ff75 	bl	0x20fe4
@   0x080260fa: 2053        movs	r0, #83	@ 0x53
@   0x080260fc: 215d        movs	r1, #93	@ 0x5d
@   0x080260fe: f7df        fe07 	bl	0x5d10
@   0x08026102: bc30        pop	{r4, r5}
@   0x08026104: bc01        pop	{r0}
@   0x08026106: 4700        bx	r0
@   0x08026108: 4adc        ldr	r2, [pc, #880]	@ (0x2647c)
@   0x0802610a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080260D4
sub_080260D4: @ 0x080260d4
        .incbin "baserom.gba", 0x260d4, 0x38
        thumb_func_end sub_080260D4
