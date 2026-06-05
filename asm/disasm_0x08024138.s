@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024138, 0x08024180)  (72 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024138 --end 0x8024180 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024138: b570        push	{r4, r5, r6, lr}
@   0x0802413a: b084        sub	sp, #16
@   0x0802413c: 2400        movs	r4, #0
@   0x0802413e: 4e0f        ldr	r6, [pc, #60]	@ (0x2417c)
@   0x08024140: 2503        movs	r5, #3
@   0x08024142: 1c20        adds	r0, r4, #0
@   0x08024144: 3033        adds	r0, #51	@ 0x33
@   0x08024146: 00a1        lsls	r1, r4, #2
@   0x08024148: 1989        adds	r1, r1, r6
@   0x0802414a: 6809        ldr	r1, [r1, #0]
@   0x0802414c: 22f1        movs	r2, #241	@ 0xf1
@   0x0802414e: 9200        str	r2, [sp, #0]
@   0x08024150: 2205        movs	r2, #5
@   0x08024152: 9201        str	r2, [sp, #4]
@   0x08024154: 9502        str	r5, [sp, #8]
@   0x08024156: 9503        str	r5, [sp, #12]
@   0x08024158: 2280        movs	r2, #128	@ 0x80
@   0x0802415a: 00d2        lsls	r2, r2, #3
@   0x0802415c: 231a        movs	r3, #26
@   0x0802415e: f7fc        ff9f 	bl	0x210a0
@   0x08024162: 1c60        adds	r0, r4, #1
@   0x08024164: 0600        lsls	r0, r0, #24
@   0x08024166: 0e04        lsrs	r4, r0, #24
@   0x08024168: 2c25        cmp	r4, #37	@ 0x25
@   0x0802416a: d9ea        bls.n	0x24142
@   0x0802416c: 2033        movs	r0, #51	@ 0x33
@   0x0802416e: f7e2        f93d 	bl	0x63ec
@   0x08024172: b004        add	sp, #16
@   0x08024174: bc70        pop	{r4, r5, r6}
@   0x08024176: bc01        pop	{r0}
@   0x08024178: 4700        bx	r0
@   0x0802417a: 0000        movs	r0, r0
@   0x0802417c: 2dd4        cmp	r5, #212	@ 0xd4
@   0x0802417e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024138
sub_08024138: @ 0x08024138
        .incbin "frog_us_baserom.gba", 0x24138, 0x48
        thumb_func_end sub_08024138
