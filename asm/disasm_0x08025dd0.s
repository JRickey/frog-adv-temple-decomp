@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025dd0, 0x08025dfc)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025dd0 --end 0x8025dfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025dd0: b500        push	{lr}
@   0x08025dd2: b083        sub	sp, #12
@   0x08025dd4: 4907        ldr	r1, [pc, #28]	@ (0x25df4)
@   0x08025dd6: 4808        ldr	r0, [pc, #32]	@ (0x25df8)
@   0x08025dd8: 9000        str	r0, [sp, #0]
@   0x08025dda: 2004        movs	r0, #4
@   0x08025ddc: 9001        str	r0, [sp, #4]
@   0x08025dde: 2000        movs	r0, #0
@   0x08025de0: 9002        str	r0, [sp, #8]
@   0x08025de2: 2029        movs	r0, #41	@ 0x29
@   0x08025de4: 2210        movs	r2, #16
@   0x08025de6: 2322        movs	r3, #34	@ 0x22
@   0x08025de8: f7fb        f9aa 	bl	0x21140
@   0x08025dec: b003        add	sp, #12
@   0x08025dee: bc01        pop	{r0}
@   0x08025df0: 4700        bx	r0
@   0x08025df2: 0000        movs	r0, r0
@   0x08025df4: 4208        tst	r0, r1
@   0x08025df6: 0831        lsrs	r1, r6, #32
@   0x08025df8: 0181        lsls	r1, r0, #6

        thumb_func_start sub_08025DD0
sub_08025DD0: @ 0x08025dd0
        .incbin "baserom.gba", 0x25dd0, 0x2c
        thumb_func_end sub_08025DD0
