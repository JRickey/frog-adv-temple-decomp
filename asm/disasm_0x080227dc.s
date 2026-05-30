@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080227dc, 0x08022800)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80227dc --end 0x8022800 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080227dc: b500        push	{lr}
@   0x080227de: b081        sub	sp, #4
@   0x080227e0: 4905        ldr	r1, [pc, #20]	@ (0x227f8)
@   0x080227e2: 4b06        ldr	r3, [pc, #24]	@ (0x227fc)
@   0x080227e4: 2000        movs	r0, #0
@   0x080227e6: 9000        str	r0, [sp, #0]
@   0x080227e8: 202f        movs	r0, #47	@ 0x2f
@   0x080227ea: 220b        movs	r2, #11
@   0x080227ec: f7fe        fe90 	bl	0x21510
@   0x080227f0: b001        add	sp, #4
@   0x080227f2: bc01        pop	{r0}
@   0x080227f4: 4700        bx	r0
@   0x080227f6: 0000        movs	r0, r0
@   0x080227f8: 0c2c        lsrs	r4, r5, #16
@   0x080227fa: 0831        lsrs	r1, r6, #32
@   0x080227fc: 6110        str	r0, [r2, #16]
@   0x080227fe: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080227DC
sub_080227DC: @ 0x080227dc
        .incbin "frog_us_baserom.gba", 0x227dc, 0x24
        thumb_func_end sub_080227DC
