@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080255bc, 0x080255f4)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80255bc --end 0x80255f4 --mode thumb
@
@ BOUNDARY EVIDENCE: Thumb epilogue (pop {r4,r5}; pop {r0}; bx r0) at 0x080255ea-0x080255f0.
@ The next instruction at 0x080255f0 (eors r0,r1) begins a new function.
@ Computed branch target at 0x080255bc identified by boundary.py analysis.

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080255bc: b530        push	{r4, r5, lr}
@   0x080255be: 2400        movs	r4, #0
@   0x080255c0: 4d0b        ldr	r5, [pc, #44]	@ (0x255f0)
@   0x080255c2: 00a0        lsls	r0, r4, #2
@   0x080255c4: 1940        adds	r0, r0, r5
@   0x080255c6: 6800        ldr	r0, [r0, #0]
@   0x080255c8: 1c21        adds	r1, r4, #0
@   0x080255ca: 315f        adds	r1, #95	@ 0x5f
@   0x080255cc: f7fc        f9f6 	bl	0x219bc
@   0x080255d0: 1c60        adds	r0, r4, #1
@   0x080255d2: 0600        lsls	r0, r0, #24
@   0x080255d4: 0e04        lsrs	r4, r0, #24
@   0x080255d6: 2c03        cmp	r4, #3
@   0x080255d8: d9f3        bls.n	0x255c2
@   0x080255da: 205f        movs	r0, #95	@ 0x5f
@   0x080255dc: 2162        movs	r1, #98	@ 0x62
@   0x080255de: f7fb        fd01 	bl	0x20fe4
@   0x080255e2: 205f        movs	r0, #95	@ 0x5f
@   0x080255e4: 2162        movs	r1, #98	@ 0x62
@   0x080255e6: f7e0        fb93 	bl	0x5d10
@   0x080255ea: bc30        pop	{r4, r5}
@   0x080255ec: bc01        pop	{r0}
@   0x080255ee: 4700        bx	r0
@   0x080255f0: 4048        eors	r0, r1
@   0x080255f2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080255BC
sub_080255BC: @ 0x080255bc
        .incbin "baserom.gba", 0x255bc, 0x38
        thumb_func_end sub_080255BC
