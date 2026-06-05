@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080242d8, 0x08024304)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80242d8 --end 0x8024304 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080242d8: b500        push	{lr}
@   0x080242da: b083        sub	sp, #12
@   0x080242dc: 4907        ldr	r1, [pc, #28]	@ (0x242fc)
@   0x080242de: 4808        ldr	r0, [pc, #32]	@ (0x24300)
@   0x080242e0: 9000        str	r0, [sp, #0]
@   0x080242e2: 2009        movs	r0, #9
@   0x080242e4: 9001        str	r0, [sp, #4]
@   0x080242e6: 2000        movs	r0, #0
@   0x080242e8: 9002        str	r0, [sp, #8]
@   0x080242ea: 2065        movs	r0, #101	@ 0x65
@   0x080242ec: 2210        movs	r2, #16
@   0x080242ee: 230b        movs	r3, #11
@   0x080242f0: f7fc        ff26 	bl	0x21140
@   0x080242f4: b003        add	sp, #12
@   0x080242f6: bc01        pop	{r0}
@   0x080242f8: 4700        bx	r0
@   0x080242fa: 0000        movs	r0, r0
@   0x080242fc: 2270        movs	r2, #112	@ 0x70
@   0x080242fe: 0831        lsrs	r1, r6, #32
@   0x08024300: 01e1        lsls	r1, r4, #7

        thumb_func_start sub_080242D8
sub_080242D8: @ 0x080242d8
        .incbin "frog_us_baserom.gba", 0x242d8, 0x2c
        thumb_func_end sub_080242D8
