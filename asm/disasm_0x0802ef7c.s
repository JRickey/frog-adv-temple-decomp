@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ef7c, 0x0802f054)  (216 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ef7c --end 0x802f054 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802EF7C
sub_0802EF7C: @ 0x0802ef7c
        .incbin "frog_us_baserom.gba", 0x2ef7c, 0xd8
        thumb_func_end sub_0802EF7C
