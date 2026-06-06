@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d534, 0x0802d538)  (4 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d534 --end 0x802d538 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d534: df06        svc	6
@   0x0802d536: 4770        bx	lr

        thumb_func_start sub_0802D534
sub_0802D534: @ 0x0802d534
        .incbin "frog_us_baserom.gba", 0x2d534, 0x4
        thumb_func_end sub_0802D534
