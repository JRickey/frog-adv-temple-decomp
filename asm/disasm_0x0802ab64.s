@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ab64, 0x0802abb0)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ab64 --end 0x802abb0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ab64: b530        push	{r4, r5, lr}
@   0x0802ab66: b084        sub	sp, #16
@   0x0802ab68: 2400        movs	r4, #0
@   0x0802ab6a: 1c20        adds	r0, r4, #0
@   0x0802ab6c: 3011        adds	r0, #17
@   0x0802ab6e: 4a0e        ldr	r2, [pc, #56]	@ (0x2aba8)
@   0x0802ab70: 00a1        lsls	r1, r4, #2
@   0x0802ab72: 1889        adds	r1, r1, r2
@   0x0802ab74: 6809        ldr	r1, [r1, #0]
@   0x0802ab76: 2201        movs	r2, #1
@   0x0802ab78: 4022        ands	r2, r4
@   0x0802ab7a: 0112        lsls	r2, r2, #4
@   0x0802ab7c: 4d0b        ldr	r5, [pc, #44]	@ (0x2abac)
@   0x0802ab7e: 1c2b        adds	r3, r5, #0
@   0x0802ab80: 431a        orrs	r2, r3
@   0x0802ab82: 9200        str	r2, [sp, #0]
@   0x0802ab84: 2206        movs	r2, #6
@   0x0802ab86: 9201        str	r2, [sp, #4]
@   0x0802ab88: 2203        movs	r2, #3
@   0x0802ab8a: 9202        str	r2, [sp, #8]
@   0x0802ab8c: 9203        str	r2, [sp, #12]
@   0x0802ab8e: 2200        movs	r2, #0
@   0x0802ab90: 231b        movs	r3, #27
@   0x0802ab92: f7f6        fa85 	bl	0x210a0
@   0x0802ab96: 1c60        adds	r0, r4, #1
@   0x0802ab98: 0600        lsls	r0, r0, #24
@   0x0802ab9a: 0e04        lsrs	r4, r0, #24
@   0x0802ab9c: 2c01        cmp	r4, #1
@   0x0802ab9e: d9e4        bls.n	0x2ab6a
@   0x0802aba0: b004        add	sp, #16
@   0x0802aba2: bc30        pop	{r4, r5}
@   0x0802aba4: bc01        pop	{r0}
@   0x0802aba6: 4700        bx	r0
@   0x0802aba8: 7e6c        ldrb	r4, [r5, #25]
@   0x0802abaa: 0831        lsrs	r1, r6, #32
@   0x0802abac: 0161        lsls	r1, r4, #5

        thumb_func_start sub_0802AB64
sub_0802AB64: @ 0x0802ab64
        .incbin "frog_us_baserom.gba", 0x2ab64, 0x4c
        thumb_func_end sub_0802AB64
