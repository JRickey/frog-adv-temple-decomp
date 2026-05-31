@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020d2c, 0x08020d9c)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020d2c --end 0x8020d9c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020d2c: b570        push	{r4, r5, r6, lr}
@   0x08020d2e: 1c04        adds	r4, r0, #0
@   0x08020d30: 1c0e        adds	r6, r1, #0
@   0x08020d32: 1c11        adds	r1, r2, #0
@   0x08020d34: 1c1a        adds	r2, r3, #0
@   0x08020d36: 0609        lsls	r1, r1, #24
@   0x08020d38: 0e09        lsrs	r1, r1, #24
@   0x08020d3a: 0612        lsls	r2, r2, #24
@   0x08020d3c: 0e12        lsrs	r2, r2, #24
@   0x08020d3e: f001        f879 	bl	0x21e34
@   0x08020d42: 0600        lsls	r0, r0, #24
@   0x08020d44: 2800        cmp	r0, #0
@   0x08020d46: d021        beq.n	0x20d8c
@   0x08020d48: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08020d4a: 2280        movs	r2, #128	@ 0x80
@   0x08020d4c: 0192        lsls	r2, r2, #6
@   0x08020d4e: 1c10        adds	r0, r2, #0
@   0x08020d50: 4008        ands	r0, r1
@   0x08020d52: 2800        cmp	r0, #0
@   0x08020d54: d11e        bne.n	0x20d94
@   0x08020d56: 1c10        adds	r0, r2, #0
@   0x08020d58: 4308        orrs	r0, r1
@   0x08020d5a: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08020d5c: 2401        movs	r4, #1
@   0x08020d5e: 4264        negs	r4, r4
@   0x08020d60: 4d09        ldr	r5, [pc, #36]	@ (0x20d88)
@   0x08020d62: 2010        movs	r0, #16
@   0x08020d64: 7829        ldrb	r1, [r5, #0]
@   0x08020d66: 4008        ands	r0, r1
@   0x08020d68: 2800        cmp	r0, #0
@   0x08020d6a: d00b        beq.n	0x20d84
@   0x08020d6c: 1c30        adds	r0, r6, #0
@   0x08020d6e: 21ff        movs	r1, #255	@ 0xff
@   0x08020d70: 22ff        movs	r2, #255	@ 0xff
@   0x08020d72: 23ff        movs	r3, #255	@ 0xff
@   0x08020d74: f00c        fe3a 	bl	0x2d9ec
@   0x08020d78: 1c04        adds	r4, r0, #0
@   0x08020d7a: 217f        movs	r1, #127	@ 0x7f
@   0x08020d7c: 78ad        ldrb	r5, [r5, #2]
@   0x08020d7e: 4029        ands	r1, r5
@   0x08020d80: f00c        ff4c 	bl	0x2dc1c
@   0x08020d84: 1c20        adds	r0, r4, #0
@   0x08020d86: e005        b.n	0x20d94
@   0x08020d88: 3570        adds	r5, #112	@ 0x70
@   0x08020d8a: 0300        lsls	r0, r0, #12
@   0x08020d8c: 4803        ldr	r0, [pc, #12]	@ (0x20d9c)
@   0x08020d8e: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08020d90: 4008        ands	r0, r1
@   0x08020d92: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08020d94: bc70        pop	{r4, r5, r6}
@   0x08020d96: bc02        pop	{r1}
@   0x08020d98: 4708        bx	r1

        thumb_func_start sub_08020D2C
sub_08020D2C: @ 0x08020d2c
        .incbin "frog_us_baserom.gba", 0x20d2c, 0x70
        thumb_func_end sub_08020D2C
