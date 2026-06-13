@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027f40, 0x08027f78)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027f40 --end 0x8027f78 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027f40: b530        push	{r4, r5, lr}
@   0x08027f42: 2400        movs	r4, #0
@   0x08027f44: 4d0b        ldr	r5, [pc, #44]	@ (0x27f74)
@   0x08027f46: 00a0        lsls	r0, r4, #2
@   0x08027f48: 1940        adds	r0, r0, r5
@   0x08027f4a: 6800        ldr	r0, [r0, #0]
@   0x08027f4c: 1c21        adds	r1, r4, #0
@   0x08027f4e: 3133        adds	r1, #51	@ 0x33
@   0x08027f50: f7f9        fd34 	bl	0x219bc
@   0x08027f54: 1c60        adds	r0, r4, #1
@   0x08027f56: 0600        lsls	r0, r0, #24
@   0x08027f58: 0e04        lsrs	r4, r0, #24
@   0x08027f5a: 2c09        cmp	r4, #9
@   0x08027f5c: d9f3        bls.n	0x27f46
@   0x08027f5e: 2033        movs	r0, #51	@ 0x33
@   0x08027f60: 213c        movs	r1, #60	@ 0x3c
@   0x08027f62: f7f9        f83f 	bl	0x20fe4
@   0x08027f66: 2033        movs	r0, #51	@ 0x33
@   0x08027f68: 213c        movs	r1, #60	@ 0x3c
@   0x08027f6a: f7dd        fed1 	bl	0x5d10
@   0x08027f6e: bc30        pop	{r4, r5}
@   0x08027f70: bc01        pop	{r0}
@   0x08027f72: 4700        bx	r0
@   0x08027f74: 6df8        ldr	r0, [r7, #92]	@ 0x5c
@   0x08027f76: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027F40
sub_08027F40: @ 0x08027f40
        .incbin "baserom.gba", 0x27f40, 0x38
        thumb_func_end sub_08027F40
