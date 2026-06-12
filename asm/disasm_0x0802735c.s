@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802735c, 0x08027384)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802735c --end 0x8027384 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802735c: b500        push	{lr}
@   0x0802735e: b083        sub	sp, #12
@   0x08027360: 4907        ldr	r1, [pc, #28]	@ (0x27380)
@   0x08027362: 2051        movs	r0, #81	@ 0x51
@   0x08027364: 9000        str	r0, [sp, #0]
@   0x08027366: 2002        movs	r0, #2
@   0x08027368: 9001        str	r0, [sp, #4]
@   0x0802736a: 2000        movs	r0, #0
@   0x0802736c: 9002        str	r0, [sp, #8]
@   0x0802736e: 2022        movs	r0, #34	@ 0x22
@   0x08027370: 2210        movs	r2, #16
@   0x08027372: 230b        movs	r3, #11
@   0x08027374: f7f9        fee4 	bl	0x21140
@   0x08027378: b003        add	sp, #12
@   0x0802737a: bc01        pop	{r0}
@   0x0802737c: 4700        bx	r0
@   0x0802737e: 0000        movs	r0, r0
@   0x08027380: 5d18        ldrb	r0, [r3, r4]
@   0x08027382: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802735C
sub_0802735C: @ 0x0802735c
        .incbin "baserom.gba", 0x2735c, 0x28
        thumb_func_end sub_0802735C
