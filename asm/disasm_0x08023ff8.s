@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023ff8, 0x08024024)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023ff8 --end 0x8024024 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023ff8: b500        push	{lr}
@   0x08023ffa: b083        sub	sp, #12
@   0x08023ffc: 4907        ldr	r1, [pc, #28]	@ (0x2401c)
@   0x08023ffe: 4808        ldr	r0, [pc, #32]	@ (0x24020)
@   0x08024000: 9000        str	r0, [sp, #0]
@   0x08024002: 200d        movs	r0, #13
@   0x08024004: 9001        str	r0, [sp, #4]
@   0x08024006: 2000        movs	r0, #0
@   0x08024008: 9002        str	r0, [sp, #8]
@   0x0802400a: 2074        movs	r0, #116	@ 0x74
@   0x0802400c: 2210        movs	r2, #16
@   0x0802400e: 2304        movs	r3, #4
@   0x08024010: f7fd        f896 	bl	0x21140
@   0x08024014: b003        add	sp, #12
@   0x08024016: bc01        pop	{r0}
@   0x08024018: 4700        bx	r0
@   0x0802401a: 0000        movs	r0, r0
@   0x0802401c: 2228        movs	r2, #40	@ 0x28
@   0x0802401e: 0831        lsrs	r1, r6, #32
@   0x08024020: 0341        lsls	r1, r0, #13

        thumb_func_start sub_08023FF8
sub_08023FF8: @ 0x08023ff8
        .incbin "frog_us_baserom.gba", 0x23ff8, 0x2c
        thumb_func_end sub_08023FF8
