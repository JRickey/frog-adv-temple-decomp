@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d094, 0x0801d0bc)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d094 --end 0x801d0bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d094: b500        push	{lr}
@   0x0801d096: b083        sub	sp, #12
@   0x0801d098: 4807        ldr	r0, [pc, #28]	@ (0x1d0b8)
@   0x0801d09a: 218b        movs	r1, #139	@ 0x8b
@   0x0801d09c: 0049        lsls	r1, r1, #1
@   0x0801d09e: 9100        str	r1, [sp, #0]
@   0x0801d0a0: 210e        movs	r1, #14
@   0x0801d0a2: 9101        str	r1, [sp, #4]
@   0x0801d0a4: 2103        movs	r1, #3
@   0x0801d0a6: 9102        str	r1, [sp, #8]
@   0x0801d0a8: 2108        movs	r1, #8
@   0x0801d0aa: 220b        movs	r2, #11
@   0x0801d0ac: 230a        movs	r3, #10
@   0x0801d0ae: f7fe        fee5 	bl	0x1be7c
@   0x0801d0b2: b003        add	sp, #12
@   0x0801d0b4: bc01        pop	{r0}
@   0x0801d0b6: 4700        bx	r0
@   0x0801d0b8: df8c        svc	140	@ 0x8c
@   0x0801d0ba: 081b        lsrs	r3, r3, #32

        thumb_func_start sub_0801D094
sub_0801D094: @ 0x0801d094
        .incbin "frog_us_baserom.gba", 0x1d094, 0x28
        thumb_func_end sub_0801D094
