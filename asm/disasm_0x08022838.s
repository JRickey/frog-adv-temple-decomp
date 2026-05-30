@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022838, 0x08022884)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022838 --end 0x8022884 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022838: b570        push	{r4, r5, r6, lr}
@   0x0802283a: b084        sub	sp, #16
@   0x0802283c: 2400        movs	r4, #0
@   0x0802283e: 4e0f        ldr	r6, [pc, #60]	@ (0x2287c)
@   0x08022840: 2503        movs	r5, #3
@   0x08022842: 1c20        adds	r0, r4, #0
@   0x08022844: 303e        adds	r0, #62	@ 0x3e
@   0x08022846: 00a1        lsls	r1, r4, #2
@   0x08022848: 1989        adds	r1, r1, r6
@   0x0802284a: 6809        ldr	r1, [r1, #0]
@   0x0802284c: 4a0c        ldr	r2, [pc, #48]	@ (0x22880)
@   0x0802284e: 9200        str	r2, [sp, #0]
@   0x08022850: 2209        movs	r2, #9
@   0x08022852: 9201        str	r2, [sp, #4]
@   0x08022854: 9502        str	r5, [sp, #8]
@   0x08022856: 9503        str	r5, [sp, #12]
@   0x08022858: 2280        movs	r2, #128	@ 0x80
@   0x0802285a: 00d2        lsls	r2, r2, #3
@   0x0802285c: 230e        movs	r3, #14
@   0x0802285e: f7fe        fc1f 	bl	0x210a0
@   0x08022862: 1c60        adds	r0, r4, #1
@   0x08022864: 0600        lsls	r0, r0, #24
@   0x08022866: 0e04        lsrs	r4, r0, #24
@   0x08022868: 2c06        cmp	r4, #6
@   0x0802286a: d9ea        bls.n	0x22842
@   0x0802286c: 203e        movs	r0, #62	@ 0x3e
@   0x0802286e: f7e3        fdbd 	bl	0x63ec
@   0x08022872: b004        add	sp, #16
@   0x08022874: bc70        pop	{r4, r5, r6}
@   0x08022876: bc01        pop	{r0}
@   0x08022878: 4700        bx	r0
@   0x0802287a: 0000        movs	r0, r0
@   0x0802287c: 118c        asrs	r4, r1, #6
@   0x0802287e: 0831        lsrs	r1, r6, #32
@   0x08022880: 0165        lsls	r5, r4, #5

        thumb_func_start sub_08022838
sub_08022838: @ 0x08022838
        .incbin "frog_us_baserom.gba", 0x22838, 0x4c
        thumb_func_end sub_08022838
