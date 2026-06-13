@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029710, 0x08029748)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029710 --end 0x8029748 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08029710
sub_08029710: @ 0x08029710
        .incbin "baserom.gba", 0x29710, 0x38
        thumb_func_end sub_08029710
