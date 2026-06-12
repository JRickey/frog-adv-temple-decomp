@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025f38, 0x08025f70)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025f38 --end 0x8025f70 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025f38: b530        push	{r4, r5, lr}
@   0x08025f3a: 2400        movs	r4, #0
@   0x08025f3c: 4d0b        ldr	r5, [pc, #44]	@ (0x25f6c)
@   0x08025f3e: 00a0        lsls	r0, r4, #2
@   0x08025f40: 1940        adds	r0, r0, r5
@   0x08025f42: 6800        ldr	r0, [r0, #0]
@   0x08025f44: 1c21        adds	r1, r4, #0
@   0x08025f46: 3140        adds	r1, #64	@ 0x40
@   0x08025f48: f7fb        fd38 	bl	0x219bc
@   0x08025f4c: 1c60        adds	r0, r4, #1
@   0x08025f4e: 0600        lsls	r0, r0, #24
@   0x08025f50: 0e04        lsrs	r4, r0, #24
@   0x08025f52: 2c03        cmp	r4, #3
@   0x08025f54: d9f3        bls.n	0x25f3e
@   0x08025f56: 2040        movs	r0, #64	@ 0x40
@   0x08025f58: 2143        movs	r1, #67	@ 0x43
@   0x08025f5a: f7fb        f843 	bl	0x20fe4
@   0x08025f5e: 2040        movs	r0, #64	@ 0x40
@   0x08025f60: 2143        movs	r1, #67	@ 0x43
@   0x08025f62: f7df        fed5 	bl	0x5d10
@   0x08025f66: bc30        pop	{r4, r5}
@   0x08025f68: bc01        pop	{r0}
@   0x08025f6a: 4700        bx	r0
@   0x08025f6c: 4ac4        ldr	r2, [pc, #784]	@ (0x26280)
@   0x08025f6e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025F38
sub_08025F38: @ 0x08025f38
        .incbin "baserom.gba", 0x25f38, 0x38
        thumb_func_end sub_08025F38
