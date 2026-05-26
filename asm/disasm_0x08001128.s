@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001128, 0x08001140)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001128 --end 0x8001140 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001128: b500        push	{lr}
@   0x0800112a: 4b04        ldr	r3, [pc, #16]	@ (0x113c)
@   0x0800112c: 2202        movs	r2, #2
@   0x0800112e: 729a        strb	r2, [r3, #10]
@   0x08001130: 2203        movs	r2, #3
@   0x08001132: f00a        fb3d 	bl	0xb7b0
@   0x08001136: bc01        pop	{r0}
@   0x08001138: 4700        bx	r0
@   0x0800113a: 0000        movs	r0, r0
@   0x0800113c: 5330        strh	r0, [r6, r4]
@   0x0800113e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001128
sub_08001128: @ 0x08001128
        .incbin "frog_us_baserom.gba", 0x1128, 0x18
        thumb_func_end sub_08001128
