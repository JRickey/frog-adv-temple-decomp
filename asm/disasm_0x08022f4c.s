@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022f4c, 0x08022fec)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022f4c --end 0x8022fec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022f4c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022f4e: 4647        mov	r7, r8
@   0x08022f50: b480        push	{r7}
@   0x08022f52: b084        sub	sp, #16
@   0x08022f54: 2600        movs	r6, #0
@   0x08022f56: 4810        ldr	r0, [pc, #64]	@ (0x22f98)
@   0x08022f58: 4680        mov	r8, r0
@   0x08022f5a: 2703        movs	r7, #3
@   0x08022f5c: 2e03        cmp	r6, #3
@   0x08022f5e: d81f        bhi.n	0x22fa0
@   0x08022f60: 1c35        adds	r5, r6, #0
@   0x08022f62: 3551        adds	r5, #81	@ 0x51
@   0x08022f64: 00b0        lsls	r0, r6, #2
@   0x08022f66: 4440        add	r0, r8
@   0x08022f68: 6804        ldr	r4, [r0, #0]
@   0x08022f6a: 1c30        adds	r0, r6, #0
@   0x08022f6c: 2106        movs	r1, #6
@   0x08022f6e: f010        fff5 	bl	0x33f5c
@   0x08022f72: 0600        lsls	r0, r0, #24
@   0x08022f74: 0900        lsrs	r0, r0, #4
@   0x08022f76: 4909        ldr	r1, [pc, #36]	@ (0x22f9c)
@   0x08022f78: 1840        adds	r0, r0, r1
@   0x08022f7a: 0c00        lsrs	r0, r0, #16
@   0x08022f7c: 9000        str	r0, [sp, #0]
@   0x08022f7e: 200b        movs	r0, #11
@   0x08022f80: 9001        str	r0, [sp, #4]
@   0x08022f82: 2002        movs	r0, #2
@   0x08022f84: 9002        str	r0, [sp, #8]
@   0x08022f86: 9703        str	r7, [sp, #12]
@   0x08022f88: 1c28        adds	r0, r5, #0
@   0x08022f8a: 1c21        adds	r1, r4, #0
@   0x08022f8c: 2210        movs	r2, #16
@   0x08022f8e: 230d        movs	r3, #13
@   0x08022f90: f7fe        f886 	bl	0x210a0
@   0x08022f94: e01d        b.n	0x22fd2
@   0x08022f96: 0000        movs	r0, r0
@   0x08022f98: 1ec0        subs	r0, r0, #3
@   0x08022f9a: 0831        lsrs	r1, r6, #32
@   0x08022f9c: 0000        movs	r0, r0
@   0x08022f9e: 0171        lsls	r1, r6, #5
@   0x08022fa0: 1c35        adds	r5, r6, #0
@   0x08022fa2: 3551        adds	r5, #81	@ 0x51
@   0x08022fa4: 00b0        lsls	r0, r6, #2
@   0x08022fa6: 4440        add	r0, r8
@   0x08022fa8: 6804        ldr	r4, [r0, #0]
@   0x08022faa: 1c30        adds	r0, r6, #0
@   0x08022fac: 2106        movs	r1, #6
@   0x08022fae: f010        ffd5 	bl	0x33f5c
@   0x08022fb2: 0600        lsls	r0, r0, #24
@   0x08022fb4: 0900        lsrs	r0, r0, #4
@   0x08022fb6: 490c        ldr	r1, [pc, #48]	@ (0x22fe8)
@   0x08022fb8: 1840        adds	r0, r0, r1
@   0x08022fba: 0c00        lsrs	r0, r0, #16
@   0x08022fbc: 9000        str	r0, [sp, #0]
@   0x08022fbe: 200b        movs	r0, #11
@   0x08022fc0: 9001        str	r0, [sp, #4]
@   0x08022fc2: 9702        str	r7, [sp, #8]
@   0x08022fc4: 9703        str	r7, [sp, #12]
@   0x08022fc6: 1c28        adds	r0, r5, #0
@   0x08022fc8: 1c21        adds	r1, r4, #0
@   0x08022fca: 2210        movs	r2, #16
@   0x08022fcc: 230d        movs	r3, #13
@   0x08022fce: f7fe        f867 	bl	0x210a0
@   0x08022fd2: 1c70        adds	r0, r6, #1
@   0x08022fd4: 0600        lsls	r0, r0, #24
@   0x08022fd6: 0e06        lsrs	r6, r0, #24
@   0x08022fd8: 2e09        cmp	r6, #9
@   0x08022fda: d9bf        bls.n	0x22f5c
@   0x08022fdc: b004        add	sp, #16
@   0x08022fde: bc08        pop	{r3}
@   0x08022fe0: 4698        mov	r8, r3
@   0x08022fe2: bcf0        pop	{r4, r5, r6, r7}
@   0x08022fe4: bc01        pop	{r0}
@   0x08022fe6: 4700        bx	r0
@   0x08022fe8: 0000        movs	r0, r0
@   0x08022fea: 0171        lsls	r1, r6, #5

        thumb_func_start sub_08022F4C
sub_08022F4C: @ 0x08022f4c
        .incbin "frog_us_baserom.gba", 0x22f4c, 0xa0
        thumb_func_end sub_08022F4C
