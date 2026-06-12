@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024970, 0x080249a8)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024970 --end 0x80249a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024970: b530        push	{r4, r5, lr}
@   0x08024972: 2400        movs	r4, #0
@   0x08024974: 4d0b        ldr	r5, [pc, #44]	@ (0x249a4)
@   0x08024976: 00a0        lsls	r0, r4, #2
@   0x08024978: 1940        adds	r0, r0, r5
@   0x0802497a: 6800        ldr	r0, [r0, #0]
@   0x0802497c: 1c21        adds	r1, r4, #0
@   0x0802497e: 3146        adds	r1, #70	@ 0x46
@   0x08024980: f7fd        f81c 	bl	0x219bc
@   0x08024984: 1c60        adds	r0, r4, #1
@   0x08024986: 0600        lsls	r0, r0, #24
@   0x08024988: 0e04        lsrs	r4, r0, #24
@   0x0802498a: 2c02        cmp	r4, #2
@   0x0802498c: d9f3        bls.n	0x24976
@   0x0802498e: 2046        movs	r0, #70	@ 0x46
@   0x08024990: 2148        movs	r1, #72	@ 0x48
@   0x08024992: f7fc        fb27 	bl	0x20fe4
@   0x08024996: 2046        movs	r0, #70	@ 0x46
@   0x08024998: 2148        movs	r1, #72	@ 0x48
@   0x0802499a: f7e1        f9b9 	bl	0x5d10
@   0x0802499e: bc30        pop	{r4, r5}
@   0x080249a0: bc01        pop	{r0}
@   0x080249a2: 4700        bx	r0
@   0x080249a4: 3338        adds	r3, #56	@ 0x38
@   0x080249a6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024970
sub_08024970: @ 0x08024970
        .incbin "baserom.gba", 0x24970, 0x38
        thumb_func_end sub_08024970
