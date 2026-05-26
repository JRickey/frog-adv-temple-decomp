@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080018f8, 0x080019b4)  (188 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80018f8 --end 0x80019b4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080018f8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080018fa: 1c06        adds	r6, r0, #0
@   0x080018fc: 1c0f        adds	r7, r1, #0
@   0x080018fe: 2205        movs	r2, #5
@   0x08001900: f00a        f80a 	bl	0xb918
@   0x08001904: 4b27        ldr	r3, [pc, #156]	@ (0x19a4)
@   0x08001906: 2040        movs	r0, #64	@ 0x40
@   0x08001908: 8a19        ldrh	r1, [r3, #16]
@   0x0800190a: 4008        ands	r0, r1
@   0x0800190c: 2800        cmp	r0, #0
@   0x0800190e: d017        beq.n	0x1940
@   0x08001910: 7e18        ldrb	r0, [r3, #24]
@   0x08001912: 7e59        ldrb	r1, [r3, #25]
@   0x08001914: 2408        movs	r4, #8
@   0x08001916: 5f1a        ldrsh	r2, [r3, r4]
@   0x08001918: 240a        movs	r4, #10
@   0x0800191a: 5f1b        ldrsh	r3, [r3, r4]
@   0x0800191c: f00b        fa34 	bl	0xcd88
@   0x08001920: 0600        lsls	r0, r0, #24
@   0x08001922: 0e04        lsrs	r4, r0, #24
@   0x08001924: 2c14        cmp	r4, #20
@   0x08001926: d104        bne.n	0x1932
@   0x08001928: 481f        ldr	r0, [pc, #124]	@ (0x19a8)
@   0x0800192a: 2108        movs	r1, #8
@   0x0800192c: 2200        movs	r2, #0
@   0x0800192e: f004        fe67 	bl	0x6600
@   0x08001932: 2c15        cmp	r4, #21
@   0x08001934: d104        bne.n	0x1940
@   0x08001936: 481c        ldr	r0, [pc, #112]	@ (0x19a8)
@   0x08001938: 2108        movs	r1, #8
@   0x0800193a: 2201        movs	r2, #1
@   0x0800193c: f004        fe60 	bl	0x6600
@   0x08001940: 4d18        ldr	r5, [pc, #96]	@ (0x19a4)
@   0x08001942: 7e28        ldrb	r0, [r5, #24]
@   0x08001944: 7e69        ldrb	r1, [r5, #25]
@   0x08001946: 2308        movs	r3, #8
@   0x08001948: 5eea        ldrsh	r2, [r5, r3]
@   0x0800194a: 240a        movs	r4, #10
@   0x0800194c: 5f2b        ldrsh	r3, [r5, r4]
@   0x0800194e: f00b        fa1b 	bl	0xcd88
@   0x08001952: 0600        lsls	r0, r0, #24
@   0x08001954: 0e04        lsrs	r4, r0, #24
@   0x08001956: 2010        movs	r0, #16
@   0x08001958: 8a29        ldrh	r1, [r5, #16]
@   0x0800195a: 4008        ands	r0, r1
@   0x0800195c: 2800        cmp	r0, #0
@   0x0800195e: d005        beq.n	0x196c
@   0x08001960: 1c30        adds	r0, r6, #0
@   0x08001962: 1c39        adds	r1, r7, #0
@   0x08001964: 2205        movs	r2, #5
@   0x08001966: 1c23        adds	r3, r4, #0
@   0x08001968: f009        ff9e 	bl	0xb8a8
@   0x0800196c: 490f        ldr	r1, [pc, #60]	@ (0x19ac)
@   0x0800196e: 2004        movs	r0, #4
@   0x08001970: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08001972: 4010        ands	r0, r2
@   0x08001974: 2800        cmp	r0, #0
@   0x08001976: d112        bne.n	0x199e
@   0x08001978: 8848        ldrh	r0, [r1, #2]
@   0x0800197a: 38a9        subs	r0, #169	@ 0xa9
@   0x0800197c: 0400        lsls	r0, r0, #16
@   0x0800197e: 0c00        lsrs	r0, r0, #16
@   0x08001980: 28a6        cmp	r0, #166	@ 0xa6
@   0x08001982: d80c        bhi.n	0x199e
@   0x08001984: 2304        movs	r3, #4
@   0x08001986: 5ec9        ldrsh	r1, [r1, r3]
@   0x08001988: 4809        ldr	r0, [pc, #36]	@ (0x19b0)
@   0x0800198a: 2436        movs	r4, #54	@ 0x36
@   0x0800198c: 5f00        ldrsh	r0, [r0, r4]
@   0x0800198e: 00c0        lsls	r0, r0, #3
@   0x08001990: 4281        cmp	r1, r0
@   0x08001992: da04        bge.n	0x199e
@   0x08001994: 2180        movs	r1, #128	@ 0x80
@   0x08001996: 0109        lsls	r1, r1, #4
@   0x08001998: 1c28        adds	r0, r5, #0
@   0x0800199a: f005        f8f5 	bl	0x6b88
@   0x0800199e: bcf0        pop	{r4, r5, r6, r7}
@   0x080019a0: bc01        pop	{r0}
@   0x080019a2: 4700        bx	r0
@   0x080019a4: 35e0        adds	r5, #224	@ 0xe0
@   0x080019a6: 0300        lsls	r0, r0, #12
@   0x080019a8: 6110        str	r0, [r2, #16]
@   0x080019aa: 0300        lsls	r0, r0, #12
@   0x080019ac: 3720        adds	r7, #32
@   0x080019ae: 0300        lsls	r0, r0, #12
@   0x080019b0: 6480        str	r0, [r0, #72]	@ 0x48
@   0x080019b2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080018F8
sub_080018F8: @ 0x080018f8
        .incbin "frog_us_baserom.gba", 0x18f8, 0xbc
        thumb_func_end sub_080018F8
