@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020c3c, 0x08020c58)  (28 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020c3c --end 0x8020c58 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020c3c: b500        push	{lr}
@   0x08020c3e: 2000        movs	r0, #0
@   0x08020c40: f000        f92a 	bl	0x20e98
@   0x08020c44: 4903        ldr	r1, [pc, #12]	@ (0x20c54)
@   0x08020c46: 20ef        movs	r0, #239	@ 0xef
@   0x08020c48: 780a        ldrb	r2, [r1, #0]
@   0x08020c4a: 4010        ands	r0, r2
@   0x08020c4c: 7008        strb	r0, [r1, #0]
@   0x08020c4e: bc01        pop	{r0}
@   0x08020c50: 4700        bx	r0
@   0x08020c52: 0000        movs	r0, r0
@   0x08020c54: 3570        adds	r5, #112	@ 0x70
@   0x08020c56: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020C3C
sub_08020C3C: @ 0x08020c3c
        .incbin "frog_us_baserom.gba", 0x20c3c, 0x1c
        thumb_func_end sub_08020C3C
