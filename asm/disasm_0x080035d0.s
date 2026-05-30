@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080035d0, 0x080035f8)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80035d0 --end 0x80035f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080035d0: b530        push	{r4, r5, lr}
@   0x080035d2: 1c04        adds	r4, r0, #0
@   0x080035d4: 1c0d        adds	r5, r1, #0
@   0x080035d6: f006        fb1d 	bl	0x9c14
@   0x080035da: 2800        cmp	r0, #0
@   0x080035dc: d101        bne.n	0x35e2
@   0x080035de: 2007        movs	r0, #7
@   0x080035e0: 7020        strb	r0, [r4, #0]
@   0x080035e2: 4804        ldr	r0, [pc, #16]	@ (0x35f4)
@   0x080035e4: 2100        movs	r1, #0
@   0x080035e6: 6101        str	r1, [r0, #16]
@   0x080035e8: 2087        movs	r0, #135	@ 0x87
@   0x080035ea: 8028        strh	r0, [r5, #0]
@   0x080035ec: bc30        pop	{r4, r5}
@   0x080035ee: bc01        pop	{r0}
@   0x080035f0: 4700        bx	r0
@   0x080035f2: 0000        movs	r0, r0
@   0x080035f4: 6110        str	r0, [r2, #16]
@   0x080035f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080035D0
sub_080035D0: @ 0x080035d0
        .incbin "frog_us_baserom.gba", 0x35d0, 0x28
        thumb_func_end sub_080035D0
