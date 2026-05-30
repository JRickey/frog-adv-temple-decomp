@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022758, 0x0802277c)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022758 --end 0x802277c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022758: b500        push	{lr}
@   0x0802275a: b081        sub	sp, #4
@   0x0802275c: 4905        ldr	r1, [pc, #20]	@ (0x22774)
@   0x0802275e: 4b06        ldr	r3, [pc, #24]	@ (0x22778)
@   0x08022760: 2000        movs	r0, #0
@   0x08022762: 9000        str	r0, [sp, #0]
@   0x08022764: 2002        movs	r0, #2
@   0x08022766: 2204        movs	r2, #4
@   0x08022768: f7fe        fed2 	bl	0x21510
@   0x0802276c: b001        add	sp, #4
@   0x0802276e: bc01        pop	{r0}
@   0x08022770: 4700        bx	r0
@   0x08022772: 0000        movs	r0, r0
@   0x08022774: 0b64        lsrs	r4, r4, #13
@   0x08022776: 0831        lsrs	r1, r6, #32
@   0x08022778: 6110        str	r0, [r2, #16]
@   0x0802277a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08022758
sub_08022758: @ 0x08022758
        .incbin "frog_us_baserom.gba", 0x22758, 0x24
        thumb_func_end sub_08022758
