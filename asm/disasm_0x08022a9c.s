@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022a9c, 0x08022ac8)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022a9c --end 0x8022ac8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022a9c: b500        push	{lr}
@   0x08022a9e: b083        sub	sp, #12
@   0x08022aa0: 4907        ldr	r1, [pc, #28]	@ (0x22ac0)
@   0x08022aa2: 4808        ldr	r0, [pc, #32]	@ (0x22ac4)
@   0x08022aa4: 9000        str	r0, [sp, #0]
@   0x08022aa6: 200d        movs	r0, #13
@   0x08022aa8: 9001        str	r0, [sp, #4]
@   0x08022aaa: 2000        movs	r0, #0
@   0x08022aac: 9002        str	r0, [sp, #8]
@   0x08022aae: 2059        movs	r0, #89	@ 0x59
@   0x08022ab0: 2200        movs	r2, #0
@   0x08022ab2: 234c        movs	r3, #76	@ 0x4c
@   0x08022ab4: f7fe        fb44 	bl	0x21140
@   0x08022ab8: b003        add	sp, #12
@   0x08022aba: bc01        pop	{r0}
@   0x08022abc: 4700        bx	r0
@   0x08022abe: 0000        movs	r0, r0
@   0x08022ac0: 0b54        lsrs	r4, r2, #13
@   0x08022ac2: 0831        lsrs	r1, r6, #32
@   0x08022ac4: 01c5        lsls	r5, r0, #7

        thumb_func_start sub_08022A9C
sub_08022A9C: @ 0x08022a9c
        .incbin "frog_us_baserom.gba", 0x22a9c, 0x2c
        thumb_func_end sub_08022A9C
