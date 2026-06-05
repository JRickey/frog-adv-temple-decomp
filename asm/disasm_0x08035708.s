@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08035708, 0x08035730)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8035708 --end 0x8035730 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08035708: b081        sub	sp, #4
@   0x0803570a: b510        push	{r4, lr}
@   0x0803570c: b085        sub	sp, #20
@   0x0803570e: 9307        str	r3, [sp, #28]
@   0x08035710: 9b07        ldr	r3, [sp, #28]
@   0x08035712: 9c08        ldr	r4, [sp, #32]
@   0x08035714: 9000        str	r0, [sp, #0]
@   0x08035716: 9101        str	r1, [sp, #4]
@   0x08035718: 9202        str	r2, [sp, #8]
@   0x0803571a: 9303        str	r3, [sp, #12]
@   0x0803571c: 9404        str	r4, [sp, #16]
@   0x0803571e: 4668        mov	r0, sp
@   0x08035720: f7ff        f95a 	bl	0x349d8
@   0x08035724: b005        add	sp, #20
@   0x08035726: bc10        pop	{r4}
@   0x08035728: bc08        pop	{r3}
@   0x0803572a: b001        add	sp, #4
@   0x0803572c: 4718        bx	r3

        thumb_func_start sub_08035708
sub_08035708: @ 0x08035708
        .incbin "frog_us_baserom.gba", 0x35708, 0x28
        thumb_func_end sub_08035708
