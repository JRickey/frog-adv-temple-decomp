@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002e94, 0x08002eac)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002e94 --end 0x8002eac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002e94: b510        push	{r4, lr}
@   0x08002e96: 1c04        adds	r4, r0, #0
@   0x08002e98: f006        febc 	bl	0x9c14
@   0x08002e9c: 2800        cmp	r0, #0
@   0x08002e9e: d101        bne.n	0x2ea4
@   0x08002ea0: 2009        movs	r0, #9
@   0x08002ea2: 7020        strb	r0, [r4, #0]
@   0x08002ea4: bc10        pop	{r4}
@   0x08002ea6: bc01        pop	{r0}
@   0x08002ea8: 4700        bx	r0

        thumb_func_start sub_08002E94
sub_08002E94: @ 0x08002e94
        .incbin "frog_us_baserom.gba", 0x2e94, 0x18
        thumb_func_end sub_08002E94
