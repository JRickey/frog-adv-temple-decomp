@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020c14, 0x08020c3c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020c14 --end 0x8020c3c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020c14: b500        push	{lr}
@   0x08020c16: 1c02        adds	r2, r0, #0
@   0x08020c18: 4907        ldr	r1, [pc, #28]	@ (0x20c38)
@   0x08020c1a: 2001        movs	r0, #1
@   0x08020c1c: 780b        ldrb	r3, [r1, #0]
@   0x08020c1e: 4318        orrs	r0, r3
@   0x08020c20: 7008        strb	r0, [r1, #0]
@   0x08020c22: 2101        movs	r1, #1
@   0x08020c24: 4008        ands	r0, r1
@   0x08020c26: 2800        cmp	r0, #0
@   0x08020c28: d004        beq.n	0x20c34
@   0x08020c2a: 1c10        adds	r0, r2, #0
@   0x08020c2c: f011        f8fa 	bl	0x31e24
@   0x08020c30: f011        fee0 	bl	0x329f4
@   0x08020c34: bc01        pop	{r0}
@   0x08020c36: 4700        bx	r0
@   0x08020c38: 3570        adds	r5, #112	@ 0x70
@   0x08020c3a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020C14
sub_08020C14: @ 0x08020c14
        .incbin "frog_us_baserom.gba", 0x20c14, 0x28
        thumb_func_end sub_08020C14
