@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027ee8, 0x08027f40)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027ee8 --end 0x8027f40 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027ee8: b570        push	{r4, r5, r6, lr}
@   0x08027eea: b084        sub	sp, #16
@   0x08027eec: 2600        movs	r6, #0
@   0x08027eee: 1c35        adds	r5, r6, #0
@   0x08027ef0: 3533        adds	r5, #51	@ 0x33
@   0x08027ef2: 4911        ldr	r1, [pc, #68]	@ (0x27f38)
@   0x08027ef4: 00b0        lsls	r0, r6, #2
@   0x08027ef6: 1840        adds	r0, r0, r1
@   0x08027ef8: 6804        ldr	r4, [r0, #0]
@   0x08027efa: 1c30        adds	r0, r6, #0
@   0x08027efc: 2107        movs	r1, #7
@   0x08027efe: f00c        f82d 	bl	0x33f5c
@   0x08027f02: 0600        lsls	r0, r0, #24
@   0x08027f04: 0900        lsrs	r0, r0, #4
@   0x08027f06: 490d        ldr	r1, [pc, #52]	@ (0x27f3c)
@   0x08027f08: 1840        adds	r0, r0, r1
@   0x08027f0a: 0c00        lsrs	r0, r0, #16
@   0x08027f0c: 9000        str	r0, [sp, #0]
@   0x08027f0e: 2008        movs	r0, #8
@   0x08027f10: 9001        str	r0, [sp, #4]
@   0x08027f12: 2003        movs	r0, #3
@   0x08027f14: 9002        str	r0, [sp, #8]
@   0x08027f16: 9003        str	r0, [sp, #12]
@   0x08027f18: 1c28        adds	r0, r5, #0
@   0x08027f1a: 1c21        adds	r1, r4, #0
@   0x08027f1c: 2210        movs	r2, #16
@   0x08027f1e: 233b        movs	r3, #59	@ 0x3b
@   0x08027f20: f7f9        f8be 	bl	0x210a0
@   0x08027f24: 1c70        adds	r0, r6, #1
@   0x08027f26: 0600        lsls	r0, r0, #24
@   0x08027f28: 0e06        lsrs	r6, r0, #24
@   0x08027f2a: 2e09        cmp	r6, #9
@   0x08027f2c: d9df        bls.n	0x27eee
@   0x08027f2e: b004        add	sp, #16
@   0x08027f30: bc70        pop	{r4, r5, r6}
@   0x08027f32: bc01        pop	{r0}
@   0x08027f34: 4700        bx	r0
@   0x08027f36: 0000        movs	r0, r0
@   0x08027f38: 6df8        ldr	r0, [r7, #92]	@ 0x5c
@   0x08027f3a: 0831        lsrs	r1, r6, #32
@   0x08027f3c: 0000        movs	r0, r0
@   0x08027f3e: 0121        lsls	r1, r4, #4

        thumb_func_start sub_08027EE8
sub_08027EE8: @ 0x08027ee8
        .incbin "baserom.gba", 0x27ee8, 0x58
        thumb_func_end sub_08027EE8
