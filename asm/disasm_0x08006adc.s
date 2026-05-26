@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006adc, 0x08006afc)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006adc --end 0x8006afc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006adc: b500        push	{lr}
@   0x08006ade: 1c01        adds	r1, r0, #0
@   0x08006ae0: 7808        ldrb	r0, [r1, #0]
@   0x08006ae2: 3801        subs	r0, #1
@   0x08006ae4: 7008        strb	r0, [r1, #0]
@   0x08006ae6: 0600        lsls	r0, r0, #24
@   0x08006ae8: 2800        cmp	r0, #0
@   0x08006aea: db03        blt.n	0x6af4
@   0x08006aec: f00f        ffa8 	bl	0x16a40
@   0x08006af0: 2001        movs	r0, #1
@   0x08006af2: e001        b.n	0x6af8
@   0x08006af4: 2000        movs	r0, #0
@   0x08006af6: 7008        strb	r0, [r1, #0]
@   0x08006af8: bc02        pop	{r1}
@   0x08006afa: 4708        bx	r1

        thumb_func_start sub_08006ADC
sub_08006ADC: @ 0x08006adc
        .incbin "frog_us_baserom.gba", 0x6adc, 0x20
        thumb_func_end sub_08006ADC
