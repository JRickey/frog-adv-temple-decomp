@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802626c, 0x08026290)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802626c --end 0x8026290 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802626c: b500        push	{lr}
@   0x0802626e: b081        sub	sp, #4
@   0x08026270: 4905        ldr	r1, [pc, #20]	@ (0x26288)
@   0x08026272: 4b06        ldr	r3, [pc, #24]	@ (0x2628c)
@   0x08026274: 2000        movs	r0, #0
@   0x08026276: 9000        str	r0, [sp, #0]
@   0x08026278: 205e        movs	r0, #94	@ 0x5e
@   0x0802627a: 224c        movs	r2, #76	@ 0x4c
@   0x0802627c: f7fb        f948 	bl	0x21510
@   0x08026280: b001        add	sp, #4
@   0x08026282: bc01        pop	{r0}
@   0x08026284: 4700        bx	r0
@   0x08026286: 0000        movs	r0, r0
@   0x08026288: 40a8        lsls	r0, r5
@   0x0802628a: 0831        lsrs	r1, r6, #32
@   0x0802628c: 6110        str	r0, [r2, #16]
@   0x0802628e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802626C
sub_0802626C: @ 0x0802626c
        .incbin "baserom.gba", 0x2626c, 0x24
        thumb_func_end sub_0802626C
