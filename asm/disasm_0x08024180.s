@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024180, 0x080241cc)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024180 --end 0x80241cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024180: b570        push	{r4, r5, r6, lr}
@   0x08024182: b084        sub	sp, #16
@   0x08024184: 2400        movs	r4, #0
@   0x08024186: 2503        movs	r5, #3
@   0x08024188: 1c20        adds	r0, r4, #0
@   0x0802418a: 3059        adds	r0, #89	@ 0x59
@   0x0802418c: 4a0d        ldr	r2, [pc, #52]	@ (0x241c4)
@   0x0802418e: 00a1        lsls	r1, r4, #2
@   0x08024190: 1889        adds	r1, r1, r2
@   0x08024192: 6809        ldr	r1, [r1, #0]
@   0x08024194: 1c22        adds	r2, r4, #0
@   0x08024196: 402a        ands	r2, r5
@   0x08024198: 0112        lsls	r2, r2, #4
@   0x0802419a: 4e0b        ldr	r6, [pc, #44]	@ (0x241c8)
@   0x0802419c: 1c33        adds	r3, r6, #0
@   0x0802419e: 431a        orrs	r2, r3
@   0x080241a0: 9200        str	r2, [sp, #0]
@   0x080241a2: 2206        movs	r2, #6
@   0x080241a4: 9201        str	r2, [sp, #4]
@   0x080241a6: 9502        str	r5, [sp, #8]
@   0x080241a8: 9503        str	r5, [sp, #12]
@   0x080241aa: 2210        movs	r2, #16
@   0x080241ac: 230d        movs	r3, #13
@   0x080241ae: f7fc        ff77 	bl	0x210a0
@   0x080241b2: 1c60        adds	r0, r4, #1
@   0x080241b4: 0600        lsls	r0, r0, #24
@   0x080241b6: 0e04        lsrs	r4, r0, #24
@   0x080241b8: 2c05        cmp	r4, #5
@   0x080241ba: d9e5        bls.n	0x24188
@   0x080241bc: b004        add	sp, #16
@   0x080241be: bc70        pop	{r4, r5, r6}
@   0x080241c0: bc01        pop	{r0}
@   0x080241c2: 4700        bx	r0
@   0x080241c4: 2e6c        cmp	r6, #108	@ 0x6c
@   0x080241c6: 0831        lsrs	r1, r6, #32
@   0x080241c8: 0101        lsls	r1, r0, #4

        thumb_func_start sub_08024180
sub_08024180: @ 0x08024180
        .incbin "frog_us_baserom.gba", 0x24180, 0x4c
        thumb_func_end sub_08024180
