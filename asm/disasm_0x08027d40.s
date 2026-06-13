@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027d40, 0x08027d64)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027d40 --end 0x8027d64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027d40: b500        push	{lr}
@   0x08027d42: b081        sub	sp, #4
@   0x08027d44: 4905        ldr	r1, [pc, #20]	@ (0x27d5c)
@   0x08027d46: 4b06        ldr	r3, [pc, #24]	@ (0x27d60)
@   0x08027d48: 2000        movs	r0, #0
@   0x08027d4a: 9000        str	r0, [sp, #0]
@   0x08027d4c: 2002        movs	r0, #2
@   0x08027d4e: 2204        movs	r2, #4
@   0x08027d50: f7f9        fbde 	bl	0x21510
@   0x08027d54: b001        add	sp, #4
@   0x08027d56: bc01        pop	{r0}
@   0x08027d58: 4700        bx	r0
@   0x08027d5a: 0000        movs	r0, r0
@   0x08027d5c: 67a0        str	r0, [r4, #120]	@ 0x78
@   0x08027d5e: 0831        lsrs	r1, r6, #32
@   0x08027d60: 6110        str	r0, [r2, #16]
@   0x08027d62: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027D40
sub_08027D40: @ 0x08027d40
        .incbin "baserom.gba", 0x27d40, 0x24
        thumb_func_end sub_08027D40
