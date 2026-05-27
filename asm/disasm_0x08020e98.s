@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020e98, 0x08020f3c)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020e98 --end 0x8020f3c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020e98: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08020e9a: 0600        lsls	r0, r0, #24
@   0x08020e9c: 2400        movs	r4, #0
@   0x08020e9e: 4e0d        ldr	r6, [pc, #52]	@ (0x20ed4)
@   0x08020ea0: 1c37        adds	r7, r6, #0
@   0x08020ea2: 3708        adds	r7, #8
@   0x08020ea4: 25fe        movs	r5, #254	@ 0xfe
@   0x08020ea6: 05ed        lsls	r5, r5, #23
@   0x08020ea8: 4005        ands	r5, r0
@   0x08020eaa: 00e2        lsls	r2, r4, #3
@   0x08020eac: 1d30        adds	r0, r6, #4
@   0x08020eae: 1810        adds	r0, r2, r0
@   0x08020eb0: 6801        ldr	r1, [r0, #0]
@   0x08020eb2: 2001        movs	r0, #1
@   0x08020eb4: 4240        negs	r0, r0
@   0x08020eb6: 4281        cmp	r1, r0
@   0x08020eb8: d004        beq.n	0x20ec4
@   0x08020eba: 19d0        adds	r0, r2, r7
@   0x08020ebc: 6800        ldr	r0, [r0, #0]
@   0x08020ebe: 0e29        lsrs	r1, r5, #24
@   0x08020ec0: f00c        feac 	bl	0x2dc1c
@   0x08020ec4: 1c60        adds	r0, r4, #1
@   0x08020ec6: 0600        lsls	r0, r0, #24
@   0x08020ec8: 0e04        lsrs	r4, r0, #24
@   0x08020eca: 2c0b        cmp	r4, #11
@   0x08020ecc: d9ed        bls.n	0x20eaa
@   0x08020ece: bcf0        pop	{r4, r5, r6, r7}
@   0x08020ed0: bc01        pop	{r0}
@   0x08020ed2: 4700        bx	r0
@   0x08020ed4: 3570        adds	r5, #112	@ 0x70
@   0x08020ed6: 0300        lsls	r0, r0, #12
@   0x08020ed8: 4801        ldr	r0, [pc, #4]	@ (0x20ee0)
@   0x08020eda: 70c1        strb	r1, [r0, #3]
@   0x08020edc: 4770        bx	lr
@   0x08020ede: 0000        movs	r0, r0
@   0x08020ee0: 3570        adds	r5, #112	@ 0x70
@   0x08020ee2: 0300        lsls	r0, r0, #12
@   0x08020ee4: b500        push	{lr}
@   0x08020ee6: 0600        lsls	r0, r0, #24
@   0x08020ee8: 0e02        lsrs	r2, r0, #24
@   0x08020eea: 4906        ldr	r1, [pc, #24]	@ (0x20f04)
@   0x08020eec: 78c8        ldrb	r0, [r1, #3]
@   0x08020eee: 28f4        cmp	r0, #244	@ 0xf4
@   0x08020ef0: d805        bhi.n	0x20efe
@   0x08020ef2: 3001        adds	r0, #1
@   0x08020ef4: 70c8        strb	r0, [r1, #3]
@   0x08020ef6: 78c9        ldrb	r1, [r1, #3]
@   0x08020ef8: 1c10        adds	r0, r2, #0
@   0x08020efa: f00c        fe8f 	bl	0x2dc1c
@   0x08020efe: bc01        pop	{r0}
@   0x08020f00: 4700        bx	r0
@   0x08020f02: 0000        movs	r0, r0
@   0x08020f04: 3570        adds	r5, #112	@ 0x70
@   0x08020f06: 0300        lsls	r0, r0, #12
@   0x08020f08: b500        push	{lr}
@   0x08020f0a: 0600        lsls	r0, r0, #24
@   0x08020f0c: 0e02        lsrs	r2, r0, #24
@   0x08020f0e: 4906        ldr	r1, [pc, #24]	@ (0x20f28)
@   0x08020f10: 78c8        ldrb	r0, [r1, #3]
@   0x08020f12: 3801        subs	r0, #1
@   0x08020f14: 70c8        strb	r0, [r1, #3]
@   0x08020f16: 0600        lsls	r0, r0, #24
@   0x08020f18: 0e00        lsrs	r0, r0, #24
@   0x08020f1a: 28ff        cmp	r0, #255	@ 0xff
@   0x08020f1c: d006        beq.n	0x20f2c
@   0x08020f1e: 78c9        ldrb	r1, [r1, #3]
@   0x08020f20: 1c10        adds	r0, r2, #0
@   0x08020f22: f00c        fe7b 	bl	0x2dc1c
@   0x08020f26: e007        b.n	0x20f38
@   0x08020f28: 3570        adds	r5, #112	@ 0x70
@   0x08020f2a: 0300        lsls	r0, r0, #12
@   0x08020f2c: 00d0        lsls	r0, r2, #3
@   0x08020f2e: 3108        adds	r1, #8
@   0x08020f30: 1840        adds	r0, r0, r1
@   0x08020f32: 6800        ldr	r0, [r0, #0]
@   0x08020f34: f00d        f8e4 	bl	0x2e100
@   0x08020f38: bc01        pop	{r0}
@   0x08020f3a: 4700        bx	r0

        thumb_func_start sub_08020E98
sub_08020E98: @ 0x08020e98
        .incbin "frog_us_baserom.gba", 0x20e98, 0xa4
        thumb_func_end sub_08020E98
