@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080268c8, 0x0802690c)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80268c8 --end 0x802690c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080268c8: b570        push	{r4, r5, r6, lr}
@   0x080268ca: b084        sub	sp, #16
@   0x080268cc: 2400        movs	r4, #0
@   0x080268ce: 4e0e        ldr	r6, [pc, #56]	@ (0x26908)
@   0x080268d0: 2503        movs	r5, #3
@   0x080268d2: 1d20        adds	r0, r4, #4
@   0x080268d4: 00a1        lsls	r1, r4, #2
@   0x080268d6: 1989        adds	r1, r1, r6
@   0x080268d8: 6809        ldr	r1, [r1, #0]
@   0x080268da: 2241        movs	r2, #65	@ 0x41
@   0x080268dc: 9200        str	r2, [sp, #0]
@   0x080268de: 2201        movs	r2, #1
@   0x080268e0: 9201        str	r2, [sp, #4]
@   0x080268e2: 9502        str	r5, [sp, #8]
@   0x080268e4: 9503        str	r5, [sp, #12]
@   0x080268e6: 2280        movs	r2, #128	@ 0x80
@   0x080268e8: 00d2        lsls	r2, r2, #3
@   0x080268ea: 2335        movs	r3, #53	@ 0x35
@   0x080268ec: f7fa        fbd8 	bl	0x210a0
@   0x080268f0: 1c60        adds	r0, r4, #1
@   0x080268f2: 0600        lsls	r0, r0, #24
@   0x080268f4: 0e04        lsrs	r4, r0, #24
@   0x080268f6: 2c0a        cmp	r4, #10
@   0x080268f8: d9eb        bls.n	0x268d2
@   0x080268fa: 2004        movs	r0, #4
@   0x080268fc: f7df        fd76 	bl	0x63ec
@   0x08026900: b004        add	sp, #16
@   0x08026902: bc70        pop	{r4, r5, r6}
@   0x08026904: bc01        pop	{r0}
@   0x08026906: 4700        bx	r0
@   0x08026908: 5a48        ldrh	r0, [r1, r1]
@   0x0802690a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080268C8
sub_080268C8: @ 0x080268c8
        .incbin "baserom.gba", 0x268c8, 0x44
        thumb_func_end sub_080268C8
