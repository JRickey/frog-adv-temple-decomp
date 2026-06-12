@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080252e8, 0x0802532c)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80252e8 --end 0x802532c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080252e8: b570        push	{r4, r5, r6, lr}
@   0x080252ea: b084        sub	sp, #16
@   0x080252ec: 2400        movs	r4, #0
@   0x080252ee: 4e0d        ldr	r6, [pc, #52]	@ (0x25324)
@   0x080252f0: 2503        movs	r5, #3
@   0x080252f2: 1c20        adds	r0, r4, #0
@   0x080252f4: 3034        adds	r0, #52	@ 0x34
@   0x080252f6: 00a1        lsls	r1, r4, #2
@   0x080252f8: 1989        adds	r1, r1, r6
@   0x080252fa: 6809        ldr	r1, [r1, #0]
@   0x080252fc: 4a0a        ldr	r2, [pc, #40]	@ (0x25328)
@   0x080252fe: 9200        str	r2, [sp, #0]
@   0x08025300: 2205        movs	r2, #5
@   0x08025302: 9201        str	r2, [sp, #4]
@   0x08025304: 9502        str	r5, [sp, #8]
@   0x08025306: 9503        str	r5, [sp, #12]
@   0x08025308: 2200        movs	r2, #0
@   0x0802530a: 2323        movs	r3, #35	@ 0x23
@   0x0802530c: f7fb        fec8 	bl	0x210a0
@   0x08025310: 1c60        adds	r0, r4, #1
@   0x08025312: 0600        lsls	r0, r0, #24
@   0x08025314: 0e04        lsrs	r4, r0, #24
@   0x08025316: 2c05        cmp	r4, #5
@   0x08025318: d9eb        bls.n	0x252f2
@   0x0802531a: b004        add	sp, #16
@   0x0802531c: bc70        pop	{r4, r5, r6}
@   0x0802531e: bc01        pop	{r0}
@   0x08025320: 4700        bx	r0
@   0x08025322: 0000        movs	r0, r0
@   0x08025324: 3fec        subs	r7, #236	@ 0xec
@   0x08025326: 0831        lsrs	r1, r6, #32
@   0x08025328: 0281        lsls	r1, r0, #10

        thumb_func_start sub_080252E8
sub_080252E8: @ 0x080252e8
        .incbin "baserom.gba", 0x252e8, 0x44
        thumb_func_end sub_080252E8
