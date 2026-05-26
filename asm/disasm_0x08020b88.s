@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020b88, 0x08020bac)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020b88 --end 0x8020bac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020b88: b500        push	{lr}
@   0x08020b8a: 1c02        adds	r2, r0, #0
@   0x08020b8c: 4906        ldr	r1, [pc, #24]	@ (0x20ba8)
@   0x08020b8e: 2001        movs	r0, #1
@   0x08020b90: 7809        ldrb	r1, [r1, #0]
@   0x08020b92: 4008        ands	r0, r1
@   0x08020b94: 2800        cmp	r0, #0
@   0x08020b96: d004        beq.n	0x20ba2
@   0x08020b98: 1c10        adds	r0, r2, #0
@   0x08020b9a: f011        f943 	bl	0x31e24
@   0x08020b9e: f011        ff29 	bl	0x329f4
@   0x08020ba2: bc01        pop	{r0}
@   0x08020ba4: 4700        bx	r0
@   0x08020ba6: 0000        movs	r0, r0
@   0x08020ba8: 3570        adds	r5, #112	@ 0x70
@   0x08020baa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020B88
sub_08020B88: @ 0x08020b88
        .incbin "frog_us_baserom.gba", 0x20b88, 0x24
        thumb_func_end sub_08020B88
