@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025eb4, 0x08025eec)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025eb4 --end 0x8025eec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025eb4: b530        push	{r4, r5, lr}
@   0x08025eb6: 2400        movs	r4, #0
@   0x08025eb8: 4d0b        ldr	r5, [pc, #44]	@ (0x25ee8)
@   0x08025eba: 00a0        lsls	r0, r4, #2
@   0x08025ebc: 1940        adds	r0, r0, r5
@   0x08025ebe: 6800        ldr	r0, [r0, #0]
@   0x08025ec0: 1c21        adds	r1, r4, #0
@   0x08025ec2: 312d        adds	r1, #45	@ 0x2d
@   0x08025ec4: f7fb        fd7a 	bl	0x219bc
@   0x08025ec8: 1c60        adds	r0, r4, #1
@   0x08025eca: 0600        lsls	r0, r0, #24
@   0x08025ecc: 0e04        lsrs	r4, r0, #24
@   0x08025ece: 2c12        cmp	r4, #18
@   0x08025ed0: d9f3        bls.n	0x25eba
@   0x08025ed2: 202d        movs	r0, #45	@ 0x2d
@   0x08025ed4: 213f        movs	r1, #63	@ 0x3f
@   0x08025ed6: f7fb        f885 	bl	0x20fe4
@   0x08025eda: 202d        movs	r0, #45	@ 0x2d
@   0x08025edc: 213f        movs	r1, #63	@ 0x3f
@   0x08025ede: f7df        ff17 	bl	0x5d10
@   0x08025ee2: bc30        pop	{r4, r5}
@   0x08025ee4: bc01        pop	{r0}
@   0x08025ee6: 4700        bx	r0
@   0x08025ee8: 4a78        ldr	r2, [pc, #480]	@ (0x260cc)
@   0x08025eea: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025EB4
sub_08025EB4: @ 0x08025eb4
        .incbin "baserom.gba", 0x25eb4, 0x38
        thumb_func_end sub_08025EB4
