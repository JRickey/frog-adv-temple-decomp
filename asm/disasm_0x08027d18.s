@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027d18, 0x08027d40)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027d18 --end 0x8027d40 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027d18: b500        push	{lr}
@   0x08027d1a: b083        sub	sp, #12
@   0x08027d1c: 4907        ldr	r1, [pc, #28]	@ (0x27d3c)
@   0x08027d1e: 2041        movs	r0, #65	@ 0x41
@   0x08027d20: 9000        str	r0, [sp, #0]
@   0x08027d22: 2001        movs	r0, #1
@   0x08027d24: 9001        str	r0, [sp, #4]
@   0x08027d26: 2000        movs	r0, #0
@   0x08027d28: 9002        str	r0, [sp, #8]
@   0x08027d2a: 2002        movs	r0, #2
@   0x08027d2c: 2210        movs	r2, #16
@   0x08027d2e: 2304        movs	r3, #4
@   0x08027d30: f7f9        fa06 	bl	0x21140
@   0x08027d34: b003        add	sp, #12
@   0x08027d36: bc01        pop	{r0}
@   0x08027d38: 4700        bx	r0
@   0x08027d3a: 0000        movs	r0, r0
@   0x08027d3c: 67a0        str	r0, [r4, #120]	@ 0x78
@   0x08027d3e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027D18
sub_08027D18: @ 0x08027d18
        .incbin "baserom.gba", 0x27d18, 0x28
        thumb_func_end sub_08027D18
