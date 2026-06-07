@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e544, 0x0802e5d8)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e544 --end 0x802e5d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_0802E544
sub_0802E544: @ 0x0802e544
        .incbin "frog_us_baserom.gba", 0x2e544, 0x94
        thumb_func_end sub_0802E544
