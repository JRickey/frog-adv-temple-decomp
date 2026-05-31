@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a458, 0x0800a4d0)  (120 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a458 --end 0x800a4d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0800A458
sub_0800A458: @ 0x0800a458
        .incbin "frog_us_baserom.gba", 0xa458, 0x78
        thumb_func_end sub_0800A458
