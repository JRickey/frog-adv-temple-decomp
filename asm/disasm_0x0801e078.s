@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801e078, 0x0801e118)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801e078 --end 0x801e118 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801e078: b500        push	{lr}
@   0x0801e07a: 2180        movs	r1, #128	@ 0x80
@   0x0801e07c: 04c9        lsls	r1, r1, #19
@   0x0801e07e: 2280        movs	r2, #128	@ 0x80
@   0x0801e080: 0052        lsls	r2, r2, #1
@   0x0801e082: 1c10        adds	r0, r2, #0
@   0x0801e084: 8008        strh	r0, [r1, #0]
@   0x0801e086: 3108        adds	r1, #8
@   0x0801e088: 4a0f        ldr	r2, [pc, #60]	@ (0x1e0c8)
@   0x0801e08a: 1c10        adds	r0, r2, #0
@   0x0801e08c: 8008        strh	r0, [r1, #0]
@   0x0801e08e: 31cc        adds	r1, #204	@ 0xcc
@   0x0801e090: 480e        ldr	r0, [pc, #56]	@ (0x1e0cc)
@   0x0801e092: 6008        str	r0, [r1, #0]
@   0x0801e094: 20c0        movs	r0, #192	@ 0xc0
@   0x0801e096: 04c0        lsls	r0, r0, #19
@   0x0801e098: 6048        str	r0, [r1, #4]
@   0x0801e09a: 480d        ldr	r0, [pc, #52]	@ (0x1e0d0)
@   0x0801e09c: 6088        str	r0, [r1, #8]
@   0x0801e09e: 6888        ldr	r0, [r1, #8]
@   0x0801e0a0: 480c        ldr	r0, [pc, #48]	@ (0x1e0d4)
@   0x0801e0a2: 6008        str	r0, [r1, #0]
@   0x0801e0a4: 20a0        movs	r0, #160	@ 0xa0
@   0x0801e0a6: 04c0        lsls	r0, r0, #19
@   0x0801e0a8: 6048        str	r0, [r1, #4]
@   0x0801e0aa: 480b        ldr	r0, [pc, #44]	@ (0x1e0d8)
@   0x0801e0ac: 6088        str	r0, [r1, #8]
@   0x0801e0ae: 6888        ldr	r0, [r1, #8]
@   0x0801e0b0: 480a        ldr	r0, [pc, #40]	@ (0x1e0dc)
@   0x0801e0b2: 6008        str	r0, [r1, #0]
@   0x0801e0b4: 480a        ldr	r0, [pc, #40]	@ (0x1e0e0)
@   0x0801e0b6: 6048        str	r0, [r1, #4]
@   0x0801e0b8: 480a        ldr	r0, [pc, #40]	@ (0x1e0e4)
@   0x0801e0ba: 6088        str	r0, [r1, #8]
@   0x0801e0bc: 6888        ldr	r0, [r1, #8]
@   0x0801e0be: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e0c0: f7f2        fb14 	bl	0x106ec
@   0x0801e0c4: e013        b.n	0x1e0ee
@   0x0801e0c6: 0000        movs	r0, r0
@   0x0801e0c8: 1c83        adds	r3, r0, #2
@   0x0801e0ca: 0000        movs	r0, r0
@   0x0801e0cc: d778        bvc.n	0x1e1c0
@   0x0801e0ce: 0820        lsrs	r0, r4, #32
@   0x0801e0d0: 4000        ands	r0, r0
@   0x0801e0d2: 8000        strh	r0, [r0, #0]
@   0x0801e0d4: cd78        ldmia	r5, {r3, r4, r5, r6}
@   0x0801e0d6: 0820        lsrs	r0, r4, #32
@   0x0801e0d8: 0100        lsls	r0, r0, #4
@   0x0801e0da: 8000        strh	r0, [r0, #0]
@   0x0801e0dc: cf78        ldmia	r7!, {r3, r4, r5, r6}
@   0x0801e0de: 0820        lsrs	r0, r4, #32
@   0x0801e0e0: e000        b.n	0x1e0e4
@   0x0801e0e2: 0600        lsls	r0, r0, #24
@   0x0801e0e4: 0400        lsls	r0, r0, #16
@   0x0801e0e6: 8000        strh	r0, [r0, #0]
@   0x0801e0e8: 2002        movs	r0, #2
@   0x0801e0ea: f000        f8c1 	bl	0x1e270
@   0x0801e0ee: f7f2        fb0f 	bl	0x10710
@   0x0801e0f2: 2800        cmp	r0, #0
@   0x0801e0f4: d1f8        bne.n	0x1e0e8
@   0x0801e0f6: 20b4        movs	r0, #180	@ 0xb4
@   0x0801e0f8: 0040        lsls	r0, r0, #1
@   0x0801e0fa: f000        f8b9 	bl	0x1e270
@   0x0801e0fe: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e100: f7f2        fac8 	bl	0x10694
@   0x0801e104: e002        b.n	0x1e10c
@   0x0801e106: 2002        movs	r0, #2
@   0x0801e108: f000        f8b2 	bl	0x1e270
@   0x0801e10c: f7f2        fad4 	bl	0x106b8
@   0x0801e110: 2800        cmp	r0, #0
@   0x0801e112: d1f8        bne.n	0x1e106
@   0x0801e114: bc01        pop	{r0}
@   0x0801e116: 4700        bx	r0

        thumb_func_start sub_0801E078
sub_0801E078: @ 0x0801e078
        .incbin "frog_us_baserom.gba", 0x1e078, 0xa0
        thumb_func_end sub_0801E078
