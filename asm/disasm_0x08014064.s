@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08014064, 0x08014078)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8014064 --end 0x8014078 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08014064: b500        push	{lr}
@   0x08014066: 2005        movs	r0, #5
@   0x08014068: 2103        movs	r1, #3
@   0x0801406a: f7fc        fceb 	bl	0x10a44
@   0x0801406e: f002        ffc7 	bl	0x17000
@   0x08014072: bc01        pop	{r0}
@   0x08014074: 4700        bx	r0

        thumb_func_start sub_08014064
sub_08014064: @ 0x08014064
        .incbin "frog_us_baserom.gba", 0x14064, 0x14
        thumb_func_end sub_08014064
