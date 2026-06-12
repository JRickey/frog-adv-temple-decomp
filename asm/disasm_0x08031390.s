@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08031390, 0x080313fc)  (108 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8031390 --end 0x80313fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031390: b530        push	{r4, r5, lr}
@   0x08031392: 1c02        adds	r2, r0, #0
@   0x08031394: 1c0d        adds	r5, r1, #0
@   0x08031396: 682c        ldr	r4, [r5, #0]
@   0x08031398: 2a03        cmp	r2, #3
@   0x0803139a: dd27        ble.n	0x313ec
@   0x0803139c: 2104        movs	r1, #4
@   0x0803139e: 5e60        ldrsh	r0, [r4, r1]
@   0x080313a0: 2800        cmp	r0, #0
@   0x080313a2: d023        beq.n	0x313ec
@   0x080313a4: 3a04        subs	r2, #4
@   0x080313a6: 4807        ldr	r0, [pc, #28]	@ (0x313c4)
@   0x080313a8: 6800        ldr	r0, [r0, #0]
@   0x080313aa: 30c8        adds	r0, #200	@ 0xc8
@   0x080313ac: 0191        lsls	r1, r2, #6
@   0x080313ae: 6800        ldr	r0, [r0, #0]
@   0x080313b0: 1843        adds	r3, r0, r1
@   0x080313b2: 1c19        adds	r1, r3, #0
@   0x080313b4: 1c1a        adds	r2, r3, #0
@   0x080313b6: 323c        adds	r2, #60	@ 0x3c
@   0x080313b8: 7810        ldrb	r0, [r2, #0]
@   0x080313ba: 28ff        cmp	r0, #255	@ 0xff
@   0x080313bc: d004        beq.n	0x313c8
@   0x080313be: 7812        ldrb	r2, [r2, #0]
@   0x080313c0: 0210        lsls	r0, r2, #8
@   0x080313c2: e004        b.n	0x313ce
@   0x080313c4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080313c6: 0300        lsls	r0, r0, #12
@   0x080313c8: 2280        movs	r2, #128	@ 0x80
@   0x080313ca: 01d2        lsls	r2, r2, #7
@   0x080313cc: 1c10        adds	r0, r2, #0
@   0x080313ce: 8148        strh	r0, [r1, #10]
@   0x080313d0: 88a0        ldrh	r0, [r4, #4]
@   0x080313d2: 8248        strh	r0, [r1, #18]
@   0x080313d4: 78a0        ldrb	r0, [r4, #2]
@   0x080313d6: 7688        strb	r0, [r1, #26]
@   0x080313d8: 78e0        ldrb	r0, [r4, #3]
@   0x080313da: 76c8        strb	r0, [r1, #27]
@   0x080313dc: 7860        ldrb	r0, [r4, #1]
@   0x080313de: 2800        cmp	r0, #0
@   0x080313e0: d004        beq.n	0x313ec
@   0x080313e2: 6b98        ldr	r0, [r3, #56]	@ 0x38
@   0x080313e4: 2180        movs	r1, #128	@ 0x80
@   0x080313e6: 0189        lsls	r1, r1, #6
@   0x080313e8: 4308        orrs	r0, r1
@   0x080313ea: 6398        str	r0, [r3, #56]	@ 0x38
@   0x080313ec: 6828        ldr	r0, [r5, #0]
@   0x080313ee: 3006        adds	r0, #6
@   0x080313f0: 6028        str	r0, [r5, #0]
@   0x080313f2: 2001        movs	r0, #1
@   0x080313f4: bc30        pop	{r4, r5}
@   0x080313f6: bc02        pop	{r1}
@   0x080313f8: 4708        bx	r1

        thumb_func_start sub_08031390
sub_08031390: @ 0x08031390
        .incbin "baserom.gba", 0x31390, 0x6c
        thumb_func_end sub_08031390
