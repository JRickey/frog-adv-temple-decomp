@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027680, 0x080276b8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027680 --end 0x80276b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027680: b530        push	{r4, r5, lr}
@   0x08027682: 2400        movs	r4, #0
@   0x08027684: 4d0b        ldr	r5, [pc, #44]	@ (0x276b4)
@   0x08027686: 00a0        lsls	r0, r4, #2
@   0x08027688: 1940        adds	r0, r0, r5
@   0x0802768a: 6800        ldr	r0, [r0, #0]
@   0x0802768c: 1c21        adds	r1, r4, #0
@   0x0802768e: 3164        adds	r1, #100	@ 0x64
@   0x08027690: f7fa        f994 	bl	0x219bc
@   0x08027694: 1c60        adds	r0, r4, #1
@   0x08027696: 0600        lsls	r0, r0, #24
@   0x08027698: 0e04        lsrs	r4, r0, #24
@   0x0802769a: 2c03        cmp	r4, #3
@   0x0802769c: d9f3        bls.n	0x27686
@   0x0802769e: 2064        movs	r0, #100	@ 0x64
@   0x080276a0: 2167        movs	r1, #103	@ 0x67
@   0x080276a2: f7f9        fc9f 	bl	0x20fe4
@   0x080276a6: 2064        movs	r0, #100	@ 0x64
@   0x080276a8: 2167        movs	r1, #103	@ 0x67
@   0x080276aa: f7de        fb31 	bl	0x5d10
@   0x080276ae: bc30        pop	{r4, r5}
@   0x080276b0: bc01        pop	{r0}
@   0x080276b2: 4700        bx	r0
@   0x080276b4: 66f4        str	r4, [r6, #108]	@ 0x6c
@   0x080276b6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027680
sub_08027680: @ 0x08027680
        .incbin "baserom.gba", 0x27680, 0x38
        thumb_func_end sub_08027680
