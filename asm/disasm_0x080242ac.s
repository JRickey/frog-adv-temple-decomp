@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080242ac, 0x080242d8)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80242ac --end 0x80242d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080242ac: b500        push	{lr}
@   0x080242ae: b083        sub	sp, #12
@   0x080242b0: 4907        ldr	r1, [pc, #28]	@ (0x242d0)
@   0x080242b2: 4808        ldr	r0, [pc, #32]	@ (0x242d4)
@   0x080242b4: 9000        str	r0, [sp, #0]
@   0x080242b6: 2008        movs	r0, #8
@   0x080242b8: 9001        str	r0, [sp, #4]
@   0x080242ba: 2000        movs	r0, #0
@   0x080242bc: 9002        str	r0, [sp, #8]
@   0x080242be: 2061        movs	r0, #97	@ 0x61
@   0x080242c0: 2210        movs	r2, #16
@   0x080242c2: 2311        movs	r3, #17
@   0x080242c4: f7fc        ff3c 	bl	0x21140
@   0x080242c8: b003        add	sp, #12
@   0x080242ca: bc01        pop	{r0}
@   0x080242cc: 4700        bx	r0
@   0x080242ce: 0000        movs	r0, r0
@   0x080242d0: 2248        movs	r2, #72	@ 0x48
@   0x080242d2: 0831        lsrs	r1, r6, #32
@   0x080242d4: 01c1        lsls	r1, r0, #7

        thumb_func_start sub_080242AC
sub_080242AC: @ 0x080242ac
        .incbin "frog_us_baserom.gba", 0x242ac, 0x2c
        thumb_func_end sub_080242AC
