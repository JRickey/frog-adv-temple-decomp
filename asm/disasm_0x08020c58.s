@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020c58, 0x08020c78)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020c58 --end 0x8020c78 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020c58: b510        push	{r4, lr}
@   0x08020c5a: 4c06        ldr	r4, [pc, #24]	@ (0x20c74)
@   0x08020c5c: 207f        movs	r0, #127	@ 0x7f
@   0x08020c5e: 78a1        ldrb	r1, [r4, #2]
@   0x08020c60: 4008        ands	r0, r1
@   0x08020c62: f000        f919 	bl	0x20e98
@   0x08020c66: 2010        movs	r0, #16
@   0x08020c68: 7821        ldrb	r1, [r4, #0]
@   0x08020c6a: 4308        orrs	r0, r1
@   0x08020c6c: 7020        strb	r0, [r4, #0]
@   0x08020c6e: bc10        pop	{r4}
@   0x08020c70: bc01        pop	{r0}
@   0x08020c72: 4700        bx	r0
@   0x08020c74: 3570        adds	r5, #112	@ 0x70
@   0x08020c76: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020C58
sub_08020C58: @ 0x08020c58
        .incbin "frog_us_baserom.gba", 0x20c58, 0x20
        thumb_func_end sub_08020C58
