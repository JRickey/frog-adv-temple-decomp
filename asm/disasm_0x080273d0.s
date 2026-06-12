@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080273d0, 0x080273f4)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80273d0 --end 0x80273f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080273d0: b500        push	{lr}
@   0x080273d2: b081        sub	sp, #4
@   0x080273d4: 4905        ldr	r1, [pc, #20]	@ (0x273ec)
@   0x080273d6: 4b06        ldr	r3, [pc, #24]	@ (0x273f0)
@   0x080273d8: 2000        movs	r0, #0
@   0x080273da: 9000        str	r0, [sp, #0]
@   0x080273dc: 2025        movs	r0, #37	@ 0x25
@   0x080273de: 2204        movs	r2, #4
@   0x080273e0: f7fa        f896 	bl	0x21510
@   0x080273e4: b001        add	sp, #4
@   0x080273e6: bc01        pop	{r0}
@   0x080273e8: 4700        bx	r0
@   0x080273ea: 0000        movs	r0, r0
@   0x080273ec: 5d38        ldrb	r0, [r7, r4]
@   0x080273ee: 0831        lsrs	r1, r6, #32
@   0x080273f0: 6110        str	r0, [r2, #16]
@   0x080273f2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080273D0
sub_080273D0: @ 0x080273d0
        .incbin "baserom.gba", 0x273d0, 0x24
        thumb_func_end sub_080273D0
