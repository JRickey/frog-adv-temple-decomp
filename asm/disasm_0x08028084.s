@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028084, 0x080280c8)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028084 --end 0x80280c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028084: b570        push	{r4, r5, r6, lr}
@   0x08028086: b084        sub	sp, #16
@   0x08028088: 2400        movs	r4, #0
@   0x0802808a: 4e0d        ldr	r6, [pc, #52]	@ (0x280c0)
@   0x0802808c: 2503        movs	r5, #3
@   0x0802808e: 1c20        adds	r0, r4, #0
@   0x08028090: 3045        adds	r0, #69	@ 0x45
@   0x08028092: 00a1        lsls	r1, r4, #2
@   0x08028094: 1989        adds	r1, r1, r6
@   0x08028096: 6809        ldr	r1, [r1, #0]
@   0x08028098: 4a0a        ldr	r2, [pc, #40]	@ (0x280c4)
@   0x0802809a: 9200        str	r2, [sp, #0]
@   0x0802809c: 220b        movs	r2, #11
@   0x0802809e: 9201        str	r2, [sp, #4]
@   0x080280a0: 9502        str	r5, [sp, #8]
@   0x080280a2: 9503        str	r5, [sp, #12]
@   0x080280a4: 2200        movs	r2, #0
@   0x080280a6: 233f        movs	r3, #63	@ 0x3f
@   0x080280a8: f7f8        fffa 	bl	0x210a0
@   0x080280ac: 1c60        adds	r0, r4, #1
@   0x080280ae: 0600        lsls	r0, r0, #24
@   0x080280b0: 0e04        lsrs	r4, r0, #24
@   0x080280b2: 2c03        cmp	r4, #3
@   0x080280b4: d9eb        bls.n	0x2808e
@   0x080280b6: b004        add	sp, #16
@   0x080280b8: bc70        pop	{r4, r5, r6}
@   0x080280ba: bc01        pop	{r0}
@   0x080280bc: 4700        bx	r0
@   0x080280be: 0000        movs	r0, r0
@   0x080280c0: 6e3c        ldr	r4, [r7, #96]	@ 0x60
@   0x080280c2: 0831        lsrs	r1, r6, #32
@   0x080280c4: 01d1        lsls	r1, r2, #7

        thumb_func_start sub_08028084
sub_08028084: @ 0x08028084
        .incbin "baserom.gba", 0x28084, 0x44
        thumb_func_end sub_08028084
