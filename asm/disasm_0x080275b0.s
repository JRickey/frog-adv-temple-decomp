@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080275b0, 0x080275fc)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80275b0 --end 0x80275fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080275b0: b530        push	{r4, r5, lr}
@   0x080275b2: b084        sub	sp, #16
@   0x080275b4: 2400        movs	r4, #0
@   0x080275b6: 2503        movs	r5, #3
@   0x080275b8: 1c20        adds	r0, r4, #0
@   0x080275ba: 305f        adds	r0, #95	@ 0x5f
@   0x080275bc: 4a0d        ldr	r2, [pc, #52]	@ (0x275f4)
@   0x080275be: 00a1        lsls	r1, r4, #2
@   0x080275c0: 1889        adds	r1, r1, r2
@   0x080275c2: 6809        ldr	r1, [r1, #0]
@   0x080275c4: 1c22        adds	r2, r4, #0
@   0x080275c6: 402a        ands	r2, r5
@   0x080275c8: 0512        lsls	r2, r2, #20
@   0x080275ca: 4b0b        ldr	r3, [pc, #44]	@ (0x275f8)
@   0x080275cc: 18d2        adds	r2, r2, r3
@   0x080275ce: 0c12        lsrs	r2, r2, #16
@   0x080275d0: 9200        str	r2, [sp, #0]
@   0x080275d2: 220a        movs	r2, #10
@   0x080275d4: 9201        str	r2, [sp, #4]
@   0x080275d6: 9502        str	r5, [sp, #8]
@   0x080275d8: 9503        str	r5, [sp, #12]
@   0x080275da: 2210        movs	r2, #16
@   0x080275dc: 232f        movs	r3, #47	@ 0x2f
@   0x080275de: f7f9        fd5f 	bl	0x210a0
@   0x080275e2: 1c60        adds	r0, r4, #1
@   0x080275e4: 0600        lsls	r0, r0, #24
@   0x080275e6: 0e04        lsrs	r4, r0, #24
@   0x080275e8: 2c04        cmp	r4, #4
@   0x080275ea: d9e5        bls.n	0x275b8
@   0x080275ec: b004        add	sp, #16
@   0x080275ee: bc30        pop	{r4, r5}
@   0x080275f0: bc01        pop	{r0}
@   0x080275f2: 4700        bx	r0
@   0x080275f4: 66e0        str	r0, [r4, #108]	@ 0x6c
@   0x080275f6: 0831        lsrs	r1, r6, #32
@   0x080275f8: 0000        movs	r0, r0
@   0x080275fa: 0331        lsls	r1, r6, #12

        thumb_func_start sub_080275B0
sub_080275B0: @ 0x080275b0
        .incbin "baserom.gba", 0x275b0, 0x4c
        thumb_func_end sub_080275B0
