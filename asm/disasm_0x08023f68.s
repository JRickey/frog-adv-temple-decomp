@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023f68, 0x08023fac)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023f68 --end 0x8023fac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023f68: b530        push	{r4, r5, lr}
@   0x08023f6a: b084        sub	sp, #16
@   0x08023f6c: 2400        movs	r4, #0
@   0x08023f6e: 2503        movs	r5, #3
@   0x08023f70: 1ca0        adds	r0, r4, #2
@   0x08023f72: 4a0d        ldr	r2, [pc, #52]	@ (0x23fa8)
@   0x08023f74: 00a1        lsls	r1, r4, #2
@   0x08023f76: 1889        adds	r1, r1, r2
@   0x08023f78: 6809        ldr	r1, [r1, #0]
@   0x08023f7a: 1c22        adds	r2, r4, #0
@   0x08023f7c: 402a        ands	r2, r5
@   0x08023f7e: 0112        lsls	r2, r2, #4
@   0x08023f80: 3241        adds	r2, #65	@ 0x41
@   0x08023f82: 9200        str	r2, [sp, #0]
@   0x08023f84: 2201        movs	r2, #1
@   0x08023f86: 9201        str	r2, [sp, #4]
@   0x08023f88: 9502        str	r5, [sp, #8]
@   0x08023f8a: 9503        str	r5, [sp, #12]
@   0x08023f8c: 2210        movs	r2, #16
@   0x08023f8e: 2307        movs	r3, #7
@   0x08023f90: f7fd        f886 	bl	0x210a0
@   0x08023f94: 1c60        adds	r0, r4, #1
@   0x08023f96: 0600        lsls	r0, r0, #24
@   0x08023f98: 0e04        lsrs	r4, r0, #24
@   0x08023f9a: 2c07        cmp	r4, #7
@   0x08023f9c: d9e8        bls.n	0x23f70
@   0x08023f9e: b004        add	sp, #16
@   0x08023fa0: bc30        pop	{r4, r5}
@   0x08023fa2: bc01        pop	{r0}
@   0x08023fa4: 4700        bx	r0
@   0x08023fa6: 0000        movs	r0, r0
@   0x08023fa8: 2d60        cmp	r5, #96	@ 0x60
@   0x08023faa: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08023F68
sub_08023F68: @ 0x08023f68
        .incbin "frog_us_baserom.gba", 0x23f68, 0x44
        thumb_func_end sub_08023F68
