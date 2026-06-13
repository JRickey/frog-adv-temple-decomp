@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027584, 0x080275b0)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027584 --end 0x80275b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027584: b500        push	{lr}
@   0x08027586: b083        sub	sp, #12
@   0x08027588: 4907        ldr	r1, [pc, #28]	@ (0x275a8)
@   0x0802758a: 4808        ldr	r0, [pc, #32]	@ (0x275ac)
@   0x0802758c: 9000        str	r0, [sp, #0]
@   0x0802758e: 2008        movs	r0, #8
@   0x08027590: 9001        str	r0, [sp, #4]
@   0x08027592: 2000        movs	r0, #0
@   0x08027594: 9002        str	r0, [sp, #8]
@   0x08027596: 2055        movs	r0, #85	@ 0x55
@   0x08027598: 2210        movs	r2, #16
@   0x0802759a: 2338        movs	r3, #56	@ 0x38
@   0x0802759c: f7f9        fdd0 	bl	0x21140
@   0x080275a0: b003        add	sp, #12
@   0x080275a2: bc01        pop	{r0}
@   0x080275a4: 4700        bx	r0
@   0x080275a6: 0000        movs	r0, r0
@   0x080275a8: 64b8        str	r0, [r7, #72]	@ 0x48
@   0x080275aa: 0831        lsrs	r1, r6, #32
@   0x080275ac: 02d1        lsls	r1, r2, #11

        thumb_func_start sub_08027584
sub_08027584: @ 0x08027584
        .incbin "baserom.gba", 0x27584, 0x2c
        thumb_func_end sub_08027584
