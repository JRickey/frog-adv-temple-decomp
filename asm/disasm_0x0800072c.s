@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800072c, 0x08000764)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800072c --end 0x8000764 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800072c: b510        push	{r4, lr}
@   0x0800072e: b082        sub	sp, #8
@   0x08000730: 2400        movs	r4, #0
@   0x08000732: 9400        str	r4, [sp, #0]
@   0x08000734: 4907        ldr	r1, [pc, #28]	@ (0x754)
@   0x08000736: 4a08        ldr	r2, [pc, #32]	@ (0x758)
@   0x08000738: 4668        mov	r0, sp
@   0x0800073a: f02c        ff0d 	bl	0x2d558
@   0x0800073e: 9401        str	r4, [sp, #4]
@   0x08000740: a801        add	r0, sp, #4
@   0x08000742: 4906        ldr	r1, [pc, #24]	@ (0x75c)
@   0x08000744: 4a06        ldr	r2, [pc, #24]	@ (0x760)
@   0x08000746: f02c        ff07 	bl	0x2d558
@   0x0800074a: b002        add	sp, #8
@   0x0800074c: bc10        pop	{r4}
@   0x0800074e: bc01        pop	{r0}
@   0x08000750: 4700        bx	r0
@   0x08000752: 0000        movs	r0, r0
@   0x08000754: 0000        movs	r0, r0
@   0x08000756: 0601        lsls	r1, r0, #24
@   0x08000758: 0008        movs	r0, r1
@   0x0800075a: 0100        lsls	r0, r0, #4
@   0x0800075c: 54a0        strb	r0, [r4, r2]
@   0x0800075e: 0300        lsls	r0, r0, #12
@   0x08000760: 0100        lsls	r0, r0, #4
@   0x08000762: 0100        lsls	r0, r0, #4

        thumb_func_start sub_0800072C
sub_0800072C: @ 0x0800072c
        .incbin "frog_us_baserom.gba", 0x72c, 0x38
        thumb_func_end sub_0800072C
