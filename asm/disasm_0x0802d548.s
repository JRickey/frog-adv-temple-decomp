@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d548, 0x0802d54c)  (4 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d548 --end 0x802d54c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d548: df08        svc	8
@   0x0802d54a: 4770        bx	lr

        thumb_func_start sub_0802D548
sub_0802D548: @ 0x0802d548
        .incbin "frog_us_baserom.gba", 0x2d548, 0x4
        thumb_func_end sub_0802D548
