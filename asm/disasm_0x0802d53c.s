@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d53c, 0x0802d548)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d53c --end 0x802d548 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d53c: df06        svc	6
@   0x0802d53e: 1c08        adds	r0, r1, #0
@   0x0802d540: 4770        bx	lr
@   0x0802d542: df07        svc	7
@   0x0802d544: 1c08        adds	r0, r1, #0
@   0x0802d546: 4770        bx	lr

        thumb_func_start sub_0802D53C
sub_0802D53C: @ 0x0802d53c
        .incbin "frog_us_baserom.gba", 0x2d53c, 0xc
        thumb_func_end sub_0802D53C
