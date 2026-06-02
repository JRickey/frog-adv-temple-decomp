@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802dfbc, 0x0802e00c)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802dfbc --end 0x802e00c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802DFBC
sub_0802DFBC: @ 0x0802dfbc
        .incbin "frog_us_baserom.gba", 0x2dfbc, 0x50
        thumb_func_end sub_0802DFBC
