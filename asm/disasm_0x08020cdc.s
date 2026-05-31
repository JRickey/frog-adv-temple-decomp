@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020cdc, 0x08020d2c)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020cdc --end 0x8020d2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020cdc: b570        push	{r4, r5, r6, lr}
@   0x08020cde: 1c0e        adds	r6, r1, #0
@   0x08020ce0: 1c11        adds	r1, r2, #0
@   0x08020ce2: 1c1a        adds	r2, r3, #0
@   0x08020ce4: 0609        lsls	r1, r1, #24
@   0x08020ce6: 0e09        lsrs	r1, r1, #24
@   0x08020ce8: 0612        lsls	r2, r2, #24
@   0x08020cea: 0e12        lsrs	r2, r2, #24
@   0x08020cec: f001        f8a2 	bl	0x21e34
@   0x08020cf0: 0600        lsls	r0, r0, #24
@   0x08020cf2: 2800        cmp	r0, #0
@   0x08020cf4: d014        beq.n	0x20d20
@   0x08020cf6: 2401        movs	r4, #1
@   0x08020cf8: 4264        negs	r4, r4
@   0x08020cfa: 4d0b        ldr	r5, [pc, #44]	@ (0x20d28)
@   0x08020cfc: 2010        movs	r0, #16
@   0x08020cfe: 7829        ldrb	r1, [r5, #0]
@   0x08020d00: 4008        ands	r0, r1
@   0x08020d02: 2800        cmp	r0, #0
@   0x08020d04: d00b        beq.n	0x20d1e
@   0x08020d06: 1c30        adds	r0, r6, #0
@   0x08020d08: 21ff        movs	r1, #255	@ 0xff
@   0x08020d0a: 22ff        movs	r2, #255	@ 0xff
@   0x08020d0c: 23ff        movs	r3, #255	@ 0xff
@   0x08020d0e: f00c        fe6d 	bl	0x2d9ec
@   0x08020d12: 1c04        adds	r4, r0, #0
@   0x08020d14: 217f        movs	r1, #127	@ 0x7f
@   0x08020d16: 78ad        ldrb	r5, [r5, #2]
@   0x08020d18: 4029        ands	r1, r5
@   0x08020d1a: f00c        ff7f 	bl	0x2dc1c
@   0x08020d1e: 1c20        adds	r0, r4, #0
@   0x08020d20: bc70        pop	{r4, r5, r6}
@   0x08020d22: bc02        pop	{r1}
@   0x08020d24: 4708        bx	r1
@   0x08020d26: 0000        movs	r0, r0
@   0x08020d28: 3570        adds	r5, #112	@ 0x70
@   0x08020d2a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020CDC
sub_08020CDC: @ 0x08020cdc
        .incbin "frog_us_baserom.gba", 0x20cdc, 0x50
        thumb_func_end sub_08020CDC
