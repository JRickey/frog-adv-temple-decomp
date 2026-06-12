@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080247d4, 0x080247f8)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80247d4 --end 0x80247f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080247d4: b500        push	{lr}
@   0x080247d6: b081        sub	sp, #4
@   0x080247d8: 4905        ldr	r1, [pc, #20]	@ (0x247f0)
@   0x080247da: 4b06        ldr	r3, [pc, #24]	@ (0x247f4)
@   0x080247dc: 2000        movs	r0, #0
@   0x080247de: 9000        str	r0, [sp, #0]
@   0x080247e0: 2002        movs	r0, #2
@   0x080247e2: 2211        movs	r2, #17
@   0x080247e4: f7fc        fe94 	bl	0x21510
@   0x080247e8: b001        add	sp, #4
@   0x080247ea: bc01        pop	{r0}
@   0x080247ec: 4700        bx	r0
@   0x080247ee: 0000        movs	r0, r0
@   0x080247f0: 2eec        cmp	r6, #236	@ 0xec
@   0x080247f2: 0831        lsrs	r1, r6, #32
@   0x080247f4: 6110        str	r0, [r2, #16]
@   0x080247f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080247D4
sub_080247D4: @ 0x080247d4
        .incbin "baserom.gba", 0x247d4, 0x24
        thumb_func_end sub_080247D4
