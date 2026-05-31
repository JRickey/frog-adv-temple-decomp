@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080118fc, 0x0801190c)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80118fc --end 0x801190c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080118fc: b500        push	{lr}
@   0x080118fe: 2004        movs	r0, #4
@   0x08011900: f7ff        feda 	bl	0x116b8
@   0x08011904: f005        fb7c 	bl	0x17000
@   0x08011908: bc01        pop	{r0}
@   0x0801190a: 4700        bx	r0

        thumb_func_start sub_080118FC
sub_080118FC: @ 0x080118fc
        .incbin "frog_us_baserom.gba", 0x118fc, 0x10
        thumb_func_end sub_080118FC
