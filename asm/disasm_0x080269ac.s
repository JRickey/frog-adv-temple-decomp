@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080269ac, 0x080269e4)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80269ac --end 0x80269e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080269ac: b530        push	{r4, r5, lr}
@   0x080269ae: 2400        movs	r4, #0
@   0x080269b0: 4d0b        ldr	r5, [pc, #44]	@ (0x269e0)
@   0x080269b2: 00a0        lsls	r0, r4, #2
@   0x080269b4: 1940        adds	r0, r0, r5
@   0x080269b6: 6800        ldr	r0, [r0, #0]
@   0x080269b8: 1c21        adds	r1, r4, #0
@   0x080269ba: 310f        adds	r1, #15
@   0x080269bc: f7fa        fffe 	bl	0x219bc
@   0x080269c0: 1c60        adds	r0, r4, #1
@   0x080269c2: 0600        lsls	r0, r0, #24
@   0x080269c4: 0e04        lsrs	r4, r0, #24
@   0x080269c6: 2c19        cmp	r4, #25
@   0x080269c8: d9f3        bls.n	0x269b2
@   0x080269ca: 200f        movs	r0, #15
@   0x080269cc: 2128        movs	r1, #40	@ 0x28
@   0x080269ce: f7fa        fb09 	bl	0x20fe4
@   0x080269d2: 200f        movs	r0, #15
@   0x080269d4: 2128        movs	r1, #40	@ 0x28
@   0x080269d6: f7df        f99b 	bl	0x5d10
@   0x080269da: bc30        pop	{r4, r5}
@   0x080269dc: bc01        pop	{r0}
@   0x080269de: 4700        bx	r0
@   0x080269e0: 5a74        ldrh	r4, [r6, r1]
@   0x080269e2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080269AC
sub_080269AC: @ 0x080269ac
        .incbin "baserom.gba", 0x269ac, 0x38
        thumb_func_end sub_080269AC
