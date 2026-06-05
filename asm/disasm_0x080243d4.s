@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080243d4, 0x08024444)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80243d4 --end 0x8024444 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080243d4: b510        push	{r4, lr}
@   0x080243d6: b083        sub	sp, #12
@   0x080243d8: 490d        ldr	r1, [pc, #52]	@ (0x24410)
@   0x080243da: 480e        ldr	r0, [pc, #56]	@ (0x24414)
@   0x080243dc: 9000        str	r0, [sp, #0]
@   0x080243de: 200c        movs	r0, #12
@   0x080243e0: 9001        str	r0, [sp, #4]
@   0x080243e2: 2000        movs	r0, #0
@   0x080243e4: 9002        str	r0, [sp, #8]
@   0x080243e6: 2071        movs	r0, #113	@ 0x71
@   0x080243e8: 2200        movs	r2, #0
@   0x080243ea: 231f        movs	r3, #31
@   0x080243ec: f7fc        fea8 	bl	0x21140
@   0x080243f0: 2200        movs	r2, #0
@   0x080243f2: 4b09        ldr	r3, [pc, #36]	@ (0x24418)
@   0x080243f4: 4c09        ldr	r4, [pc, #36]	@ (0x2441c)
@   0x080243f6: 2005        movs	r0, #5
@   0x080243f8: 5620        ldrsb	r0, [r4, r0]
@   0x080243fa: 2801        cmp	r0, #1
@   0x080243fc: dd10        ble.n	0x24420
@   0x080243fe: 1c10        adds	r0, r2, #0
@   0x08024400: 3071        adds	r0, #113	@ 0x71
@   0x08024402: 00c1        lsls	r1, r0, #3
@   0x08024404: 1a09        subs	r1, r1, r0
@   0x08024406: 00c9        lsls	r1, r1, #3
@   0x08024408: 18c9        adds	r1, r1, r3
@   0x0802440a: 2003        movs	r0, #3
@   0x0802440c: e00f        b.n	0x2442e
@   0x0802440e: 0000        movs	r0, r0
@   0x08024410: 21f0        movs	r1, #240	@ 0xf0
@   0x08024412: 0831        lsrs	r1, r6, #32
@   0x08024414: 02e1        lsls	r1, r4, #11
@   0x08024416: 0000        movs	r0, r0
@   0x08024418: 3720        adds	r7, #32
@   0x0802441a: 0300        lsls	r0, r0, #12
@   0x0802441c: 35e0        adds	r5, #224	@ 0xe0
@   0x0802441e: 0300        lsls	r0, r0, #12
@   0x08024420: 1c10        adds	r0, r2, #0
@   0x08024422: 3071        adds	r0, #113	@ 0x71
@   0x08024424: 00c1        lsls	r1, r0, #3
@   0x08024426: 1a09        subs	r1, r1, r0
@   0x08024428: 00c9        lsls	r1, r1, #3
@   0x0802442a: 18c9        adds	r1, r1, r3
@   0x0802442c: 2000        movs	r0, #0
@   0x0802442e: 7688        strb	r0, [r1, #26]
@   0x08024430: 1c50        adds	r0, r2, #1
@   0x08024432: 0600        lsls	r0, r0, #24
@   0x08024434: 0e02        lsrs	r2, r0, #24
@   0x08024436: 2a02        cmp	r2, #2
@   0x08024438: d9dd        bls.n	0x243f6
@   0x0802443a: b003        add	sp, #12
@   0x0802443c: bc10        pop	{r4}
@   0x0802443e: bc01        pop	{r0}
@   0x08024440: 4700        bx	r0

        thumb_func_start sub_080243D4
sub_080243D4: @ 0x080243d4
        .incbin "frog_us_baserom.gba", 0x243d4, 0x70
        thumb_func_end sub_080243D4
