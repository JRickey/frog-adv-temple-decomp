@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800df9c, 0x0800dfac)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800df9c --end 0x800dfac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800df9c: b500        push	{lr}
@   0x0800df9e: f7fc        f85d 	bl	0xa05c
@   0x0800dfa2: f005        fc6d 	bl	0x13880
@   0x0800dfa6: bc01        pop	{r0}
@   0x0800dfa8: 4700        bx	r0

        thumb_func_start sub_0800DF9C
sub_0800DF9C: @ 0x0800df9c
        .incbin "frog_us_baserom.gba", 0xdf9c, 0x10
        thumb_func_end sub_0800DF9C
