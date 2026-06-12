@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027384, 0x080273a8)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027384 --end 0x80273a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027384: b500        push	{lr}
@   0x08027386: b081        sub	sp, #4
@   0x08027388: 4905        ldr	r1, [pc, #20]	@ (0x273a0)
@   0x0802738a: 4b06        ldr	r3, [pc, #24]	@ (0x273a4)
@   0x0802738c: 2000        movs	r0, #0
@   0x0802738e: 9000        str	r0, [sp, #0]
@   0x08027390: 2022        movs	r0, #34	@ 0x22
@   0x08027392: 220b        movs	r2, #11
@   0x08027394: f7fa        f8bc 	bl	0x21510
@   0x08027398: b001        add	sp, #4
@   0x0802739a: bc01        pop	{r0}
@   0x0802739c: 4700        bx	r0
@   0x0802739e: 0000        movs	r0, r0
@   0x080273a0: 5d18        ldrb	r0, [r3, r4]
@   0x080273a2: 0831        lsrs	r1, r6, #32
@   0x080273a4: 6110        str	r0, [r2, #16]
@   0x080273a6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08027384
sub_08027384: @ 0x08027384
        .incbin "baserom.gba", 0x27384, 0x24
        thumb_func_end sub_08027384
