@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800276c, 0x080027a0)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800276c --end 0x80027a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800276c: b500        push	{lr}
@   0x0800276e: b082        sub	sp, #8
@   0x08002770: 4809        ldr	r0, [pc, #36]	@ (0x2798)
@   0x08002772: 4b0a        ldr	r3, [pc, #40]	@ (0x279c)
@   0x08002774: 2101        movs	r1, #1
@   0x08002776: 9100        str	r1, [sp, #0]
@   0x08002778: 2103        movs	r1, #3
@   0x0800277a: 9101        str	r1, [sp, #4]
@   0x0800277c: 2178        movs	r1, #120	@ 0x78
@   0x0800277e: 2208        movs	r2, #8
@   0x08002780: f003        ff04 	bl	0x658c
@   0x08002784: 2008        movs	r0, #8
@   0x08002786: 2100        movs	r1, #0
@   0x08002788: f00a        fb86 	bl	0xce98
@   0x0800278c: f007        fa96 	bl	0x9cbc
@   0x08002790: b002        add	sp, #8
@   0x08002792: bc01        pop	{r0}
@   0x08002794: 4700        bx	r0
@   0x08002796: 0000        movs	r0, r0
@   0x08002798: 6110        str	r0, [r2, #16]
@   0x0800279a: 0300        lsls	r0, r0, #12
@   0x0800279c: 9a84        ldr	r2, [sp, #528]	@ 0x210
@   0x0800279e: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_0800276C
sub_0800276C: @ 0x0800276c
        .incbin "frog_us_baserom.gba", 0x276c, 0x34
        thumb_func_end sub_0800276C
