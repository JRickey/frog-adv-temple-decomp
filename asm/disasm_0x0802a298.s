@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802a298, 0x0802a2d8)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802a298 --end 0x802a2d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a298: b530        push	{r4, r5, lr}
@   0x0802a29a: 2300        movs	r3, #0
@   0x0802a29c: 4d0c        ldr	r5, [pc, #48]	@ (0x2a2d0)
@   0x0802a29e: 4c0d        ldr	r4, [pc, #52]	@ (0x2a2d4)
@   0x0802a2a0: 00d8        lsls	r0, r3, #3
@   0x0802a2a2: 1942        adds	r2, r0, r5
@   0x0802a2a4: 1900        adds	r0, r0, r4
@   0x0802a2a6: 6841        ldr	r1, [r0, #4]
@   0x0802a2a8: 6800        ldr	r0, [r0, #0]
@   0x0802a2aa: 6050        str	r0, [r2, #4]
@   0x0802a2ac: 6091        str	r1, [r2, #8]
@   0x0802a2ae: 1c58        adds	r0, r3, #1
@   0x0802a2b0: 0600        lsls	r0, r0, #24
@   0x0802a2b2: 0e03        lsrs	r3, r0, #24
@   0x0802a2b4: 2b07        cmp	r3, #7
@   0x0802a2b6: d9f3        bls.n	0x2a2a0
@   0x0802a2b8: f7ff        ff8c 	bl	0x2a1d4
@   0x0802a2bc: f7ff        ffaa 	bl	0x2a214
@   0x0802a2c0: f7ff        ffbc 	bl	0x2a23c
@   0x0802a2c4: f7ff        ffd4 	bl	0x2a270
@   0x0802a2c8: bc30        pop	{r4, r5}
@   0x0802a2ca: bc01        pop	{r0}
@   0x0802a2cc: 4700        bx	r0
@   0x0802a2ce: 0000        movs	r0, r0
@   0x0802a2d0: 3570        adds	r5, #112	@ 0x70
@   0x0802a2d2: 0300        lsls	r0, r0, #12
@   0x0802a2d4: 7c84        ldrb	r4, [r0, #18]
@   0x0802a2d6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802A298
sub_0802A298: @ 0x0802a298
        .incbin "baserom.gba", 0x2a298, 0x40
        thumb_func_end sub_0802A298
