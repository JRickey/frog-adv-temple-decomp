@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802349c, 0x080234e8)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802349c --end 0x80234e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802349c: b570        push	{r4, r5, r6, lr}
@   0x0802349e: b084        sub	sp, #16
@   0x080234a0: 4e0e        ldr	r6, [pc, #56]	@ (0x234dc)
@   0x080234a2: 6831        ldr	r1, [r6, #0]
@   0x080234a4: 480e        ldr	r0, [pc, #56]	@ (0x234e0)
@   0x080234a6: 9000        str	r0, [sp, #0]
@   0x080234a8: 250c        movs	r5, #12
@   0x080234aa: 9501        str	r5, [sp, #4]
@   0x080234ac: 2403        movs	r4, #3
@   0x080234ae: 9402        str	r4, [sp, #8]
@   0x080234b0: 9403        str	r4, [sp, #12]
@   0x080234b2: 205b        movs	r0, #91	@ 0x5b
@   0x080234b4: 2210        movs	r2, #16
@   0x080234b6: 2317        movs	r3, #23
@   0x080234b8: f7fd        fdf2 	bl	0x210a0
@   0x080234bc: 6871        ldr	r1, [r6, #4]
@   0x080234be: 4809        ldr	r0, [pc, #36]	@ (0x234e4)
@   0x080234c0: 9000        str	r0, [sp, #0]
@   0x080234c2: 9501        str	r5, [sp, #4]
@   0x080234c4: 9402        str	r4, [sp, #8]
@   0x080234c6: 9403        str	r4, [sp, #12]
@   0x080234c8: 205c        movs	r0, #92	@ 0x5c
@   0x080234ca: 2210        movs	r2, #16
@   0x080234cc: 2317        movs	r3, #23
@   0x080234ce: f7fd        fde7 	bl	0x210a0
@   0x080234d2: b004        add	sp, #16
@   0x080234d4: bc70        pop	{r4, r5, r6}
@   0x080234d6: bc01        pop	{r0}
@   0x080234d8: 4700        bx	r0
@   0x080234da: 0000        movs	r0, r0
@   0x080234dc: 1f78        subs	r0, r7, #5
@   0x080234de: 0831        lsrs	r1, r6, #32
@   0x080234e0: 01d1        lsls	r1, r2, #7
@   0x080234e2: 0000        movs	r0, r0
@   0x080234e4: 01f1        lsls	r1, r6, #7

        thumb_func_start sub_0802349C
sub_0802349C: @ 0x0802349c
        .incbin "frog_us_baserom.gba", 0x2349c, 0x4c
        thumb_func_end sub_0802349C
