@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024a98, 0x08024ac4)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024a98 --end 0x8024ac4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024a98: b500        push	{lr}
@   0x08024a9a: b083        sub	sp, #12
@   0x08024a9c: 4907        ldr	r1, [pc, #28]	@ (0x24abc)
@   0x08024a9e: 4808        ldr	r0, [pc, #32]	@ (0x24ac0)
@   0x08024aa0: 9000        str	r0, [sp, #0]
@   0x08024aa2: 200a        movs	r0, #10
@   0x08024aa4: 9001        str	r0, [sp, #4]
@   0x08024aa6: 2000        movs	r0, #0
@   0x08024aa8: 9002        str	r0, [sp, #8]
@   0x08024aaa: 2053        movs	r0, #83	@ 0x53
@   0x08024aac: 2200        movs	r2, #0
@   0x08024aae: 234c        movs	r3, #76	@ 0x4c
@   0x08024ab0: f7fc        fb46 	bl	0x21140
@   0x08024ab4: b003        add	sp, #12
@   0x08024ab6: bc01        pop	{r0}
@   0x08024ab8: 4700        bx	r0
@   0x08024aba: 0000        movs	r0, r0
@   0x08024abc: 2edc        cmp	r6, #220	@ 0xdc
@   0x08024abe: 0831        lsrs	r1, r6, #32
@   0x08024ac0: 01c1        lsls	r1, r0, #7

        thumb_func_start sub_08024A98
sub_08024A98: @ 0x08024a98
        .incbin "baserom.gba", 0x24a98, 0x2c
        thumb_func_end sub_08024A98
