@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027458, 0x08027490)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027458 --end 0x8027490 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027458: b530        push	{r4, r5, lr}
@   0x0802745a: 2400        movs	r4, #0
@   0x0802745c: 4d0b        ldr	r5, [pc, #44]	@ (0x2748c)
@   0x0802745e: 00a0        lsls	r0, r4, #2
@   0x08027460: 1940        adds	r0, r0, r5
@   0x08027462: 6800        ldr	r0, [r0, #0]
@   0x08027464: 1c21        adds	r1, r4, #0
@   0x08027466: 312a        adds	r1, #42	@ 0x2a
@   0x08027468: f7fa        faa8 	bl	0x219bc
@   0x0802746c: 1c60        adds	r0, r4, #1
@   0x0802746e: 0600        lsls	r0, r0, #24
@   0x08027470: 0e04        lsrs	r4, r0, #24
@   0x08027472: 2c02        cmp	r4, #2
@   0x08027474: d9f3        bls.n	0x2745e
@   0x08027476: 202a        movs	r0, #42	@ 0x2a
@   0x08027478: 212c        movs	r1, #44	@ 0x2c
@   0x0802747a: f7f9        fdb3 	bl	0x20fe4
@   0x0802747e: 202a        movs	r0, #42	@ 0x2a
@   0x08027480: 212c        movs	r1, #44	@ 0x2c
@   0x08027482: f7de        fc45 	bl	0x5d10
@   0x08027486: bc30        pop	{r4, r5}
@   0x08027488: bc01        pop	{r0}
@   0x0802748a: 4700        bx	r0
@   0x0802748c: 6660        str	r0, [r4, #100]	@ 0x64
@   0x0802748e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027458
sub_08027458: @ 0x08027458
        .incbin "baserom.gba", 0x27458, 0x38
        thumb_func_end sub_08027458
