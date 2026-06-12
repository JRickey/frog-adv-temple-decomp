@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080252b0, 0x080252e8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80252b0 --end 0x80252e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080252b0: b530        push	{r4, r5, lr}
@   0x080252b2: 2400        movs	r4, #0
@   0x080252b4: 4d0b        ldr	r5, [pc, #44]	@ (0x252e4)
@   0x080252b6: 00a0        lsls	r0, r4, #2
@   0x080252b8: 1940        adds	r0, r0, r5
@   0x080252ba: 6800        ldr	r0, [r0, #0]
@   0x080252bc: 1c21        adds	r1, r4, #0
@   0x080252be: 312a        adds	r1, #42	@ 0x2a
@   0x080252c0: f7fc        fb7c 	bl	0x219bc
@   0x080252c4: 1c60        adds	r0, r4, #1
@   0x080252c6: 0600        lsls	r0, r0, #24
@   0x080252c8: 0e04        lsrs	r4, r0, #24
@   0x080252ca: 2c09        cmp	r4, #9
@   0x080252cc: d9f3        bls.n	0x252b6
@   0x080252ce: 202a        movs	r0, #42	@ 0x2a
@   0x080252d0: 2133        movs	r1, #51	@ 0x33
@   0x080252d2: f7fb        fe87 	bl	0x20fe4
@   0x080252d6: 202a        movs	r0, #42	@ 0x2a
@   0x080252d8: 2133        movs	r1, #51	@ 0x33
@   0x080252da: f7e0        fd19 	bl	0x5d10
@   0x080252de: bc30        pop	{r4, r5}
@   0x080252e0: bc01        pop	{r0}
@   0x080252e2: 4700        bx	r0
@   0x080252e4: 3fc4        subs	r7, #196	@ 0xc4
@   0x080252e6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080252B0
sub_080252B0: @ 0x080252b0
        .incbin "baserom.gba", 0x252b0, 0x38
        thumb_func_end sub_080252B0
