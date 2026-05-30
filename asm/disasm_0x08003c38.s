@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003c38, 0x08003c9c)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003c38 --end 0x8003c9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003c38: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08003c3a: 4657        mov	r7, sl
@   0x08003c3c: 464e        mov	r6, r9
@   0x08003c3e: 4645        mov	r5, r8
@   0x08003c40: b4e0        push	{r5, r6, r7}
@   0x08003c42: b082        sub	sp, #8
@   0x08003c44: 1c04        adds	r4, r0, #0
@   0x08003c46: 4688        mov	r8, r1
@   0x08003c48: 4691        mov	r9, r2
@   0x08003c4a: 469a        mov	sl, r3
@   0x08003c4c: 9f0a        ldr	r7, [sp, #40]	@ 0x28
@   0x08003c4e: 9d0b        ldr	r5, [sp, #44]	@ 0x2c
@   0x08003c50: 9e0c        ldr	r6, [sp, #48]	@ 0x30
@   0x08003c52: 2001        movs	r0, #1
@   0x08003c54: 1c21        adds	r1, r4, #0
@   0x08003c56: f003        fd03 	bl	0x7660
@   0x08003c5a: f006        fb3d 	bl	0xa2d8
@   0x08003c5e: f7fc        fe3d 	bl	0x8dc
@   0x08003c62: f006        fb61 	bl	0xa328
@   0x08003c66: f005        fc47 	bl	0x94f8
@   0x08003c6a: f005        fe8b 	bl	0x9984
@   0x08003c6e: 9500        str	r5, [sp, #0]
@   0x08003c70: 9601        str	r6, [sp, #4]
@   0x08003c72: 4640        mov	r0, r8
@   0x08003c74: 4649        mov	r1, r9
@   0x08003c76: 4652        mov	r2, sl
@   0x08003c78: 1c3b        adds	r3, r7, #0
@   0x08003c7a: f7ff        fcf5 	bl	0x3668
@   0x08003c7e: 4906        ldr	r1, [pc, #24]	@ (0x3c98)
@   0x08003c80: 6948        ldr	r0, [r1, #20]
@   0x08003c82: 3001        adds	r0, #1
@   0x08003c84: 6148        str	r0, [r1, #20]
@   0x08003c86: b002        add	sp, #8
@   0x08003c88: bc38        pop	{r3, r4, r5}
@   0x08003c8a: 4698        mov	r8, r3
@   0x08003c8c: 46a1        mov	r9, r4
@   0x08003c8e: 46aa        mov	sl, r5
@   0x08003c90: bcf0        pop	{r4, r5, r6, r7}
@   0x08003c92: bc01        pop	{r0}
@   0x08003c94: 4700        bx	r0
@   0x08003c96: 0000        movs	r0, r0
@   0x08003c98: 5330        strh	r0, [r6, r4]
@   0x08003c9a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003C38
sub_08003C38: @ 0x08003c38
        .incbin "frog_us_baserom.gba", 0x3c38, 0x64
        thumb_func_end sub_08003C38
