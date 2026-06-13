@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027f78, 0x08027fd0)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027f78 --end 0x8027fd0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027f78: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08027f7a: b084        sub	sp, #16
@   0x08027f7c: 2600        movs	r6, #0
@   0x08027f7e: 2703        movs	r7, #3
@   0x08027f80: 1c35        adds	r5, r6, #0
@   0x08027f82: 353d        adds	r5, #61	@ 0x3d
@   0x08027f84: 4910        ldr	r1, [pc, #64]	@ (0x27fc8)
@   0x08027f86: 00b0        lsls	r0, r6, #2
@   0x08027f88: 1840        adds	r0, r0, r1
@   0x08027f8a: 6804        ldr	r4, [r0, #0]
@   0x08027f8c: 1c30        adds	r0, r6, #0
@   0x08027f8e: 2103        movs	r1, #3
@   0x08027f90: f00b        ffe4 	bl	0x33f5c
@   0x08027f94: 0600        lsls	r0, r0, #24
@   0x08027f96: 0900        lsrs	r0, r0, #4
@   0x08027f98: 490c        ldr	r1, [pc, #48]	@ (0x27fcc)
@   0x08027f9a: 1840        adds	r0, r0, r1
@   0x08027f9c: 0c00        lsrs	r0, r0, #16
@   0x08027f9e: 9000        str	r0, [sp, #0]
@   0x08027fa0: 2009        movs	r0, #9
@   0x08027fa2: 9001        str	r0, [sp, #4]
@   0x08027fa4: 9702        str	r7, [sp, #8]
@   0x08027fa6: 9703        str	r7, [sp, #12]
@   0x08027fa8: 1c28        adds	r0, r5, #0
@   0x08027faa: 1c21        adds	r1, r4, #0
@   0x08027fac: 2210        movs	r2, #16
@   0x08027fae: 233c        movs	r3, #60	@ 0x3c
@   0x08027fb0: f7f9        f876 	bl	0x210a0
@   0x08027fb4: 1c70        adds	r0, r6, #1
@   0x08027fb6: 0600        lsls	r0, r0, #24
@   0x08027fb8: 0e06        lsrs	r6, r0, #24
@   0x08027fba: 2e06        cmp	r6, #6
@   0x08027fbc: d9e0        bls.n	0x27f80
@   0x08027fbe: b004        add	sp, #16
@   0x08027fc0: bcf0        pop	{r4, r5, r6, r7}
@   0x08027fc2: bc01        pop	{r0}
@   0x08027fc4: 4700        bx	r0
@   0x08027fc6: 0000        movs	r0, r0
@   0x08027fc8: 6e20        ldr	r0, [r4, #96]	@ 0x60
@   0x08027fca: 0831        lsrs	r1, r6, #32
@   0x08027fcc: 0000        movs	r0, r0
@   0x08027fce: 0191        lsls	r1, r2, #6

        thumb_func_start sub_08027F78
sub_08027F78: @ 0x08027f78
        .incbin "baserom.gba", 0x27f78, 0x58
        thumb_func_end sub_08027F78
