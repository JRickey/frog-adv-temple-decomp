@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0803175c, 0x080317c0)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x803175c --end 0x80317c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803175c: b570        push	{r4, r5, r6, lr}
@   0x0803175e: 1c02        adds	r2, r0, #0
@   0x08031760: 1c0c        adds	r4, r1, #0
@   0x08031762: 6825        ldr	r5, [r4, #0]
@   0x08031764: 480b        ldr	r0, [pc, #44]	@ (0x31794)
@   0x08031766: 6800        ldr	r0, [r0, #0]
@   0x08031768: 2188        movs	r1, #136	@ 0x88
@   0x0803176a: 0049        lsls	r1, r1, #1
@   0x0803176c: 1840        adds	r0, r0, r1
@   0x0803176e: 6800        ldr	r0, [r0, #0]
@   0x08031770: 6841        ldr	r1, [r0, #4]
@   0x08031772: 886e        ldrh	r6, [r5, #2]
@   0x08031774: 00b3        lsls	r3, r6, #2
@   0x08031776: 1841        adds	r1, r0, r1
@   0x08031778: 185b        adds	r3, r3, r1
@   0x0803177a: 6819        ldr	r1, [r3, #0]
@   0x0803177c: 1840        adds	r0, r0, r1
@   0x0803177e: 7869        ldrb	r1, [r5, #1]
@   0x08031780: f7fd        fbba 	bl	0x2eef8
@   0x08031784: 6820        ldr	r0, [r4, #0]
@   0x08031786: 3004        adds	r0, #4
@   0x08031788: 6020        str	r0, [r4, #0]
@   0x0803178a: 2001        movs	r0, #1
@   0x0803178c: bc70        pop	{r4, r5, r6}
@   0x0803178e: bc02        pop	{r1}
@   0x08031790: 4708        bx	r1
@   0x08031792: 0000        movs	r0, r0
@   0x08031794: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031796: 0300        lsls	r0, r0, #12
@   0x08031798: 680a        ldr	r2, [r1, #0]
@   0x0803179a: 8893        ldrh	r3, [r2, #4]
@   0x0803179c: 0418        lsls	r0, r3, #16
@   0x0803179e: 8853        ldrh	r3, [r2, #2]
@   0x080317a0: 4318        orrs	r0, r3
@   0x080317a2: 1810        adds	r0, r2, r0
@   0x080317a4: 6048        str	r0, [r1, #4]
@   0x080317a6: 3206        adds	r2, #6
@   0x080317a8: 600a        str	r2, [r1, #0]
@   0x080317aa: 2001        movs	r0, #1
@   0x080317ac: 4770        bx	lr
@   0x080317ae: 0000        movs	r0, r0
@   0x080317b0: 2000        movs	r0, #0
@   0x080317b2: 6048        str	r0, [r1, #4]
@   0x080317b4: 6808        ldr	r0, [r1, #0]
@   0x080317b6: 3002        adds	r0, #2
@   0x080317b8: 6008        str	r0, [r1, #0]
@   0x080317ba: 2001        movs	r0, #1
@   0x080317bc: 4770        bx	lr

        thumb_func_start sub_0803175C
sub_0803175C: @ 0x0803175c
        .incbin "baserom.gba", 0x3175c, 0x64
        thumb_func_end sub_0803175C
