@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800df7c, 0x0800df9c)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800df7c --end 0x800df9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800df7c: b500        push	{lr}
@   0x0800df7e: 4905        ldr	r1, [pc, #20]	@ (0xdf94)
@   0x0800df80: 4805        ldr	r0, [pc, #20]	@ (0xdf98)
@   0x0800df82: 7a80        ldrb	r0, [r0, #10]
@   0x0800df84: 0080        lsls	r0, r0, #2
@   0x0800df86: 1840        adds	r0, r0, r1
@   0x0800df88: 6800        ldr	r0, [r0, #0]
@   0x0800df8a: f025        fea5 	bl	0x33cd8
@   0x0800df8e: bc01        pop	{r0}
@   0x0800df90: 4700        bx	r0
@   0x0800df92: 0000        movs	r0, r0
@   0x0800df94: 0ddc        lsrs	r4, r3, #23
@   0x0800df96: 080c        lsrs	r4, r1, #32
@   0x0800df98: 5330        strh	r0, [r6, r4]
@   0x0800df9a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800DF7C
sub_0800DF7C: @ 0x0800df7c
        .incbin "frog_us_baserom.gba", 0xdf7c, 0x20
        thumb_func_end sub_0800DF7C
