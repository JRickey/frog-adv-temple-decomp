@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027d8c, 0x08027db0)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027d8c --end 0x8027db0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027d8c: b500        push	{lr}
@   0x08027d8e: b081        sub	sp, #4
@   0x08027d90: 4905        ldr	r1, [pc, #20]	@ (0x27da8)
@   0x08027d92: 4b06        ldr	r3, [pc, #24]	@ (0x27dac)
@   0x08027d94: 2000        movs	r0, #0
@   0x08027d96: 9000        str	r0, [sp, #0]
@   0x08027d98: 2005        movs	r0, #5
@   0x08027d9a: 220b        movs	r2, #11
@   0x08027d9c: f7f9        fbb8 	bl	0x21510
@   0x08027da0: b001        add	sp, #4
@   0x08027da2: bc01        pop	{r0}
@   0x08027da4: 4700        bx	r0
@   0x08027da6: 0000        movs	r0, r0
@   0x08027da8: 67c0        str	r0, [r0, #124]	@ 0x7c
@   0x08027daa: 0831        lsrs	r1, r6, #32
@   0x08027dac: 6110        str	r0, [r2, #16]
@   0x08027dae: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027D8C
sub_08027D8C: @ 0x08027d8c
        .incbin "baserom.gba", 0x27d8c, 0x24
        thumb_func_end sub_08027D8C
