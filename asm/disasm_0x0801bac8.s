@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801bac8, 0x0801badc)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801bac8 --end 0x801badc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801bac8: b500        push	{lr}
@   0x0801baca: f000        f825 	bl	0x1bb18
@   0x0801bace: f000        f825 	bl	0x1bb1c
@   0x0801bad2: bc01        pop	{r0}
@   0x0801bad4: 4700        bx	r0
@   0x0801bad6: 0000        movs	r0, r0
@   0x0801bad8: 4770        bx	lr

        thumb_func_start sub_0801BAC8
sub_0801BAC8: @ 0x0801bac8
        .incbin "frog_us_baserom.gba", 0x1bac8, 0x14
        thumb_func_end sub_0801BAC8
