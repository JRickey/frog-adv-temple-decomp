@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024390, 0x080243d4)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024390 --end 0x80243d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024390: b510        push	{r4, lr}
@   0x08024392: b084        sub	sp, #16
@   0x08024394: 2400        movs	r4, #0
@   0x08024396: 1c20        adds	r0, r4, #0
@   0x08024398: 300a        adds	r0, #10
@   0x0802439a: 4a0d        ldr	r2, [pc, #52]	@ (0x243d0)
@   0x0802439c: 00a1        lsls	r1, r4, #2
@   0x0802439e: 1889        adds	r1, r1, r2
@   0x080243a0: 6809        ldr	r1, [r1, #0]
@   0x080243a2: 2201        movs	r2, #1
@   0x080243a4: 4022        ands	r2, r4
@   0x080243a6: 0112        lsls	r2, r2, #4
@   0x080243a8: 3281        adds	r2, #129	@ 0x81
@   0x080243aa: 9200        str	r2, [sp, #0]
@   0x080243ac: 2202        movs	r2, #2
@   0x080243ae: 9201        str	r2, [sp, #4]
@   0x080243b0: 2203        movs	r2, #3
@   0x080243b2: 9202        str	r2, [sp, #8]
@   0x080243b4: 9203        str	r2, [sp, #12]
@   0x080243b6: 2210        movs	r2, #16
@   0x080243b8: 231e        movs	r3, #30
@   0x080243ba: f7fc        fe71 	bl	0x210a0
@   0x080243be: 1c60        adds	r0, r4, #1
@   0x080243c0: 0600        lsls	r0, r0, #24
@   0x080243c2: 0e04        lsrs	r4, r0, #24
@   0x080243c4: 2c09        cmp	r4, #9
@   0x080243c6: d9e6        bls.n	0x24396
@   0x080243c8: b004        add	sp, #16
@   0x080243ca: bc10        pop	{r4}
@   0x080243cc: bc01        pop	{r0}
@   0x080243ce: 4700        bx	r0
@   0x080243d0: 2d80        cmp	r5, #128	@ 0x80
@   0x080243d2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024390
sub_08024390: @ 0x08024390
        .incbin "frog_us_baserom.gba", 0x24390, 0x44
        thumb_func_end sub_08024390
