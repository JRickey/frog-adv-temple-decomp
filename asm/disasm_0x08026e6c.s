@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026e6c, 0x08026e90)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026e6c --end 0x8026e90 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026e6c: b500        push	{lr}
@   0x08026e6e: b081        sub	sp, #4
@   0x08026e70: 4905        ldr	r1, [pc, #20]	@ (0x26e88)
@   0x08026e72: 4b06        ldr	r3, [pc, #24]	@ (0x26e8c)
@   0x08026e74: 2000        movs	r0, #0
@   0x08026e76: 9000        str	r0, [sp, #0]
@   0x08026e78: 2073        movs	r0, #115	@ 0x73
@   0x08026e7a: 224c        movs	r2, #76	@ 0x4c
@   0x08026e7c: f7fa        fb48 	bl	0x21510
@   0x08026e80: b001        add	sp, #4
@   0x08026e82: bc01        pop	{r0}
@   0x08026e84: 4700        bx	r0
@   0x08026e86: 0000        movs	r0, r0
@   0x08026e88: 4b70        ldr	r3, [pc, #448]	@ (0x2704c)
@   0x08026e8a: 0831        lsrs	r1, r6, #32
@   0x08026e8c: 6110        str	r0, [r2, #16]
@   0x08026e8e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08026E6C
sub_08026E6C: @ 0x08026e6c
        .incbin "baserom.gba", 0x26e6c, 0x24
        thumb_func_end sub_08026E6C
