@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800aa70, 0x0800ab84)  (276 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800aa70 --end 0x800ab84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800aa70: b570        push	{r4, r5, r6, lr}
@   0x0800aa72: 0600        lsls	r0, r0, #24
@   0x0800aa74: 0e00        lsrs	r0, r0, #24
@   0x0800aa76: 2814        cmp	r0, #20
@   0x0800aa78: d16a        bne.n	0xab50
@   0x0800aa7a: 4c09        ldr	r4, [pc, #36]	@ (0xaaa0)
@   0x0800aa7c: 2008        movs	r0, #8
@   0x0800aa7e: 5e21        ldrsh	r1, [r4, r0]
@   0x0800aa80: 200a        movs	r0, #10
@   0x0800aa82: 5e22        ldrsh	r2, [r4, r0]
@   0x0800aa84: 200f        movs	r0, #15
@   0x0800aa86: f7ff        fe8f 	bl	0xa7a8
@   0x0800aa8a: 0600        lsls	r0, r0, #24
@   0x0800aa8c: 0e06        lsrs	r6, r0, #24
@   0x0800aa8e: 1600        asrs	r0, r0, #24
@   0x0800aa90: 2801        cmp	r0, #1
@   0x0800aa92: d01b        beq.n	0xaacc
@   0x0800aa94: 2801        cmp	r0, #1
@   0x0800aa96: dc05        bgt.n	0xaaa4
@   0x0800aa98: 2800        cmp	r0, #0
@   0x0800aa9a: d008        beq.n	0xaaae
@   0x0800aa9c: e050        b.n	0xab40
@   0x0800aa9e: 0000        movs	r0, r0
@   0x0800aaa0: 35e0        adds	r5, #224	@ 0xe0
@   0x0800aaa2: 0300        lsls	r0, r0, #12
@   0x0800aaa4: 2802        cmp	r0, #2
@   0x0800aaa6: d01f        beq.n	0xaae8
@   0x0800aaa8: 2803        cmp	r0, #3
@   0x0800aaaa: d035        beq.n	0xab18
@   0x0800aaac: e048        b.n	0xab40
@   0x0800aaae: 4c06        ldr	r4, [pc, #24]	@ (0xaac8)
@   0x0800aab0: 1c20        adds	r0, r4, #0
@   0x0800aab2: 2105        movs	r1, #5
@   0x0800aab4: 2206        movs	r2, #6
@   0x0800aab6: f7fb        fda3 	bl	0x6600
@   0x0800aaba: 1c20        adds	r0, r4, #0
@   0x0800aabc: 2105        movs	r1, #5
@   0x0800aabe: 2201        movs	r2, #1
@   0x0800aac0: f7fb        fe00 	bl	0x66c4
@   0x0800aac4: e03c        b.n	0xab40
@   0x0800aac6: 0000        movs	r0, r0
@   0x0800aac8: 6110        str	r0, [r2, #16]
@   0x0800aaca: 0300        lsls	r0, r0, #12
@   0x0800aacc: 4c05        ldr	r4, [pc, #20]	@ (0xaae4)
@   0x0800aace: 1c20        adds	r0, r4, #0
@   0x0800aad0: 2105        movs	r1, #5
@   0x0800aad2: 2207        movs	r2, #7
@   0x0800aad4: f7fb        fd94 	bl	0x6600
@   0x0800aad8: 1c20        adds	r0, r4, #0
@   0x0800aada: 2105        movs	r1, #5
@   0x0800aadc: 2200        movs	r2, #0
@   0x0800aade: f7fb        fdf1 	bl	0x66c4
@   0x0800aae2: e02d        b.n	0xab40
@   0x0800aae4: 6110        str	r0, [r2, #16]
@   0x0800aae6: 0300        lsls	r0, r0, #12
@   0x0800aae8: 4d0a        ldr	r5, [pc, #40]	@ (0xab14)
@   0x0800aaea: 1c28        adds	r0, r5, #0
@   0x0800aaec: 2105        movs	r1, #5
@   0x0800aaee: 2202        movs	r2, #2
@   0x0800aaf0: f7fb        fe54 	bl	0x679c
@   0x0800aaf4: 0600        lsls	r0, r0, #24
@   0x0800aaf6: 2800        cmp	r0, #0
@   0x0800aaf8: d122        bne.n	0xab40
@   0x0800aafa: 7e21        ldrb	r1, [r4, #24]
@   0x0800aafc: 200d        movs	r0, #13
@   0x0800aafe: 2200        movs	r2, #0
@   0x0800ab00: 2301        movs	r3, #1
@   0x0800ab02: f7ff        fe9b 	bl	0xa83c
@   0x0800ab06: 1c28        adds	r0, r5, #0
@   0x0800ab08: 2108        movs	r1, #8
@   0x0800ab0a: 2201        movs	r2, #1
@   0x0800ab0c: f7fb        fd78 	bl	0x6600
@   0x0800ab10: e016        b.n	0xab40
@   0x0800ab12: 0000        movs	r0, r0
@   0x0800ab14: 6110        str	r0, [r2, #16]
@   0x0800ab16: 0300        lsls	r0, r0, #12
@   0x0800ab18: 4d0c        ldr	r5, [pc, #48]	@ (0xab4c)
@   0x0800ab1a: 1c28        adds	r0, r5, #0
@   0x0800ab1c: 2105        movs	r1, #5
@   0x0800ab1e: 2203        movs	r2, #3
@   0x0800ab20: f7fb        fe3c 	bl	0x679c
@   0x0800ab24: 0600        lsls	r0, r0, #24
@   0x0800ab26: 2800        cmp	r0, #0
@   0x0800ab28: d10a        bne.n	0xab40
@   0x0800ab2a: 7e21        ldrb	r1, [r4, #24]
@   0x0800ab2c: 200e        movs	r0, #14
@   0x0800ab2e: 2200        movs	r2, #0
@   0x0800ab30: 2301        movs	r3, #1
@   0x0800ab32: f7ff        fe83 	bl	0xa83c
@   0x0800ab36: 1c28        adds	r0, r5, #0
@   0x0800ab38: 2108        movs	r1, #8
@   0x0800ab3a: 2202        movs	r2, #2
@   0x0800ab3c: f7fb        fd60 	bl	0x6600
@   0x0800ab40: 4802        ldr	r0, [pc, #8]	@ (0xab4c)
@   0x0800ab42: 1c32        adds	r2, r6, #0
@   0x0800ab44: 2105        movs	r1, #5
@   0x0800ab46: f7fb        fd5b 	bl	0x6600
@   0x0800ab4a: e016        b.n	0xab7a
@   0x0800ab4c: 6110        str	r0, [r2, #16]
@   0x0800ab4e: 0300        lsls	r0, r0, #12
@   0x0800ab50: 2815        cmp	r0, #21
@   0x0800ab52: d107        bne.n	0xab64
@   0x0800ab54: 4802        ldr	r0, [pc, #8]	@ (0xab60)
@   0x0800ab56: 2103        movs	r1, #3
@   0x0800ab58: 2200        movs	r2, #0
@   0x0800ab5a: f7fb        fd51 	bl	0x6600
@   0x0800ab5e: e00c        b.n	0xab7a
@   0x0800ab60: 6110        str	r0, [r2, #16]
@   0x0800ab62: 0300        lsls	r0, r0, #12
@   0x0800ab64: 4c06        ldr	r4, [pc, #24]	@ (0xab80)
@   0x0800ab66: 1c20        adds	r0, r4, #0
@   0x0800ab68: 2105        movs	r1, #5
@   0x0800ab6a: 2200        movs	r2, #0
@   0x0800ab6c: f7fb        fdaa 	bl	0x66c4
@   0x0800ab70: 1c20        adds	r0, r4, #0
@   0x0800ab72: 2105        movs	r1, #5
@   0x0800ab74: 2201        movs	r2, #1
@   0x0800ab76: f7fb        fda5 	bl	0x66c4
@   0x0800ab7a: bc70        pop	{r4, r5, r6}
@   0x0800ab7c: bc01        pop	{r0}
@   0x0800ab7e: 4700        bx	r0
@   0x0800ab80: 6110        str	r0, [r2, #16]
@   0x0800ab82: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800AA70
sub_0800AA70: @ 0x0800aa70
        .incbin "frog_us_baserom.gba", 0xaa70, 0x114
        thumb_func_end sub_0800AA70
