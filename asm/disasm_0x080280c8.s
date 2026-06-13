@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080280c8, 0x08028118)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80280c8 --end 0x8028118 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080280c8: b570        push	{r4, r5, r6, lr}
@   0x080280ca: 4646        mov	r6, r8
@   0x080280cc: b440        push	{r6}
@   0x080280ce: b084        sub	sp, #16
@   0x080280d0: 480f        ldr	r0, [pc, #60]	@ (0x28110)
@   0x080280d2: 4680        mov	r8, r0
@   0x080280d4: 6801        ldr	r1, [r0, #0]
@   0x080280d6: 4e0f        ldr	r6, [pc, #60]	@ (0x28114)
@   0x080280d8: 9600        str	r6, [sp, #0]
@   0x080280da: 250d        movs	r5, #13
@   0x080280dc: 9501        str	r5, [sp, #4]
@   0x080280de: 2403        movs	r4, #3
@   0x080280e0: 9402        str	r4, [sp, #8]
@   0x080280e2: 9403        str	r4, [sp, #12]
@   0x080280e4: 204a        movs	r0, #74	@ 0x4a
@   0x080280e6: 2200        movs	r2, #0
@   0x080280e8: 233d        movs	r3, #61	@ 0x3d
@   0x080280ea: f7f8        ffd9 	bl	0x210a0
@   0x080280ee: 4640        mov	r0, r8
@   0x080280f0: 6841        ldr	r1, [r0, #4]
@   0x080280f2: 9600        str	r6, [sp, #0]
@   0x080280f4: 9501        str	r5, [sp, #4]
@   0x080280f6: 9402        str	r4, [sp, #8]
@   0x080280f8: 9403        str	r4, [sp, #12]
@   0x080280fa: 204b        movs	r0, #75	@ 0x4b
@   0x080280fc: 2200        movs	r2, #0
@   0x080280fe: 233d        movs	r3, #61	@ 0x3d
@   0x08028100: f7f8        ffce 	bl	0x210a0
@   0x08028104: b004        add	sp, #16
@   0x08028106: bc08        pop	{r3}
@   0x08028108: 4698        mov	r8, r3
@   0x0802810a: bc70        pop	{r4, r5, r6}
@   0x0802810c: bc01        pop	{r0}
@   0x0802810e: 4700        bx	r0
@   0x08028110: 6e4c        ldr	r4, [r1, #100]	@ 0x64
@   0x08028112: 0831        lsrs	r1, r6, #32
@   0x08028114: 01e9        lsls	r1, r5, #7

        thumb_func_start sub_080280C8
sub_080280C8: @ 0x080280c8
        .incbin "baserom.gba", 0x280c8, 0x50
        thumb_func_end sub_080280C8
