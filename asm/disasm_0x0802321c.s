@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802321c, 0x08023244)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802321c --end 0x8023244 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802321c: b500        push	{lr}
@   0x0802321e: b083        sub	sp, #12
@   0x08023220: 4907        ldr	r1, [pc, #28]	@ (0x23240)
@   0x08023222: 2061        movs	r0, #97	@ 0x61
@   0x08023224: 9000        str	r0, [sp, #0]
@   0x08023226: 2003        movs	r0, #3
@   0x08023228: 9001        str	r0, [sp, #4]
@   0x0802322a: 2000        movs	r0, #0
@   0x0802322c: 9002        str	r0, [sp, #8]
@   0x0802322e: 2006        movs	r0, #6
@   0x08023230: 2200        movs	r2, #0
@   0x08023232: 2312        movs	r3, #18
@   0x08023234: f7fd        ff84 	bl	0x21140
@   0x08023238: b003        add	sp, #12
@   0x0802323a: bc01        pop	{r0}
@   0x0802323c: 4700        bx	r0
@   0x0802323e: 0000        movs	r0, r0
@   0x08023240: 14c0        asrs	r0, r0, #19
@   0x08023242: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802321C
sub_0802321C: @ 0x0802321c
        .incbin "frog_us_baserom.gba", 0x2321c, 0x28
        thumb_func_end sub_0802321C
