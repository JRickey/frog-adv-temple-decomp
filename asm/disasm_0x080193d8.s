@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080193d8, 0x08019500)  (296 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80193d8 --end 0x8019500 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start Menu25_PollInput
Menu25_PollInput: @ 0x08019420
        .incbin "frog_us_baserom.gba", 0x19420, 0xe0
        thumb_func_end Menu25_PollInput
