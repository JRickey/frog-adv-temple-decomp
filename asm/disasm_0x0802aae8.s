@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802aae8, 0x0802aaec)  (4 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802aae8 --end 0x802aaec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802aae8: 4770        bx	lr

        thumb_func_start sub_0802AAE8
sub_0802AAE8: @ 0x0802aae8
        .incbin "frog_us_baserom.gba", 0x2aae8, 0x4
        thumb_func_end sub_0802AAE8
