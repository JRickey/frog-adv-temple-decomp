@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a4a4, 0x0802a538)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a4a4 --end 0x802a538 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a4a4: b570        push	{r4, r5, r6, lr}
@   0x0802a4a6: b083        sub	sp, #12
@   0x0802a4a8: 4e12        ldr	r6, [pc, #72]	@ (0x2a4f4)
@   0x0802a4aa: 4d13        ldr	r5, [pc, #76]	@ (0x2a4f8)
@   0x0802a4ac: 4813        ldr	r0, [pc, #76]	@ (0x2a4fc)
@   0x0802a4ae: 182c        adds	r4, r5, r0
@   0x0802a4b0: 6830        ldr	r0, [r6, #0]
@   0x0802a4b2: 6821        ldr	r1, [r4, #0]
@   0x0802a4b4: 1a40        subs	r0, r0, r1
@   0x0802a4b6: 4912        ldr	r1, [pc, #72]	@ (0x2a500)
@   0x0802a4b8: 4288        cmp	r0, r1
@   0x0802a4ba: d903        bls.n	0x2a4c4
@   0x0802a4bc: f7ff        ffb6 	bl	0x2a42c
@   0x0802a4c0: 6830        ldr	r0, [r6, #0]
@   0x0802a4c2: 6020        str	r0, [r4, #0]
@   0x0802a4c4: 490f        ldr	r1, [pc, #60]	@ (0x2a504)
@   0x0802a4c6: 9801        ldr	r0, [sp, #4]
@   0x0802a4c8: 4008        ands	r0, r1
@   0x0802a4ca: 2101        movs	r1, #1
@   0x0802a4cc: 4308        orrs	r0, r1
@   0x0802a4ce: 9001        str	r0, [sp, #4]
@   0x0802a4d0: f7d6        fa16 	bl	0x900
@   0x0802a4d4: 22eb        movs	r2, #235	@ 0xeb
@   0x0802a4d6: 0092        lsls	r2, r2, #2
@   0x0802a4d8: 18a9        adds	r1, r5, r2
@   0x0802a4da: 6809        ldr	r1, [r1, #0]
@   0x0802a4dc: 1a40        subs	r0, r0, r1
@   0x0802a4de: 28ef        cmp	r0, #239	@ 0xef
@   0x0802a4e0: d814        bhi.n	0x2a50c
@   0x0802a4e2: 4b09        ldr	r3, [pc, #36]	@ (0x2a508)
@   0x0802a4e4: 2000        movs	r0, #0
@   0x0802a4e6: 9000        str	r0, [sp, #0]
@   0x0802a4e8: 2010        movs	r0, #16
@   0x0802a4ea: a901        add	r1, sp, #4
@   0x0802a4ec: 220c        movs	r2, #12
@   0x0802a4ee: f7f7        f80f 	bl	0x21510
@   0x0802a4f2: e01c        b.n	0x2a52e
@   0x0802a4f4: 5330        strh	r0, [r6, r4]
@   0x0802a4f6: 0300        lsls	r0, r0, #12
@   0x0802a4f8: 3720        adds	r7, #32
@   0x0802a4fa: 0300        lsls	r0, r0, #12
@   0x0802a4fc: 0b48        lsrs	r0, r1, #13
@   0x0802a4fe: 0000        movs	r0, r0
@   0x0802a500: 05dc        lsls	r4, r3, #23
@   0x0802a502: 0000        movs	r0, r0
@   0x0802a504: 0000        movs	r0, r0
@   0x0802a506: ffff        6110 	vsra.u32	d22, d0, #1
@   0x0802a50a: 0300        lsls	r0, r0, #12
@   0x0802a50c: 2200        movs	r2, #0
@   0x0802a50e: 1c2c        adds	r4, r5, #0
@   0x0802a510: 2308        movs	r3, #8
@   0x0802a512: 1c11        adds	r1, r2, #0
@   0x0802a514: 3110        adds	r1, #16
@   0x0802a516: 00c8        lsls	r0, r1, #3
@   0x0802a518: 1a40        subs	r0, r0, r1
@   0x0802a51a: 00c0        lsls	r0, r0, #3
@   0x0802a51c: 1900        adds	r0, r0, r4
@   0x0802a51e: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x0802a520: 4319        orrs	r1, r3
@   0x0802a522: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802a524: 1c50        adds	r0, r2, #1
@   0x0802a526: 0600        lsls	r0, r0, #24
@   0x0802a528: 0e02        lsrs	r2, r0, #24
@   0x0802a52a: 2a00        cmp	r2, #0
@   0x0802a52c: d0f1        beq.n	0x2a512
@   0x0802a52e: b003        add	sp, #12
@   0x0802a530: bc70        pop	{r4, r5, r6}
@   0x0802a532: bc01        pop	{r0}
@   0x0802a534: 4700        bx	r0

        thumb_func_start sub_0802A4A4
sub_0802A4A4: @ 0x0802a4a4
        .incbin "frog_us_baserom.gba", 0x2a4a4, 0x94
        thumb_func_end sub_0802A4A4
