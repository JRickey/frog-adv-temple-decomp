@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004104, 0x0800411c)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004104 --end 0x800411c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004104: b500        push	{lr}
@   0x08004106: 4904        ldr	r1, [pc, #16]	@ (0x4118)
@   0x08004108: 2002        movs	r0, #2
@   0x0800410a: 75c8        strb	r0, [r1, #23]
@   0x0800410c: f00f        ff48 	bl	0x13fa0
@   0x08004110: f009        feb6 	bl	0xde80
@   0x08004114: bc01        pop	{r0}
@   0x08004116: 4700        bx	r0
@   0x08004118: 3720        adds	r7, #32
@   0x0800411a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08004104
sub_08004104: @ 0x08004104
        .incbin "frog_us_baserom.gba", 0x4104, 0x18
        thumb_func_end sub_08004104
