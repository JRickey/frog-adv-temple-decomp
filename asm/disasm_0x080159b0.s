@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080159b0, 0x08015a00)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80159b0 --end 0x8015a00 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_080159B0
sub_080159B0: @ 0x080159b0
        .incbin "frog_us_baserom.gba", 0x159b0, 0x50
        thumb_func_end sub_080159B0
