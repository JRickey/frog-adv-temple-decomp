@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a214, 0x0800a258)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a214 --end 0x800a258 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a214: b530        push	{r4, r5, lr}
@   0x0800a216: 4c06        ldr	r4, [pc, #24]	@ (0xa230)
@   0x0800a218: 6820        ldr	r0, [r4, #0]
@   0x0800a21a: 2103        movs	r1, #3
@   0x0800a21c: f029        fe9e 	bl	0x33f5c
@   0x0800a220: 2801        cmp	r0, #1
@   0x0800a222: d009        beq.n	0xa238
@   0x0800a224: 2801        cmp	r0, #1
@   0x0800a226: d305        bcc.n	0xa234
@   0x0800a228: 2802        cmp	r0, #2
@   0x0800a22a: d007        beq.n	0xa23c
@   0x0800a22c: e007        b.n	0xa23e
@   0x0800a22e: 0000        movs	r0, r0
@   0x0800a230: 5330        strh	r0, [r6, r4]
@   0x0800a232: 0300        lsls	r0, r0, #12
@   0x0800a234: 250d        movs	r5, #13
@   0x0800a236: e002        b.n	0xa23e
@   0x0800a238: 2508        movs	r5, #8
@   0x0800a23a: e000        b.n	0xa23e
@   0x0800a23c: 2512        movs	r5, #18
@   0x0800a23e: 7aa0        ldrb	r0, [r4, #10]
@   0x0800a240: 380f        subs	r0, #15
@   0x0800a242: 0600        lsls	r0, r0, #24
@   0x0800a244: 0e00        lsrs	r0, r0, #24
@   0x0800a246: 2801        cmp	r0, #1
@   0x0800a248: d800        bhi.n	0xa24c
@   0x0800a24a: 2507        movs	r5, #7
@   0x0800a24c: f016        fcae 	bl	0x20bac
@   0x0800a250: 1c28        adds	r0, r5, #0
@   0x0800a252: bc30        pop	{r4, r5}
@   0x0800a254: bc02        pop	{r1}
@   0x0800a256: 4708        bx	r1

        thumb_func_start sub_0800A214
sub_0800A214: @ 0x0800a214
        .incbin "frog_us_baserom.gba", 0xa214, 0x44
        thumb_func_end sub_0800A214
