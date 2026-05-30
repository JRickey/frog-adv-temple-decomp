@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802277c, 0x080227b4)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802277c --end 0x80227b4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802277c: b530        push	{r4, r5, lr}
@   0x0802277e: 2400        movs	r4, #0
@   0x08022780: 4d0b        ldr	r5, [pc, #44]	@ (0x227b0)
@   0x08022782: 00a0        lsls	r0, r4, #2
@   0x08022784: 1940        adds	r0, r0, r5
@   0x08022786: 6800        ldr	r0, [r0, #0]
@   0x08022788: 1c21        adds	r1, r4, #0
@   0x0802278a: 3136        adds	r1, #54	@ 0x36
@   0x0802278c: f7ff        f916 	bl	0x219bc
@   0x08022790: 1c60        adds	r0, r4, #1
@   0x08022792: 0600        lsls	r0, r0, #24
@   0x08022794: 0e04        lsrs	r4, r0, #24
@   0x08022796: 2c07        cmp	r4, #7
@   0x08022798: d9f3        bls.n	0x22782
@   0x0802279a: 2036        movs	r0, #54	@ 0x36
@   0x0802279c: 213d        movs	r1, #61	@ 0x3d
@   0x0802279e: f7fe        fc21 	bl	0x20fe4
@   0x080227a2: 2036        movs	r0, #54	@ 0x36
@   0x080227a4: 213d        movs	r1, #61	@ 0x3d
@   0x080227a6: f7e3        fab3 	bl	0x5d10
@   0x080227aa: bc30        pop	{r4, r5}
@   0x080227ac: bc01        pop	{r0}
@   0x080227ae: 4700        bx	r0
@   0x080227b0: 0dd4        lsrs	r4, r2, #23
@   0x080227b2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802277C
sub_0802277C: @ 0x0802277c
        .incbin "frog_us_baserom.gba", 0x2277c, 0x38
        thumb_func_end sub_0802277C
