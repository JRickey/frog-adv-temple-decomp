@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802610c, 0x0802618c)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802610c --end 0x802618c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802610c: b570        push	{r4, r5, r6, lr}
@   0x0802610e: 464e        mov	r6, r9
@   0x08026110: 4645        mov	r5, r8
@   0x08026112: b460        push	{r5, r6}
@   0x08026114: b084        sub	sp, #16
@   0x08026116: 4e1c        ldr	r6, [pc, #112]	@ (0x26188)
@   0x08026118: 6831        ldr	r1, [r6, #0]
@   0x0802611a: 2071        movs	r0, #113	@ 0x71
@   0x0802611c: 4681        mov	r9, r0
@   0x0802611e: 9000        str	r0, [sp, #0]
@   0x08026120: 2507        movs	r5, #7
@   0x08026122: 9501        str	r5, [sp, #4]
@   0x08026124: 2403        movs	r4, #3
@   0x08026126: 9402        str	r4, [sp, #8]
@   0x08026128: 9403        str	r4, [sp, #12]
@   0x0802612a: 2044        movs	r0, #68	@ 0x44
@   0x0802612c: 2210        movs	r2, #16
@   0x0802612e: 2325        movs	r3, #37	@ 0x25
@   0x08026130: f7fa        ffb6 	bl	0x210a0
@   0x08026134: 6871        ldr	r1, [r6, #4]
@   0x08026136: 2091        movs	r0, #145	@ 0x91
@   0x08026138: 4680        mov	r8, r0
@   0x0802613a: 9000        str	r0, [sp, #0]
@   0x0802613c: 9501        str	r5, [sp, #4]
@   0x0802613e: 9402        str	r4, [sp, #8]
@   0x08026140: 9403        str	r4, [sp, #12]
@   0x08026142: 2045        movs	r0, #69	@ 0x45
@   0x08026144: 2210        movs	r2, #16
@   0x08026146: 2325        movs	r3, #37	@ 0x25
@   0x08026148: f7fa        ffaa 	bl	0x210a0
@   0x0802614c: 68b1        ldr	r1, [r6, #8]
@   0x0802614e: 4648        mov	r0, r9
@   0x08026150: 9000        str	r0, [sp, #0]
@   0x08026152: 9501        str	r5, [sp, #4]
@   0x08026154: 9402        str	r4, [sp, #8]
@   0x08026156: 9403        str	r4, [sp, #12]
@   0x08026158: 2046        movs	r0, #70	@ 0x46
@   0x0802615a: 2210        movs	r2, #16
@   0x0802615c: 2325        movs	r3, #37	@ 0x25
@   0x0802615e: f7fa        ff9f 	bl	0x210a0
@   0x08026162: 68f1        ldr	r1, [r6, #12]
@   0x08026164: 4640        mov	r0, r8
@   0x08026166: 9000        str	r0, [sp, #0]
@   0x08026168: 9501        str	r5, [sp, #4]
@   0x0802616a: 9402        str	r4, [sp, #8]
@   0x0802616c: 9403        str	r4, [sp, #12]
@   0x0802616e: 2047        movs	r0, #71	@ 0x47
@   0x08026170: 2210        movs	r2, #16
@   0x08026172: 2325        movs	r3, #37	@ 0x25
@   0x08026174: f7fa        ff94 	bl	0x210a0
@   0x08026178: b004        add	sp, #16
@   0x0802617a: bc18        pop	{r3, r4}
@   0x0802617c: 4698        mov	r8, r3
@   0x0802617e: 46a1        mov	r9, r4
@   0x08026180: bc70        pop	{r4, r5, r6}
@   0x08026182: bc01        pop	{r0}
@   0x08026184: 4700        bx	r0
@   0x08026186: 0000        movs	r0, r0
@   0x08026188: 4a68        ldr	r2, [pc, #416]	@ (0x2632c)
@   0x0802618a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802610C
sub_0802610C: @ 0x0802610c
        .incbin "baserom.gba", 0x2610c, 0x80
        thumb_func_end sub_0802610C
