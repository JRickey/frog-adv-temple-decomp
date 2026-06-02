@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ca80, 0x0802cafc)  (124 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ca80 --end 0x802cafc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ca80: b510        push	{r4, lr}
@   0x0802ca82: b084        sub	sp, #16
@   0x0802ca84: 490a        ldr	r1, [pc, #40]	@ (0x2cab0)
@   0x0802ca86: 480b        ldr	r0, [pc, #44]	@ (0x2cab4)
@   0x0802ca88: 9000        str	r0, [sp, #0]
@   0x0802ca8a: 2004        movs	r0, #4
@   0x0802ca8c: 9001        str	r0, [sp, #4]
@   0x0802ca8e: 2403        movs	r4, #3
@   0x0802ca90: 9402        str	r4, [sp, #8]
@   0x0802ca92: 2001        movs	r0, #1
@   0x0802ca94: 9003        str	r0, [sp, #12]
@   0x0802ca96: 2016        movs	r0, #22
@   0x0802ca98: 2210        movs	r2, #16
@   0x0802ca9a: 2360        movs	r3, #96	@ 0x60
@   0x0802ca9c: f7f4        fb00 	bl	0x210a0
@   0x0802caa0: 4805        ldr	r0, [pc, #20]	@ (0x2cab8)
@   0x0802caa2: 4906        ldr	r1, [pc, #24]	@ (0x2cabc)
@   0x0802caa4: 1840        adds	r0, r0, r1
@   0x0802caa6: 7004        strb	r4, [r0, #0]
@   0x0802caa8: b004        add	sp, #16
@   0x0802caaa: bc10        pop	{r4}
@   0x0802caac: bc01        pop	{r0}
@   0x0802caae: 4700        bx	r0
@   0x0802cab0: 805c        strh	r4, [r3, #2]
@   0x0802cab2: 0831        lsrs	r1, r6, #32
@   0x0802cab4: 0245        lsls	r5, r0, #9
@   0x0802cab6: 0000        movs	r0, r0
@   0x0802cab8: 3720        adds	r7, #32
@   0x0802caba: 0300        lsls	r0, r0, #12
@   0x0802cabc: 0b7a        lsrs	r2, r7, #13
@   0x0802cabe: 0000        movs	r0, r0
@   0x0802cac0: b530        push	{r4, r5, lr}
@   0x0802cac2: 2300        movs	r3, #0
@   0x0802cac4: 480a        ldr	r0, [pc, #40]	@ (0x2caf0)
@   0x0802cac6: 2408        movs	r4, #8
@   0x0802cac8: 21e0        movs	r1, #224	@ 0xe0
@   0x0802caca: 0049        lsls	r1, r1, #1
@   0x0802cacc: 1842        adds	r2, r0, r1
@   0x0802cace: 210d        movs	r1, #13
@   0x0802cad0: 1c20        adds	r0, r4, #0
@   0x0802cad2: 8e95        ldrh	r5, [r2, #52]	@ 0x34
@   0x0802cad4: 4028        ands	r0, r5
@   0x0802cad6: 2800        cmp	r0, #0
@   0x0802cad8: d002        beq.n	0x2cae0
@   0x0802cada: 1c58        adds	r0, r3, #1
@   0x0802cadc: 0600        lsls	r0, r0, #24
@   0x0802cade: 0e03        lsrs	r3, r0, #24
@   0x0802cae0: 3238        adds	r2, #56	@ 0x38
@   0x0802cae2: 3901        subs	r1, #1
@   0x0802cae4: 2900        cmp	r1, #0
@   0x0802cae6: daf3        bge.n	0x2cad0
@   0x0802cae8: 2b0e        cmp	r3, #14
@   0x0802caea: d003        beq.n	0x2caf4
@   0x0802caec: 2000        movs	r0, #0
@   0x0802caee: e002        b.n	0x2caf6
@   0x0802caf0: 3720        adds	r7, #32
@   0x0802caf2: 0300        lsls	r0, r0, #12
@   0x0802caf4: 2001        movs	r0, #1
@   0x0802caf6: bc30        pop	{r4, r5}
@   0x0802caf8: bc02        pop	{r1}
@   0x0802cafa: 4708        bx	r1

        thumb_func_start sub_0802CA80
sub_0802CA80: @ 0x0802ca80
        .incbin "frog_us_baserom.gba", 0x2ca80, 0x7c
        thumb_func_end sub_0802CA80
