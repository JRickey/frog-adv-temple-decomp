@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801cf18, 0x0801cfa0)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801cf18 --end 0x801cfa0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801cf18: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801cf1a: 4657        mov	r7, sl
@   0x0801cf1c: 464e        mov	r6, r9
@   0x0801cf1e: 4645        mov	r5, r8
@   0x0801cf20: b4e0        push	{r5, r6, r7}
@   0x0801cf22: b084        sub	sp, #16
@   0x0801cf24: 1c05        adds	r5, r0, #0
@   0x0801cf26: 468a        mov	sl, r1
@   0x0801cf28: 1c1e        adds	r6, r3, #0
@   0x0801cf2a: 980c        ldr	r0, [sp, #48]	@ 0x30
@   0x0801cf2c: 4680        mov	r8, r0
@   0x0801cf2e: 980d        ldr	r0, [sp, #52]	@ 0x34
@   0x0801cf30: 4681        mov	r9, r0
@   0x0801cf32: 062d        lsls	r5, r5, #24
@   0x0801cf34: 0e2d        lsrs	r5, r5, #24
@   0x0801cf36: 4650        mov	r0, sl
@   0x0801cf38: 0600        lsls	r0, r0, #24
@   0x0801cf3a: 0e00        lsrs	r0, r0, #24
@   0x0801cf3c: 4682        mov	sl, r0
@   0x0801cf3e: 0612        lsls	r2, r2, #24
@   0x0801cf40: 0e17        lsrs	r7, r2, #24
@   0x0801cf42: 0436        lsls	r6, r6, #16
@   0x0801cf44: 0c36        lsrs	r6, r6, #16
@   0x0801cf46: 4640        mov	r0, r8
@   0x0801cf48: 0400        lsls	r0, r0, #16
@   0x0801cf4a: 0c00        lsrs	r0, r0, #16
@   0x0801cf4c: 4680        mov	r8, r0
@   0x0801cf4e: 4648        mov	r0, r9
@   0x0801cf50: 0600        lsls	r0, r0, #24
@   0x0801cf52: 0e00        lsrs	r0, r0, #24
@   0x0801cf54: 4681        mov	r9, r0
@   0x0801cf56: 1c28        adds	r0, r5, #0
@   0x0801cf58: 210a        movs	r1, #10
@   0x0801cf5a: f016        ffc3 	bl	0x33ee4
@   0x0801cf5e: 1c04        adds	r4, r0, #0
@   0x0801cf60: 0624        lsls	r4, r4, #24
@   0x0801cf62: 0e24        lsrs	r4, r4, #24
@   0x0801cf64: 1c28        adds	r0, r5, #0
@   0x0801cf66: 210a        movs	r1, #10
@   0x0801cf68: f016        fff8 	bl	0x33f5c
@   0x0801cf6c: 0600        lsls	r0, r0, #24
@   0x0801cf6e: 0e00        lsrs	r0, r0, #24
@   0x0801cf70: a903        add	r1, sp, #12
@   0x0801cf72: 3430        adds	r4, #48	@ 0x30
@   0x0801cf74: 700c        strb	r4, [r1, #0]
@   0x0801cf76: 3030        adds	r0, #48	@ 0x30
@   0x0801cf78: 7048        strb	r0, [r1, #1]
@   0x0801cf7a: 9600        str	r6, [sp, #0]
@   0x0801cf7c: 4640        mov	r0, r8
@   0x0801cf7e: 9001        str	r0, [sp, #4]
@   0x0801cf80: 4648        mov	r0, r9
@   0x0801cf82: 9002        str	r0, [sp, #8]
@   0x0801cf84: 1c08        adds	r0, r1, #0
@   0x0801cf86: 2102        movs	r1, #2
@   0x0801cf88: 4652        mov	r2, sl
@   0x0801cf8a: 1c3b        adds	r3, r7, #0
@   0x0801cf8c: f7fe        ff76 	bl	0x1be7c
@   0x0801cf90: b004        add	sp, #16
@   0x0801cf92: bc38        pop	{r3, r4, r5}
@   0x0801cf94: 4698        mov	r8, r3
@   0x0801cf96: 46a1        mov	r9, r4
@   0x0801cf98: 46aa        mov	sl, r5
@   0x0801cf9a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801cf9c: bc01        pop	{r0}
@   0x0801cf9e: 4700        bx	r0

        thumb_func_start sub_0801CF18
sub_0801CF18: @ 0x0801cf18
        .incbin "frog_us_baserom.gba", 0x1cf18, 0x88
        thumb_func_end sub_0801CF18
