@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024844, 0x0802486c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024844 --end 0x802486c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024844: b500        push	{lr}
@   0x08024846: b083        sub	sp, #12
@   0x08024848: 4907        ldr	r1, [pc, #28]	@ (0x24868)
@   0x0802484a: 2071        movs	r0, #113	@ 0x71
@   0x0802484c: 9000        str	r0, [sp, #0]
@   0x0802484e: 2003        movs	r0, #3
@   0x08024850: 9001        str	r0, [sp, #4]
@   0x08024852: 2000        movs	r0, #0
@   0x08024854: 9002        str	r0, [sp, #8]
@   0x08024856: 2025        movs	r0, #37	@ 0x25
@   0x08024858: 2210        movs	r2, #16
@   0x0802485a: 2302        movs	r3, #2
@   0x0802485c: f7fc        fc70 	bl	0x21140
@   0x08024860: b003        add	sp, #12
@   0x08024862: bc01        pop	{r0}
@   0x08024864: 4700        bx	r0
@   0x08024866: 0000        movs	r0, r0
@   0x08024868: 3014        adds	r0, #20
@   0x0802486a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024844
sub_08024844: @ 0x08024844
        .incbin "baserom.gba", 0x24844, 0x28
        thumb_func_end sub_08024844
