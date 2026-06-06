@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080318f0, 0x08031910)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80318f0 --end 0x8031910 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080318f0: b510        push	{r4, lr}
@   0x080318f2: 1c0c        adds	r4, r1, #0
@   0x080318f4: 6821        ldr	r1, [r4, #0]
@   0x080318f6: 2803        cmp	r0, #3
@   0x080318f8: d102        bne.n	0x31900
@   0x080318fa: 7848        ldrb	r0, [r1, #1]
@   0x080318fc: f7fd        ffc2 	bl	0x2f884
@   0x08031900: 6820        ldr	r0, [r4, #0]
@   0x08031902: 3002        adds	r0, #2
@   0x08031904: 6020        str	r0, [r4, #0]
@   0x08031906: 2001        movs	r0, #1
@   0x08031908: bc10        pop	{r4}
@   0x0803190a: bc02        pop	{r1}
@   0x0803190c: 4708        bx	r1

        thumb_func_start sub_080318F0
sub_080318F0: @ 0x080318f0
        .incbin "frog_us_baserom.gba", 0x318f0, 0x20
        thumb_func_end sub_080318F0
