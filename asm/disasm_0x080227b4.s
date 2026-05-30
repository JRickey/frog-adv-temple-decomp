@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080227b4, 0x080227dc)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80227b4 --end 0x80227dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080227b4: b500        push	{lr}
@   0x080227b6: b083        sub	sp, #12
@   0x080227b8: 4907        ldr	r1, [pc, #28]	@ (0x227d8)
@   0x080227ba: 20d1        movs	r0, #209	@ 0xd1
@   0x080227bc: 9000        str	r0, [sp, #0]
@   0x080227be: 2007        movs	r0, #7
@   0x080227c0: 9001        str	r0, [sp, #4]
@   0x080227c2: 2000        movs	r0, #0
@   0x080227c4: 9002        str	r0, [sp, #8]
@   0x080227c6: 202f        movs	r0, #47	@ 0x2f
@   0x080227c8: 2200        movs	r2, #0
@   0x080227ca: 230b        movs	r3, #11
@   0x080227cc: f7fe        fcb8 	bl	0x21140
@   0x080227d0: b003        add	sp, #12
@   0x080227d2: bc01        pop	{r0}
@   0x080227d4: 4700        bx	r0
@   0x080227d6: 0000        movs	r0, r0
@   0x080227d8: 0c2c        lsrs	r4, r5, #16
@   0x080227da: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080227B4
sub_080227B4: @ 0x080227b4
        .incbin "frog_us_baserom.gba", 0x227b4, 0x28
        thumb_func_end sub_080227B4
