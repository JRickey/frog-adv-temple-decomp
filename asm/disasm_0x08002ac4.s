@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002ac4, 0x08002adc)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002ac4 --end 0x8002adc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002ac4: b510        push	{r4, lr}
@   0x08002ac6: 1c04        adds	r4, r0, #0
@   0x08002ac8: f007        f8a4 	bl	0x9c14
@   0x08002acc: 2800        cmp	r0, #0
@   0x08002ace: d101        bne.n	0x2ad4
@   0x08002ad0: 2007        movs	r0, #7
@   0x08002ad2: 7020        strb	r0, [r4, #0]
@   0x08002ad4: bc10        pop	{r4}
@   0x08002ad6: bc01        pop	{r0}
@   0x08002ad8: 4700        bx	r0

        thumb_func_start sub_08002AC4
sub_08002AC4: @ 0x08002ac4
        .incbin "frog_us_baserom.gba", 0x2ac4, 0x18
        thumb_func_end sub_08002AC4
