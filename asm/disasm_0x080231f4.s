@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080231f4, 0x0802321c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80231f4 --end 0x802321c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080231f4: b500        push	{lr}
@   0x080231f6: b083        sub	sp, #12
@   0x080231f8: 4907        ldr	r1, [pc, #28]	@ (0x23218)
@   0x080231fa: 2041        movs	r0, #65	@ 0x41
@   0x080231fc: 9000        str	r0, [sp, #0]
@   0x080231fe: 2001        movs	r0, #1
@   0x08023200: 9001        str	r0, [sp, #4]
@   0x08023202: 2000        movs	r0, #0
@   0x08023204: 9002        str	r0, [sp, #8]
@   0x08023206: 2002        movs	r0, #2
@   0x08023208: 2210        movs	r2, #16
@   0x0802320a: 2311        movs	r3, #17
@   0x0802320c: f7fd        ff98 	bl	0x21140
@   0x08023210: b003        add	sp, #12
@   0x08023212: bc01        pop	{r0}
@   0x08023214: 4700        bx	r0
@   0x08023216: 0000        movs	r0, r0
@   0x08023218: 1498        asrs	r0, r3, #18
@   0x0802321a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080231F4
sub_080231F4: @ 0x080231f4
        .incbin "frog_us_baserom.gba", 0x231f4, 0x28
        thumb_func_end sub_080231F4
