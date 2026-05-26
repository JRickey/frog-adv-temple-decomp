@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001198, 0x080011a4)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001198 --end 0x80011a4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001198: b500        push	{lr}
@   0x0800119a: f00c        fe71 	bl	0xde80
@   0x0800119e: bc01        pop	{r0}
@   0x080011a0: 4700        bx	r0

        thumb_func_start sub_08001198
sub_08001198: @ 0x08001198
        .incbin "frog_us_baserom.gba", 0x1198, 0xc
        thumb_func_end sub_08001198
