@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003584, 0x0800359c)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003584 --end 0x800359c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003584: b500        push	{lr}
@   0x08003586: 1c01        adds	r1, r0, #0
@   0x08003588: 4a03        ldr	r2, [pc, #12]	@ (0x3598)
@   0x0800358a: 200a        movs	r0, #10
@   0x0800358c: 7290        strb	r0, [r2, #10]
@   0x0800358e: 2006        movs	r0, #6
@   0x08003590: f003        fb10 	bl	0x6bb4
@   0x08003594: bc01        pop	{r0}
@   0x08003596: 4700        bx	r0
@   0x08003598: 5330        strh	r0, [r6, r4]
@   0x0800359a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003584
sub_08003584: @ 0x08003584
        .incbin "frog_us_baserom.gba", 0x3584, 0x18
        thumb_func_end sub_08003584
