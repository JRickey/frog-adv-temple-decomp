@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080251a8, 0x080251cc)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80251a8 --end 0x80251cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080251a8: b500        push	{lr}
@   0x080251aa: b081        sub	sp, #4
@   0x080251ac: 4905        ldr	r1, [pc, #20]	@ (0x251c4)
@   0x080251ae: 4b06        ldr	r3, [pc, #24]	@ (0x251c8)
@   0x080251b0: 2000        movs	r0, #0
@   0x080251b2: 9000        str	r0, [sp, #0]
@   0x080251b4: 2002        movs	r0, #2
@   0x080251b6: 2202        movs	r2, #2
@   0x080251b8: f7fc        f9aa 	bl	0x21510
@   0x080251bc: b001        add	sp, #4
@   0x080251be: bc01        pop	{r0}
@   0x080251c0: 4700        bx	r0
@   0x080251c2: 0000        movs	r0, r0
@   0x080251c4: 33d0        adds	r3, #208	@ 0xd0
@   0x080251c6: 0831        lsrs	r1, r6, #32
@   0x080251c8: 6110        str	r0, [r2, #16]
@   0x080251ca: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080251A8
sub_080251A8: @ 0x080251a8
        .incbin "baserom.gba", 0x251a8, 0x24
        thumb_func_end sub_080251A8
