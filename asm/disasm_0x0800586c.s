@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800586c, 0x08005890)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800586c --end 0x8005890 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800586c: b510        push	{r4, lr}
@   0x0800586e: 4a06        ldr	r2, [pc, #24]	@ (0x5888)
@   0x08005870: 2400        movs	r4, #0
@   0x08005872: 2110        movs	r1, #16
@   0x08005874: 7291        strb	r1, [r2, #10]
@   0x08005876: f005        fb6b 	bl	0xaf50
@   0x0800587a: 4804        ldr	r0, [pc, #16]	@ (0x588c)
@   0x0800587c: 3033        adds	r0, #51	@ 0x33
@   0x0800587e: 7004        strb	r4, [r0, #0]
@   0x08005880: bc10        pop	{r4}
@   0x08005882: bc01        pop	{r0}
@   0x08005884: 4700        bx	r0
@   0x08005886: 0000        movs	r0, r0
@   0x08005888: 5330        strh	r0, [r6, r4]
@   0x0800588a: 0300        lsls	r0, r0, #12
@   0x0800588c: 6110        str	r0, [r2, #16]
@   0x0800588e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800586C
sub_0800586C: @ 0x0800586c
        .incbin "frog_us_baserom.gba", 0x586c, 0x24
        thumb_func_end sub_0800586C
