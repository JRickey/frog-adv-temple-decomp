@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026a30, 0x08026a58)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026a30 --end 0x8026a58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026a30: b500        push	{lr}
@   0x08026a32: b083        sub	sp, #12
@   0x08026a34: 4907        ldr	r1, [pc, #28]	@ (0x26a54)
@   0x08026a36: 2061        movs	r0, #97	@ 0x61
@   0x08026a38: 9000        str	r0, [sp, #0]
@   0x08026a3a: 2004        movs	r0, #4
@   0x08026a3c: 9001        str	r0, [sp, #4]
@   0x08026a3e: 2000        movs	r0, #0
@   0x08026a40: 9002        str	r0, [sp, #8]
@   0x08026a42: 202c        movs	r0, #44	@ 0x2c
@   0x08026a44: 2210        movs	r2, #16
@   0x08026a46: 2338        movs	r3, #56	@ 0x38
@   0x08026a48: f7fa        fb7a 	bl	0x21140
@   0x08026a4c: b003        add	sp, #12
@   0x08026a4e: bc01        pop	{r0}
@   0x08026a50: 4700        bx	r0
@   0x08026a52: 0000        movs	r0, r0
@   0x08026a54: 5110        str	r0, [r2, r4]
@   0x08026a56: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026A30
sub_08026A30: @ 0x08026a30
        .incbin "baserom.gba", 0x26a30, 0x28
        thumb_func_end sub_08026A30
