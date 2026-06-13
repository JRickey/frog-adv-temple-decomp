@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027744, 0x08027770)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027744 --end 0x8027770 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027744: b500        push	{lr}
@   0x08027746: b083        sub	sp, #12
@   0x08027748: 4907        ldr	r1, [pc, #28]	@ (0x27768)
@   0x0802774a: 4808        ldr	r0, [pc, #32]	@ (0x2776c)
@   0x0802774c: 9000        str	r0, [sp, #0]
@   0x0802774e: 200d        movs	r0, #13
@   0x08027750: 9001        str	r0, [sp, #4]
@   0x08027752: 2000        movs	r0, #0
@   0x08027754: 9002        str	r0, [sp, #8]
@   0x08027756: 206b        movs	r0, #107	@ 0x6b
@   0x08027758: 2200        movs	r2, #0
@   0x0802775a: 234c        movs	r3, #76	@ 0x4c
@   0x0802775c: f7f9        fcf0 	bl	0x21140
@   0x08027760: b003        add	sp, #12
@   0x08027762: bc01        pop	{r0}
@   0x08027764: 4700        bx	r0
@   0x08027766: 0000        movs	r0, r0
@   0x08027768: 5c00        ldrb	r0, [r0, r0]
@   0x0802776a: 0831        lsrs	r1, r6, #32
@   0x0802776c: 0351        lsls	r1, r2, #13

        thumb_func_start sub_08027744
sub_08027744: @ 0x08027744
        .incbin "baserom.gba", 0x27744, 0x2c
        thumb_func_end sub_08027744
