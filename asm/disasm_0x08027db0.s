@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027db0, 0x08027dd8)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027db0 --end 0x8027dd8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027db0: b500        push	{lr}
@   0x08027db2: b083        sub	sp, #12
@   0x08027db4: 4907        ldr	r1, [pc, #28]	@ (0x27dd4)
@   0x08027db6: 2061        movs	r0, #97	@ 0x61
@   0x08027db8: 9000        str	r0, [sp, #0]
@   0x08027dba: 2003        movs	r0, #3
@   0x08027dbc: 9001        str	r0, [sp, #4]
@   0x08027dbe: 2000        movs	r0, #0
@   0x08027dc0: 9002        str	r0, [sp, #8]
@   0x08027dc2: 2009        movs	r0, #9
@   0x08027dc4: 2210        movs	r2, #16
@   0x08027dc6: 2302        movs	r3, #2
@   0x08027dc8: f7f9        f9ba 	bl	0x21140
@   0x08027dcc: b003        add	sp, #12
@   0x08027dce: bc01        pop	{r0}
@   0x08027dd0: 4700        bx	r0
@   0x08027dd2: 0000        movs	r0, r0
@   0x08027dd4: 67e8        str	r0, [r5, #124]	@ 0x7c
@   0x08027dd6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027DB0
sub_08027DB0: @ 0x08027db0
        .incbin "baserom.gba", 0x27db0, 0x28
        thumb_func_end sub_08027DB0
