@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002eac, 0x08002eb8)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002eac --end 0x8002eb8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002eac: b500        push	{lr}
@   0x08002eae: f00a        ffe7 	bl	0xde80
@   0x08002eb2: bc01        pop	{r0}
@   0x08002eb4: 4700        bx	r0

        thumb_func_start sub_08002EAC
sub_08002EAC: @ 0x08002eac
        .incbin "frog_us_baserom.gba", 0x2eac, 0xc
        thumb_func_end sub_08002EAC
