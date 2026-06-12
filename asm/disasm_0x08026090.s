@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026090, 0x080260d4)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026090 --end 0x80260d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026090: b570        push	{r4, r5, r6, lr}
@   0x08026092: b084        sub	sp, #16
@   0x08026094: 2400        movs	r4, #0
@   0x08026096: 4e0d        ldr	r6, [pc, #52]	@ (0x260cc)
@   0x08026098: 2503        movs	r5, #3
@   0x0802609a: 1c20        adds	r0, r4, #0
@   0x0802609c: 3053        adds	r0, #83	@ 0x53
@   0x0802609e: 00a1        lsls	r1, r4, #2
@   0x080260a0: 1989        adds	r1, r1, r6
@   0x080260a2: 6809        ldr	r1, [r1, #0]
@   0x080260a4: 4a0a        ldr	r2, [pc, #40]	@ (0x260d0)
@   0x080260a6: 9200        str	r2, [sp, #0]
@   0x080260a8: 220b        movs	r2, #11
@   0x080260aa: 9201        str	r2, [sp, #4]
@   0x080260ac: 9502        str	r5, [sp, #8]
@   0x080260ae: 9503        str	r5, [sp, #12]
@   0x080260b0: 2210        movs	r2, #16
@   0x080260b2: 2326        movs	r3, #38	@ 0x26
@   0x080260b4: f7fa        fff4 	bl	0x210a0
@   0x080260b8: 1c60        adds	r0, r4, #1
@   0x080260ba: 0600        lsls	r0, r0, #24
@   0x080260bc: 0e04        lsrs	r4, r0, #24
@   0x080260be: 2c0a        cmp	r4, #10
@   0x080260c0: d9eb        bls.n	0x2609a
@   0x080260c2: b004        add	sp, #16
@   0x080260c4: bc70        pop	{r4, r5, r6}
@   0x080260c6: bc01        pop	{r0}
@   0x080260c8: 4700        bx	r0
@   0x080260ca: 0000        movs	r0, r0
@   0x080260cc: 4adc        ldr	r2, [pc, #880]	@ (0x26440)
@   0x080260ce: 0831        lsrs	r1, r6, #32
@   0x080260d0: 0241        lsls	r1, r0, #9

        thumb_func_start sub_08026090
sub_08026090: @ 0x08026090
        .incbin "baserom.gba", 0x26090, 0x44
        thumb_func_end sub_08026090
