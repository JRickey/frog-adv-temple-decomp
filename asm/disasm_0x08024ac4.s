@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024ac4, 0x08024ae8)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024ac4 --end 0x8024ae8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024ac4: b500        push	{lr}
@   0x08024ac6: b081        sub	sp, #4
@   0x08024ac8: 4905        ldr	r1, [pc, #20]	@ (0x24ae0)
@   0x08024aca: 4b06        ldr	r3, [pc, #24]	@ (0x24ae4)
@   0x08024acc: 2000        movs	r0, #0
@   0x08024ace: 9000        str	r0, [sp, #0]
@   0x08024ad0: 2053        movs	r0, #83	@ 0x53
@   0x08024ad2: 224c        movs	r2, #76	@ 0x4c
@   0x08024ad4: f7fc        fd1c 	bl	0x21510
@   0x08024ad8: b001        add	sp, #4
@   0x08024ada: bc01        pop	{r0}
@   0x08024adc: 4700        bx	r0
@   0x08024ade: 0000        movs	r0, r0
@   0x08024ae0: 2edc        cmp	r6, #220	@ 0xdc
@   0x08024ae2: 0831        lsrs	r1, r6, #32
@   0x08024ae4: 6110        str	r0, [r2, #16]
@   0x08024ae6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024AC4
sub_08024AC4: @ 0x08024ac4
        .incbin "baserom.gba", 0x24ac4, 0x24
        thumb_func_end sub_08024AC4
