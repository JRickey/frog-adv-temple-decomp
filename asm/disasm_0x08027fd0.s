@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027fd0, 0x08028008)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027fd0 --end 0x8028008 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027fd0: b530        push	{r4, r5, lr}
@   0x08027fd2: 2400        movs	r4, #0
@   0x08027fd4: 4d0b        ldr	r5, [pc, #44]	@ (0x28004)
@   0x08027fd6: 00a0        lsls	r0, r4, #2
@   0x08027fd8: 1940        adds	r0, r0, r5
@   0x08027fda: 6800        ldr	r0, [r0, #0]
@   0x08027fdc: 1c21        adds	r1, r4, #0
@   0x08027fde: 313d        adds	r1, #61	@ 0x3d
@   0x08027fe0: f7f9        fcec 	bl	0x219bc
@   0x08027fe4: 1c60        adds	r0, r4, #1
@   0x08027fe6: 0600        lsls	r0, r0, #24
@   0x08027fe8: 0e04        lsrs	r4, r0, #24
@   0x08027fea: 2c06        cmp	r4, #6
@   0x08027fec: d9f3        bls.n	0x27fd6
@   0x08027fee: 203d        movs	r0, #61	@ 0x3d
@   0x08027ff0: 2143        movs	r1, #67	@ 0x43
@   0x08027ff2: f7f8        fff7 	bl	0x20fe4
@   0x08027ff6: 203d        movs	r0, #61	@ 0x3d
@   0x08027ff8: 2143        movs	r1, #67	@ 0x43
@   0x08027ffa: f7dd        fe89 	bl	0x5d10
@   0x08027ffe: bc30        pop	{r4, r5}
@   0x08028000: bc01        pop	{r0}
@   0x08028002: 4700        bx	r0
@   0x08028004: 6e20        ldr	r0, [r4, #96]	@ 0x60
@   0x08028006: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027FD0
sub_08027FD0: @ 0x08027fd0
        .incbin "baserom.gba", 0x27fd0, 0x38
        thumb_func_end sub_08027FD0
