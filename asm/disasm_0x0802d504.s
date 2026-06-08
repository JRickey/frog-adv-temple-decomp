@ Auto-emitted by tools/disasm/peel.py; shrunk after splitting SoftResetExram
@ (0x0802d514) out into asm/libagbsyscall.s. This slice is now just the game
@ trampoline that tail-calls Entity2_Tick + sub_0802D170.
@ Range:  [0x0802d504, 0x0802d514)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d504 --end 0x802d514 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d504: b500        push	{lr}
@   0x0802d506: f7ff        fcab 	bl	0x2ce60
@   0x0802d50a: f7ff        fe31 	bl	0x2d170
@   0x0802d50e: bc01        pop	{r0}
@   0x0802d510: 4700        bx	r0
@   0x0802d512: 0000        movs	r0, r0

        thumb_func_start sub_0802D504
sub_0802D504: @ 0x0802d504
        .incbin "frog_us_baserom.gba", 0x2d504, 0x10
        thumb_func_end sub_0802D504
