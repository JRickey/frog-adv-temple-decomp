@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800b07c, 0x0800b178)  (252 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800b07c --end 0x800b178 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800b07c: b570        push	{r4, r5, r6, lr}
@   0x0800b07e: 1c06        adds	r6, r0, #0
@   0x0800b080: 24ff        movs	r4, #255	@ 0xff
@   0x0800b082: 4d3a        ldr	r5, [pc, #232]	@ (0xb16c)
@   0x0800b084: 1c28        adds	r0, r5, #0
@   0x0800b086: 2105        movs	r1, #5
@   0x0800b088: 2208        movs	r2, #8
@   0x0800b08a: f7fb        fb87 	bl	0x679c
@   0x0800b08e: 0600        lsls	r0, r0, #24
@   0x0800b090: 2800        cmp	r0, #0
@   0x0800b092: d00d        beq.n	0xb0b0
@   0x0800b094: 4836        ldr	r0, [pc, #216]	@ (0xb170)
@   0x0800b096: 21b7        movs	r1, #183	@ 0xb7
@   0x0800b098: 0109        lsls	r1, r1, #4
@   0x0800b09a: 1840        adds	r0, r0, r1
@   0x0800b09c: 2200        movs	r2, #0
@   0x0800b09e: 5e81        ldrsh	r1, [r0, r2]
@   0x0800b0a0: 4248        negs	r0, r1
@   0x0800b0a2: 4308        orrs	r0, r1
@   0x0800b0a4: 0fc4        lsrs	r4, r0, #31
@   0x0800b0a6: 1c28        adds	r0, r5, #0
@   0x0800b0a8: 2105        movs	r1, #5
@   0x0800b0aa: 2208        movs	r2, #8
@   0x0800b0ac: f7fb        fb0a 	bl	0x66c4
@   0x0800b0b0: 1c28        adds	r0, r5, #0
@   0x0800b0b2: 2105        movs	r1, #5
@   0x0800b0b4: 2209        movs	r2, #9
@   0x0800b0b6: f7fb        fb71 	bl	0x679c
@   0x0800b0ba: 0600        lsls	r0, r0, #24
@   0x0800b0bc: 2800        cmp	r0, #0
@   0x0800b0be: d00e        beq.n	0xb0de
@   0x0800b0c0: 482b        ldr	r0, [pc, #172]	@ (0xb170)
@   0x0800b0c2: 21b7        movs	r1, #183	@ 0xb7
@   0x0800b0c4: 0109        lsls	r1, r1, #4
@   0x0800b0c6: 1840        adds	r0, r0, r1
@   0x0800b0c8: 2200        movs	r2, #0
@   0x0800b0ca: 5e80        ldrsh	r0, [r0, r2]
@   0x0800b0cc: 2401        movs	r4, #1
@   0x0800b0ce: 2800        cmp	r0, #0
@   0x0800b0d0: d000        beq.n	0xb0d4
@   0x0800b0d2: 2402        movs	r4, #2
@   0x0800b0d4: 1c28        adds	r0, r5, #0
@   0x0800b0d6: 2105        movs	r1, #5
@   0x0800b0d8: 2209        movs	r2, #9
@   0x0800b0da: f7fb        faf3 	bl	0x66c4
@   0x0800b0de: 4d23        ldr	r5, [pc, #140]	@ (0xb16c)
@   0x0800b0e0: 1c28        adds	r0, r5, #0
@   0x0800b0e2: 2105        movs	r1, #5
@   0x0800b0e4: 220a        movs	r2, #10
@   0x0800b0e6: f7fb        fb59 	bl	0x679c
@   0x0800b0ea: 0600        lsls	r0, r0, #24
@   0x0800b0ec: 2800        cmp	r0, #0
@   0x0800b0ee: d00e        beq.n	0xb10e
@   0x0800b0f0: 481f        ldr	r0, [pc, #124]	@ (0xb170)
@   0x0800b0f2: 21b7        movs	r1, #183	@ 0xb7
@   0x0800b0f4: 0109        lsls	r1, r1, #4
@   0x0800b0f6: 1840        adds	r0, r0, r1
@   0x0800b0f8: 2200        movs	r2, #0
@   0x0800b0fa: 5e80        ldrsh	r0, [r0, r2]
@   0x0800b0fc: 2402        movs	r4, #2
@   0x0800b0fe: 2800        cmp	r0, #0
@   0x0800b100: d000        beq.n	0xb104
@   0x0800b102: 2403        movs	r4, #3
@   0x0800b104: 1c28        adds	r0, r5, #0
@   0x0800b106: 2105        movs	r1, #5
@   0x0800b108: 220a        movs	r2, #10
@   0x0800b10a: f7fb        fadb 	bl	0x66c4
@   0x0800b10e: 4d17        ldr	r5, [pc, #92]	@ (0xb16c)
@   0x0800b110: 1c28        adds	r0, r5, #0
@   0x0800b112: 2105        movs	r1, #5
@   0x0800b114: 220b        movs	r2, #11
@   0x0800b116: f7fb        fb41 	bl	0x679c
@   0x0800b11a: 0600        lsls	r0, r0, #24
@   0x0800b11c: 2800        cmp	r0, #0
@   0x0800b11e: d00e        beq.n	0xb13e
@   0x0800b120: 4813        ldr	r0, [pc, #76]	@ (0xb170)
@   0x0800b122: 21b7        movs	r1, #183	@ 0xb7
@   0x0800b124: 0109        lsls	r1, r1, #4
@   0x0800b126: 1840        adds	r0, r0, r1
@   0x0800b128: 2200        movs	r2, #0
@   0x0800b12a: 5e80        ldrsh	r0, [r0, r2]
@   0x0800b12c: 2403        movs	r4, #3
@   0x0800b12e: 2800        cmp	r0, #0
@   0x0800b130: d000        beq.n	0xb134
@   0x0800b132: 2400        movs	r4, #0
@   0x0800b134: 1c28        adds	r0, r5, #0
@   0x0800b136: 2105        movs	r1, #5
@   0x0800b138: 220b        movs	r2, #11
@   0x0800b13a: f7fb        fac3 	bl	0x66c4
@   0x0800b13e: 0620        lsls	r0, r4, #24
@   0x0800b140: 1601        asrs	r1, r0, #24
@   0x0800b142: 2001        movs	r0, #1
@   0x0800b144: 4240        negs	r0, r0
@   0x0800b146: 4281        cmp	r1, r0
@   0x0800b148: d00d        beq.n	0xb166
@   0x0800b14a: 00c8        lsls	r0, r1, #3
@   0x0800b14c: 1981        adds	r1, r0, r6
@   0x0800b14e: 7908        ldrb	r0, [r1, #4]
@   0x0800b150: 2800        cmp	r0, #0
@   0x0800b152: d108        bne.n	0xb166
@   0x0800b154: 7148        strb	r0, [r1, #5]
@   0x0800b156: 2001        movs	r0, #1
@   0x0800b158: 7108        strb	r0, [r1, #4]
@   0x0800b15a: 4806        ldr	r0, [pc, #24]	@ (0xb174)
@   0x0800b15c: 6800        ldr	r0, [r0, #0]
@   0x0800b15e: 6008        str	r0, [r1, #0]
@   0x0800b160: 206c        movs	r0, #108	@ 0x6c
@   0x0800b162: f015        fd89 	bl	0x20c78
@   0x0800b166: bc70        pop	{r4, r5, r6}
@   0x0800b168: bc01        pop	{r0}
@   0x0800b16a: 4700        bx	r0
@   0x0800b16c: 6110        str	r0, [r2, #16]
@   0x0800b16e: 0300        lsls	r0, r0, #12
@   0x0800b170: 3720        adds	r7, #32
@   0x0800b172: 0300        lsls	r0, r0, #12
@   0x0800b174: 5330        strh	r0, [r6, r4]
@   0x0800b176: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800B07C
sub_0800B07C: @ 0x0800b07c
        .incbin "frog_us_baserom.gba", 0xb07c, 0xfc
        thumb_func_end sub_0800B07C
