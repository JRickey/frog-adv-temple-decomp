@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080297ac, 0x080297f0)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80297ac --end 0x80297f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080297ac: b570        push	{r4, r5, r6, lr}
@   0x080297ae: b084        sub	sp, #16
@   0x080297b0: 2400        movs	r4, #0
@   0x080297b2: 4e0d        ldr	r6, [pc, #52]	@ (0x297e8)
@   0x080297b4: 2503        movs	r5, #3
@   0x080297b6: 1c20        adds	r0, r4, #0
@   0x080297b8: 3057        adds	r0, #87	@ 0x57
@   0x080297ba: 00a1        lsls	r1, r4, #2
@   0x080297bc: 1989        adds	r1, r1, r6
@   0x080297be: 6809        ldr	r1, [r1, #0]
@   0x080297c0: 4a0a        ldr	r2, [pc, #40]	@ (0x297ec)
@   0x080297c2: 9200        str	r2, [sp, #0]
@   0x080297c4: 2209        movs	r2, #9
@   0x080297c6: 9201        str	r2, [sp, #4]
@   0x080297c8: 9502        str	r5, [sp, #8]
@   0x080297ca: 9503        str	r5, [sp, #12]
@   0x080297cc: 2200        movs	r2, #0
@   0x080297ce: 2343        movs	r3, #67	@ 0x43
@   0x080297d0: f7f7        fc66 	bl	0x210a0
@   0x080297d4: 1c60        adds	r0, r4, #1
@   0x080297d6: 0600        lsls	r0, r0, #24
@   0x080297d8: 0e04        lsrs	r4, r0, #24
@   0x080297da: 2c01        cmp	r4, #1
@   0x080297dc: d9eb        bls.n	0x297b6
@   0x080297de: b004        add	sp, #16
@   0x080297e0: bc70        pop	{r4, r5, r6}
@   0x080297e2: bc01        pop	{r0}
@   0x080297e4: 4700        bx	r0
@   0x080297e6: 0000        movs	r0, r0
@   0x080297e8: 7ab0        ldrb	r0, [r6, #10]
@   0x080297ea: 0831        lsrs	r1, r6, #32
@   0x080297ec: 01e5        lsls	r5, r4, #7

        thumb_func_start sub_080297AC
sub_080297AC: @ 0x080297ac
        .incbin "baserom.gba", 0x297ac, 0x44
        thumb_func_end sub_080297AC
