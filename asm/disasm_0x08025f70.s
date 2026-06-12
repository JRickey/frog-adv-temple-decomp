@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025f70, 0x08025fbc)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025f70 --end 0x8025fbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025f70: b530        push	{r4, r5, lr}
@   0x08025f72: b084        sub	sp, #16
@   0x08025f74: 2400        movs	r4, #0
@   0x08025f76: 1c20        adds	r0, r4, #0
@   0x08025f78: 3048        adds	r0, #72	@ 0x48
@   0x08025f7a: 4a0e        ldr	r2, [pc, #56]	@ (0x25fb4)
@   0x08025f7c: 00a1        lsls	r1, r4, #2
@   0x08025f7e: 1889        adds	r1, r1, r2
@   0x08025f80: 6809        ldr	r1, [r1, #0]
@   0x08025f82: 2201        movs	r2, #1
@   0x08025f84: 4022        ands	r2, r4
@   0x08025f86: 0112        lsls	r2, r2, #4
@   0x08025f88: 4d0b        ldr	r5, [pc, #44]	@ (0x25fb8)
@   0x08025f8a: 1c2b        adds	r3, r5, #0
@   0x08025f8c: 431a        orrs	r2, r3
@   0x08025f8e: 9200        str	r2, [sp, #0]
@   0x08025f90: 2208        movs	r2, #8
@   0x08025f92: 9201        str	r2, [sp, #4]
@   0x08025f94: 2203        movs	r2, #3
@   0x08025f96: 9202        str	r2, [sp, #8]
@   0x08025f98: 9203        str	r2, [sp, #12]
@   0x08025f9a: 2200        movs	r2, #0
@   0x08025f9c: 2327        movs	r3, #39	@ 0x27
@   0x08025f9e: f7fb        f87f 	bl	0x210a0
@   0x08025fa2: 1c60        adds	r0, r4, #1
@   0x08025fa4: 0600        lsls	r0, r0, #24
@   0x08025fa6: 0e04        lsrs	r4, r0, #24
@   0x08025fa8: 2c01        cmp	r4, #1
@   0x08025faa: d9e4        bls.n	0x25f76
@   0x08025fac: b004        add	sp, #16
@   0x08025fae: bc30        pop	{r4, r5}
@   0x08025fb0: bc01        pop	{r0}
@   0x08025fb2: 4700        bx	r0
@   0x08025fb4: 4ad4        ldr	r2, [pc, #848]	@ (0x26308)
@   0x08025fb6: 0831        lsrs	r1, r6, #32
@   0x08025fb8: 0261        lsls	r1, r4, #9

        thumb_func_start sub_08025F70
sub_08025F70: @ 0x08025f70
        .incbin "baserom.gba", 0x25f70, 0x4c
        thumb_func_end sub_08025F70
