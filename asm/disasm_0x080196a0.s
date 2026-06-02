@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080196a0, 0x080196ec)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80196a0 --end 0x80196ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080196a0: b500        push	{lr}
@   0x080196a2: f7f7        f809 	bl	0x106b8
@   0x080196a6: 1c02        adds	r2, r0, #0
@   0x080196a8: 2a00        cmp	r2, #0
@   0x080196aa: d106        bne.n	0x196ba
@   0x080196ac: 4904        ldr	r1, [pc, #16]	@ (0x196c0)
@   0x080196ae: 2004        movs	r0, #4
@   0x080196b0: 7248        strb	r0, [r1, #9]
@   0x080196b2: 4804        ldr	r0, [pc, #16]	@ (0x196c4)
@   0x080196b4: 70c2        strb	r2, [r0, #3]
@   0x080196b6: 7002        strb	r2, [r0, #0]
@   0x080196b8: 7142        strb	r2, [r0, #5]
@   0x080196ba: bc01        pop	{r0}
@   0x080196bc: 4700        bx	r0
@   0x080196be: 0000        movs	r0, r0
@   0x080196c0: 5330        strh	r0, [r6, r4]
@   0x080196c2: 0300        lsls	r0, r0, #12
@   0x080196c4: 3480        adds	r4, #128	@ 0x80
@   0x080196c6: 0300        lsls	r0, r0, #12
@   0x080196c8: 4905        ldr	r1, [pc, #20]	@ (0x196e0)
@   0x080196ca: 2200        movs	r2, #0
@   0x080196cc: 2019        movs	r0, #25
@   0x080196ce: 7248        strb	r0, [r1, #9]
@   0x080196d0: 4804        ldr	r0, [pc, #16]	@ (0x196e4)
@   0x080196d2: 7002        strb	r2, [r0, #0]
@   0x080196d4: 7142        strb	r2, [r0, #5]
@   0x080196d6: 2102        movs	r1, #2
@   0x080196d8: 70c1        strb	r1, [r0, #3]
@   0x080196da: 7102        strb	r2, [r0, #4]
@   0x080196dc: 4770        bx	lr
@   0x080196de: 0000        movs	r0, r0
@   0x080196e0: 5330        strh	r0, [r6, r4]
@   0x080196e2: 0300        lsls	r0, r0, #12
@   0x080196e4: 3480        adds	r4, #128	@ 0x80
@   0x080196e6: 0300        lsls	r0, r0, #12
@   0x080196e8: 4770        bx	lr

        thumb_func_start sub_080196A0
sub_080196A0: @ 0x080196a0
        .incbin "frog_us_baserom.gba", 0x196a0, 0x4c
        thumb_func_end sub_080196A0
