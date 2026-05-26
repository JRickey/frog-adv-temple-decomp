@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020c78, 0x08020ca4)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020c78 --end 0x8020ca4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020c78: b500        push	{lr}
@   0x08020c7a: 1c02        adds	r2, r0, #0
@   0x08020c7c: 2301        movs	r3, #1
@   0x08020c7e: 425b        negs	r3, r3
@   0x08020c80: 4907        ldr	r1, [pc, #28]	@ (0x20ca0)
@   0x08020c82: 2010        movs	r0, #16
@   0x08020c84: 7809        ldrb	r1, [r1, #0]
@   0x08020c86: 4008        ands	r0, r1
@   0x08020c88: 2800        cmp	r0, #0
@   0x08020c8a: d006        beq.n	0x20c9a
@   0x08020c8c: 1c10        adds	r0, r2, #0
@   0x08020c8e: 21ff        movs	r1, #255	@ 0xff
@   0x08020c90: 22ff        movs	r2, #255	@ 0xff
@   0x08020c92: 23ff        movs	r3, #255	@ 0xff
@   0x08020c94: f00c        feaa 	bl	0x2d9ec
@   0x08020c98: 1c03        adds	r3, r0, #0
@   0x08020c9a: 1c18        adds	r0, r3, #0
@   0x08020c9c: bc02        pop	{r1}
@   0x08020c9e: 4708        bx	r1
@   0x08020ca0: 3570        adds	r5, #112	@ 0x70
@   0x08020ca2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020C78
sub_08020C78: @ 0x08020c78
        .incbin "frog_us_baserom.gba", 0x20c78, 0x2c
        thumb_func_end sub_08020C78
