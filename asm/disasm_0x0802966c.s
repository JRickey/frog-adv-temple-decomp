@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802966c, 0x08029690)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802966c --end 0x8029690 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802966c: b500        push	{lr}
@   0x0802966e: b081        sub	sp, #4
@   0x08029670: 4905        ldr	r1, [pc, #20]	@ (0x29688)
@   0x08029672: 4b06        ldr	r3, [pc, #24]	@ (0x2968c)
@   0x08029674: 2000        movs	r0, #0
@   0x08029676: 9000        str	r0, [sp, #0]
@   0x08029678: 201e        movs	r0, #30
@   0x0802967a: 220b        movs	r2, #11
@   0x0802967c: f7f7        ff48 	bl	0x21510
@   0x08029680: b001        add	sp, #4
@   0x08029682: bc01        pop	{r0}
@   0x08029684: 4700        bx	r0
@   0x08029686: 0000        movs	r0, r0
@   0x08029688: 7054        strb	r4, [r2, #1]
@   0x0802968a: 0831        lsrs	r1, r6, #32
@   0x0802968c: 6110        str	r0, [r2, #16]
@   0x0802968e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802966C
sub_0802966C: @ 0x0802966c
        .incbin "baserom.gba", 0x2966c, 0x24
        thumb_func_end sub_0802966C
