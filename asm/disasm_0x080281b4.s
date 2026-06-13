@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080281b4, 0x080281d8)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80281b4 --end 0x80281d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080281b4: b500        push	{lr}
@   0x080281b6: b081        sub	sp, #4
@   0x080281b8: 4905        ldr	r1, [pc, #20]	@ (0x281d0)
@   0x080281ba: 4b06        ldr	r3, [pc, #24]	@ (0x281d4)
@   0x080281bc: 2000        movs	r0, #0
@   0x080281be: 9000        str	r0, [sp, #0]
@   0x080281c0: 204c        movs	r0, #76	@ 0x4c
@   0x080281c2: 224c        movs	r2, #76	@ 0x4c
@   0x080281c4: f7f9        f9a4 	bl	0x21510
@   0x080281c8: b001        add	sp, #4
@   0x080281ca: bc01        pop	{r0}
@   0x080281cc: 4700        bx	r0
@   0x080281ce: 0000        movs	r0, r0
@   0x080281d0: 6760        str	r0, [r4, #116]	@ 0x74
@   0x080281d2: 0831        lsrs	r1, r6, #32
@   0x080281d4: 6110        str	r0, [r2, #16]
@   0x080281d6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080281B4
sub_080281B4: @ 0x080281b4
        .incbin "baserom.gba", 0x281b4, 0x24
        thumb_func_end sub_080281B4
