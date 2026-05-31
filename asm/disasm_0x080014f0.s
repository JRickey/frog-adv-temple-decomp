@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080014f0, 0x08001508)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80014f0 --end 0x8001508 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080014f0: b510        push	{r4, lr}
@   0x080014f2: 1c04        adds	r4, r0, #0
@   0x080014f4: f008        fb8e 	bl	0x9c14
@   0x080014f8: 2800        cmp	r0, #0
@   0x080014fa: d101        bne.n	0x1500
@   0x080014fc: 2008        movs	r0, #8
@   0x080014fe: 7020        strb	r0, [r4, #0]
@   0x08001500: bc10        pop	{r4}
@   0x08001502: bc01        pop	{r0}
@   0x08001504: 4700        bx	r0

        thumb_func_start sub_080014F0
sub_080014F0: @ 0x080014f0
        .incbin "frog_us_baserom.gba", 0x14f0, 0x18
        thumb_func_end sub_080014F0
