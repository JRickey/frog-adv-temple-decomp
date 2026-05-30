@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080053f4, 0x08005404)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80053f4 --end 0x8005404 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080053f4: b500        push	{lr}
@   0x080053f6: f010        fb03 	bl	0x15a00
@   0x080053fa: f008        fd41 	bl	0xde80
@   0x080053fe: bc01        pop	{r0}
@   0x08005400: 4700        bx	r0

        thumb_func_start sub_080053F4
sub_080053F4: @ 0x080053f4
        .incbin "frog_us_baserom.gba", 0x53f4, 0x10
        thumb_func_end sub_080053F4
