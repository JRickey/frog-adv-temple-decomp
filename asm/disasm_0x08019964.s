@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019964, 0x08019984)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019964 --end 0x8019984 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019964: b500        push	{lr}
@   0x08019966: 20c8        movs	r0, #200	@ 0xc8
@   0x08019968: f7f7        ff78 	bl	0x1185c
@   0x0801996c: 4903        ldr	r1, [pc, #12]	@ (0x1997c)
@   0x0801996e: 61c8        str	r0, [r1, #28]
@   0x08019970: 4903        ldr	r1, [pc, #12]	@ (0x19980)
@   0x08019972: 2002        movs	r0, #2
@   0x08019974: 7048        strb	r0, [r1, #1]
@   0x08019976: bc01        pop	{r0}
@   0x08019978: 4700        bx	r0
@   0x0801997a: 0000        movs	r0, r0
@   0x0801997c: 5330        strh	r0, [r6, r4]
@   0x0801997e: 0300        lsls	r0, r0, #12
@   0x08019980: 34a0        adds	r4, #160	@ 0xa0
@   0x08019982: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019964
sub_08019964: @ 0x08019964
        .incbin "frog_us_baserom.gba", 0x19964, 0x20
        thumb_func_end sub_08019964
