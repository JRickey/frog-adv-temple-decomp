@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080314ac, 0x08031540)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80314ac --end 0x8031540 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080314ac: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080314ae: 1c03        adds	r3, r0, #0
@   0x080314b0: 1c0e        adds	r6, r1, #0
@   0x080314b2: 6835        ldr	r5, [r6, #0]
@   0x080314b4: 2b03        cmp	r3, #3
@   0x080314b6: dd3b        ble.n	0x31530
@   0x080314b8: 3b04        subs	r3, #4
@   0x080314ba: 4a0e        ldr	r2, [pc, #56]	@ (0x314f4)
@   0x080314bc: 6814        ldr	r4, [r2, #0]
@   0x080314be: 1c20        adds	r0, r4, #0
@   0x080314c0: 30c8        adds	r0, #200	@ 0xc8
@   0x080314c2: 0199        lsls	r1, r3, #6
@   0x080314c4: 6800        ldr	r0, [r0, #0]
@   0x080314c6: 1840        adds	r0, r0, r1
@   0x080314c8: 6b81        ldr	r1, [r0, #56]	@ 0x38
@   0x080314ca: 20a0        movs	r0, #160	@ 0xa0
@   0x080314cc: 0140        lsls	r0, r0, #5
@   0x080314ce: 4001        ands	r1, r0
@   0x080314d0: 2080        movs	r0, #128	@ 0x80
@   0x080314d2: 0140        lsls	r0, r0, #5
@   0x080314d4: 1c17        adds	r7, r2, #0
@   0x080314d6: 4281        cmp	r1, r0
@   0x080314d8: d12a        bne.n	0x31530
@   0x080314da: 7868        ldrb	r0, [r5, #1]
@   0x080314dc: 2800        cmp	r0, #0
@   0x080314de: d10b        bne.n	0x314f8
@   0x080314e0: 1c20        adds	r0, r4, #0
@   0x080314e2: 30cc        adds	r0, #204	@ 0xcc
@   0x080314e4: 6801        ldr	r1, [r0, #0]
@   0x080314e6: 0098        lsls	r0, r3, #2
@   0x080314e8: 1840        adds	r0, r0, r1
@   0x080314ea: 6802        ldr	r2, [r0, #0]
@   0x080314ec: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x080314ee: 2180        movs	r1, #128	@ 0x80
@   0x080314f0: 0109        lsls	r1, r1, #4
@   0x080314f2: e00a        b.n	0x3150a
@   0x080314f4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080314f6: 0300        lsls	r0, r0, #12
@   0x080314f8: 1c20        adds	r0, r4, #0
@   0x080314fa: 30cc        adds	r0, #204	@ 0xcc
@   0x080314fc: 6801        ldr	r1, [r0, #0]
@   0x080314fe: 0098        lsls	r0, r3, #2
@   0x08031500: 1840        adds	r0, r0, r1
@   0x08031502: 6802        ldr	r2, [r0, #0]
@   0x08031504: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x08031506: 2190        movs	r1, #144	@ 0x90
@   0x08031508: 01c9        lsls	r1, r1, #7
@   0x0803150a: 4308        orrs	r0, r1
@   0x0803150c: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0803150e: 6838        ldr	r0, [r7, #0]
@   0x08031510: 30c8        adds	r0, #200	@ 0xc8
@   0x08031512: 0199        lsls	r1, r3, #6
@   0x08031514: 6802        ldr	r2, [r0, #0]
@   0x08031516: 1852        adds	r2, r2, r1
@   0x08031518: 1c11        adds	r1, r2, #0
@   0x0803151a: 312c        adds	r1, #44	@ 0x2c
@   0x0803151c: 88a8        ldrh	r0, [r5, #4]
@   0x0803151e: 8088        strh	r0, [r1, #4]
@   0x08031520: 88a8        ldrh	r0, [r5, #4]
@   0x08031522: 8048        strh	r0, [r1, #2]
@   0x08031524: 79a8        ldrb	r0, [r5, #6]
@   0x08031526: 71c8        strb	r0, [r1, #7]
@   0x08031528: 79a8        ldrb	r0, [r5, #6]
@   0x0803152a: 7188        strb	r0, [r1, #6]
@   0x0803152c: 8868        ldrh	r0, [r5, #2]
@   0x0803152e: 8590        strh	r0, [r2, #44]	@ 0x2c
@   0x08031530: 6830        ldr	r0, [r6, #0]
@   0x08031532: 3008        adds	r0, #8
@   0x08031534: 6030        str	r0, [r6, #0]
@   0x08031536: 2001        movs	r0, #1
@   0x08031538: bcf0        pop	{r4, r5, r6, r7}
@   0x0803153a: bc02        pop	{r1}
@   0x0803153c: 4708        bx	r1

        thumb_func_start sub_080314AC
sub_080314AC: @ 0x080314ac
        .incbin "baserom.gba", 0x314ac, 0x94
        thumb_func_end sub_080314AC
