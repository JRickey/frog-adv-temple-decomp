@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024094, 0x080240e0)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024094 --end 0x80240e0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024094: b530        push	{r4, r5, lr}
@   0x08024096: b084        sub	sp, #16
@   0x08024098: 2400        movs	r4, #0
@   0x0802409a: 2503        movs	r5, #3
@   0x0802409c: 1c20        adds	r0, r4, #0
@   0x0802409e: 3028        adds	r0, #40	@ 0x28
@   0x080240a0: 4a0e        ldr	r2, [pc, #56]	@ (0x240dc)
@   0x080240a2: 00a1        lsls	r1, r4, #2
@   0x080240a4: 1889        adds	r1, r1, r2
@   0x080240a6: 6809        ldr	r1, [r1, #0]
@   0x080240a8: 1c22        adds	r2, r4, #0
@   0x080240aa: 402a        ands	r2, r5
@   0x080240ac: 0512        lsls	r2, r2, #20
@   0x080240ae: 23b1        movs	r3, #177	@ 0xb1
@   0x080240b0: 041b        lsls	r3, r3, #16
@   0x080240b2: 18d2        adds	r2, r2, r3
@   0x080240b4: 0c12        lsrs	r2, r2, #16
@   0x080240b6: 9200        str	r2, [sp, #0]
@   0x080240b8: 2204        movs	r2, #4
@   0x080240ba: 9201        str	r2, [sp, #4]
@   0x080240bc: 9502        str	r5, [sp, #8]
@   0x080240be: 9503        str	r5, [sp, #12]
@   0x080240c0: 2200        movs	r2, #0
@   0x080240c2: 231b        movs	r3, #27
@   0x080240c4: f7fc        ffec 	bl	0x210a0
@   0x080240c8: 1c60        adds	r0, r4, #1
@   0x080240ca: 0600        lsls	r0, r0, #24
@   0x080240cc: 0e04        lsrs	r4, r0, #24
@   0x080240ce: 2c0a        cmp	r4, #10
@   0x080240d0: d9e4        bls.n	0x2409c
@   0x080240d2: b004        add	sp, #16
@   0x080240d4: bc30        pop	{r4, r5}
@   0x080240d6: bc01        pop	{r0}
@   0x080240d8: 4700        bx	r0
@   0x080240da: 0000        movs	r0, r0
@   0x080240dc: 2da8        cmp	r5, #168	@ 0xa8
@   0x080240de: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024094
sub_08024094: @ 0x08024094
        .incbin "frog_us_baserom.gba", 0x24094, 0x4c
        thumb_func_end sub_08024094
