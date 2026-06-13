@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028238, 0x08028270)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028238 --end 0x8028270 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028238: b500        push	{lr}
@   0x0802823a: f7ff        fd81 	bl	0x27d40
@   0x0802823e: f7ff        fda5 	bl	0x27d8c
@   0x08028242: f7ff        fdc9 	bl	0x27dd8
@   0x08028246: f7ff        faf1 	bl	0x2782c
@   0x0802824a: f7ff        fb47 	bl	0x278dc
@   0x0802824e: f7ff        fe2f 	bl	0x27eb0
@   0x08028252: f7ff        fe75 	bl	0x27f40
@   0x08028256: f7ff        febb 	bl	0x27fd0
@   0x0802825a: f7ff        fc33 	bl	0x27ac4
@   0x0802825e: f7ff        fd11 	bl	0x27c84
@   0x08028262: f7ff        ff59 	bl	0x28118
@   0x08028266: f7ff        ffa5 	bl	0x281b4
@   0x0802826a: bc01        pop	{r0}
@   0x0802826c: 4700        bx	r0

        thumb_func_start sub_08028238
sub_08028238: @ 0x08028238
        .incbin "baserom.gba", 0x28238, 0x38
        thumb_func_end sub_08028238
