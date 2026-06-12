@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026a0c, 0x08026a30)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026a0c --end 0x8026a30 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026a0c: b500        push	{lr}
@   0x08026a0e: b081        sub	sp, #4
@   0x08026a10: 4905        ldr	r1, [pc, #20]	@ (0x26a28)
@   0x08026a12: 4b06        ldr	r3, [pc, #24]	@ (0x26a2c)
@   0x08026a14: 2000        movs	r0, #0
@   0x08026a16: 9000        str	r0, [sp, #0]
@   0x08026a18: 2029        movs	r0, #41	@ 0x29
@   0x08026a1a: 2204        movs	r2, #4
@   0x08026a1c: f7fa        fd78 	bl	0x21510
@   0x08026a20: b001        add	sp, #4
@   0x08026a22: bc01        pop	{r0}
@   0x08026a24: 4700        bx	r0
@   0x08026a26: 0000        movs	r0, r0
@   0x08026a28: 50f0        str	r0, [r6, r3]
@   0x08026a2a: 0831        lsrs	r1, r6, #32
@   0x08026a2c: 6110        str	r0, [r2, #16]
@   0x08026a2e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08026A0C
sub_08026A0C: @ 0x08026a0c
        .incbin "baserom.gba", 0x26a0c, 0x24
        thumb_func_end sub_08026A0C
