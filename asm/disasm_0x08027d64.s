@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027d64, 0x08027d8c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027d64 --end 0x8027d8c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027d64: b500        push	{lr}
@   0x08027d66: b083        sub	sp, #12
@   0x08027d68: 4907        ldr	r1, [pc, #28]	@ (0x27d88)
@   0x08027d6a: 2051        movs	r0, #81	@ 0x51
@   0x08027d6c: 9000        str	r0, [sp, #0]
@   0x08027d6e: 2002        movs	r0, #2
@   0x08027d70: 9001        str	r0, [sp, #4]
@   0x08027d72: 2000        movs	r0, #0
@   0x08027d74: 9002        str	r0, [sp, #8]
@   0x08027d76: 2005        movs	r0, #5
@   0x08027d78: 2210        movs	r2, #16
@   0x08027d7a: 230b        movs	r3, #11
@   0x08027d7c: f7f9        f9e0 	bl	0x21140
@   0x08027d80: b003        add	sp, #12
@   0x08027d82: bc01        pop	{r0}
@   0x08027d84: 4700        bx	r0
@   0x08027d86: 0000        movs	r0, r0
@   0x08027d88: 67c0        str	r0, [r0, #124]	@ 0x7c
@   0x08027d8a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08027D64
sub_08027D64: @ 0x08027d64
        .incbin "baserom.gba", 0x27d64, 0x28
        thumb_func_end sub_08027D64
