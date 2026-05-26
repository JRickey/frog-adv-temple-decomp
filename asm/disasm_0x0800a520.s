@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a520, 0x0800a540)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a520 --end 0x800a540 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a520: b500        push	{lr}
@   0x0800a522: f7fd        fc55 	bl	0x7dd0
@   0x0800a526: 2018        movs	r0, #24
@   0x0800a528: 2118        movs	r1, #24
@   0x0800a52a: f7fd        fa07 	bl	0x793c
@   0x0800a52e: f7fd        fe21 	bl	0x8174
@   0x0800a532: f7fe        fdbd 	bl	0x90b0
@   0x0800a536: f7ff        ffcb 	bl	0xa4d0
@   0x0800a53a: bc01        pop	{r0}
@   0x0800a53c: 4700        bx	r0

        thumb_func_start sub_0800A520
sub_0800A520: @ 0x0800a520
        .incbin "frog_us_baserom.gba", 0xa520, 0x20
        thumb_func_end sub_0800A520
