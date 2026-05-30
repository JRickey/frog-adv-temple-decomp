@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022730, 0x08022758)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022730 --end 0x8022758 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022730: b500        push	{lr}
@   0x08022732: b083        sub	sp, #12
@   0x08022734: 4907        ldr	r1, [pc, #28]	@ (0x22754)
@   0x08022736: 2041        movs	r0, #65	@ 0x41
@   0x08022738: 9000        str	r0, [sp, #0]
@   0x0802273a: 2001        movs	r0, #1
@   0x0802273c: 9001        str	r0, [sp, #4]
@   0x0802273e: 2000        movs	r0, #0
@   0x08022740: 9002        str	r0, [sp, #8]
@   0x08022742: 2002        movs	r0, #2
@   0x08022744: 2200        movs	r2, #0
@   0x08022746: 2304        movs	r3, #4
@   0x08022748: f7fe        fcfa 	bl	0x21140
@   0x0802274c: b003        add	sp, #12
@   0x0802274e: bc01        pop	{r0}
@   0x08022750: 4700        bx	r0
@   0x08022752: 0000        movs	r0, r0
@   0x08022754: 0b64        lsrs	r4, r4, #13
@   0x08022756: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022730
sub_08022730: @ 0x08022730
        .incbin "frog_us_baserom.gba", 0x22730, 0x28
        thumb_func_end sub_08022730
