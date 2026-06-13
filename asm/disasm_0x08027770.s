@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027770, 0x08027794)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027770 --end 0x8027794 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027770: b500        push	{lr}
@   0x08027772: b081        sub	sp, #4
@   0x08027774: 4905        ldr	r1, [pc, #20]	@ (0x2778c)
@   0x08027776: 4b06        ldr	r3, [pc, #24]	@ (0x27790)
@   0x08027778: 2000        movs	r0, #0
@   0x0802777a: 9000        str	r0, [sp, #0]
@   0x0802777c: 206b        movs	r0, #107	@ 0x6b
@   0x0802777e: 224c        movs	r2, #76	@ 0x4c
@   0x08027780: f7f9        fec6 	bl	0x21510
@   0x08027784: b001        add	sp, #4
@   0x08027786: bc01        pop	{r0}
@   0x08027788: 4700        bx	r0
@   0x0802778a: 0000        movs	r0, r0
@   0x0802778c: 5c00        ldrb	r0, [r0, r0]
@   0x0802778e: 0831        lsrs	r1, r6, #32
@   0x08027790: 6110        str	r0, [r2, #16]
@   0x08027792: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027770
sub_08027770: @ 0x08027770
        .incbin "baserom.gba", 0x27770, 0x24
        thumb_func_end sub_08027770
