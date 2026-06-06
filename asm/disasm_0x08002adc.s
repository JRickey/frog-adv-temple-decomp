@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002adc, 0x08002ae8)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002adc --end 0x8002ae8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002adc: b500        push	{lr}
@   0x08002ade: f00b        f9cf 	bl	0xde80
@   0x08002ae2: bc01        pop	{r0}
@   0x08002ae4: 4700        bx	r0

        thumb_func_start sub_08002ADC
sub_08002ADC: @ 0x08002adc
        .incbin "frog_us_baserom.gba", 0x2adc, 0xc
        thumb_func_end sub_08002ADC
