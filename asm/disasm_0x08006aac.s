@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006aac, 0x08006ab8)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006aac --end 0x8006ab8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006aac: b500        push	{lr}
@   0x08006aae: 7001        strb	r1, [r0, #0]
@   0x08006ab0: f00f        ffc6 	bl	0x16a40
@   0x08006ab4: bc01        pop	{r0}
@   0x08006ab6: 4700        bx	r0

        thumb_func_start sub_08006AAC
sub_08006AAC: @ 0x08006aac
        .incbin "frog_us_baserom.gba", 0x6aac, 0xc
        thumb_func_end sub_08006AAC
