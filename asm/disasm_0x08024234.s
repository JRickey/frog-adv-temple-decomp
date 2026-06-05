@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024234, 0x08024260)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024234 --end 0x8024260 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024234: b500        push	{lr}
@   0x08024236: b083        sub	sp, #12
@   0x08024238: 4907        ldr	r1, [pc, #28]	@ (0x24258)
@   0x0802423a: 4808        ldr	r0, [pc, #32]	@ (0x2425c)
@   0x0802423c: 9000        str	r0, [sp, #0]
@   0x0802423e: 2007        movs	r0, #7
@   0x08024240: 9001        str	r0, [sp, #4]
@   0x08024242: 2000        movs	r0, #0
@   0x08024244: 9002        str	r0, [sp, #8]
@   0x08024246: 205f        movs	r0, #95	@ 0x5f
@   0x08024248: 2210        movs	r2, #16
@   0x0802424a: 2319        movs	r3, #25
@   0x0802424c: f7fc        ff78 	bl	0x21140
@   0x08024250: b003        add	sp, #12
@   0x08024252: bc01        pop	{r0}
@   0x08024254: 4700        bx	r0
@   0x08024256: 0000        movs	r0, r0
@   0x08024258: 2210        movs	r2, #16
@   0x0802425a: 0831        lsrs	r1, r6, #32
@   0x0802425c: 0141        lsls	r1, r0, #5

        thumb_func_start sub_08024234
sub_08024234: @ 0x08024234
        .incbin "frog_us_baserom.gba", 0x24234, 0x2c
        thumb_func_end sub_08024234
