@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d554, 0x0802d558)  (4 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d554 --end 0x802d558 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d554: df0b        svc	11
@   0x0802d556: 4770        bx	lr

        thumb_func_start sub_0802D554
sub_0802D554: @ 0x0802d554
        .incbin "frog_us_baserom.gba", 0x2d554, 0x4
        thumb_func_end sub_0802D554
