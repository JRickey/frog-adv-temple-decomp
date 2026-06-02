@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022ddc, 0x08022ea8)  (204 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022ddc --end 0x8022ea8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022ddc: b570        push	{r4, r5, r6, lr}
@   0x08022dde: 4a0a        ldr	r2, [pc, #40]	@ (0x22e08)
@   0x08022de0: 2004        movs	r0, #4
@   0x08022de2: 5e11        ldrsh	r1, [r2, r0]
@   0x08022de4: 20b4        movs	r0, #180	@ 0xb4
@   0x08022de6: 0040        lsls	r0, r0, #1
@   0x08022de8: 4281        cmp	r1, r0
@   0x08022dea: dc59        bgt.n	0x22ea0
@   0x08022dec: 29d7        cmp	r1, #215	@ 0xd7
@   0x08022dee: dc0f        bgt.n	0x22e10
@   0x08022df0: 2002        movs	r0, #2
@   0x08022df2: 5e11        ldrsh	r1, [r2, r0]
@   0x08022df4: 29a8        cmp	r1, #168	@ 0xa8
@   0x08022df6: dd0b        ble.n	0x22e10
@   0x08022df8: 4804        ldr	r0, [pc, #16]	@ (0x22e0c)
@   0x08022dfa: 4281        cmp	r1, r0
@   0x08022dfc: dc08        bgt.n	0x22e10
@   0x08022dfe: 2005        movs	r0, #5
@   0x08022e00: f7fd        ffe0 	bl	0x20dc4
@   0x08022e04: e007        b.n	0x22e16
@   0x08022e06: 0000        movs	r0, r0
@   0x08022e08: 3720        adds	r7, #32
@   0x08022e0a: 0300        lsls	r0, r0, #12
@   0x08022e0c: 0167        lsls	r7, r4, #5
@   0x08022e0e: 0000        movs	r0, r0
@   0x08022e10: 2005        movs	r0, #5
@   0x08022e12: f7fe        f833 	bl	0x20e7c
@   0x08022e16: 2500        movs	r5, #0
@   0x08022e18: 4e11        ldr	r6, [pc, #68]	@ (0x22e60)
@   0x08022e1a: 4812        ldr	r0, [pc, #72]	@ (0x22e64)
@   0x08022e1c: 00ac        lsls	r4, r5, #2
@   0x08022e1e: 1820        adds	r0, r4, r0
@   0x08022e20: 6800        ldr	r0, [r0, #0]
@   0x08022e22: 1c29        adds	r1, r5, #0
@   0x08022e24: 311a        adds	r1, #26
@   0x08022e26: f7fe        fdc9 	bl	0x219bc
@   0x08022e2a: 480f        ldr	r0, [pc, #60]	@ (0x22e68)
@   0x08022e2c: 1820        adds	r0, r4, r0
@   0x08022e2e: 6800        ldr	r0, [r0, #0]
@   0x08022e30: 1c29        adds	r1, r5, #0
@   0x08022e32: 3122        adds	r1, #34	@ 0x22
@   0x08022e34: f7fe        fdc2 	bl	0x219bc
@   0x08022e38: 480c        ldr	r0, [pc, #48]	@ (0x22e6c)
@   0x08022e3a: 1824        adds	r4, r4, r0
@   0x08022e3c: 6820        ldr	r0, [r4, #0]
@   0x08022e3e: 1c2c        adds	r4, r5, #0
@   0x08022e40: 342a        adds	r4, #42	@ 0x2a
@   0x08022e42: 1c21        adds	r1, r4, #0
@   0x08022e44: f7fe        fdba 	bl	0x219bc
@   0x08022e48: 2d03        cmp	r5, #3
@   0x08022e4a: d811        bhi.n	0x22e70
@   0x08022e4c: 00e0        lsls	r0, r4, #3
@   0x08022e4e: 1b00        subs	r0, r0, r4
@   0x08022e50: 00c0        lsls	r0, r0, #3
@   0x08022e52: 1981        adds	r1, r0, r6
@   0x08022e54: 7e88        ldrb	r0, [r1, #26]
@   0x08022e56: 2801        cmp	r0, #1
@   0x08022e58: d013        beq.n	0x22e82
@   0x08022e5a: 2003        movs	r0, #3
@   0x08022e5c: e012        b.n	0x22e84
@   0x08022e5e: 0000        movs	r0, r0
@   0x08022e60: 3720        adds	r7, #32
@   0x08022e62: 0300        lsls	r0, r0, #12
@   0x08022e64: 17f0        asrs	r0, r6, #31
@   0x08022e66: 0831        lsrs	r1, r6, #32
@   0x08022e68: 1910        adds	r0, r2, r4
@   0x08022e6a: 0831        lsrs	r1, r6, #32
@   0x08022e6c: 1a30        subs	r0, r6, r0
@   0x08022e6e: 0831        lsrs	r1, r6, #32
@   0x08022e70: 00e0        lsls	r0, r4, #3
@   0x08022e72: 1b00        subs	r0, r0, r4
@   0x08022e74: 00c0        lsls	r0, r0, #3
@   0x08022e76: 1981        adds	r1, r0, r6
@   0x08022e78: 7e88        ldrb	r0, [r1, #26]
@   0x08022e7a: 2801        cmp	r0, #1
@   0x08022e7c: d101        bne.n	0x22e82
@   0x08022e7e: 2003        movs	r0, #3
@   0x08022e80: e000        b.n	0x22e84
@   0x08022e82: 2002        movs	r0, #2
@   0x08022e84: 7188        strb	r0, [r1, #6]
@   0x08022e86: 1c68        adds	r0, r5, #1
@   0x08022e88: 0600        lsls	r0, r0, #24
@   0x08022e8a: 0e05        lsrs	r5, r0, #24
@   0x08022e8c: 2d07        cmp	r5, #7
@   0x08022e8e: d9c4        bls.n	0x22e1a
@   0x08022e90: 201a        movs	r0, #26
@   0x08022e92: 2131        movs	r1, #49	@ 0x31
@   0x08022e94: f7fe        f8a6 	bl	0x20fe4
@   0x08022e98: 201a        movs	r0, #26
@   0x08022e9a: 2131        movs	r1, #49	@ 0x31
@   0x08022e9c: f7e2        ff38 	bl	0x5d10
@   0x08022ea0: bc70        pop	{r4, r5, r6}
@   0x08022ea2: bc01        pop	{r0}
@   0x08022ea4: 4700        bx	r0

        thumb_func_start sub_08022DDC
sub_08022DDC: @ 0x08022ddc
        .incbin "frog_us_baserom.gba", 0x22ddc, 0xcc
        thumb_func_end sub_08022DDC
