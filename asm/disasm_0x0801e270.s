@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801e270, 0x0801e28c)  (28 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801e270 --end 0x801e28c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801e270: b530        push	{r4, r5, lr}
@   0x0801e272: 1c05        adds	r5, r0, #0
@   0x0801e274: f7e2        fb44 	bl	0x900
@   0x0801e278: 1c04        adds	r4, r0, #0
@   0x0801e27a: f7e2        fb41 	bl	0x900
@   0x0801e27e: 1b00        subs	r0, r0, r4
@   0x0801e280: 42a8        cmp	r0, r5
@   0x0801e282: d3fa        bcc.n	0x1e27a
@   0x0801e284: bc30        pop	{r4, r5}
@   0x0801e286: bc01        pop	{r0}
@   0x0801e288: 4700        bx	r0

        thumb_func_start sub_0801E270
sub_0801E270: @ 0x0801e270
        .incbin "frog_us_baserom.gba", 0x1e270, 0x1c
        thumb_func_end sub_0801E270
