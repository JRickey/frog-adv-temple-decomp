@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024a48, 0x08024a6c)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024a48 --end 0x8024a6c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024a48: b500        push	{lr}
@   0x08024a4a: b081        sub	sp, #4
@   0x08024a4c: 4905        ldr	r1, [pc, #20]	@ (0x24a64)
@   0x08024a4e: 4b06        ldr	r3, [pc, #24]	@ (0x24a68)
@   0x08024a50: 2000        movs	r0, #0
@   0x08024a52: 9000        str	r0, [sp, #0]
@   0x08024a54: 204a        movs	r0, #74	@ 0x4a
@   0x08024a56: 220b        movs	r2, #11
@   0x08024a58: f7fc        fd5a 	bl	0x21510
@   0x08024a5c: b001        add	sp, #4
@   0x08024a5e: bc01        pop	{r0}
@   0x08024a60: 4700        bx	r0
@   0x08024a62: 0000        movs	r0, r0
@   0x08024a64: 326c        adds	r2, #108	@ 0x6c
@   0x08024a66: 0831        lsrs	r1, r6, #32
@   0x08024a68: 6110        str	r0, [r2, #16]
@   0x08024a6a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024A48
sub_08024A48: @ 0x08024a48
        .incbin "baserom.gba", 0x24a48, 0x24
        thumb_func_end sub_08024A48
