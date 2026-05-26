@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800f24c, 0x0800f2f8)  (172 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800f24c --end 0x800f2f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800f24c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800f24e: 464f        mov	r7, r9
@   0x0800f250: 4646        mov	r6, r8
@   0x0800f252: b4c0        push	{r6, r7}
@   0x0800f254: 0600        lsls	r0, r0, #24
@   0x0800f256: 0e00        lsrs	r0, r0, #24
@   0x0800f258: 4680        mov	r8, r0
@   0x0800f25a: 4824        ldr	r0, [pc, #144]	@ (0xf2ec)
@   0x0800f25c: 7a80        ldrb	r0, [r0, #10]
@   0x0800f25e: 2806        cmp	r0, #6
@   0x0800f260: d03d        beq.n	0xf2de
@   0x0800f262: 2700        movs	r7, #0
@   0x0800f264: 4547        cmp	r7, r8
@   0x0800f266: d23a        bcs.n	0xf2de
@   0x0800f268: 4821        ldr	r0, [pc, #132]	@ (0xf2f0)
@   0x0800f26a: 4684        mov	ip, r0
@   0x0800f26c: 4e21        ldr	r6, [pc, #132]	@ (0xf2f4)
@   0x0800f26e: 2100        movs	r1, #0
@   0x0800f270: 4689        mov	r9, r1
@   0x0800f272: 017a        lsls	r2, r7, #5
@   0x0800f274: 4660        mov	r0, ip
@   0x0800f276: 300c        adds	r0, #12
@   0x0800f278: 1814        adds	r4, r2, r0
@   0x0800f27a: 2102        movs	r1, #2
@   0x0800f27c: 5e70        ldrsh	r0, [r6, r1]
@   0x0800f27e: 3878        subs	r0, #120	@ 0x78
@   0x0800f280: 6020        str	r0, [r4, #0]
@   0x0800f282: 4660        mov	r0, ip
@   0x0800f284: 3010        adds	r0, #16
@   0x0800f286: 1815        adds	r5, r2, r0
@   0x0800f288: 2104        movs	r1, #4
@   0x0800f28a: 5e70        ldrsh	r0, [r6, r1]
@   0x0800f28c: 3850        subs	r0, #80	@ 0x50
@   0x0800f28e: 6028        str	r0, [r5, #0]
@   0x0800f290: 2102        movs	r1, #2
@   0x0800f292: 5e70        ldrsh	r0, [r6, r1]
@   0x0800f294: 2877        cmp	r0, #119	@ 0x77
@   0x0800f296: dc01        bgt.n	0xf29c
@   0x0800f298: 4648        mov	r0, r9
@   0x0800f29a: 6020        str	r0, [r4, #0]
@   0x0800f29c: 2104        movs	r1, #4
@   0x0800f29e: 5e70        ldrsh	r0, [r6, r1]
@   0x0800f2a0: 284f        cmp	r0, #79	@ 0x4f
@   0x0800f2a2: dc01        bgt.n	0xf2a8
@   0x0800f2a4: 4648        mov	r0, r9
@   0x0800f2a6: 6028        str	r0, [r5, #0]
@   0x0800f2a8: 2002        movs	r0, #2
@   0x0800f2aa: 5e31        ldrsh	r1, [r6, r0]
@   0x0800f2ac: 4660        mov	r0, ip
@   0x0800f2ae: 1813        adds	r3, r2, r0
@   0x0800f2b0: 8b58        ldrh	r0, [r3, #26]
@   0x0800f2b2: 00c2        lsls	r2, r0, #3
@   0x0800f2b4: 1c10        adds	r0, r2, #0
@   0x0800f2b6: 3878        subs	r0, #120	@ 0x78
@   0x0800f2b8: 4281        cmp	r1, r0
@   0x0800f2ba: dd01        ble.n	0xf2c0
@   0x0800f2bc: 3878        subs	r0, #120	@ 0x78
@   0x0800f2be: 6020        str	r0, [r4, #0]
@   0x0800f2c0: 2004        movs	r0, #4
@   0x0800f2c2: 5e31        ldrsh	r1, [r6, r0]
@   0x0800f2c4: 8b1b        ldrh	r3, [r3, #24]
@   0x0800f2c6: 00da        lsls	r2, r3, #3
@   0x0800f2c8: 1c10        adds	r0, r2, #0
@   0x0800f2ca: 3850        subs	r0, #80	@ 0x50
@   0x0800f2cc: 4281        cmp	r1, r0
@   0x0800f2ce: dd01        ble.n	0xf2d4
@   0x0800f2d0: 3850        subs	r0, #80	@ 0x50
@   0x0800f2d2: 6028        str	r0, [r5, #0]
@   0x0800f2d4: 1c78        adds	r0, r7, #1
@   0x0800f2d6: 0600        lsls	r0, r0, #24
@   0x0800f2d8: 0e07        lsrs	r7, r0, #24
@   0x0800f2da: 4547        cmp	r7, r8
@   0x0800f2dc: d3c9        bcc.n	0xf272
@   0x0800f2de: bc18        pop	{r3, r4}
@   0x0800f2e0: 4698        mov	r8, r3
@   0x0800f2e2: 46a1        mov	r9, r4
@   0x0800f2e4: bcf0        pop	{r4, r5, r6, r7}
@   0x0800f2e6: bc01        pop	{r0}
@   0x0800f2e8: 4700        bx	r0
@   0x0800f2ea: 0000        movs	r0, r0
@   0x0800f2ec: 5330        strh	r0, [r6, r4]
@   0x0800f2ee: 0300        lsls	r0, r0, #12
@   0x0800f2f0: 60a0        str	r0, [r4, #8]
@   0x0800f2f2: 0300        lsls	r0, r0, #12
@   0x0800f2f4: 3720        adds	r7, #32
@   0x0800f2f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800F24C
sub_0800F24C: @ 0x0800f24c
        .incbin "frog_us_baserom.gba", 0xf24c, 0xac
        thumb_func_end sub_0800F24C
