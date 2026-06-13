@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029620, 0x08029644)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029620 --end 0x8029644 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029620: b500        push	{lr}
@   0x08029622: b081        sub	sp, #4
@   0x08029624: 4905        ldr	r1, [pc, #20]	@ (0x2963c)
@   0x08029626: 4b06        ldr	r3, [pc, #24]	@ (0x29640)
@   0x08029628: 2000        movs	r0, #0
@   0x0802962a: 9000        str	r0, [sp, #0]
@   0x0802962c: 2019        movs	r0, #25
@   0x0802962e: 2204        movs	r2, #4
@   0x08029630: f7f7        ff6e 	bl	0x21510
@   0x08029634: b001        add	sp, #4
@   0x08029636: bc01        pop	{r0}
@   0x08029638: 4700        bx	r0
@   0x0802963a: 0000        movs	r0, r0
@   0x0802963c: 7024        strb	r4, [r4, #0]
@   0x0802963e: 0831        lsrs	r1, r6, #32
@   0x08029640: 6110        str	r0, [r2, #16]
@   0x08029642: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08029620
sub_08029620: @ 0x08029620
        .incbin "baserom.gba", 0x29620, 0x24
        thumb_func_end sub_08029620
