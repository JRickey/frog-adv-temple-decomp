@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080253f0, 0x0802543c)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80253f0 --end 0x802543c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080253f0: b530        push	{r4, r5, lr}
@   0x080253f2: b084        sub	sp, #16
@   0x080253f4: 2400        movs	r4, #0
@   0x080253f6: 2503        movs	r5, #3
@   0x080253f8: 1c20        adds	r0, r4, #0
@   0x080253fa: 303d        adds	r0, #61	@ 0x3d
@   0x080253fc: 4a0e        ldr	r2, [pc, #56]	@ (0x25438)
@   0x080253fe: 00a1        lsls	r1, r4, #2
@   0x08025400: 1889        adds	r1, r1, r2
@   0x08025402: 6809        ldr	r1, [r1, #0]
@   0x08025404: 1c22        adds	r2, r4, #0
@   0x08025406: 402a        ands	r2, r5
@   0x08025408: 0552        lsls	r2, r2, #21
@   0x0802540a: 23f1        movs	r3, #241	@ 0xf1
@   0x0802540c: 041b        lsls	r3, r3, #16
@   0x0802540e: 18d2        adds	r2, r2, r3
@   0x08025410: 0c12        lsrs	r2, r2, #16
@   0x08025412: 9200        str	r2, [sp, #0]
@   0x08025414: 2207        movs	r2, #7
@   0x08025416: 9201        str	r2, [sp, #4]
@   0x08025418: 9502        str	r5, [sp, #8]
@   0x0802541a: 9503        str	r5, [sp, #12]
@   0x0802541c: 2210        movs	r2, #16
@   0x0802541e: 2321        movs	r3, #33	@ 0x21
@   0x08025420: f7fb        fe3e 	bl	0x210a0
@   0x08025424: 1c60        adds	r0, r4, #1
@   0x08025426: 0600        lsls	r0, r0, #24
@   0x08025428: 0e04        lsrs	r4, r0, #24
@   0x0802542a: 2c03        cmp	r4, #3
@   0x0802542c: d9e4        bls.n	0x253f8
@   0x0802542e: b004        add	sp, #16
@   0x08025430: bc30        pop	{r4, r5}
@   0x08025432: bc01        pop	{r0}
@   0x08025434: 4700        bx	r0
@   0x08025436: 0000        movs	r0, r0
@   0x08025438: 4004        ands	r4, r0
@   0x0802543a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080253F0
sub_080253F0: @ 0x080253f0
        .incbin "baserom.gba", 0x253f0, 0x4c
        thumb_func_end sub_080253F0
