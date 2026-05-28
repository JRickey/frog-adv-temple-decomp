@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a258, 0x0800a26c)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a258 --end 0x800a26c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a258: b510        push	{r4, lr}
@   0x0800a25a: 1c04        adds	r4, r0, #0
@   0x0800a25c: f016        fca6 	bl	0x20bac
@   0x0800a260: 1c20        adds	r0, r4, #0
@   0x0800a262: f016        fc91 	bl	0x20b88
@   0x0800a266: bc10        pop	{r4}
@   0x0800a268: bc01        pop	{r0}
@   0x0800a26a: 4700        bx	r0

        thumb_func_start sub_0800A258
sub_0800A258: @ 0x0800a258
        .incbin "frog_us_baserom.gba", 0xa258, 0x14
        thumb_func_end sub_0800A258
