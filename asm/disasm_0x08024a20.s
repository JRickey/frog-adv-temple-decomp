@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024a20, 0x08024a48)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024a20 --end 0x8024a48 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024a20: b500        push	{lr}
@   0x08024a22: b083        sub	sp, #12
@   0x08024a24: 4907        ldr	r1, [pc, #28]	@ (0x24a44)
@   0x08024a26: 20f1        movs	r0, #241	@ 0xf1
@   0x08024a28: 9000        str	r0, [sp, #0]
@   0x08024a2a: 2007        movs	r0, #7
@   0x08024a2c: 9001        str	r0, [sp, #4]
@   0x08024a2e: 2000        movs	r0, #0
@   0x08024a30: 9002        str	r0, [sp, #8]
@   0x08024a32: 204a        movs	r0, #74	@ 0x4a
@   0x08024a34: 2210        movs	r2, #16
@   0x08024a36: 230b        movs	r3, #11
@   0x08024a38: f7fc        fb82 	bl	0x21140
@   0x08024a3c: b003        add	sp, #12
@   0x08024a3e: bc01        pop	{r0}
@   0x08024a40: 4700        bx	r0
@   0x08024a42: 0000        movs	r0, r0
@   0x08024a44: 326c        adds	r2, #108	@ 0x6c
@   0x08024a46: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024A20
sub_08024A20: @ 0x08024a20
        .incbin "baserom.gba", 0x24a20, 0x28
        thumb_func_end sub_08024A20
