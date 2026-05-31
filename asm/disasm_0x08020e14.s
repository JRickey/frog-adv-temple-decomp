@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020e14, 0x08020e7c)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020e14 --end 0x8020e7c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020e14: b570        push	{r4, r5, r6, lr}
@   0x08020e16: 0609        lsls	r1, r1, #24
@   0x08020e18: 0e0c        lsrs	r4, r1, #24
@   0x08020e1a: 0612        lsls	r2, r2, #24
@   0x08020e1c: 0e12        lsrs	r2, r2, #24
@   0x08020e1e: 061b        lsls	r3, r3, #24
@   0x08020e20: 0e1b        lsrs	r3, r3, #24
@   0x08020e22: 1c11        adds	r1, r2, #0
@   0x08020e24: 1c1a        adds	r2, r3, #0
@   0x08020e26: f001        f805 	bl	0x21e34
@   0x08020e2a: 0600        lsls	r0, r0, #24
@   0x08020e2c: 2800        cmp	r0, #0
@   0x08020e2e: d020        beq.n	0x20e72
@   0x08020e30: 4d11        ldr	r5, [pc, #68]	@ (0x20e78)
@   0x08020e32: 00e4        lsls	r4, r4, #3
@   0x08020e34: 1c28        adds	r0, r5, #0
@   0x08020e36: 3008        adds	r0, #8
@   0x08020e38: 1826        adds	r6, r4, r0
@   0x08020e3a: 6830        ldr	r0, [r6, #0]
@   0x08020e3c: f00d        f9a2 	bl	0x2e184
@   0x08020e40: 2800        cmp	r0, #0
@   0x08020e42: d116        bne.n	0x20e72
@   0x08020e44: 1d28        adds	r0, r5, #4
@   0x08020e46: 1820        adds	r0, r4, r0
@   0x08020e48: 6801        ldr	r1, [r0, #0]
@   0x08020e4a: 2401        movs	r4, #1
@   0x08020e4c: 4264        negs	r4, r4
@   0x08020e4e: 2010        movs	r0, #16
@   0x08020e50: 782a        ldrb	r2, [r5, #0]
@   0x08020e52: 4010        ands	r0, r2
@   0x08020e54: 2800        cmp	r0, #0
@   0x08020e56: d00b        beq.n	0x20e70
@   0x08020e58: 1c08        adds	r0, r1, #0
@   0x08020e5a: 21ff        movs	r1, #255	@ 0xff
@   0x08020e5c: 22ff        movs	r2, #255	@ 0xff
@   0x08020e5e: 23ff        movs	r3, #255	@ 0xff
@   0x08020e60: f00c        fdc4 	bl	0x2d9ec
@   0x08020e64: 1c04        adds	r4, r0, #0
@   0x08020e66: 217f        movs	r1, #127	@ 0x7f
@   0x08020e68: 78ad        ldrb	r5, [r5, #2]
@   0x08020e6a: 4029        ands	r1, r5
@   0x08020e6c: f00c        fed6 	bl	0x2dc1c
@   0x08020e70: 6034        str	r4, [r6, #0]
@   0x08020e72: bc70        pop	{r4, r5, r6}
@   0x08020e74: bc01        pop	{r0}
@   0x08020e76: 4700        bx	r0
@   0x08020e78: 3570        adds	r5, #112	@ 0x70
@   0x08020e7a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020E14
sub_08020E14: @ 0x08020e14
        .incbin "frog_us_baserom.gba", 0x20e14, 0x68
        thumb_func_end sub_08020E14
