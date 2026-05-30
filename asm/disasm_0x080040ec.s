@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080040ec, 0x08004104)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80040ec --end 0x8004104 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080040ec: b510        push	{r4, lr}
@   0x080040ee: 1c04        adds	r4, r0, #0
@   0x080040f0: f005        fd90 	bl	0x9c14
@   0x080040f4: 2800        cmp	r0, #0
@   0x080040f6: d101        bne.n	0x40fc
@   0x080040f8: 2008        movs	r0, #8
@   0x080040fa: 7020        strb	r0, [r4, #0]
@   0x080040fc: bc10        pop	{r4}
@   0x080040fe: bc01        pop	{r0}
@   0x08004100: 4700        bx	r0

        thumb_func_start sub_080040EC
sub_080040EC: @ 0x080040ec
        .incbin "frog_us_baserom.gba", 0x40ec, 0x18
        thumb_func_end sub_080040EC
