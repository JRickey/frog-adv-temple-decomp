@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080228ac, 0x080228d0)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80228ac --end 0x80228d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080228ac: b500        push	{lr}
@   0x080228ae: b081        sub	sp, #4
@   0x080228b0: 4905        ldr	r1, [pc, #20]	@ (0x228c8)
@   0x080228b2: 4b06        ldr	r3, [pc, #24]	@ (0x228cc)
@   0x080228b4: 2000        movs	r0, #0
@   0x080228b6: 9000        str	r0, [sp, #0]
@   0x080228b8: 2005        movs	r0, #5
@   0x080228ba: 2202        movs	r2, #2
@   0x080228bc: f7fe        fe28 	bl	0x21510
@   0x080228c0: b001        add	sp, #4
@   0x080228c2: bc01        pop	{r0}
@   0x080228c4: 4700        bx	r0
@   0x080228c6: 0000        movs	r0, r0
@   0x080228c8: 0b84        lsrs	r4, r0, #14
@   0x080228ca: 0831        lsrs	r1, r6, #32
@   0x080228cc: 6110        str	r0, [r2, #16]
@   0x080228ce: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080228AC
sub_080228AC: @ 0x080228ac
        .incbin "frog_us_baserom.gba", 0x228ac, 0x24
        thumb_func_end sub_080228AC
