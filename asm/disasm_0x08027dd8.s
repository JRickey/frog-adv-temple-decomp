@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027dd8, 0x08027dfc)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027dd8 --end 0x8027dfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027dd8: b500        push	{lr}
@   0x08027dda: b081        sub	sp, #4
@   0x08027ddc: 4905        ldr	r1, [pc, #20]	@ (0x27df4)
@   0x08027dde: 4b06        ldr	r3, [pc, #24]	@ (0x27df8)
@   0x08027de0: 2000        movs	r0, #0
@   0x08027de2: 9000        str	r0, [sp, #0]
@   0x08027de4: 2009        movs	r0, #9
@   0x08027de6: 2202        movs	r2, #2
@   0x08027de8: f7f9        fb92 	bl	0x21510
@   0x08027dec: b001        add	sp, #4
@   0x08027dee: bc01        pop	{r0}
@   0x08027df0: 4700        bx	r0
@   0x08027df2: 0000        movs	r0, r0
@   0x08027df4: 67e8        str	r0, [r5, #124]	@ 0x7c
@   0x08027df6: 0831        lsrs	r1, r6, #32
@   0x08027df8: 6110        str	r0, [r2, #16]
@   0x08027dfa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027DD8
sub_08027DD8: @ 0x08027dd8
        .incbin "baserom.gba", 0x27dd8, 0x24
        thumb_func_end sub_08027DD8
