@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027eb0, 0x08027ee8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027eb0 --end 0x8027ee8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027eb0: b530        push	{r4, r5, lr}
@   0x08027eb2: 2400        movs	r4, #0
@   0x08027eb4: 4d0b        ldr	r5, [pc, #44]	@ (0x27ee4)
@   0x08027eb6: 00a0        lsls	r0, r4, #2
@   0x08027eb8: 1940        adds	r0, r0, r5
@   0x08027eba: 6800        ldr	r0, [r0, #0]
@   0x08027ebc: 1c21        adds	r1, r4, #0
@   0x08027ebe: 3129        adds	r1, #41	@ 0x29
@   0x08027ec0: f7f9        fd7c 	bl	0x219bc
@   0x08027ec4: 1c60        adds	r0, r4, #1
@   0x08027ec6: 0600        lsls	r0, r0, #24
@   0x08027ec8: 0e04        lsrs	r4, r0, #24
@   0x08027eca: 2c09        cmp	r4, #9
@   0x08027ecc: d9f3        bls.n	0x27eb6
@   0x08027ece: 2029        movs	r0, #41	@ 0x29
@   0x08027ed0: 2132        movs	r1, #50	@ 0x32
@   0x08027ed2: f7f9        f887 	bl	0x20fe4
@   0x08027ed6: 2029        movs	r0, #41	@ 0x29
@   0x08027ed8: 2132        movs	r1, #50	@ 0x32
@   0x08027eda: f7dd        ff19 	bl	0x5d10
@   0x08027ede: bc30        pop	{r4, r5}
@   0x08027ee0: bc01        pop	{r0}
@   0x08027ee2: 4700        bx	r0
@   0x08027ee4: 6dd0        ldr	r0, [r2, #92]	@ 0x5c
@   0x08027ee6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027EB0
sub_08027EB0: @ 0x08027eb0
        .incbin "baserom.gba", 0x27eb0, 0x38
        thumb_func_end sub_08027EB0
