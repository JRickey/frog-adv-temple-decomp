@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e528, 0x0802e5d8)  (176 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e528 --end 0x802e5d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e528: b500        push	{lr}
@   0x0802e52a: 0300        lsls	r0, r0, #12
@   0x0802e52c: 4904        ldr	r1, [pc, #16]	@ (0x2e540)
@   0x0802e52e: 6809        ldr	r1, [r1, #0]
@   0x0802e530: 8849        ldrh	r1, [r1, #2]
@   0x0802e532: f005        fcd7 	bl	0x33ee4
@   0x0802e536: 0940        lsrs	r0, r0, #5
@   0x0802e538: 3002        adds	r0, #2
@   0x0802e53a: bc02        pop	{r1}
@   0x0802e53c: 4708        bx	r1
@   0x0802e53e: 0000        movs	r0, r0
@   0x0802e540: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e542: 0300        lsls	r0, r0, #12
@   0x0802e544: 491d        ldr	r1, [pc, #116]	@ (0x2e5bc)
@   0x0802e546: 2080        movs	r0, #128	@ 0x80
@   0x0802e548: 8008        strh	r0, [r1, #0]
@   0x0802e54a: 3904        subs	r1, #4
@   0x0802e54c: 481c        ldr	r0, [pc, #112]	@ (0x2e5c0)
@   0x0802e54e: 6008        str	r0, [r1, #0]
@   0x0802e550: 3920        subs	r1, #32
@   0x0802e552: 2008        movs	r0, #8
@   0x0802e554: 8008        strh	r0, [r1, #0]
@   0x0802e556: 481b        ldr	r0, [pc, #108]	@ (0x2e5c4)
@   0x0802e558: 2200        movs	r2, #0
@   0x0802e55a: 8002        strh	r2, [r0, #0]
@   0x0802e55c: 3002        adds	r0, #2
@   0x0802e55e: 2380        movs	r3, #128	@ 0x80
@   0x0802e560: 021b        lsls	r3, r3, #8
@   0x0802e562: 1c19        adds	r1, r3, #0
@   0x0802e564: 8001        strh	r1, [r0, #0]
@   0x0802e566: 3004        adds	r0, #4
@   0x0802e568: 8002        strh	r2, [r0, #0]
@   0x0802e56a: 3004        adds	r0, #4
@   0x0802e56c: 8001        strh	r1, [r0, #0]
@   0x0802e56e: 4916        ldr	r1, [pc, #88]	@ (0x2e5c8)
@   0x0802e570: 2040        movs	r0, #64	@ 0x40
@   0x0802e572: 8008        strh	r0, [r1, #0]
@   0x0802e574: 3120        adds	r1, #32
@   0x0802e576: 2007        movs	r0, #7
@   0x0802e578: 800a        strh	r2, [r1, #0]
@   0x0802e57a: 3102        adds	r1, #2
@   0x0802e57c: 3801        subs	r0, #1
@   0x0802e57e: 2800        cmp	r0, #0
@   0x0802e580: dafa        bge.n	0x2e578
@   0x0802e582: 4911        ldr	r1, [pc, #68]	@ (0x2e5c8)
@   0x0802e584: 2000        movs	r0, #0
@   0x0802e586: 8008        strh	r0, [r1, #0]
@   0x0802e588: 3120        adds	r1, #32
@   0x0802e58a: 2200        movs	r2, #0
@   0x0802e58c: 2007        movs	r0, #7
@   0x0802e58e: 800a        strh	r2, [r1, #0]
@   0x0802e590: 3102        adds	r1, #2
@   0x0802e592: 3801        subs	r0, #1
@   0x0802e594: 2800        cmp	r0, #0
@   0x0802e596: dafa        bge.n	0x2e58e
@   0x0802e598: 480c        ldr	r0, [pc, #48]	@ (0x2e5cc)
@   0x0802e59a: 2100        movs	r1, #0
@   0x0802e59c: 8001        strh	r1, [r0, #0]
@   0x0802e59e: 3002        adds	r0, #2
@   0x0802e5a0: 2380        movs	r3, #128	@ 0x80
@   0x0802e5a2: 021b        lsls	r3, r3, #8
@   0x0802e5a4: 1c1a        adds	r2, r3, #0
@   0x0802e5a6: 8002        strh	r2, [r0, #0]
@   0x0802e5a8: 8001        strh	r1, [r0, #0]
@   0x0802e5aa: 3004        adds	r0, #4
@   0x0802e5ac: 8001        strh	r1, [r0, #0]
@   0x0802e5ae: 3004        adds	r0, #4
@   0x0802e5b0: 8002        strh	r2, [r0, #0]
@   0x0802e5b2: 4907        ldr	r1, [pc, #28]	@ (0x2e5d0)
@   0x0802e5b4: 4a07        ldr	r2, [pc, #28]	@ (0x2e5d4)
@   0x0802e5b6: 1c10        adds	r0, r2, #0
@   0x0802e5b8: 8008        strh	r0, [r1, #0]
@   0x0802e5ba: 4770        bx	lr
@   0x0802e5bc: 0084        lsls	r4, r0, #2
@   0x0802e5be: 0400        lsls	r0, r0, #16
@   0x0802e5c0: 0000        movs	r0, r0
@   0x0802e5c2: 9a0d        ldr	r2, [sp, #52]	@ 0x34
@   0x0802e5c4: 0062        lsls	r2, r4, #1
@   0x0802e5c6: 0400        lsls	r0, r0, #16
@   0x0802e5c8: 0070        lsls	r0, r6, #1
@   0x0802e5ca: 0400        lsls	r0, r0, #16
@   0x0802e5cc: 0072        lsls	r2, r6, #1
@   0x0802e5ce: 0400        lsls	r0, r0, #16
@   0x0802e5d0: 0080        lsls	r0, r0, #2
@   0x0802e5d2: 0400        lsls	r0, r0, #16
@   0x0802e5d4: ff77        0000 	vhadd.u<illegal width 64>	d16, d7, d0

        thumb_func_start sub_0802E528
sub_0802E528: @ 0x0802e528
        .incbin "frog_us_baserom.gba", 0x2e528, 0xb0
        thumb_func_end sub_0802E528
