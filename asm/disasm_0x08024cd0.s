@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024cd0, 0x08024dbc)  (236 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024cd0 --end 0x8024dbc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024cd0: b510        push	{r4, lr}
@   0x08024cd2: 2400        movs	r4, #0
@   0x08024cd4: 00e0        lsls	r0, r4, #3
@   0x08024cd6: 1b00        subs	r0, r0, r4
@   0x08024cd8: 00c0        lsls	r0, r0, #3
@   0x08024cda: 4934        ldr	r1, [pc, #208]	@ (0x24dac)
@   0x08024cdc: 1840        adds	r0, r0, r1
@   0x08024cde: 7e81        ldrb	r1, [r0, #26]
@   0x08024ce0: 2902        cmp	r1, #2
@   0x08024ce2: d001        beq.n	0x24ce8
@   0x08024ce4: 2904        cmp	r1, #4
@   0x08024ce6: d104        bne.n	0x24cf2
@   0x08024ce8: 2104        movs	r1, #4
@   0x08024cea: 2201        movs	r2, #1
@   0x08024cec: 2301        movs	r3, #1
@   0x08024cee: f7fc        f891 	bl	0x20e14
@   0x08024cf2: 1c60        adds	r0, r4, #1
@   0x08024cf4: 0600        lsls	r0, r0, #24
@   0x08024cf6: 0e04        lsrs	r4, r0, #24
@   0x08024cf8: 2c0a        cmp	r4, #10
@   0x08024cfa: d9eb        bls.n	0x24cd4
@   0x08024cfc: 240b        movs	r4, #11
@   0x08024cfe: 00e0        lsls	r0, r4, #3
@   0x08024d00: 1b00        subs	r0, r0, r4
@   0x08024d02: 00c0        lsls	r0, r0, #3
@   0x08024d04: 4929        ldr	r1, [pc, #164]	@ (0x24dac)
@   0x08024d06: 1840        adds	r0, r0, r1
@   0x08024d08: 7e81        ldrb	r1, [r0, #26]
@   0x08024d0a: 2901        cmp	r1, #1
@   0x08024d0c: d001        beq.n	0x24d12
@   0x08024d0e: 2903        cmp	r1, #3
@   0x08024d10: d104        bne.n	0x24d1c
@   0x08024d12: 2104        movs	r1, #4
@   0x08024d14: 2201        movs	r2, #1
@   0x08024d16: 2301        movs	r3, #1
@   0x08024d18: f7fc        f87c 	bl	0x20e14
@   0x08024d1c: 1c60        adds	r0, r4, #1
@   0x08024d1e: 0600        lsls	r0, r0, #24
@   0x08024d20: 0e04        lsrs	r4, r0, #24
@   0x08024d22: 2c0c        cmp	r4, #12
@   0x08024d24: d9eb        bls.n	0x24cfe
@   0x08024d26: 4c22        ldr	r4, [pc, #136]	@ (0x24db0)
@   0x08024d28: 6820        ldr	r0, [r4, #0]
@   0x08024d2a: 2141        movs	r1, #65	@ 0x41
@   0x08024d2c: f7fc        fe46 	bl	0x219bc
@   0x08024d30: 6860        ldr	r0, [r4, #4]
@   0x08024d32: 2142        movs	r1, #66	@ 0x42
@   0x08024d34: f7fc        fe42 	bl	0x219bc
@   0x08024d38: 68a0        ldr	r0, [r4, #8]
@   0x08024d3a: 2143        movs	r1, #67	@ 0x43
@   0x08024d3c: f7fc        fe3e 	bl	0x219bc
@   0x08024d40: 68e0        ldr	r0, [r4, #12]
@   0x08024d42: 2144        movs	r1, #68	@ 0x44
@   0x08024d44: f7fc        fe3a 	bl	0x219bc
@   0x08024d48: 6920        ldr	r0, [r4, #16]
@   0x08024d4a: 2145        movs	r1, #69	@ 0x45
@   0x08024d4c: f7fc        fe36 	bl	0x219bc
@   0x08024d50: 6960        ldr	r0, [r4, #20]
@   0x08024d52: 2146        movs	r1, #70	@ 0x46
@   0x08024d54: f7fc        fe32 	bl	0x219bc
@   0x08024d58: 69a0        ldr	r0, [r4, #24]
@   0x08024d5a: 2147        movs	r1, #71	@ 0x47
@   0x08024d5c: f7fc        fe2e 	bl	0x219bc
@   0x08024d60: 69e0        ldr	r0, [r4, #28]
@   0x08024d62: 2148        movs	r1, #72	@ 0x48
@   0x08024d64: f7fc        fe2a 	bl	0x219bc
@   0x08024d68: 4c12        ldr	r4, [pc, #72]	@ (0x24db4)
@   0x08024d6a: 6820        ldr	r0, [r4, #0]
@   0x08024d6c: 2149        movs	r1, #73	@ 0x49
@   0x08024d6e: f7fc        fe25 	bl	0x219bc
@   0x08024d72: 6860        ldr	r0, [r4, #4]
@   0x08024d74: 214a        movs	r1, #74	@ 0x4a
@   0x08024d76: f7fc        fe21 	bl	0x219bc
@   0x08024d7a: 68a0        ldr	r0, [r4, #8]
@   0x08024d7c: 214b        movs	r1, #75	@ 0x4b
@   0x08024d7e: f7fc        fe1d 	bl	0x219bc
@   0x08024d82: 68e0        ldr	r0, [r4, #12]
@   0x08024d84: 214c        movs	r1, #76	@ 0x4c
@   0x08024d86: f7fc        fe19 	bl	0x219bc
@   0x08024d8a: 480b        ldr	r0, [pc, #44]	@ (0x24db8)
@   0x08024d8c: 6800        ldr	r0, [r0, #0]
@   0x08024d8e: 214d        movs	r1, #77	@ 0x4d
@   0x08024d90: f7fc        fe14 	bl	0x219bc
@   0x08024d94: 2041        movs	r0, #65	@ 0x41
@   0x08024d96: 214d        movs	r1, #77	@ 0x4d
@   0x08024d98: f7fc        f924 	bl	0x20fe4
@   0x08024d9c: 2041        movs	r0, #65	@ 0x41
@   0x08024d9e: 214d        movs	r1, #77	@ 0x4d
@   0x08024da0: f7e0        ffb6 	bl	0x5d10
@   0x08024da4: bc10        pop	{r4}
@   0x08024da6: bc01        pop	{r0}
@   0x08024da8: 4700        bx	r0
@   0x08024daa: 0000        movs	r0, r0
@   0x08024dac: 4558        cmp	r0, fp
@   0x08024dae: 0300        lsls	r0, r0, #12
@   0x08024db0: 4014        ands	r4, r2
@   0x08024db2: 0831        lsrs	r1, r6, #32
@   0x08024db4: 4034        ands	r4, r6
@   0x08024db6: 0831        lsrs	r1, r6, #32
@   0x08024db8: 4044        eors	r4, r0
@   0x08024dba: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08024CD0
sub_08024CD0: @ 0x08024cd0
        .incbin "baserom.gba", 0x24cd0, 0xec
        thumb_func_end sub_08024CD0
