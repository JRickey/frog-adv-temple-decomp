@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020bac, 0x08020bc0)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020bac --end 0x8020bc0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020bac: b500        push	{lr}
@   0x08020bae: f011        facb 	bl	0x32148
@   0x08020bb2: 2800        cmp	r0, #0
@   0x08020bb4: d002        beq.n	0x20bbc
@   0x08020bb6: 2001        movs	r0, #1
@   0x08020bb8: f011        fa10 	bl	0x31fdc
@   0x08020bbc: bc01        pop	{r0}
@   0x08020bbe: 4700        bx	r0

        thumb_func_start sub_08020BAC
sub_08020BAC: @ 0x08020bac
        .incbin "frog_us_baserom.gba", 0x20bac, 0x14
        thumb_func_end sub_08020BAC
