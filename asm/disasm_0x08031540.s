@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08031540, 0x080315d8)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8031540 --end 0x80315d8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031540: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08031542: 1c04        adds	r4, r0, #0
@   0x08031544: 1c0d        adds	r5, r1, #0
@   0x08031546: 682f        ldr	r7, [r5, #0]
@   0x08031548: 2c03        cmp	r4, #3
@   0x0803154a: dd3c        ble.n	0x315c6
@   0x0803154c: 3c04        subs	r4, #4
@   0x0803154e: 4821        ldr	r0, [pc, #132]	@ (0x315d4)
@   0x08031550: 6800        ldr	r0, [r0, #0]
@   0x08031552: 4684        mov	ip, r0
@   0x08031554: 30c8        adds	r0, #200	@ 0xc8
@   0x08031556: 01a1        lsls	r1, r4, #6
@   0x08031558: 6800        ldr	r0, [r0, #0]
@   0x0803155a: 1842        adds	r2, r0, r1
@   0x0803155c: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0803155e: 2180        movs	r1, #128	@ 0x80
@   0x08031560: 00c9        lsls	r1, r1, #3
@   0x08031562: 4008        ands	r0, r1
@   0x08031564: 2800        cmp	r0, #0
@   0x08031566: d02e        beq.n	0x315c6
@   0x08031568: 1c16        adds	r6, r2, #0
@   0x0803156a: 362c        adds	r6, #44	@ 0x2c
@   0x0803156c: 4661        mov	r1, ip
@   0x0803156e: 31c0        adds	r1, #192	@ 0xc0
@   0x08031570: 00e0        lsls	r0, r4, #3
@   0x08031572: 1b00        subs	r0, r0, r4
@   0x08031574: 0080        lsls	r0, r0, #2
@   0x08031576: 6809        ldr	r1, [r1, #0]
@   0x08031578: 180b        adds	r3, r1, r0
@   0x0803157a: 4660        mov	r0, ip
@   0x0803157c: 30c4        adds	r0, #196	@ 0xc4
@   0x0803157e: 6801        ldr	r1, [r0, #0]
@   0x08031580: 00a0        lsls	r0, r4, #2
@   0x08031582: 1840        adds	r0, r0, r1
@   0x08031584: 2100        movs	r1, #0
@   0x08031586: 6001        str	r1, [r0, #0]
@   0x08031588: 2088        movs	r0, #136	@ 0x88
@   0x0803158a: 0040        lsls	r0, r0, #1
@   0x0803158c: 4460        add	r0, ip
@   0x0803158e: 6802        ldr	r2, [r0, #0]
@   0x08031590: 69d0        ldr	r0, [r2, #28]
@   0x08031592: 887f        ldrh	r7, [r7, #2]
@   0x08031594: 00b9        lsls	r1, r7, #2
@   0x08031596: 1810        adds	r0, r2, r0
@   0x08031598: 1809        adds	r1, r1, r0
@   0x0803159a: 6808        ldr	r0, [r1, #0]
@   0x0803159c: 1811        adds	r1, r2, r0
@   0x0803159e: 6808        ldr	r0, [r1, #0]
@   0x080315a0: 287f        cmp	r0, #127	@ 0x7f
@   0x080315a2: d910        bls.n	0x315c6
@   0x080315a4: 6019        str	r1, [r3, #0]
@   0x080315a6: 2004        movs	r0, #4
@   0x080315a8: 5630        ldrsb	r0, [r6, r0]
@   0x080315aa: 3010        adds	r0, #16
@   0x080315ac: 1808        adds	r0, r1, r0
@   0x080315ae: 60d8        str	r0, [r3, #12]
@   0x080315b0: 6058        str	r0, [r3, #4]
@   0x080315b2: 3040        adds	r0, #64	@ 0x40
@   0x080315b4: 6098        str	r0, [r3, #8]
@   0x080315b6: 2040        movs	r0, #64	@ 0x40
@   0x080315b8: 6118        str	r0, [r3, #16]
@   0x080315ba: 1c20        adds	r0, r4, #0
@   0x080315bc: f7fd        feec 	bl	0x2f398
@   0x080315c0: 1c20        adds	r0, r4, #0
@   0x080315c2: f7fe        fa4d 	bl	0x2fa60
@   0x080315c6: 6828        ldr	r0, [r5, #0]
@   0x080315c8: 3004        adds	r0, #4
@   0x080315ca: 6028        str	r0, [r5, #0]
@   0x080315cc: 2001        movs	r0, #1
@   0x080315ce: bcf0        pop	{r4, r5, r6, r7}
@   0x080315d0: bc02        pop	{r1}
@   0x080315d2: 4708        bx	r1
@   0x080315d4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080315d6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031540
sub_08031540: @ 0x08031540
        .incbin "baserom.gba", 0x31540, 0x98
        thumb_func_end sub_08031540
