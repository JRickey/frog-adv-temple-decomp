@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019678, 0x080196a0)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019678 --end 0x80196a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019678: b500        push	{lr}
@   0x0801967a: f7f7        f81d 	bl	0x106b8
@   0x0801967e: 1c03        adds	r3, r0, #0
@   0x08019680: 2b00        cmp	r3, #0
@   0x08019682: d107        bne.n	0x19694
@   0x08019684: 4904        ldr	r1, [pc, #16]	@ (0x19698)
@   0x08019686: 78c8        ldrb	r0, [r1, #3]
@   0x08019688: 3001        adds	r0, #1
@   0x0801968a: 70c8        strb	r0, [r1, #3]
@   0x0801968c: 4a03        ldr	r2, [pc, #12]	@ (0x1969c)
@   0x0801968e: 2004        movs	r0, #4
@   0x08019690: 7250        strb	r0, [r2, #9]
@   0x08019692: 700b        strb	r3, [r1, #0]
@   0x08019694: bc01        pop	{r0}
@   0x08019696: 4700        bx	r0
@   0x08019698: 3480        adds	r4, #128	@ 0x80
@   0x0801969a: 0300        lsls	r0, r0, #12
@   0x0801969c: 5330        strh	r0, [r6, r4]
@   0x0801969e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019678
sub_08019678: @ 0x08019678
        .incbin "frog_us_baserom.gba", 0x19678, 0x28
        thumb_func_end sub_08019678
