@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a9d4, 0x0800aa70)  (156 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a9d4 --end 0x800aa70 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a9d4: b570        push	{r4, r5, r6, lr}
@   0x0800a9d6: 0600        lsls	r0, r0, #24
@   0x0800a9d8: 0e00        lsrs	r0, r0, #24
@   0x0800a9da: 2814        cmp	r0, #20
@   0x0800a9dc: d143        bne.n	0xaa66
@   0x0800a9de: 4c08        ldr	r4, [pc, #32]	@ (0xaa00)
@   0x0800a9e0: 2008        movs	r0, #8
@   0x0800a9e2: 5e21        ldrsh	r1, [r4, r0]
@   0x0800a9e4: 200a        movs	r0, #10
@   0x0800a9e6: 5e22        ldrsh	r2, [r4, r0]
@   0x0800a9e8: 2008        movs	r0, #8
@   0x0800a9ea: f7ff        fedd 	bl	0xa7a8
@   0x0800a9ee: 0600        lsls	r0, r0, #24
@   0x0800a9f0: 0e06        lsrs	r6, r0, #24
@   0x0800a9f2: 1600        asrs	r0, r0, #24
@   0x0800a9f4: 2802        cmp	r0, #2
@   0x0800a9f6: d005        beq.n	0xaa04
@   0x0800a9f8: 2803        cmp	r0, #3
@   0x0800a9fa: d01b        beq.n	0xaa34
@   0x0800a9fc: e02e        b.n	0xaa5c
@   0x0800a9fe: 0000        movs	r0, r0
@   0x0800aa00: 35e0        adds	r5, #224	@ 0xe0
@   0x0800aa02: 0300        lsls	r0, r0, #12
@   0x0800aa04: 4d0a        ldr	r5, [pc, #40]	@ (0xaa30)
@   0x0800aa06: 1c28        adds	r0, r5, #0
@   0x0800aa08: 2105        movs	r1, #5
@   0x0800aa0a: 2202        movs	r2, #2
@   0x0800aa0c: f7fb        fec6 	bl	0x679c
@   0x0800aa10: 0600        lsls	r0, r0, #24
@   0x0800aa12: 2800        cmp	r0, #0
@   0x0800aa14: d122        bne.n	0xaa5c
@   0x0800aa16: 7e21        ldrb	r1, [r4, #24]
@   0x0800aa18: 2009        movs	r0, #9
@   0x0800aa1a: 2200        movs	r2, #0
@   0x0800aa1c: 2301        movs	r3, #1
@   0x0800aa1e: f7ff        ff0d 	bl	0xa83c
@   0x0800aa22: 1c28        adds	r0, r5, #0
@   0x0800aa24: 2108        movs	r1, #8
@   0x0800aa26: 2200        movs	r2, #0
@   0x0800aa28: f7fb        fdea 	bl	0x6600
@   0x0800aa2c: e016        b.n	0xaa5c
@   0x0800aa2e: 0000        movs	r0, r0
@   0x0800aa30: 6110        str	r0, [r2, #16]
@   0x0800aa32: 0300        lsls	r0, r0, #12
@   0x0800aa34: 4d0d        ldr	r5, [pc, #52]	@ (0xaa6c)
@   0x0800aa36: 1c28        adds	r0, r5, #0
@   0x0800aa38: 2105        movs	r1, #5
@   0x0800aa3a: 2203        movs	r2, #3
@   0x0800aa3c: f7fb        feae 	bl	0x679c
@   0x0800aa40: 0600        lsls	r0, r0, #24
@   0x0800aa42: 2800        cmp	r0, #0
@   0x0800aa44: d10a        bne.n	0xaa5c
@   0x0800aa46: 7e21        ldrb	r1, [r4, #24]
@   0x0800aa48: 200a        movs	r0, #10
@   0x0800aa4a: 2200        movs	r2, #0
@   0x0800aa4c: 2301        movs	r3, #1
@   0x0800aa4e: f7ff        fef5 	bl	0xa83c
@   0x0800aa52: 1c28        adds	r0, r5, #0
@   0x0800aa54: 2108        movs	r1, #8
@   0x0800aa56: 2201        movs	r2, #1
@   0x0800aa58: f7fb        fdd2 	bl	0x6600
@   0x0800aa5c: 4803        ldr	r0, [pc, #12]	@ (0xaa6c)
@   0x0800aa5e: 1c32        adds	r2, r6, #0
@   0x0800aa60: 2105        movs	r1, #5
@   0x0800aa62: f7fb        fdcd 	bl	0x6600
@   0x0800aa66: bc70        pop	{r4, r5, r6}
@   0x0800aa68: bc01        pop	{r0}
@   0x0800aa6a: 4700        bx	r0
@   0x0800aa6c: 6110        str	r0, [r2, #16]
@   0x0800aa6e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800A9D4
sub_0800A9D4: @ 0x0800a9d4
        .incbin "frog_us_baserom.gba", 0xa9d4, 0x9c
        thumb_func_end sub_0800A9D4
