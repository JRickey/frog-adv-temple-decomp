@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080027f0, 0x08002808)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80027f0 --end 0x8002808 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080027f0: b510        push	{r4, lr}
@   0x080027f2: 1c04        adds	r4, r0, #0
@   0x080027f4: f007        fa0e 	bl	0x9c14
@   0x080027f8: 2800        cmp	r0, #0
@   0x080027fa: d101        bne.n	0x2800
@   0x080027fc: 2007        movs	r0, #7
@   0x080027fe: 7020        strb	r0, [r4, #0]
@   0x08002800: bc10        pop	{r4}
@   0x08002802: bc01        pop	{r0}
@   0x08002804: 4700        bx	r0

        thumb_func_start sub_080027F0
sub_080027F0: @ 0x080027f0
        .incbin "frog_us_baserom.gba", 0x27f0, 0x18
        thumb_func_end sub_080027F0
