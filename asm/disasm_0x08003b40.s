@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003b40, 0x08003b8c)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003b40 --end 0x8003b8c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003b40: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08003b42: 4647        mov	r7, r8
@   0x08003b44: b480        push	{r7}
@   0x08003b46: 1c04        adds	r4, r0, #0
@   0x08003b48: 1c0d        adds	r5, r1, #0
@   0x08003b4a: 1c16        adds	r6, r2, #0
@   0x08003b4c: 4698        mov	r8, r3
@   0x08003b4e: 9f06        ldr	r7, [sp, #24]
@   0x08003b50: 490d        ldr	r1, [pc, #52]	@ (0x3b88)
@   0x08003b52: 200b        movs	r0, #11
@   0x08003b54: 7288        strb	r0, [r1, #10]
@   0x08003b56: 2001        movs	r0, #1
@   0x08003b58: 1c21        adds	r1, r4, #0
@   0x08003b5a: f003        f82b 	bl	0x6bb4
@   0x08003b5e: 1c28        adds	r0, r5, #0
@   0x08003b60: 1c31        adds	r1, r6, #0
@   0x08003b62: 2206        movs	r2, #6
@   0x08003b64: f007        fe24 	bl	0xb7b0
@   0x08003b68: 4640        mov	r0, r8
@   0x08003b6a: 1c39        adds	r1, r7, #0
@   0x08003b6c: 2207        movs	r2, #7
@   0x08003b6e: f007        fe1f 	bl	0xb7b0
@   0x08003b72: 9807        ldr	r0, [sp, #28]
@   0x08003b74: 9908        ldr	r1, [sp, #32]
@   0x08003b76: 2216        movs	r2, #22
@   0x08003b78: f008        f94e 	bl	0xbe18
@   0x08003b7c: bc08        pop	{r3}
@   0x08003b7e: 4698        mov	r8, r3
@   0x08003b80: bcf0        pop	{r4, r5, r6, r7}
@   0x08003b82: bc01        pop	{r0}
@   0x08003b84: 4700        bx	r0
@   0x08003b86: 0000        movs	r0, r0
@   0x08003b88: 5330        strh	r0, [r6, r4]
@   0x08003b8a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003B40
sub_08003B40: @ 0x08003b40
        .incbin "frog_us_baserom.gba", 0x3b40, 0x4c
        thumb_func_end sub_08003B40
