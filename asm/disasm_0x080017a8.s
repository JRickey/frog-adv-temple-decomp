@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080017a8, 0x080017dc)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80017a8 --end 0x80017dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080017a8: b500        push	{lr}
@   0x080017aa: b082        sub	sp, #8
@   0x080017ac: 4809        ldr	r0, [pc, #36]	@ (0x17d4)
@   0x080017ae: 4b0a        ldr	r3, [pc, #40]	@ (0x17d8)
@   0x080017b0: 2101        movs	r1, #1
@   0x080017b2: 9100        str	r1, [sp, #0]
@   0x080017b4: 2103        movs	r1, #3
@   0x080017b6: 9101        str	r1, [sp, #4]
@   0x080017b8: 2180        movs	r1, #128	@ 0x80
@   0x080017ba: 2205        movs	r2, #5
@   0x080017bc: f004        fee6 	bl	0x658c
@   0x080017c0: 2005        movs	r0, #5
@   0x080017c2: 2100        movs	r1, #0
@   0x080017c4: f00b        fb68 	bl	0xce98
@   0x080017c8: f008        fa78 	bl	0x9cbc
@   0x080017cc: b002        add	sp, #8
@   0x080017ce: bc01        pop	{r0}
@   0x080017d0: 4700        bx	r0
@   0x080017d2: 0000        movs	r0, r0
@   0x080017d4: 6110        str	r0, [r2, #16]
@   0x080017d6: 0300        lsls	r0, r0, #12
@   0x080017d8: 9a1c        ldr	r2, [sp, #112]	@ 0x70
@   0x080017da: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_080017A8
sub_080017A8: @ 0x080017a8
        .incbin "frog_us_baserom.gba", 0x17a8, 0x34
        thumb_func_end sub_080017A8
