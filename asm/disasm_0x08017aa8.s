@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017aa8, 0x08017abc)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017aa8 --end 0x8017abc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017aa8: b500        push	{lr}
@   0x08017aaa: f7f7        fa71 	bl	0xef90
@   0x08017aae: f015        ff23 	bl	0x2d8f8
@   0x08017ab2: f009        f861 	bl	0x20b78
@   0x08017ab6: bc01        pop	{r0}
@   0x08017ab8: 4700        bx	r0

        thumb_func_start sub_08017AA8
sub_08017AA8: @ 0x08017aa8
        .incbin "frog_us_baserom.gba", 0x17aa8, 0x14
        thumb_func_end sub_08017AA8
