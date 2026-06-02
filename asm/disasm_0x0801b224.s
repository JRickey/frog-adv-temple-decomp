@ Auto-emitted split from asm/disasm_0x0801b1b4.s.
@ Range:  [0x0801b224, 0x0801b278)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b224 --end 0x801b278 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0801B224
sub_0801B224: @ 0x0801b224
        .incbin "frog_us_baserom.gba", 0x1b224, 0x54
        thumb_func_end sub_0801B224
