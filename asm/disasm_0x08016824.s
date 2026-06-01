@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08016824, 0x080168a0)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8016824 --end 0x80168a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08016824: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08016826: 0600        lsls	r0, r0, #24
@   0x08016828: 0e00        lsrs	r0, r0, #24
@   0x0801682a: 4d1b        ldr	r5, [pc, #108]	@ (0x16898)
@   0x0801682c: 0041        lsls	r1, r0, #1
@   0x0801682e: 1809        adds	r1, r1, r0
@   0x08016830: 00cb        lsls	r3, r1, #3
@   0x08016832: 195a        adds	r2, r3, r5
@   0x08016834: 8810        ldrh	r0, [r2, #0]
@   0x08016836: 0041        lsls	r1, r0, #1
@   0x08016838: 8854        ldrh	r4, [r2, #2]
@   0x0801683a: 01a0        lsls	r0, r4, #6
@   0x0801683c: 4e17        ldr	r6, [pc, #92]	@ (0x1689c)
@   0x0801683e: 1980        adds	r0, r0, r6
@   0x08016840: 1809        adds	r1, r1, r0
@   0x08016842: 1c28        adds	r0, r5, #0
@   0x08016844: 3010        adds	r0, #16
@   0x08016846: 1818        adds	r0, r3, r0
@   0x08016848: 6800        ldr	r0, [r0, #0]
@   0x0801684a: 6804        ldr	r4, [r0, #0]
@   0x0801684c: 2000        movs	r0, #0
@   0x0801684e: 88d6        ldrh	r6, [r2, #6]
@   0x08016850: 42b0        cmp	r0, r6
@   0x08016852: d21d        bcs.n	0x16890
@   0x08016854: 46ac        mov	ip, r5
@   0x08016856: 1c15        adds	r5, r2, #0
@   0x08016858: 1c1f        adds	r7, r3, #0
@   0x0801685a: 2200        movs	r2, #0
@   0x0801685c: 1c46        adds	r6, r0, #1
@   0x0801685e: 88a8        ldrh	r0, [r5, #4]
@   0x08016860: 4282        cmp	r2, r0
@   0x08016862: d20b        bcs.n	0x1687c
@   0x08016864: 4660        mov	r0, ip
@   0x08016866: 183b        adds	r3, r7, r0
@   0x08016868: 8820        ldrh	r0, [r4, #0]
@   0x0801686a: 8008        strh	r0, [r1, #0]
@   0x0801686c: 3402        adds	r4, #2
@   0x0801686e: 3102        adds	r1, #2
@   0x08016870: 1c50        adds	r0, r2, #1
@   0x08016872: 0600        lsls	r0, r0, #24
@   0x08016874: 0e02        lsrs	r2, r0, #24
@   0x08016876: 8898        ldrh	r0, [r3, #4]
@   0x08016878: 4282        cmp	r2, r0
@   0x0801687a: d3f5        bcc.n	0x16868
@   0x0801687c: 2020        movs	r0, #32
@   0x0801687e: 88aa        ldrh	r2, [r5, #4]
@   0x08016880: 1a80        subs	r0, r0, r2
@   0x08016882: 0040        lsls	r0, r0, #1
@   0x08016884: 1809        adds	r1, r1, r0
@   0x08016886: 0630        lsls	r0, r6, #24
@   0x08016888: 0e00        lsrs	r0, r0, #24
@   0x0801688a: 88ee        ldrh	r6, [r5, #6]
@   0x0801688c: 42b0        cmp	r0, r6
@   0x0801688e: d3e4        bcc.n	0x1685a
@   0x08016890: bcf0        pop	{r4, r5, r6, r7}
@   0x08016892: bc01        pop	{r0}
@   0x08016894: 4700        bx	r0
@   0x08016896: 0000        movs	r0, r0
@   0x08016898: 6840        ldr	r0, [r0, #4]
@   0x0801689a: 0830        lsrs	r0, r6, #32
@   0x0801689c: f800        0600 	strb.w	r0, [r0, <undefined>]

        thumb_func_start sub_08016824
sub_08016824: @ 0x08016824
        .incbin "frog_us_baserom.gba", 0x16824, 0x7c
        thumb_func_end sub_08016824
