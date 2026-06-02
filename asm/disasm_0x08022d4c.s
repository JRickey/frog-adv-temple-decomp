@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022d4c, 0x08022ddc)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022d4c --end 0x8022ddc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022d4c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022d4e: b084        sub	sp, #16
@   0x08022d50: 2500        movs	r5, #0
@   0x08022d52: 2705        movs	r7, #5
@   0x08022d54: 2603        movs	r6, #3
@   0x08022d56: 1c28        adds	r0, r5, #0
@   0x08022d58: 301a        adds	r0, #26
@   0x08022d5a: 491d        ldr	r1, [pc, #116]	@ (0x22dd0)
@   0x08022d5c: 00ac        lsls	r4, r5, #2
@   0x08022d5e: 1861        adds	r1, r4, r1
@   0x08022d60: 6809        ldr	r1, [r1, #0]
@   0x08022d62: 2291        movs	r2, #145	@ 0x91
@   0x08022d64: 9200        str	r2, [sp, #0]
@   0x08022d66: 9701        str	r7, [sp, #4]
@   0x08022d68: 9602        str	r6, [sp, #8]
@   0x08022d6a: 9603        str	r6, [sp, #12]
@   0x08022d6c: 2284        movs	r2, #132	@ 0x84
@   0x08022d6e: 00d2        lsls	r2, r2, #3
@   0x08022d70: 2315        movs	r3, #21
@   0x08022d72: f7fe        f995 	bl	0x210a0
@   0x08022d76: 1c28        adds	r0, r5, #0
@   0x08022d78: 3022        adds	r0, #34	@ 0x22
@   0x08022d7a: 4916        ldr	r1, [pc, #88]	@ (0x22dd4)
@   0x08022d7c: 1861        adds	r1, r4, r1
@   0x08022d7e: 6809        ldr	r1, [r1, #0]
@   0x08022d80: 22b1        movs	r2, #177	@ 0xb1
@   0x08022d82: 9200        str	r2, [sp, #0]
@   0x08022d84: 9701        str	r7, [sp, #4]
@   0x08022d86: 9602        str	r6, [sp, #8]
@   0x08022d88: 9603        str	r6, [sp, #12]
@   0x08022d8a: 2280        movs	r2, #128	@ 0x80
@   0x08022d8c: 00d2        lsls	r2, r2, #3
@   0x08022d8e: 2316        movs	r3, #22
@   0x08022d90: f7fe        f986 	bl	0x210a0
@   0x08022d94: 1c28        adds	r0, r5, #0
@   0x08022d96: 302a        adds	r0, #42	@ 0x2a
@   0x08022d98: 490f        ldr	r1, [pc, #60]	@ (0x22dd8)
@   0x08022d9a: 1864        adds	r4, r4, r1
@   0x08022d9c: 6821        ldr	r1, [r4, #0]
@   0x08022d9e: 2200        movs	r2, #0
@   0x08022da0: 9200        str	r2, [sp, #0]
@   0x08022da2: 9201        str	r2, [sp, #4]
@   0x08022da4: 9602        str	r6, [sp, #8]
@   0x08022da6: 9603        str	r6, [sp, #12]
@   0x08022da8: 2280        movs	r2, #128	@ 0x80
@   0x08022daa: 01d2        lsls	r2, r2, #7
@   0x08022dac: 2301        movs	r3, #1
@   0x08022dae: f7fe        f977 	bl	0x210a0
@   0x08022db2: 1c68        adds	r0, r5, #1
@   0x08022db4: 0600        lsls	r0, r0, #24
@   0x08022db6: 0e05        lsrs	r5, r0, #24
@   0x08022db8: 2d07        cmp	r5, #7
@   0x08022dba: d9cc        bls.n	0x22d56
@   0x08022dbc: 201a        movs	r0, #26
@   0x08022dbe: f7e3        fb15 	bl	0x63ec
@   0x08022dc2: 2022        movs	r0, #34	@ 0x22
@   0x08022dc4: f7e3        fb12 	bl	0x63ec
@   0x08022dc8: b004        add	sp, #16
@   0x08022dca: bcf0        pop	{r4, r5, r6, r7}
@   0x08022dcc: bc01        pop	{r0}
@   0x08022dce: 4700        bx	r0
@   0x08022dd0: 17f0        asrs	r0, r6, #31
@   0x08022dd2: 0831        lsrs	r1, r6, #32
@   0x08022dd4: 1910        adds	r0, r2, r4
@   0x08022dd6: 0831        lsrs	r1, r6, #32
@   0x08022dd8: 1a30        subs	r0, r6, r0
@   0x08022dda: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022D4C
sub_08022D4C: @ 0x08022d4c
        .incbin "frog_us_baserom.gba", 0x22d4c, 0x90
        thumb_func_end sub_08022D4C
