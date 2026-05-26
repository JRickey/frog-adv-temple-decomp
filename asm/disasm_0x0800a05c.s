@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a05c, 0x0800a104)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a05c --end 0x800a104 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a05c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800a05e: 4647        mov	r7, r8
@   0x0800a060: b480        push	{r7}
@   0x0800a062: b082        sub	sp, #8
@   0x0800a064: 2000        movs	r0, #0
@   0x0800a066: 9000        str	r0, [sp, #0]
@   0x0800a068: 4920        ldr	r1, [pc, #128]	@ (0xa0ec)
@   0x0800a06a: 4a21        ldr	r2, [pc, #132]	@ (0xa0f0)
@   0x0800a06c: 4668        mov	r0, sp
@   0x0800a06e: f023        fa73 	bl	0x2d558
@   0x0800a072: a801        add	r0, sp, #4
@   0x0800a074: 4680        mov	r8, r0
@   0x0800a076: 481f        ldr	r0, [pc, #124]	@ (0xa0f4)
@   0x0800a078: 2500        movs	r5, #0
@   0x0800a07a: 1c03        adds	r3, r0, #0
@   0x0800a07c: 21fe        movs	r1, #254	@ 0xfe
@   0x0800a07e: 0089        lsls	r1, r1, #2
@   0x0800a080: 1847        adds	r7, r0, r1
@   0x0800a082: 26f0        movs	r6, #240	@ 0xf0
@   0x0800a084: 1c04        adds	r4, r0, #0
@   0x0800a086: 801e        strh	r6, [r3, #0]
@   0x0800a088: 1ca1        adds	r1, r4, #2
@   0x0800a08a: 2202        movs	r2, #2
@   0x0800a08c: 800d        strh	r5, [r1, #0]
@   0x0800a08e: 3102        adds	r1, #2
@   0x0800a090: 3a01        subs	r2, #1
@   0x0800a092: 2a00        cmp	r2, #0
@   0x0800a094: dafa        bge.n	0xa08c
@   0x0800a096: 3308        adds	r3, #8
@   0x0800a098: 3408        adds	r4, #8
@   0x0800a09a: 42bb        cmp	r3, r7
@   0x0800a09c: ddf3        ble.n	0xa086
@   0x0800a09e: 21e0        movs	r1, #224	@ 0xe0
@   0x0800a0a0: 04c9        lsls	r1, r1, #19
@   0x0800a0a2: 2280        movs	r2, #128	@ 0x80
@   0x0800a0a4: 0052        lsls	r2, r2, #1
@   0x0800a0a6: f023        fa57 	bl	0x2d558
@   0x0800a0aa: 2500        movs	r5, #0
@   0x0800a0ac: 2100        movs	r1, #0
@   0x0800a0ae: 4812        ldr	r0, [pc, #72]	@ (0xa0f8)
@   0x0800a0b0: 8041        strh	r1, [r0, #2]
@   0x0800a0b2: 7005        strb	r5, [r0, #0]
@   0x0800a0b4: 3008        adds	r0, #8
@   0x0800a0b6: 3501        adds	r5, #1
@   0x0800a0b8: 2d3f        cmp	r5, #63	@ 0x3f
@   0x0800a0ba: ddf9        ble.n	0xa0b0
@   0x0800a0bc: 2000        movs	r0, #0
@   0x0800a0be: 9001        str	r0, [sp, #4]
@   0x0800a0c0: 4c0e        ldr	r4, [pc, #56]	@ (0xa0fc)
@   0x0800a0c2: 4a0f        ldr	r2, [pc, #60]	@ (0xa100)
@   0x0800a0c4: 4640        mov	r0, r8
@   0x0800a0c6: 1c21        adds	r1, r4, #0
@   0x0800a0c8: f023        fa46 	bl	0x2d558
@   0x0800a0cc: 2108        movs	r1, #8
@   0x0800a0ce: 3434        adds	r4, #52	@ 0x34
@   0x0800a0d0: 257f        movs	r5, #127	@ 0x7f
@   0x0800a0d2: 8820        ldrh	r0, [r4, #0]
@   0x0800a0d4: 4308        orrs	r0, r1
@   0x0800a0d6: 8020        strh	r0, [r4, #0]
@   0x0800a0d8: 3438        adds	r4, #56	@ 0x38
@   0x0800a0da: 3d01        subs	r5, #1
@   0x0800a0dc: 2d00        cmp	r5, #0
@   0x0800a0de: daf8        bge.n	0xa0d2
@   0x0800a0e0: b002        add	sp, #8
@   0x0800a0e2: bc08        pop	{r3}
@   0x0800a0e4: 4698        mov	r8, r3
@   0x0800a0e6: bcf0        pop	{r4, r5, r6, r7}
@   0x0800a0e8: bc01        pop	{r0}
@   0x0800a0ea: 4700        bx	r0
@   0x0800a0ec: 0000        movs	r0, r0
@   0x0800a0ee: 0601        lsls	r1, r0, #24
@   0x0800a0f0: 0008        movs	r0, r1
@   0x0800a0f2: 0100        lsls	r0, r0, #4
@   0x0800a0f4: 54a0        strb	r0, [r4, r2]
@   0x0800a0f6: 0300        lsls	r0, r0, #12
@   0x0800a0f8: 6160        str	r0, [r4, #20]
@   0x0800a0fa: 0300        lsls	r0, r0, #12
@   0x0800a0fc: 3720        adds	r7, #32
@   0x0800a0fe: 0300        lsls	r0, r0, #12
@   0x0800a100: 0700        lsls	r0, r0, #28
@   0x0800a102: 0100        lsls	r0, r0, #4

        thumb_func_start sub_0800A05C
sub_0800A05C: @ 0x0800a05c
        .incbin "frog_us_baserom.gba", 0xa05c, 0xa8
        thumb_func_end sub_0800A05C
