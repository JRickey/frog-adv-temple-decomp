@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080014b8, 0x080014e4)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80014b8 --end 0x80014e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080014b8: b500        push	{lr}
@   0x080014ba: f008        ff0d 	bl	0xa2d8
@   0x080014be: f7ff        fa0d 	bl	0x8dc
@   0x080014c2: f008        ff31 	bl	0xa328
@   0x080014c6: f008        f817 	bl	0x94f8
@   0x080014ca: f008        fa5b 	bl	0x9984
@   0x080014ce: f7ff        fe69 	bl	0x11a4
@   0x080014d2: 4903        ldr	r1, [pc, #12]	@ (0x14e0)
@   0x080014d4: 6948        ldr	r0, [r1, #20]
@   0x080014d6: 3001        adds	r0, #1
@   0x080014d8: 6148        str	r0, [r1, #20]
@   0x080014da: bc01        pop	{r0}
@   0x080014dc: 4700        bx	r0
@   0x080014de: 0000        movs	r0, r0
@   0x080014e0: 5330        strh	r0, [r6, r4]
@   0x080014e2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080014B8
sub_080014B8: @ 0x080014b8
        .incbin "frog_us_baserom.gba", 0x14b8, 0x2c
        thumb_func_end sub_080014B8
