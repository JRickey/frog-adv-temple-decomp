@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029780, 0x080297ac)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029780 --end 0x80297ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029780: b500        push	{lr}
@   0x08029782: b083        sub	sp, #12
@   0x08029784: 4907        ldr	r1, [pc, #28]	@ (0x297a4)
@   0x08029786: 4808        ldr	r0, [pc, #32]	@ (0x297a8)
@   0x08029788: 9000        str	r0, [sp, #0]
@   0x0802978a: 2008        movs	r0, #8
@   0x0802978c: 9001        str	r0, [sp, #4]
@   0x0802978e: 2000        movs	r0, #0
@   0x08029790: 9002        str	r0, [sp, #8]
@   0x08029792: 204c        movs	r0, #76	@ 0x4c
@   0x08029794: 2210        movs	r2, #16
@   0x08029796: 2311        movs	r3, #17
@   0x08029798: f7f7        fcd2 	bl	0x21140
@   0x0802979c: b003        add	sp, #12
@   0x0802979e: bc01        pop	{r0}
@   0x080297a0: 4700        bx	r0
@   0x080297a2: 0000        movs	r0, r0
@   0x080297a4: 6ec4        ldr	r4, [r0, #108]	@ 0x6c
@   0x080297a6: 0831        lsrs	r1, r6, #32
@   0x080297a8: 01c5        lsls	r5, r0, #7

        thumb_func_start sub_08029780
sub_08029780: @ 0x08029780
        .incbin "baserom.gba", 0x29780, 0x2c
        thumb_func_end sub_08029780
