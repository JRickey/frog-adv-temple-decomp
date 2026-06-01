@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013d44, 0x08013dfc)  (184 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013d44 --end 0x8013dfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013d44: b530        push	{r4, r5, lr}
@   0x08013d46: b082        sub	sp, #8
@   0x08013d48: 481b        ldr	r0, [pc, #108]	@ (0x13db8)
@   0x08013d4a: 1c03        adds	r3, r0, #0
@   0x08013d4c: 3340        adds	r3, #64	@ 0x40
@   0x08013d4e: 781a        ldrb	r2, [r3, #0]
@   0x08013d50: 2401        movs	r4, #1
@   0x08013d52: 1c20        adds	r0, r4, #0
@   0x08013d54: 4010        ands	r0, r2
@   0x08013d56: 2800        cmp	r0, #0
@   0x08013d58: d00d        beq.n	0x13d76
@   0x08013d5a: 4918        ldr	r1, [pc, #96]	@ (0x13dbc)
@   0x08013d5c: 4d18        ldr	r5, [pc, #96]	@ (0x13dc0)
@   0x08013d5e: 1c28        adds	r0, r5, #0
@   0x08013d60: 8008        strh	r0, [r1, #0]
@   0x08013d62: 3102        adds	r1, #2
@   0x08013d64: 4d17        ldr	r5, [pc, #92]	@ (0x13dc4)
@   0x08013d66: 1c28        adds	r0, r5, #0
@   0x08013d68: 8008        strh	r0, [r1, #0]
@   0x08013d6a: 20fe        movs	r0, #254	@ 0xfe
@   0x08013d6c: 4010        ands	r0, r2
@   0x08013d6e: 7018        strb	r0, [r3, #0]
@   0x08013d70: 2002        movs	r0, #2
@   0x08013d72: f7fb        f88f 	bl	0xee94
@   0x08013d76: 4914        ldr	r1, [pc, #80]	@ (0x13dc8)
@   0x08013d78: 1c20        adds	r0, r4, #0
@   0x08013d7a: 8cca        ldrh	r2, [r1, #38]	@ 0x26
@   0x08013d7c: 4010        ands	r0, r2
@   0x08013d7e: 2800        cmp	r0, #0
@   0x08013d80: d004        beq.n	0x13d8c
@   0x08013d82: 312a        adds	r1, #42	@ 0x2a
@   0x08013d84: 2001        movs	r0, #1
@   0x08013d86: 780d        ldrb	r5, [r1, #0]
@   0x08013d88: 4328        orrs	r0, r5
@   0x08013d8a: 7008        strb	r0, [r1, #0]
@   0x08013d8c: 2001        movs	r0, #1
@   0x08013d8e: 2101        movs	r1, #1
@   0x08013d90: f7fc        fe58 	bl	0x10a44
@   0x08013d94: f003        f934 	bl	0x17000
@   0x08013d98: 4b0c        ldr	r3, [pc, #48]	@ (0x13dcc)
@   0x08013d9a: 7898        ldrb	r0, [r3, #2]
@   0x08013d9c: 9000        str	r0, [sp, #0]
@   0x08013d9e: 480c        ldr	r0, [pc, #48]	@ (0x13dd0)
@   0x08013da0: 9001        str	r0, [sp, #4]
@   0x08013da2: 6818        ldr	r0, [r3, #0]
@   0x08013da4: 6859        ldr	r1, [r3, #4]
@   0x08013da6: 689a        ldr	r2, [r3, #8]
@   0x08013da8: 68db        ldr	r3, [r3, #12]
@   0x08013daa: f7ff        ff59 	bl	0x13c60
@   0x08013dae: b002        add	sp, #8
@   0x08013db0: bc30        pop	{r4, r5}
@   0x08013db2: bc01        pop	{r0}
@   0x08013db4: 4700        bx	r0
@   0x08013db6: 0000        movs	r0, r0
@   0x08013db8: 60a0        str	r0, [r4, #8]
@   0x08013dba: 0300        lsls	r0, r0, #12
@   0x08013dbc: 0050        lsls	r0, r2, #1
@   0x08013dbe: 0400        lsls	r0, r0, #16
@   0x08013dc0: 1744        asrs	r4, r0, #29
@   0x08013dc2: 0000        movs	r0, r0
@   0x08013dc4: 0c04        lsrs	r4, r0, #16
@   0x08013dc6: 0000        movs	r0, r0
@   0x08013dc8: 6110        str	r0, [r2, #16]
@   0x08013dca: 0300        lsls	r0, r0, #12
@   0x08013dcc: 7238        strb	r0, [r7, #8]
@   0x08013dce: 0830        lsrs	r0, r6, #32
@   0x08013dd0: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x08013dd2: 0300        lsls	r0, r0, #12
@   0x08013dd4: b500        push	{lr}
@   0x08013dd6: 2002        movs	r0, #2
@   0x08013dd8: f7fa        fd40 	bl	0xe85c
@   0x08013ddc: f7fa        fe9e 	bl	0xeb1c
@   0x08013de0: 2001        movs	r0, #1
@   0x08013de2: 2101        movs	r1, #1
@   0x08013de4: f7fc        fdb8 	bl	0x10958
@   0x08013de8: 2002        movs	r0, #2
@   0x08013dea: f7fb        fa2f 	bl	0xf24c
@   0x08013dee: 2002        movs	r0, #2
@   0x08013df0: f7fa        fef4 	bl	0xebdc
@   0x08013df4: f002        fe24 	bl	0x16a40
@   0x08013df8: bc01        pop	{r0}
@   0x08013dfa: 4700        bx	r0

        thumb_func_start sub_08013D44
sub_08013D44: @ 0x08013d44
        .incbin "frog_us_baserom.gba", 0x13d44, 0xb8
        thumb_func_end sub_08013D44
