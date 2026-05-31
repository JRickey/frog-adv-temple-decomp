@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ca70, 0x0802ca80)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ca70 --end 0x802ca80 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ca70: b500        push	{lr}
@   0x0802ca72: f7ff        f9a3 	bl	0x2bdbc
@   0x0802ca76: 205b        movs	r0, #91	@ 0x5b
@   0x0802ca78: f7ff        fbc2 	bl	0x2c200
@   0x0802ca7c: bc01        pop	{r0}
@   0x0802ca7e: 4700        bx	r0

        thumb_func_start sub_0802CA70
sub_0802CA70: @ 0x0802ca70
        .incbin "frog_us_baserom.gba", 0x2ca70, 0x10
        thumb_func_end sub_0802CA70
