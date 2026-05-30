@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080059b0, 0x080059c4)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80059b0 --end 0x80059c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080059b0: b500        push	{lr}
@   0x080059b2: f008        fa65 	bl	0xde80
@   0x080059b6: 2000        movs	r0, #0
@   0x080059b8: f018        fbae 	bl	0x1e118
@   0x080059bc: f018        f82e 	bl	0x1da1c
@   0x080059c0: bc01        pop	{r0}
@   0x080059c2: 4700        bx	r0

        thumb_func_start sub_080059B0
sub_080059B0: @ 0x080059b0
        .incbin "frog_us_baserom.gba", 0x59b0, 0x14
        thumb_func_end sub_080059B0
