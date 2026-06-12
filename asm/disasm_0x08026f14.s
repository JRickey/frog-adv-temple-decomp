@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026f14, 0x08026f8c)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026f14 --end 0x8026f8c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026f14: b530        push	{r4, r5, lr}
@   0x08026f16: 2300        movs	r3, #0
@   0x08026f18: 4d16        ldr	r5, [pc, #88]	@ (0x26f74)
@   0x08026f1a: 4c17        ldr	r4, [pc, #92]	@ (0x26f78)
@   0x08026f1c: 00d8        lsls	r0, r3, #3
@   0x08026f1e: 1942        adds	r2, r0, r5
@   0x08026f20: 1900        adds	r0, r0, r4
@   0x08026f22: 6841        ldr	r1, [r0, #4]
@   0x08026f24: 6800        ldr	r0, [r0, #0]
@   0x08026f26: 6050        str	r0, [r2, #4]
@   0x08026f28: 6091        str	r1, [r2, #8]
@   0x08026f2a: 1c58        adds	r0, r3, #1
@   0x08026f2c: 0600        lsls	r0, r0, #24
@   0x08026f2e: 0e03        lsrs	r3, r0, #24
@   0x08026f30: 2b09        cmp	r3, #9
@   0x08026f32: d9f3        bls.n	0x26f1c
@   0x08026f34: f7ff        fcc8 	bl	0x268c8
@   0x08026f38: f7ff        fd04 	bl	0x26944
@   0x08026f3c: f7ff        fd52 	bl	0x269e4
@   0x08026f40: f7ff        fd76 	bl	0x26a30
@   0x08026f44: f7ff        fdc4 	bl	0x26ad0
@   0x08026f48: f7ff        fe1c 	bl	0x26b84
@   0x08026f4c: f7ff        feb8 	bl	0x26cc0
@   0x08026f50: f7ff        fedc 	bl	0x26d0c
@   0x08026f54: f7ff        fae2 	bl	0x2651c
@   0x08026f58: f7ff        fefe 	bl	0x26d58
@   0x08026f5c: f7ff        ff70 	bl	0x26e40
@   0x08026f60: f7ff        ff96 	bl	0x26e90
@   0x08026f64: 4805        ldr	r0, [pc, #20]	@ (0x26f7c)
@   0x08026f66: 210a        movs	r1, #10
@   0x08026f68: 5e40        ldrsh	r0, [r0, r1]
@   0x08026f6a: 286e        cmp	r0, #110	@ 0x6e
@   0x08026f6c: dc08        bgt.n	0x26f80
@   0x08026f6e: f7ff        fe4f 	bl	0x26c10
@   0x08026f72: e007        b.n	0x26f84
@   0x08026f74: 3570        adds	r5, #112	@ 0x70
@   0x08026f76: 0300        lsls	r0, r0, #12
@   0x08026f78: 5bb0        ldrh	r0, [r6, r6]
@   0x08026f7a: 0831        lsrs	r1, r6, #32
@   0x08026f7c: 35e0        adds	r5, #224	@ 0xe0
@   0x08026f7e: 0300        lsls	r0, r0, #12
@   0x08026f80: f7ff        fe72 	bl	0x26c68
@   0x08026f84: bc30        pop	{r4, r5}
@   0x08026f86: bc01        pop	{r0}
@   0x08026f88: 4700        bx	r0

        thumb_func_start sub_08026F14
sub_08026F14: @ 0x08026f14
        .incbin "baserom.gba", 0x26f14, 0x78
        thumb_func_end sub_08026F14
