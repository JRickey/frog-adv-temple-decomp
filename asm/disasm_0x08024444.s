@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024444, 0x08024470)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024444 --end 0x8024470 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024444: b500        push	{lr}
@   0x08024446: b083        sub	sp, #12
@   0x08024448: 4907        ldr	r1, [pc, #28]	@ (0x24468)
@   0x0802444a: 4808        ldr	r0, [pc, #32]	@ (0x2446c)
@   0x0802444c: 9000        str	r0, [sp, #0]
@   0x0802444e: 200e        movs	r0, #14
@   0x08024450: 9001        str	r0, [sp, #4]
@   0x08024452: 2000        movs	r0, #0
@   0x08024454: 9002        str	r0, [sp, #8]
@   0x08024456: 2077        movs	r0, #119	@ 0x77
@   0x08024458: 2200        movs	r2, #0
@   0x0802445a: 234c        movs	r3, #76	@ 0x4c
@   0x0802445c: f7fc        fe70 	bl	0x21140
@   0x08024460: b003        add	sp, #12
@   0x08024462: bc01        pop	{r0}
@   0x08024464: 4700        bx	r0
@   0x08024466: 0000        movs	r0, r0
@   0x08024468: 2138        movs	r1, #56	@ 0x38
@   0x0802446a: 0831        lsrs	r1, r6, #32
@   0x0802446c: 0351        lsls	r1, r2, #13

        thumb_func_start sub_08024444
sub_08024444: @ 0x08024444
        .incbin "frog_us_baserom.gba", 0x24444, 0x2c
        thumb_func_end sub_08024444
