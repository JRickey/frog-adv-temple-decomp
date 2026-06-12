@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026ce8, 0x08026d0c)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026ce8 --end 0x8026d0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026ce8: b500        push	{lr}
@   0x08026cea: b081        sub	sp, #4
@   0x08026cec: 4905        ldr	r1, [pc, #20]	@ (0x26d04)
@   0x08026cee: 4b06        ldr	r3, [pc, #24]	@ (0x26d08)
@   0x08026cf0: 2000        movs	r0, #0
@   0x08026cf2: 9000        str	r0, [sp, #0]
@   0x08026cf4: 204c        movs	r0, #76	@ 0x4c
@   0x08026cf6: 2202        movs	r2, #2
@   0x08026cf8: f7fa        fc0a 	bl	0x21510
@   0x08026cfc: b001        add	sp, #4
@   0x08026cfe: bc01        pop	{r0}
@   0x08026d00: 4700        bx	r0
@   0x08026d02: 0000        movs	r0, r0
@   0x08026d04: 58c0        ldr	r0, [r0, r3]
@   0x08026d06: 0831        lsrs	r1, r6, #32
@   0x08026d08: 6110        str	r0, [r2, #16]
@   0x08026d0a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08026CE8
sub_08026CE8: @ 0x08026ce8
        .incbin "baserom.gba", 0x26ce8, 0x24
        thumb_func_end sub_08026CE8
