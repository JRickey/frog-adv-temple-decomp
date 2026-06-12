@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024a6c, 0x08024a98)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024a6c --end 0x8024a98 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024a6c: b500        push	{lr}
@   0x08024a6e: b083        sub	sp, #12
@   0x08024a70: 4907        ldr	r1, [pc, #28]	@ (0x24a90)
@   0x08024a72: 4808        ldr	r0, [pc, #32]	@ (0x24a94)
@   0x08024a74: 9000        str	r0, [sp, #0]
@   0x08024a76: 2008        movs	r0, #8
@   0x08024a78: 9001        str	r0, [sp, #4]
@   0x08024a7a: 2000        movs	r0, #0
@   0x08024a7c: 9002        str	r0, [sp, #8]
@   0x08024a7e: 204b        movs	r0, #75	@ 0x4b
@   0x08024a80: 2210        movs	r2, #16
@   0x08024a82: 2317        movs	r3, #23
@   0x08024a84: f7fc        fb5c 	bl	0x21140
@   0x08024a88: b003        add	sp, #12
@   0x08024a8a: bc01        pop	{r0}
@   0x08024a8c: 4700        bx	r0
@   0x08024a8e: 0000        movs	r0, r0
@   0x08024a90: 327c        adds	r2, #124	@ 0x7c
@   0x08024a92: 0831        lsrs	r1, r6, #32
@   0x08024a94: 0101        lsls	r1, r0, #4

        thumb_func_start sub_08024A6C
sub_08024A6C: @ 0x08024a6c
        .incbin "baserom.gba", 0x24a6c, 0x2c
        thumb_func_end sub_08024A6C
