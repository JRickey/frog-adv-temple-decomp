@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d524, 0x0802d534)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d524 --end 0x802d534 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d524: df01        svc	1
@   0x0802d526: 4770        bx	lr
@   0x0802d528: 2200        movs	r2, #0
@   0x0802d52a: df04        svc	4
@   0x0802d52c: 4770        bx	lr
@   0x0802d52e: 2200        movs	r2, #0
@   0x0802d530: df05        svc	5
@   0x0802d532: 4770        bx	lr

        thumb_func_start sub_0802D524
sub_0802D524: @ 0x0802d524
        .incbin "frog_us_baserom.gba", 0x2d524, 0x10
        thumb_func_end sub_0802D524
