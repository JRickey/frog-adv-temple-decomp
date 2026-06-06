@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d538, 0x0802d53c)  (4 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d538 --end 0x802d53c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d538: df07        svc	7
@   0x0802d53a: 4770        bx	lr

        thumb_func_start sub_0802D538
sub_0802D538: @ 0x0802d538
        .incbin "frog_us_baserom.gba", 0x2d538, 0x4
        thumb_func_end sub_0802D538
