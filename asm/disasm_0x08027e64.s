@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027e64, 0x08027eb0)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027e64 --end 0x8027eb0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027e64: b530        push	{r4, r5, lr}
@   0x08027e66: b084        sub	sp, #16
@   0x08027e68: 2400        movs	r4, #0
@   0x08027e6a: 2503        movs	r5, #3
@   0x08027e6c: 1c20        adds	r0, r4, #0
@   0x08027e6e: 3029        adds	r0, #41	@ 0x29
@   0x08027e70: 4a0e        ldr	r2, [pc, #56]	@ (0x27eac)
@   0x08027e72: 00a1        lsls	r1, r4, #2
@   0x08027e74: 1889        adds	r1, r1, r2
@   0x08027e76: 6809        ldr	r1, [r1, #0]
@   0x08027e78: 1c22        adds	r2, r4, #0
@   0x08027e7a: 402a        ands	r2, r5
@   0x08027e7c: 0512        lsls	r2, r2, #20
@   0x08027e7e: 23e1        movs	r3, #225	@ 0xe1
@   0x08027e80: 041b        lsls	r3, r3, #16
@   0x08027e82: 18d2        adds	r2, r2, r3
@   0x08027e84: 0c12        lsrs	r2, r2, #16
@   0x08027e86: 9200        str	r2, [sp, #0]
@   0x08027e88: 2207        movs	r2, #7
@   0x08027e8a: 9201        str	r2, [sp, #4]
@   0x08027e8c: 9502        str	r5, [sp, #8]
@   0x08027e8e: 9503        str	r5, [sp, #12]
@   0x08027e90: 2210        movs	r2, #16
@   0x08027e92: 233a        movs	r3, #58	@ 0x3a
@   0x08027e94: f7f9        f904 	bl	0x210a0
@   0x08027e98: 1c60        adds	r0, r4, #1
@   0x08027e9a: 0600        lsls	r0, r0, #24
@   0x08027e9c: 0e04        lsrs	r4, r0, #24
@   0x08027e9e: 2c09        cmp	r4, #9
@   0x08027ea0: d9e4        bls.n	0x27e6c
@   0x08027ea2: b004        add	sp, #16
@   0x08027ea4: bc30        pop	{r4, r5}
@   0x08027ea6: bc01        pop	{r0}
@   0x08027ea8: 4700        bx	r0
@   0x08027eaa: 0000        movs	r0, r0
@   0x08027eac: 6dd0        ldr	r0, [r2, #92]	@ 0x5c
@   0x08027eae: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027E64
sub_08027E64: @ 0x08027e64
        .incbin "baserom.gba", 0x27e64, 0x4c
        thumb_func_end sub_08027E64
