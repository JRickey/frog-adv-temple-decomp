@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802877c, 0x08028858)  (220 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802877c --end 0x8028858 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802877c: b570        push	{r4, r5, r6, lr}
@   0x0802877e: 4d0c        ldr	r5, [pc, #48]	@ (0x287b0)
@   0x08028780: 480c        ldr	r0, [pc, #48]	@ (0x287b4)
@   0x08028782: 182e        adds	r6, r5, r0
@   0x08028784: 8832        ldrh	r2, [r6, #0]
@   0x08028786: 2480        movs	r4, #128	@ 0x80
@   0x08028788: 00a4        lsls	r4, r4, #2
@   0x0802878a: 1c20        adds	r0, r4, #0
@   0x0802878c: 4010        ands	r0, r2
@   0x0802878e: 2800        cmp	r0, #0
@   0x08028790: d116        bne.n	0x287c0
@   0x08028792: 4809        ldr	r0, [pc, #36]	@ (0x287b8)
@   0x08028794: 2103        movs	r1, #3
@   0x08028796: 2200        movs	r2, #0
@   0x08028798: f7de        f800 	bl	0x679c
@   0x0802879c: 0600        lsls	r0, r0, #24
@   0x0802879e: 2800        cmp	r0, #0
@   0x080287a0: d027        beq.n	0x287f2
@   0x080287a2: 4806        ldr	r0, [pc, #24]	@ (0x287bc)
@   0x080287a4: 1829        adds	r1, r5, r0
@   0x080287a6: 2003        movs	r0, #3
@   0x080287a8: 7008        strb	r0, [r1, #0]
@   0x080287aa: 1c20        adds	r0, r4, #0
@   0x080287ac: e01e        b.n	0x287ec
@   0x080287ae: 0000        movs	r0, r0
@   0x080287b0: 3720        adds	r7, #32
@   0x080287b2: 0300        lsls	r0, r0, #12
@   0x080287b4: 13ac        asrs	r4, r5, #14
@   0x080287b6: 0000        movs	r0, r0
@   0x080287b8: 6110        str	r0, [r2, #16]
@   0x080287ba: 0300        lsls	r0, r0, #12
@   0x080287bc: 1392        asrs	r2, r2, #14
@   0x080287be: 0000        movs	r0, r0
@   0x080287c0: 480e        ldr	r0, [pc, #56]	@ (0x287fc)
@   0x080287c2: 182b        adds	r3, r5, r0
@   0x080287c4: 7819        ldrb	r1, [r3, #0]
@   0x080287c6: 2905        cmp	r1, #5
@   0x080287c8: d11e        bne.n	0x28808
@   0x080287ca: 2080        movs	r0, #128	@ 0x80
@   0x080287cc: 0200        lsls	r0, r0, #8
@   0x080287ce: 4010        ands	r0, r2
@   0x080287d0: 2800        cmp	r0, #0
@   0x080287d2: d00e        beq.n	0x287f2
@   0x080287d4: 4c0a        ldr	r4, [pc, #40]	@ (0x28800)
@   0x080287d6: 1c20        adds	r0, r4, #0
@   0x080287d8: 2103        movs	r1, #3
@   0x080287da: 2201        movs	r2, #1
@   0x080287dc: f7dd        ff10 	bl	0x6600
@   0x080287e0: 1c20        adds	r0, r4, #0
@   0x080287e2: 2103        movs	r1, #3
@   0x080287e4: 2202        movs	r2, #2
@   0x080287e6: f7dd        ff0b 	bl	0x6600
@   0x080287ea: 2008        movs	r0, #8
@   0x080287ec: 8831        ldrh	r1, [r6, #0]
@   0x080287ee: 4308        orrs	r0, r1
@   0x080287f0: 8030        strh	r0, [r6, #0]
@   0x080287f2: 4904        ldr	r1, [pc, #16]	@ (0x28804)
@   0x080287f4: 1868        adds	r0, r5, r1
@   0x080287f6: f7dd        f8e5 	bl	0x59c4
@   0x080287fa: e027        b.n	0x2884c
@   0x080287fc: 1392        asrs	r2, r2, #14
@   0x080287fe: 0000        movs	r0, r0
@   0x08028800: 6110        str	r0, [r2, #16]
@   0x08028802: 0300        lsls	r0, r0, #12
@   0x08028804: 1378        asrs	r0, r7, #13
@   0x08028806: 0000        movs	r0, r0
@   0x08028808: 480a        ldr	r0, [pc, #40]	@ (0x28834)
@   0x0802880a: 1829        adds	r1, r5, r0
@   0x0802880c: 20de        movs	r0, #222	@ 0xde
@   0x0802880e: 0080        lsls	r0, r0, #2
@   0x08028810: 8809        ldrh	r1, [r1, #0]
@   0x08028812: 4281        cmp	r1, r0
@   0x08028814: d112        bne.n	0x2883c
@   0x08028816: 4908        ldr	r1, [pc, #32]	@ (0x28838)
@   0x08028818: 1868        adds	r0, r5, r1
@   0x0802881a: 2100        movs	r1, #0
@   0x0802881c: 5e40        ldrsh	r0, [r0, r1]
@   0x0802881e: 28c0        cmp	r0, #192	@ 0xc0
@   0x08028820: dd0c        ble.n	0x2883c
@   0x08028822: 2005        movs	r0, #5
@   0x08028824: 7018        strb	r0, [r3, #0]
@   0x08028826: 2002        movs	r0, #2
@   0x08028828: 4310        orrs	r0, r2
@   0x0802882a: 8030        strh	r0, [r6, #0]
@   0x0802882c: 2008        movs	r0, #8
@   0x0802882e: f7f8        fb25 	bl	0x20e7c
@   0x08028832: e00b        b.n	0x2884c
@   0x08028834: 137c        asrs	r4, r7, #13
@   0x08028836: 0000        movs	r0, r0
@   0x08028838: 137a        asrs	r2, r7, #13
@   0x0802883a: 0000        movs	r0, r0
@   0x0802883c: 4805        ldr	r0, [pc, #20]	@ (0x28854)
@   0x0802883e: 6800        ldr	r0, [r0, #0]
@   0x08028840: 2159        movs	r1, #89	@ 0x59
@   0x08028842: f7f9        fb53 	bl	0x21eec
@   0x08028846: 2008        movs	r0, #8
@   0x08028848: f7f8        fabc 	bl	0x20dc4
@   0x0802884c: bc70        pop	{r4, r5, r6}
@   0x0802884e: bc01        pop	{r0}
@   0x08028850: 4700        bx	r0
@   0x08028852: 0000        movs	r0, r0
@   0x08028854: 7af8        ldrb	r0, [r7, #11]
@   0x08028856: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802877C
sub_0802877C: @ 0x0802877c
        .incbin "baserom.gba", 0x2877c, 0xdc
        thumb_func_end sub_0802877C
